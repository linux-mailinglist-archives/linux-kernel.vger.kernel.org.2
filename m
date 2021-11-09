Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE22044A54D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 04:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbhKIDZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 22:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbhKIDZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 22:25:50 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7515C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 19:23:04 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n23so17124447pgh.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 19:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=wSYrcbUAaslYVgXYS8JfHc+4Qfr42X0Kj9Fql2SnFSU=;
        b=kPObW1koF9psEludSqupKaSPbTIabX93hKlptjPqlyl9RCcnKXXXo/+YIjCcLXo5h+
         oASApBeDCl3nFAwbUDWR9coimnoevv0A2sT7fti6FlX4sl2EbB9ZENg53eIHoS+KUan8
         6rOoOQbu4X1ohyWdL4CJeoaiHFrmKk9hn+4LA0v5hZAqb5K6OlSnGadUC2D6HlA5RtLP
         uNLc4swLMMTzbeXRYJqEGMdnGSCEIfo69bZYPqynoRZtmUEtQ/fu/BTwCDw1g5/XWbVk
         bCWK9MWURUop7u8CqI5lXFhscL3Jvs4INGwqd4O5i9oZr7Q9pb3Y8nFODLHrdOLVtCbP
         2OlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wSYrcbUAaslYVgXYS8JfHc+4Qfr42X0Kj9Fql2SnFSU=;
        b=npjEdH+yAvTkghMayr0iVX4Nfxm8jrC6aEwdaI5YxPg/gFulmxl+7nu2zngMx+ZWK3
         93n2tV472Y2CVx1seoeOy8hNk+YL444JjrItsMY6W3sNOn9Wkg/Vd/hFRwzBKuiXKbPv
         qcec247F4eN3mqbl9jBD+OBYSZKbvZmD2fODiWxKkhRLNK3D2uhqfZmgbIxA9CXwHKbT
         oqNDzzs90Uj5C7wdcoLDyxOHzuFBdnwlA0oOa+tt5dHtH4CyPTaAxJAy/RzLYl657FXD
         osyxaKy6MVNQp3KyauRoc4uJ22cdyXQtrx5x+YcWguhoJqQimApWQtKGJVt8RZ18ijE1
         rVfQ==
X-Gm-Message-State: AOAM531o9SxudqLsXPIuMcygN8znTyj3L1jxyhOU0PGz1O8acZq7cT5K
        HDdgX7W8RlCaP+bfM2JkfKY=
X-Google-Smtp-Source: ABdhPJxD9lVqRyVhHYb8q96CQv4vDvnHtm1o4xWKrBgrIlFNKo8l+u0CFUnnNFCXYvYsf3siFc4qjw==
X-Received: by 2002:a63:e551:: with SMTP id z17mr3372263pgj.203.1636428184120;
        Mon, 08 Nov 2021 19:23:04 -0800 (PST)
Received: from ?IPv6:2400:4052:6980:3800:dba7:2b1f:3f26:a5ec? ([2400:4052:6980:3800:dba7:2b1f:3f26:a5ec])
        by smtp.gmail.com with ESMTPSA id d7sm18131141pfj.91.2021.11.08.19.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 19:23:03 -0800 (PST)
Message-ID: <c9ab85031655a8c1f07e2c30f4bf9b2e1dadf1e2.camel@gmail.com>
Subject: Re: [PATCH] mfd: intel_soc_pmic: Use CPU-id check instead of _HRV
 check to differentiate variants
From:   Tsuchiya Yuto <kitakar@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Nov 2021 12:23:00 +0900
In-Reply-To: <CAHp75Vd+pUGjrW2YxmaKoVehnDLSMPmGt4_45K6g0g7qRg5Smw@mail.gmail.com>
References: <20211107172641.288491-1-hdegoede@redhat.com>
         <CAHp75Vd+pUGjrW2YxmaKoVehnDLSMPmGt4_45K6g0g7qRg5Smw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-11-07 at 20:17 +0200, Andy Shevchenko wrote:
> On Sun, Nov 7, 2021 at 7:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
> > 
> > The Intel Crystal Cove PMIC has 2 different variants, one for use with
> > Bay Trail (BYT) SoCs and one for use with Cherry Trail (CHT) SoCs.
> > 
> > So far we have been using an ACPI _HRV check to differentiate between
> > the 2, but at least on the Microsoft Surface 3, which is a CHT device,
> > the wrong _HRV value is reported by ACPI.
> > 
> > So instead switch to a CPU-ID check which avoids us relying on the
> > possibly wrong ACPI _HRV value.
> 
> Thanks, I hope Tsuchiya will test this soon, from code perspective it
> looks good to me,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Hi, thank you for the patch. I tried this patch (plus the patch ("ASoC:
Intel: Move soc_intel_is_foo() helpers to a generic header") [1], which
this patch needs) on my Surface 3 and can confirm it's using CHT variant
of Crystal Cove PMIC driver as expected.

Tested-by: Tsuchiya Yuto <kitakar@gmail.com>

[1] https://lore.kernel.org/all/20211018143324.296961-2-hdegoede@redhat.com/

> > Reported-by: Tsuchiya Yuto <kitakar@gmail.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/mfd/intel_soc_pmic_core.c | 28 +++-------------------------
> >  1 file changed, 3 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
> > index ddd64f9e3341..47cb7f00dfcf 100644
> > --- a/drivers/mfd/intel_soc_pmic_core.c
> > +++ b/drivers/mfd/intel_soc_pmic_core.c
> > @@ -14,15 +14,12 @@
> >  #include <linux/module.h>
> >  #include <linux/mfd/core.h>
> >  #include <linux/mfd/intel_soc_pmic.h>
> > +#include <linux/platform_data/x86/soc.h>
> >  #include <linux/pwm.h>
> >  #include <linux/regmap.h>
> > 
> >  #include "intel_soc_pmic_core.h"
> > 
> > -/* Crystal Cove PMIC shares same ACPI ID between different platforms */
> > -#define BYT_CRC_HRV            2
> > -#define CHT_CRC_HRV            3
> > -
> >  /* PWM consumed by the Intel GFX */
> >  static struct pwm_lookup crc_pwm_lookup[] = {
> >         PWM_LOOKUP("crystal_cove_pwm", 0, "0000:00:02.0", "pwm_pmic_backlight", 0, PWM_POLARITY_NORMAL),
> > @@ -34,31 +31,12 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
> >         struct device *dev = &i2c->dev;
> >         struct intel_soc_pmic_config *config;
> >         struct intel_soc_pmic *pmic;
> > -       unsigned long long hrv;
> > -       acpi_status status;
> >         int ret;
> > 
> > -       /*
> > -        * There are 2 different Crystal Cove PMICs a Bay Trail and Cherry
> > -        * Trail version, use _HRV to differentiate between the 2.
> > -        */
> > -       status = acpi_evaluate_integer(ACPI_HANDLE(dev), "_HRV", NULL, &hrv);
> > -       if (ACPI_FAILURE(status)) {
> > -               dev_err(dev, "Failed to get PMIC hardware revision\n");
> > -               return -ENODEV;
> > -       }
> > -
> > -       switch (hrv) {
> > -       case BYT_CRC_HRV:
> > +       if (soc_intel_is_byt())
> >                 config = &intel_soc_pmic_config_byt_crc;
> > -               break;
> > -       case CHT_CRC_HRV:
> > +       else
> >                 config = &intel_soc_pmic_config_cht_crc;
> > -               break;
> > -       default:
> > -               dev_warn(dev, "Unknown hardware rev %llu, assuming BYT\n", hrv);
> > -               config = &intel_soc_pmic_config_byt_crc;
> > -       }
> > 
> >         pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
> >         if (!pmic)
> > --
> > 2.31.1
> > 
> 
> 


