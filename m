Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF2943409F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 23:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhJSVeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 17:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJSVeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:34:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D173C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 14:31:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i20so17890659edj.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 14:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KP7m3hF4vs54edPCFJbBnxbNAVx5P/u/TEvzaplpID0=;
        b=amJVaAiWVdLKpuvaL9uFiQwXcXEfk+lR+ypEeTLz7nR53taY4Cdt/jR+b7VDTQdRqz
         rsHoDV72Gpddw62ICTefP9i+eGI+aLGLvlseW6qg5JcXuIKyaLbZpjgOeyhAJ5nBPOVI
         Fuw+3xuZUbSI7WWyVnHhxBpXtlmrmhdfM9UBrr+cnKFL5juE/b1nodmDsFjyGdOT35LF
         jRvlqr2vCpG/Ows0GlaGRUQ9D8RMl9oK8C1hCorZ1Pbrepz1/c16ycjSwVZ1IdkB2cIz
         gzxTUcZL8dfsgHF65fEbe66EM1//1xbovu5mhxkJsH+Lp6ExfSJ8lAvjdclK2rg9kfnk
         5OiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KP7m3hF4vs54edPCFJbBnxbNAVx5P/u/TEvzaplpID0=;
        b=o0IkKJ+xLF/KzMNorpAZtOfPOaMthokLWS3LSQGJ1jUzOe2LW8LvIFjpzikYc8l4Rm
         zJNSVbsCi5DswFQ3roEtskfQvt4ff8EuTHhyLY4R3bjBmS9Al7b6GbVfwW6rok89p6ta
         JwhtXJpHnSxXUrLG6Tn+w/gP80BQ2SOAKSEG9DAx0jhAMI4UyrRHJLWbs3T8NzEgQ8nx
         5R86GfFH8E8AXkB21m+jidOyzYyqBAJ5Xk6qhDZM/RlcPJtZSN5IxsTwD9WdOIK8PXBo
         l4MQK+EdOre2cmba5KO4X5xMGqHh3vKTPg4dwBqzA302vYRWZpuCruv59JAvsywlL15k
         r4+Q==
X-Gm-Message-State: AOAM5311ytM2Wr78voTbhztPilr8NgQhMC1X1H5aeILoG7bhODU9m10F
        uFhQLBeNBhxwpKpY2kv5q+QdTkLH1CkZHmYTqredoQ==
X-Google-Smtp-Source: ABdhPJyU7RAD/t0qeLSYWVLIbcp8HVs9urCZmblE/iT+u4cSPcX63qHX2g8apvivOdj1dX7iAz/ukxLoocECaPEfLEo=
X-Received: by 2002:a50:e14a:: with SMTP id i10mr57304342edl.73.1634679117548;
 Tue, 19 Oct 2021 14:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211019203850.3833915-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211019203850.3833915-1-u.kleine-koenig@pengutronix.de>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 19 Oct 2021 14:31:46 -0700
Message-ID: <CABXOdTeOO=Yf37_p1c8HVigkqqRyR90RqRDaLk5qxxp3jAGgEA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec: Make cros_ec_unregister()
 return void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 1:39 PM Uwe Kleine-K=C3=B6nig
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
> ---
>  drivers/platform/chrome/cros_ec.c     | 2 +-
>  drivers/platform/chrome/cros_ec.h     | 2 +-
>  drivers/platform/chrome/cros_ec_i2c.c | 4 +++-
>  drivers/platform/chrome/cros_ec_lpc.c | 4 +++-
>  drivers/platform/chrome/cros_ec_spi.c | 4 +++-
>  5 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/=
cros_ec.c
> index fc5aa1525d13..eeb94b3563e2 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -302,7 +302,7 @@ EXPORT_SYMBOL(cros_ec_register);
>   *
>   * Return: 0 on success or negative error code.
>   */
> -int cros_ec_unregister(struct cros_ec_device *ec_dev)
> +void cros_ec_unregister(struct cros_ec_device *ec_dev)
>  {
>         if (ec_dev->pd)
>                 platform_device_unregister(ec_dev->pd);

Isn't there a "return 0;" hiding about here which would now result in
a compile error ?

Guenter

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
