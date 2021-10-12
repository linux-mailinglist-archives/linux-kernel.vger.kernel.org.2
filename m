Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80D429F27
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbhJLIBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhJLIBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:01:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78668C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 00:59:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m22so64268372wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 00:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZL0IgCxwxZOCc6N60q9ODZfFXYO+v+wjDyRWnfQDxU=;
        b=j5xf/Tz0qzecApKo55JWzWhVD7IuOay2Z08jr+B1NfbCO9C7j+94M32PU1JVNWXgBq
         lCTFIaO/lKQpswhsgcSQc13d7ZeKVTa8v0TjZMxD8F0YcgrQexjJTBnxwvgPQCq/C2O9
         SRmI/CAo4LkRPjFdtNyTs/PUzwj3/ATn5SHr8hRjr0selHPJZ5LE6nqBWCxq1EPDPnVw
         sMiX7Uxaz9ntSMEaV6Fsg5AwFk2GLg/ucT9mye0pZcnO1dzvsKMzb8gTRgNPKv/T6Kn6
         L9Tk1HcxaYHstY8qCBzmyNGG3bNpHkXWpa0+MX41S5rlKJ1Wo0KxeoX0rDl5owjC/atY
         xpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZL0IgCxwxZOCc6N60q9ODZfFXYO+v+wjDyRWnfQDxU=;
        b=uiHcbxAYRC8znA35XQcRMdB+PWr4aixkUFyKat0fEWMf52yy1FashNZQ752aBeJLOE
         PPaBtNsDuCWqb2vf8Xa6T9QssJe7iWqaw5Lt3wq2fcH9jart9rmiljUEbWUknVKhiejL
         uLeG44hoVM53ITD1ty7Nl3SrXA1WLoxTFqBbnL6mjrjIIMEUk9mENnlhDTxQ6qHtgrel
         XIfk/hJlahRLLw47uHNtkyS9864cIgm9IpsQzWK1H3yscfplo1QleuTe9c1PoVoT0TyQ
         P/0FkeTuQzsCRO0kLpe7PdmhNBrwpMlqWA3NgW4WeUJlrEO48qQrykrRx9x+doLzPkOF
         EK6w==
X-Gm-Message-State: AOAM532F8SE9uQVxRdu5/sQoTNr71Oi6IouPMTIZc5ZY+b61zYHzZABj
        PMIIW4PypzC/l9eqay5E3KorNDy5BC3WV4iuhVFmRg==
X-Google-Smtp-Source: ABdhPJwZ+vuj68nKJDo6F5dRTy5sMRtn99gwDMZHCHSI64JSatybZLfgqB9p7RAomfB3RSYsYSjczZ8IJR09Pm+GQ+k=
X-Received: by 2002:a7b:cbd1:: with SMTP id n17mr3819677wmi.113.1634025588965;
 Tue, 12 Oct 2021 00:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211012073116.4156054-1-sumit.garg@linaro.org>
In-Reply-To: <20211012073116.4156054-1-sumit.garg@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 12 Oct 2021 09:59:38 +0200
Message-ID: <CAHUa44HW=7GhvWSd7LwG3wc+47bQWHHiFq+qA-8qMnDV1C0yBQ@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Fix missing devices unregister during optee_remove
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Tue, Oct 12, 2021 at 9:31 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> When OP-TEE driver is built as a module, OP-TEE client devices
> registered on TEE bus during probe should be unregistered during
> optee_remove. So implement optee_unregister_devices() accordingly.
>
> Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/optee/core.c          |  3 +++
>  drivers/tee/optee/device.c        | 22 ++++++++++++++++++++++
>  drivers/tee/optee/optee_private.h |  1 +
>  3 files changed, 26 insertions(+)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index ccad3c7c8f6d..3915dc574503 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -586,6 +586,9 @@ static int optee_remove(struct platform_device *pdev)
>  {
>         struct optee *optee = platform_get_drvdata(pdev);
>
> +       /* Unregister OP-TEE specific client devices on TEE bus */
> +       optee_unregister_devices();
> +
>         /*
>          * Ask OP-TEE to free all cached shared memory objects to decrease
>          * reference counters and also avoid wild pointers in secure world
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index ec1d24693eba..128a2d2a50a1 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -53,6 +53,13 @@ static int get_devices(struct tee_context *ctx, u32 session,
>         return 0;
>  }
>
> +static void optee_release_device(struct device *dev)
> +{
> +       struct tee_client_device *optee_device = to_tee_client_device(dev);
> +
> +       kfree(optee_device);
> +}
> +
>  static int optee_register_device(const uuid_t *device_uuid)
>  {
>         struct tee_client_device *optee_device = NULL;
> @@ -63,6 +70,7 @@ static int optee_register_device(const uuid_t *device_uuid)
>                 return -ENOMEM;
>
>         optee_device->dev.bus = &tee_bus_type;
> +       optee_device->dev.release = optee_release_device;
>         if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
>                 kfree(optee_device);
>                 return -ENOMEM;
> @@ -154,3 +162,17 @@ int optee_enumerate_devices(u32 func)
>  {
>         return  __optee_enumerate_devices(func);
>  }
> +
> +static int __optee_unregister_device(struct device *dev, void *data)
> +{
> +       if (!strncmp(dev_name(dev), "optee-ta", strlen("optee-ta")))
> +               device_unregister(dev);
> +
> +       return 0;
> +}
> +
> +void optee_unregister_devices(void)
> +{
> +       bus_for_each_dev(&tee_bus_type, NULL, NULL,
> +                        __optee_unregister_device);

I had something like this in mind too, but there's one potential
problem with this approach. What if there's more than one OP-TEE
driver with TAs here? It seems that we'll remove TAs from other
drivers too then.

This is not likely to be a problem at upstream for the moment so I
might be enough just to keep this in mind if/when the OP-TEE driver is
extended in a way that there can be multiple OP-TEEs handled.

Cheers,
Jens
