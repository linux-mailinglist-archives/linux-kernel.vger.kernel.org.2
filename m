Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46678434BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 14:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhJTM5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 08:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhJTM5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:57:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44112C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:55:04 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y30so23655823edi.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=82ITU3rMrXPNFLNPs43kr8rBrNr3jL7LKXXnaokGi+E=;
        b=P3tQpSlOQs4X40VCMLBQiaKc6P3mFQSmVb67ddZSIy440yQqS5yR1t8Lw0WqpqCUjj
         ddMomQkc7KUbgpl1A/UkoL/WYoxUnHjQ77SZQC335favhjk3vZjTRKzHc6ObX3FhV4Gu
         RGEMPWIRm4MtY1SDCg5NOoNAaJN+PY1bEb7VuNQOgsAzNGP5ceRdHDx+6vG9IXPgKpUC
         Dy9UJ/ycNvvut37NRv5g/W/buTrecYzozZ76ht5zX+JvcKsyqgNHWFZScCGU+C8yhLv9
         h5FVXe0HsL4pzNX/E21EkI3AJ3yvJRJFyv4Wzt5RHVQ2gooeDSZF+2/eYPNLCdCjfNXL
         qagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=82ITU3rMrXPNFLNPs43kr8rBrNr3jL7LKXXnaokGi+E=;
        b=YmQAb5DslL5moUEvGpUFSespXv8EiumJdXu5d1DA/VCgPkPy373V2c0Vl0vRS04Vzk
         5pL72uJvUhJQYAbfp/DsDNR+4ndBNCEH7jh5uLCLcjlpSyH/mweQCn3PHRPxue0oma3y
         PzrbbHKRBEq3iw4jDNSi1IdG/MfDok53Rb+/GQdHWQ1PLK3/pvHKdqn7myF6vdlQoTJT
         k57H3p/jM010ohi34hx0oK0pj9CMHN8OOSefiVIThm4390mzJRf9cVQx8y1RB3lBC+cB
         KAti9VtpEGq9j1FkWruzq3S/4+p1FOdnJ3TEIvOzUidMIJBeMVBeW9Htvn2V10r5RVLH
         expw==
X-Gm-Message-State: AOAM530WHQ+0UYx+ITGdBspw/vGaikl1NPai0EqJFcmBT/RKVulVgisC
        8oUrGscNrJ5gErlcpGiXuvVeKpi321FPDau0L+lu5Q==
X-Google-Smtp-Source: ABdhPJyyf+KJpst7xbEZ6ZGPiLIm7g8o/Fi8mT1cTrkLSX/EQGvP5rMSifD9xZqlNhDYGSd++hXcLiebofcUJ/zHdTM=
X-Received: by 2002:a17:906:684e:: with SMTP id a14mr46197800ejs.142.1634734475529;
 Wed, 20 Oct 2021 05:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211019203850.3833915-1-u.kleine-koenig@pengutronix.de>
 <CABXOdTeOO=Yf37_p1c8HVigkqqRyR90RqRDaLk5qxxp3jAGgEA@mail.gmail.com> <20211020071753.wltjslmimb6wtlp5@pengutronix.de>
In-Reply-To: <20211020071753.wltjslmimb6wtlp5@pengutronix.de>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 20 Oct 2021 05:54:24 -0700
Message-ID: <CABXOdTcgbobZwVarxXt8J+MTB2v4fO5uq+wZWCTwWsg=4mQTzg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Make cros_ec_unregister()
 return return void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:17 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Up to now cros_ec_unregister() returns zero unconditionally. Make it
> return void instead which makes it easier to see in the callers that
> there is no error to handle.
>
> Also the return value of i2c, platform and spi remove callbacks is
> ignored anyway.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> On Tue, Oct 19, 2021 at 02:31:46PM -0700, Guenter Roeck wrote:
> > On Tue, Oct 19, 2021 at 1:39 PM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > -int cros_ec_unregister(struct cros_ec_device *ec_dev)
> > > +void cros_ec_unregister(struct cros_ec_device *ec_dev)
> > >  {
> > >         if (ec_dev->pd)
> > >                 platform_device_unregister(ec_dev->pd);
> >
> > Isn't there a "return 0;" hiding about here which would now result in
> > a compile error ?
>
> Argh, you're right. I forgot to squash this in after my build test :-\
> Here's a v2.
>
> Thanks
> Uwe
>
>  drivers/platform/chrome/cros_ec.c     | 4 +---
>  drivers/platform/chrome/cros_ec.h     | 2 +-
>  drivers/platform/chrome/cros_ec_i2c.c | 4 +++-
>  drivers/platform/chrome/cros_ec_lpc.c | 4 +++-
>  drivers/platform/chrome/cros_ec_spi.c | 4 +++-
>  5 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/=
cros_ec.c
> index fc5aa1525d13..d49a4efe46c8 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -302,13 +302,11 @@ EXPORT_SYMBOL(cros_ec_register);
>   *
>   * Return: 0 on success or negative error code.
>   */
> -int cros_ec_unregister(struct cros_ec_device *ec_dev)
> +void cros_ec_unregister(struct cros_ec_device *ec_dev)
>  {
>         if (ec_dev->pd)
>                 platform_device_unregister(ec_dev->pd);
>         platform_device_unregister(ec_dev->ec);
> -
> -       return 0;
>  }
>  EXPORT_SYMBOL(cros_ec_unregister);
>
> diff --git a/drivers/platform/chrome/cros_ec.h b/drivers/platform/chrome/=
cros_ec.h
> index 78363dcfdf23..bbca0096868a 100644
> --- a/drivers/platform/chrome/cros_ec.h
> +++ b/drivers/platform/chrome/cros_ec.h
> @@ -11,7 +11,7 @@
>  #include <linux/interrupt.h>
>
>  int cros_ec_register(struct cros_ec_device *ec_dev);
> -int cros_ec_unregister(struct cros_ec_device *ec_dev);
> +void cros_ec_unregister(struct cros_ec_device *ec_dev);
>
>  int cros_ec_suspend(struct cros_ec_device *ec_dev);
>  int cros_ec_resume(struct cros_ec_device *ec_dev);
> diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chr=
ome/cros_ec_i2c.c
> index 30c8938c27d5..22feb0fd4ce7 100644
> --- a/drivers/platform/chrome/cros_ec_i2c.c
> +++ b/drivers/platform/chrome/cros_ec_i2c.c
> @@ -313,7 +313,9 @@ static int cros_ec_i2c_remove(struct i2c_client *clie=
nt)
>  {
>         struct cros_ec_device *ec_dev =3D i2c_get_clientdata(client);
>
> -       return cros_ec_unregister(ec_dev);
> +       cros_ec_unregister(ec_dev);
> +
> +       return 0;
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chr=
ome/cros_ec_lpc.c
> index 1f7861944044..8527a1bac765 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -439,7 +439,9 @@ static int cros_ec_lpc_remove(struct platform_device =
*pdev)
>                 acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
>                                            cros_ec_lpc_acpi_notify);
>
> -       return cros_ec_unregister(ec_dev);
> +       cros_ec_unregister(ec_dev);
> +
> +       return 0;
>  }
>
>  static const struct acpi_device_id cros_ec_lpc_acpi_device_ids[] =3D {
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chr=
ome/cros_ec_spi.c
> index 14c4046fa04d..713c58687721 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -790,7 +790,9 @@ static int cros_ec_spi_remove(struct spi_device *spi)
>  {
>         struct cros_ec_device *ec_dev =3D spi_get_drvdata(spi);
>
> -       return cros_ec_unregister(ec_dev);
> +       cros_ec_unregister(ec_dev);
> +
> +       return 0;
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> --
> 2.30.2
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
