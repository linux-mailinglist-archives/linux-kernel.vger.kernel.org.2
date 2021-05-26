Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAF3391F50
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 20:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhEZSmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 14:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbhEZSmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 14:42:45 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE707C061574;
        Wed, 26 May 2021 11:41:12 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id o18so3442744ybc.8;
        Wed, 26 May 2021 11:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFPiHuMmgB1diVIK7dUPVf8VcVw6JsgY/PRpvldEVQ0=;
        b=qaSvn6PI+8BoBElLj/aK5GPJlL6f774Y24z0S6KncRf915wNgynqgtLORZyoSDVquM
         SpOjVNqBDwkEZ2pxfIRMa7bMNtMXBCAhSb58WtU1nsfrAT3XIxRjnmVpPjrSzcNSPb7g
         z5BVFBGZ2KuVuliw9g4hAoOnFHPQ3REKaiRClFkO6tPNNAk89cyfePVQpCAFoUniS/kY
         qBkTpVtuPjfcLaBWOn0SfYMKBxxlE457FedrsxXevhi0w3n+k4iSGSjSZXPt0npjSAdK
         agdh4otT1bi2+sYrYgK2WbafJ0hGlfOEO7Mnh3y7O0fxWY9g3RUbW6jIIOMzZysLqpVn
         a+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFPiHuMmgB1diVIK7dUPVf8VcVw6JsgY/PRpvldEVQ0=;
        b=F7NJCHRJhu4Wvb346pIKdi+yJb8nf1Ox3W+ezfj+l/vAhO7HAjnAOcXHlIvH/LEpHj
         rif6CHemliJQMCcnoSPaHHNO6NMr9nMLamJa8YjwkHnew+rPlzE670uHQGa8AZF/Ohui
         2ljW0wcKb3XgqGMgvuBdn0jjkze+mTWD92Xxyo5RuGVuPtHkEOXZ74RB/SCkV0a7kXsZ
         TDuQVsAtadiQVkEcifzgyKWDzVZ2EcrH0RnWThhWxdyCXSmQeP8va0BeUdJzvQJegGit
         OHzW0NV3fzGYqi0vTqvsK6PR3tWZG9JYuPhCCvyPlKWWYaGLbS6O+FaeYKX9mNS4bsWl
         GiMg==
X-Gm-Message-State: AOAM533711Pe8H1r2ZuF8g8NHmKZEMGQZEAwc9JPcWcqNUlxCMIiJct0
        xSApm5hy3lVKC1AiO3+nJR+4p+gVJA6AewZBaAk=
X-Google-Smtp-Source: ABdhPJwT4k6DNHfY5t+fcuHUkZTxoJn64AyHFKIC91gNYP2lNln/V0r4OROotjDGt6+BPUuDXwodmF+VI6cgRZ3t6Zw=
X-Received: by 2002:a25:3c87:: with SMTP id j129mr53760696yba.141.1622054471905;
 Wed, 26 May 2021 11:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210526162342.GA20@8bbba9ba63a4>
In-Reply-To: <20210526162342.GA20@8bbba9ba63a4>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 26 May 2021 14:41:00 -0400
Message-ID: <CAMdYzYpZoKs3P62j02RW-+5BEpqC9JL3apjucTWLWmvNFrOrCg@mail.gmail.com>
Subject: Re: [PATCH] regulator: fan53555: add back tcs4526
To:     Rudi Heitbaum <rudi@heitbaum.com>
Cc:     devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, chenjh@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 12:23 PM Rudi Heitbaum <rudi@heitbaum.com> wrote:
>
>
> For rk3399pro boards the tcs4526 regulator supports the vdd_gpu
> regulator. The tcs4526 regulator has a chip id of <0>.
> Add the compatibile tcs,tcs4526
>
> without this patch, the dmesg output is:
>   fan53555-regulator 0-0010: Chip ID 0 not supported!
>   fan53555-regulator 0-0010: Failed to setup device!
>   fan53555-regulator: probe of 0-0010 failed with error -22
> with this patch, the dmesg output is:
>   vdd_gpu: supplied by vcc5v0_sys
>
> The regulators are described as:
> - Dedicated power management IC TCS4525
> - Lithium battery protection chip TCS4526
>
> This has been tested with a Radxa Rock Pi N10.
>
> Fixes: f9028dcdf589 ("regulator: fan53555: only bind tcs4525 to correct chip id")
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>

Considering the TCS4525 wasn't supported prior to its recent addition,
and the TCS4526 wasn't supported by the driver at all, this isn't a
fix but a feature addition.
Binding only to the correct device ID exists for this reason, to
prevent unsafe voltage setting.

I also don't see the TCS4525/TCS4526 regulators in the current
linux-next device tree for the N10.

> ---
>  drivers/regulator/fan53555.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
> index 2695be617373..ddab9359ea20 100644
> --- a/drivers/regulator/fan53555.c
> +++ b/drivers/regulator/fan53555.c
> @@ -90,6 +90,7 @@ enum {
>  };
>
>  enum {
> +       TCS4525_CHIP_ID_00 = 0,
>         TCS4525_CHIP_ID_12 = 12,

This isn't a TCS4525, but a TCS4526.

>  };
>
> @@ -373,6 +374,7 @@ static int fan53555_voltages_setup_silergy(struct fan53555_device_info *di)
>  static int fan53526_voltages_setup_tcs(struct fan53555_device_info *di)
>  {
>         switch (di->chip_id) {
> +       case TCS4525_CHIP_ID_00:
>         case TCS4525_CHIP_ID_12:
>                 di->slew_reg = TCS4525_TIME;
>                 di->slew_mask = TCS_SLEW_MASK;
> @@ -564,6 +566,9 @@ static const struct of_device_id __maybe_unused fan53555_dt_ids[] = {
>         }, {
>                 .compatible = "tcs,tcs4525",
>                 .data = (void *)FAN53526_VENDOR_TCS
> +       }, {
> +               .compatible = "tcs,tcs4526",
> +               .data = (void *)FAN53526_VENDOR_TCS

Since you aren't adding any functional code, is there a particular
reason you can't just add the chip id and simply use the tcs4525
compatible?
This will prevent you from needing to modify the dt-bindings as well.

>         },
>         { }
>  };
> @@ -672,6 +677,9 @@ static const struct i2c_device_id fan53555_id[] = {
>         }, {
>                 .name = "tcs4525",
>                 .driver_data = FAN53526_VENDOR_TCS
> +       }, {
> +               .name = "tcs4526",
> +               .driver_data = FAN53526_VENDOR_TCS
>         },
>         { },
>  };
> --
> 2.29.2
>
