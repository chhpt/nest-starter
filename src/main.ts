import { NestFactory } from '@nestjs/core'
import { ExpressAdapter, NestExpressApplication } from '@nestjs/platform-express'
import express from 'express'
import { AppModule } from './app.module'

const expressApp = express()
const adapter = new ExpressAdapter(expressApp)

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule, adapter, {
    logger: false,
  })

  // enable cors
  // app.enableCors({
  //   origin: (
  //     requestOrigin: string,
  //     callback: (err: Error | null, allow?: boolean) => void,
  //   ) => {
  //     callback(null, true);
  //   },
  //   maxAge: 600,
  //   credentials: true,
  // });

  // disable x-powered-by express header
  app.disable('x-powered-by')

  await app.listen(process.env.PORT || 3000)
}

bootstrap()
