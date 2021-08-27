Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCC53F96ED
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244817AbhH0J1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244657AbhH0J1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:27:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9CCC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:26:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so3914961wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6/pEtsmPXEr0DtFJnmn/n99lBxeuj7y7P+Ae72uWNQ=;
        b=vZc+T8ZJ5gxdka3g7nbaqKV+ZU6QpU9zFc87THqV1N/i935mxvSXs1i/6uwHXRieOa
         SjrRUWflUO13YVT8+YN7YwUcrlFNMLI84ElZusvAkRonrkz4FjGnmdXj0SPdbIrzR0nv
         4V49QcYGaup0/9vk1+YfuB//5c135qDiZSacEVRCzV6iBRHb60JE9c/yKkTXR5XmDBD8
         QRTX8SjWmsQAWuAwox82XN4zVxqbry7RR5S8SWkQ7W3+p0WldKaojovLG4B6/edg2fNK
         7HN9MC/CrjdBiMVAojfyWOCFoUraKLEYOzxYzDWhtQPga+SW28llKhg31IvcxOtpkVw3
         uM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6/pEtsmPXEr0DtFJnmn/n99lBxeuj7y7P+Ae72uWNQ=;
        b=gMcM0KnjepOrmOlE7O9wfSmTBo6mkzLq172KRO5LBj4KGpUOIrDvRU5vMavOjl3mXQ
         y9BXi+KTc1zI9HFodSOvYkjQgQt+bWRd7QjnzB1YUcHsZge1W4EwjBGanhdTkuZ0pbGQ
         qiIwTAiLkpAPKavYhGDJ16Sr30aSgj5rPc7EoJj8jCChWuVyHeoq63blogZedS2vQMYE
         bmbx6nwsiwpOMuJutrjf190t2QYX7x3E3rdtQeS7O02EhjaLmVcEyLR5qGIygUXbV6Yp
         45tNFTpFsuhElMVVhiVdCv/8DXH7uhAE72gksp0UAztqy1CzzsoN3d8B6adc+JyUJpm6
         QvAQ==
X-Gm-Message-State: AOAM5322As8NqawN4hjMtPTAiYD/G4PlGI5EUV3cHxD3FHWo3C4fkZLQ
        +oPVrn/zawt4J1bPj3tJPi3i5/hFU93gEQ1XMx8qyw==
X-Google-Smtp-Source: ABdhPJxP25HXbRNWYHpFECApZlJdkZZuMsS8vVNriqMiucQtuEHv3oeceyFUPqFLuy/KFSXL3jIp70xsVV7PNU48G0A=
X-Received: by 2002:a1c:3b05:: with SMTP id i5mr7759579wma.136.1630056386806;
 Fri, 27 Aug 2021 02:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210826123032.1732926-1-jens.wiklander@linaro.org>
 <20210826123032.1732926-5-jens.wiklander@linaro.org> <CAFA6WYM_zaVsWzP-sDuD6_xf3qgv-sQsbEAebZG6vtFrKfRpag@mail.gmail.com>
In-Reply-To: <CAFA6WYM_zaVsWzP-sDuD6_xf3qgv-sQsbEAebZG6vtFrKfRpag@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 27 Aug 2021 11:26:16 +0200
Message-ID: <CAHUa44FWM-QRfeEb5rreN4J9yJjQJQrh3XEm-YLBQmZMvBLC0g@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] tee: add tee_dev_open_helper() primitive
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 8:23 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 26 Aug 2021 at 18:00, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Adds tee_dev_open_helper() and tee_dev_ctx_put() to make it easier to
> > create a driver internal struct tee_context without the usual
> > tee_device_get() on the struct tee_device as that adds a circular
> > reference counter dependency and would prevent the struct tee_device
> > from ever being released again.
>
> Can you elaborate regarding the circular dependency issue you are
> referring to? IIUC, lifespan for struct tee_device would look like
> below with normal teedev_open():
>
> optee_probe() {
>   ...
>   tee_device_alloc()            <- teedev->num_users = 1
>   tee_device_register()
>   optee_notif_init()               <- tee_device_get()
>   ...
> }
>
> optee_remove() {
>   ...
>   optee_notif_uninit()           <- tee_device_put()
>   tee_device_unregister()    <- tee_device_put()
>   ...
> }

You're right, it works just as well without this patch.
teedev_close_context() and teedev_open() must be exported in another
patch though. I'll replace this patch with such a patch in the next
patch set.


Thanks,
Jens

>
> -Sumit
>
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/tee_core.c  | 33 ++++++++++++++++++++++++---------
> >  include/linux/tee_drv.h | 27 +++++++++++++++++++++++++++
> >  2 files changed, 51 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 85102d12d716..3beb682684a8 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -43,14 +43,11 @@ static DEFINE_SPINLOCK(driver_lock);
> >  static struct class *tee_class;
> >  static dev_t tee_devt;
> >
> > -static struct tee_context *teedev_open(struct tee_device *teedev)
> > +struct tee_context *tee_dev_open_helper(struct tee_device *teedev)
> >  {
> >         int rc;
> >         struct tee_context *ctx;
> >
> > -       if (!tee_device_get(teedev))
> > -               return ERR_PTR(-EINVAL);
> > -
> >         ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> >         if (!ctx) {
> >                 rc = -ENOMEM;
> > @@ -66,10 +63,30 @@ static struct tee_context *teedev_open(struct tee_device *teedev)
> >         return ctx;
> >  err:
> >         kfree(ctx);
> > -       tee_device_put(teedev);
> >         return ERR_PTR(rc);
> >
> >  }
> > +EXPORT_SYMBOL_GPL(tee_dev_open_helper);
> > +
> > +void tee_dev_ctx_put(struct tee_context *ctx)
> > +{
> > +       teedev_ctx_put(ctx);
> > +}
> > +EXPORT_SYMBOL_GPL(tee_dev_ctx_put);
> > +
> > +static struct tee_context *teedev_open(struct tee_device *teedev)
> > +{
> > +       struct tee_context *ctx;
> > +
> > +       if (!tee_device_get(teedev))
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       ctx = tee_dev_open_helper(teedev);
> > +       if (IS_ERR(ctx))
> > +               tee_device_put(teedev);
> > +
> > +       return ctx;
> > +}
> >
> >  void teedev_ctx_get(struct tee_context *ctx)
> >  {
> > @@ -90,10 +107,8 @@ static void teedev_ctx_release(struct kref *ref)
> >
> >  void teedev_ctx_put(struct tee_context *ctx)
> >  {
> > -       if (ctx->releasing)
> > -               return;
> > -
> > -       kref_put(&ctx->refcount, teedev_ctx_release);
> > +       if (ctx && !ctx->releasing)
> > +               kref_put(&ctx->refcount, teedev_ctx_release);
> >  }
> >
> >  static void teedev_close_context(struct tee_context *ctx)
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 3ebfea0781f1..00a31ff03049 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -458,6 +458,33 @@ static inline int tee_shm_get_id(struct tee_shm *shm)
> >   */
> >  struct tee_shm *tee_shm_get_from_id(struct tee_context *ctx, int id);
> >
> > +/**
> > + * tee_dev_open_helper() - helper function to make a struct tee_context
> > + * @teedev:    Device to open
> > + *
> > + * Creates the struct tee_context without increasing the reference counter
> > + * on @teedev. This is needed for instance when a driver need an internal
> > + * struct tee_context to operate on. By skipping the reference counter
> > + * the circular dependency is broken.
> > + *
> > + * Note that this struct tee_context need special care when freeing in
> > + * order to avoid the normal put on the struct tee_device.
> > + * tee_dev_ctx_put() is the best choice for this.
> > + *
> > + * @returns a pointer 'struct tee_context' on success or an ERR_PTR on failure
> > + */
> > +struct tee_context *tee_dev_open_helper(struct tee_device *teedev);
> > +
> > +/**
> > + * tee_dev_ctx_put() - helper function to release a struct tee_context
> > + * @ctx:       The struct tee_context to release
> > + *
> > + * Note that this function doesn't do a tee_device_put() on the internal
> > + * struct tee_device so this function should normal only be used when
> > + * releasing a struct tee_context obtained with tee_dev_open_helper().
> > + */
> > +void tee_dev_ctx_put(struct tee_context *ctx);
> > +
> >  /**
> >   * tee_client_open_context() - Open a TEE context
> >   * @start:     if not NULL, continue search after this context
> > --
> > 2.31.1
> >
