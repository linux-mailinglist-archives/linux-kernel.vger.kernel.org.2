Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630053F945D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 08:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244337AbhH0GY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 02:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244331AbhH0GYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 02:24:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAD0C0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 23:23:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g13so12122411lfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 23:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rpedwb5yaPZmRQ7TUMaWIQcNQoBLY0k4x2IcEMbGMoc=;
        b=g91pVJkUFlpUnXEtC/VPwHZLsELfWsBERNq168TcegldJ6g1/xcj9vWLRFbAVgTR71
         8VYl6Sa2flrqyrnxSxH/UW6LxsofP/m+dvphUoGcyiJ8rGMRPhm1gGbHemr68MCj5Ixq
         M5nIPFeL/e45tVFYvbvKyP2qBxFygkf7DXqCd0y0kNWubxMNbe3Q2RJF813quihB/vRn
         fJz87KPuuma68ILIz/DY+RXPp7+DylbKjmFq8lXY2zytNqYnxHDjnldxoP/BRJjI7yRs
         MLHXnD23EzZ+qpb2UC7hTTiaN8DpZOtCTilJvpxIBpdFpyg3O9LGjL+fVxldYLwVE2d+
         Rtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rpedwb5yaPZmRQ7TUMaWIQcNQoBLY0k4x2IcEMbGMoc=;
        b=sRHeKFF7DZ2yOafqrck2fIgSl4xiRa5jDIrxExpb2kInO0U5Fh2trlW7UiRi128GyL
         TkuBSzb3h2Bw4SunoF+6ROvRFyA0HKFQ5Y3BYaIiLiIh1tDuiO171r6E7drXWLQb9U6m
         6ol6hdSyB+7vjHOfoKATeus0Yyy5QDkNOOrF+lX/QvgjTj8natfxNYGJBNgBKh6kBTdc
         DKiXE9MKJddv3oe9v7USV8H3jOm3GN1+IRkS2ud1uMcXaUZRp33PjahHgCLkCdILjc+n
         +wlwJ8NyEMxc4CVr/UbklkDuzuTo3NknfuBZiS1YacP4MM7XRHSnphahVI8kDH9zrsRx
         VkUg==
X-Gm-Message-State: AOAM5311KxXB7PbNWxnCQouM+AUDV8CYcw2oGQNLEJbxBLtgdSQaHGcS
        e1ViZ3slkdtuANA/SNH8QAVTF8bvpe8iSFmW/r5vUA==
X-Google-Smtp-Source: ABdhPJwTvYKnJhrnKjTE/y6SJpS8GE8XhPgJ2W27p+unVTmLnnQUa8SmaQFQZruEseDfZUFlGFW2T9MK6LJULh6jLuw=
X-Received: by 2002:a05:6512:3487:: with SMTP id v7mr5544143lfr.302.1630045404094;
 Thu, 26 Aug 2021 23:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210826123032.1732926-1-jens.wiklander@linaro.org> <20210826123032.1732926-5-jens.wiklander@linaro.org>
In-Reply-To: <20210826123032.1732926-5-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 27 Aug 2021 11:53:12 +0530
Message-ID: <CAFA6WYM_zaVsWzP-sDuD6_xf3qgv-sQsbEAebZG6vtFrKfRpag@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] tee: add tee_dev_open_helper() primitive
To:     Jens Wiklander <jens.wiklander@linaro.org>
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

On Thu, 26 Aug 2021 at 18:00, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Adds tee_dev_open_helper() and tee_dev_ctx_put() to make it easier to
> create a driver internal struct tee_context without the usual
> tee_device_get() on the struct tee_device as that adds a circular
> reference counter dependency and would prevent the struct tee_device
> from ever being released again.

Can you elaborate regarding the circular dependency issue you are
referring to? IIUC, lifespan for struct tee_device would look like
below with normal teedev_open():

optee_probe() {
  ...
  tee_device_alloc()            <- teedev->num_users = 1
  tee_device_register()
  optee_notif_init()               <- tee_device_get()
  ...
}

optee_remove() {
  ...
  optee_notif_uninit()           <- tee_device_put()
  tee_device_unregister()    <- tee_device_put()
  ...
}

-Sumit

>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_core.c  | 33 ++++++++++++++++++++++++---------
>  include/linux/tee_drv.h | 27 +++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 85102d12d716..3beb682684a8 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -43,14 +43,11 @@ static DEFINE_SPINLOCK(driver_lock);
>  static struct class *tee_class;
>  static dev_t tee_devt;
>
> -static struct tee_context *teedev_open(struct tee_device *teedev)
> +struct tee_context *tee_dev_open_helper(struct tee_device *teedev)
>  {
>         int rc;
>         struct tee_context *ctx;
>
> -       if (!tee_device_get(teedev))
> -               return ERR_PTR(-EINVAL);
> -
>         ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>         if (!ctx) {
>                 rc = -ENOMEM;
> @@ -66,10 +63,30 @@ static struct tee_context *teedev_open(struct tee_device *teedev)
>         return ctx;
>  err:
>         kfree(ctx);
> -       tee_device_put(teedev);
>         return ERR_PTR(rc);
>
>  }
> +EXPORT_SYMBOL_GPL(tee_dev_open_helper);
> +
> +void tee_dev_ctx_put(struct tee_context *ctx)
> +{
> +       teedev_ctx_put(ctx);
> +}
> +EXPORT_SYMBOL_GPL(tee_dev_ctx_put);
> +
> +static struct tee_context *teedev_open(struct tee_device *teedev)
> +{
> +       struct tee_context *ctx;
> +
> +       if (!tee_device_get(teedev))
> +               return ERR_PTR(-EINVAL);
> +
> +       ctx = tee_dev_open_helper(teedev);
> +       if (IS_ERR(ctx))
> +               tee_device_put(teedev);
> +
> +       return ctx;
> +}
>
>  void teedev_ctx_get(struct tee_context *ctx)
>  {
> @@ -90,10 +107,8 @@ static void teedev_ctx_release(struct kref *ref)
>
>  void teedev_ctx_put(struct tee_context *ctx)
>  {
> -       if (ctx->releasing)
> -               return;
> -
> -       kref_put(&ctx->refcount, teedev_ctx_release);
> +       if (ctx && !ctx->releasing)
> +               kref_put(&ctx->refcount, teedev_ctx_release);
>  }
>
>  static void teedev_close_context(struct tee_context *ctx)
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 3ebfea0781f1..00a31ff03049 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -458,6 +458,33 @@ static inline int tee_shm_get_id(struct tee_shm *shm)
>   */
>  struct tee_shm *tee_shm_get_from_id(struct tee_context *ctx, int id);
>
> +/**
> + * tee_dev_open_helper() - helper function to make a struct tee_context
> + * @teedev:    Device to open
> + *
> + * Creates the struct tee_context without increasing the reference counter
> + * on @teedev. This is needed for instance when a driver need an internal
> + * struct tee_context to operate on. By skipping the reference counter
> + * the circular dependency is broken.
> + *
> + * Note that this struct tee_context need special care when freeing in
> + * order to avoid the normal put on the struct tee_device.
> + * tee_dev_ctx_put() is the best choice for this.
> + *
> + * @returns a pointer 'struct tee_context' on success or an ERR_PTR on failure
> + */
> +struct tee_context *tee_dev_open_helper(struct tee_device *teedev);
> +
> +/**
> + * tee_dev_ctx_put() - helper function to release a struct tee_context
> + * @ctx:       The struct tee_context to release
> + *
> + * Note that this function doesn't do a tee_device_put() on the internal
> + * struct tee_device so this function should normal only be used when
> + * releasing a struct tee_context obtained with tee_dev_open_helper().
> + */
> +void tee_dev_ctx_put(struct tee_context *ctx);
> +
>  /**
>   * tee_client_open_context() - Open a TEE context
>   * @start:     if not NULL, continue search after this context
> --
> 2.31.1
>
