Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C6A3E2D1B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243140AbhHFPEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241898AbhHFPEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:04:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F39DC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 08:04:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d6so13432433edt.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hB2nIjh632OjMM+HCNWWBIFwzRxxUedWPIIoGwvPqnc=;
        b=dXs76HUlXUcFqWMeAcatgqCQwDDVZcGYH/7w6zI9ml10wCRZr7mADYbgY4oRtvwq2g
         //Wwt5rIQjt+VDZv5LxgkWmtSzEBkFhHs6jDwiyc9k7AK+8I/hGGXbNoaEL/fbkJnC3C
         yqgJYE6MmThIYP0TTQaW4LeemgOyjH8vD06fym8Tnftck55TR3lETGuNfEoYtJ/xRCXo
         K0ldqod2iyBfvyquA4dA9n6WIx3VsMXx8HJXWyq7xnkwJf7Z1drNbTopBbksuO4aQlIL
         rjv2/w/h327Z2RlOCdN4SU+bjZkQ7SCgKVOUr2OmCtbaGOVrMOrMuPNFbY9UZB6GwuZp
         BoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hB2nIjh632OjMM+HCNWWBIFwzRxxUedWPIIoGwvPqnc=;
        b=QGJ0WDodbxq8BOtZ139rByuffTbz5GXls90q+CYCIGFHH2Ezg3akJ399QpJcCGvf8Q
         7zFy6zhobiDPyYfSAzTjwTKFrbtac87QmE7c8cEb65zr5wegl/e5e9Q9dMC96ji5+Wsn
         a84mJsC6vA4+GXSUGyfZxbEh9L1oX58iy3C+i3FGqMJVGG/K1q1Y1b/Q0A168q8trJP4
         ZrY0SyI6g37n09AmWfBMfWLItPfIhZAhLfu+6hG0TIJ60GIKOlYREoE8ImX83FOmbz2Z
         fzZzWG3NRcqS3MuQJrrYPaNcPAct67RL1ICIcFVr/MaFRPh8N8m+KbMXu2h+xpYfU/UD
         scDQ==
X-Gm-Message-State: AOAM530+TWlsvTJVstODIZG63IBGLOIa0QPrMRI3SPrvHSFEpQS7f4ug
        y4kI3yB9ANeDOJC3H61DOjEdaTVJllosLBlOiVFefQ==
X-Google-Smtp-Source: ABdhPJyrB7Z4cLPe63IBfrz3BFw8VjJxAWK/ZN1xMtFRglWPFlzsxTgYPiZ3644eb4eExRRvEbOBc6EDEodxIKTJ5W0=
X-Received: by 2002:aa7:de98:: with SMTP id j24mr13830209edv.139.1628262268905;
 Fri, 06 Aug 2021 08:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210806130227.69473-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210806130227.69473-1-andriy.shevchenko@linux.intel.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 6 Aug 2021 08:04:18 -0700
Message-ID: <CABXOdTfXzdJE0Nye-rttp50cnTJy-nU9RcFxkONDo3hXvVWDUA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: cros_ec: Fix Kconfig dependency on CROS_EC_SENSORHUB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Jason M ." <jason@montleon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying again, text only this time. Sorry for the trouble.

On Fri, Aug 6, 2021 at 6:08 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When CONFIG_CROS_EC_SENSORHUB is set to m, the IIO_CROS_EC_SENSORS_CORE
> can't be built-in.
>
> Fixes: 53067471188c ("iio / platform: cros_ec: Add cros-ec-sensorhub driver")
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213979
> Reported-by: Jason M. <jason@montleon.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/common/cros_ec_sensors/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
> index fefad9572790..b0d67ceaed55 100644
> --- a/drivers/iio/common/cros_ec_sensors/Kconfig
> +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
> @@ -4,7 +4,8 @@
>  #
>  config IIO_CROS_EC_SENSORS_CORE
>         tristate "ChromeOS EC Sensors Core"
> -       depends on SYSFS && CROS_EC_SENSORHUB
> +       depends on CROS_EC_SENSORHUB=y || (CROS_EC_SENSORHUB=m && m)
> +       depends on SYSFS

This seems wrong.  IIO_CROS_EC_SENSORS_CORE should already be limited to m
if CROS_EC_SENSORHUB=m.

Note that I can not reproduce the problem in the bugzilla entry,
neither with mainline
nor with v5.13.6. And the configuration file published there looks fine and
already has IIO_CROS_EC_SENSORS_CORE=m.

Guenter

>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
>         help
> --
> 2.30.2
>
