Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5D24474EB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 19:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhKGSUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 13:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbhKGSUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 13:20:30 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002D0C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 10:17:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f4so53232552edx.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 10:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMhYT7f4HHOrvM2BB+7ftAJk6+0NTI3CufI8tmE9/eE=;
        b=L/a0tecF+6Csq7xpUisZ2Ayxbv6Q/1vCBWRxzrADHJC10FTqlunqo9gT7RtjH0U4Br
         6JsPpuzaeDPfSSe6NmibLkB0oAxF6dWefjlFyhtPJUkaH16Z3U7/RLtIoR/J5BuYIDsq
         NxzYEYG8ujHGAmWSx8QzivLTCqsWfjUI92lhJpVY8yCsMXCodnadqZfeF9v01kT4B8G0
         fMvCUFbssSSMTG5BFPbL2QIN7WcJ615kIChatrlOeRQan27sCeLBqUjTMfROOfj+1LjA
         rECagCLphAb7xKjKVabu05Sq9U+GaqbaUudA45IBdp/DYj7O68mO79b2an1MPTlklzzc
         HtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMhYT7f4HHOrvM2BB+7ftAJk6+0NTI3CufI8tmE9/eE=;
        b=artxFBX8h6aC1kPjM6k6lu88Arjk7Ibk3o9chTB8PM8faGiPvkcUu7DyqccfDuC0K3
         B1G1PhVg/qryEX9kcqObq8iK6Ropbrv+rw33nlwBUuIHDip8u0mJ58CPXtDm7NcJtD2C
         UVf6HQ1QZlg2MTRb4V9VfEM+HUdF+oA4+0HERE/stqejyW/BHD4ynWXhLzuEqa3Ck8H/
         hOcQtTLQtrf1ARIlZCZZtcvQN9FAeYp8Ky5wVCeBaoYF9i4LFOG4rOV4s/9f5iySZ0GE
         LVW8e9WO6heW61uolMNM5yJA5BGNkMupDrqCPVuxy7Y1ULi97Qc+3CG8+ZO9jEWHNUlP
         YHiQ==
X-Gm-Message-State: AOAM530IFndV87KGmf9TdXBcMYZ5qLQlbTHlK3od5Ka8x1x8JtURHmir
        p4Z8otaF/v9ZNjNTCbleyOoXE36d2/TUcEi0f74=
X-Google-Smtp-Source: ABdhPJzAoOJriTsn6SgDHOZzyKwF+qLg62xoW+uYcKSi+APoRLB+9mRebvr4P6PoOr9X/w10Ldzq+ZWdlCKC/j6/vu0=
X-Received: by 2002:a17:906:2887:: with SMTP id o7mr88058024ejd.425.1636309064681;
 Sun, 07 Nov 2021 10:17:44 -0800 (PST)
MIME-Version: 1.0
References: <20211107172641.288491-1-hdegoede@redhat.com>
In-Reply-To: <20211107172641.288491-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 7 Nov 2021 20:17:08 +0200
Message-ID: <CAHp75Vd+pUGjrW2YxmaKoVehnDLSMPmGt4_45K6g0g7qRg5Smw@mail.gmail.com>
Subject: Re: [PATCH] mfd: intel_soc_pmic: Use CPU-id check instead of _HRV
 check to differentiate variants
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 7, 2021 at 7:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Intel Crystal Cove PMIC has 2 different variants, one for use with
> Bay Trail (BYT) SoCs and one for use with Cherry Trail (CHT) SoCs.
>
> So far we have been using an ACPI _HRV check to differentiate between
> the 2, but at least on the Microsoft Surface 3, which is a CHT device,
> the wrong _HRV value is reported by ACPI.
>
> So instead switch to a CPU-ID check which avoids us relying on the
> possibly wrong ACPI _HRV value.

Thanks, I hope Tsuchiya will test this soon, from code perspective it
looks good to me,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Reported-by: Tsuchiya Yuto <kitakar@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/intel_soc_pmic_core.c | 28 +++-------------------------
>  1 file changed, 3 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
> index ddd64f9e3341..47cb7f00dfcf 100644
> --- a/drivers/mfd/intel_soc_pmic_core.c
> +++ b/drivers/mfd/intel_soc_pmic_core.c
> @@ -14,15 +14,12 @@
>  #include <linux/module.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/intel_soc_pmic.h>
> +#include <linux/platform_data/x86/soc.h>
>  #include <linux/pwm.h>
>  #include <linux/regmap.h>
>
>  #include "intel_soc_pmic_core.h"
>
> -/* Crystal Cove PMIC shares same ACPI ID between different platforms */
> -#define BYT_CRC_HRV            2
> -#define CHT_CRC_HRV            3
> -
>  /* PWM consumed by the Intel GFX */
>  static struct pwm_lookup crc_pwm_lookup[] = {
>         PWM_LOOKUP("crystal_cove_pwm", 0, "0000:00:02.0", "pwm_pmic_backlight", 0, PWM_POLARITY_NORMAL),
> @@ -34,31 +31,12 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
>         struct device *dev = &i2c->dev;
>         struct intel_soc_pmic_config *config;
>         struct intel_soc_pmic *pmic;
> -       unsigned long long hrv;
> -       acpi_status status;
>         int ret;
>
> -       /*
> -        * There are 2 different Crystal Cove PMICs a Bay Trail and Cherry
> -        * Trail version, use _HRV to differentiate between the 2.
> -        */
> -       status = acpi_evaluate_integer(ACPI_HANDLE(dev), "_HRV", NULL, &hrv);
> -       if (ACPI_FAILURE(status)) {
> -               dev_err(dev, "Failed to get PMIC hardware revision\n");
> -               return -ENODEV;
> -       }
> -
> -       switch (hrv) {
> -       case BYT_CRC_HRV:
> +       if (soc_intel_is_byt())
>                 config = &intel_soc_pmic_config_byt_crc;
> -               break;
> -       case CHT_CRC_HRV:
> +       else
>                 config = &intel_soc_pmic_config_cht_crc;
> -               break;
> -       default:
> -               dev_warn(dev, "Unknown hardware rev %llu, assuming BYT\n", hrv);
> -               config = &intel_soc_pmic_config_byt_crc;
> -       }
>
>         pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
>         if (!pmic)
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
