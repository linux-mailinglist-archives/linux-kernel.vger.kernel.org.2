Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C77A394888
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 00:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhE1WIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 18:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhE1WIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 18:08:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D0FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 15:06:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id jt22so7441910ejb.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NzCrO4wlDrdYtQq84vapD2PcfJSMaNXC/prU18bHpGA=;
        b=W7WrForHIkI8KZA9dDE4G5G5NzSc2AIhtcdg3OJvuDS9l8Ocb83fUXXdymKb+x2DG3
         TTfvizavhAjCAqA6fg5Ql9G0vXAtI+5AX41jNXpa7LyQ7Svohs6nlYBAdqzSSgABsHvl
         YGlCG4bfcj9jZeIaLvmGBN6stSY21Ns3pDFvXpadkklE0qwSOgOgU5dZvOlqEilIjT+e
         0wCCGydmlWuhhJPQR1LZhwGFaK/Y3UVtGyBvGObUXmftEGhkHh23oGYGfkhcz8GXM5Qz
         CBtTklY5xkXTzUpakI0OEK+BVxjy72EfyQM7UaWkzYBHJBs47IjRKVwCy/jBEVN8SVDW
         TL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NzCrO4wlDrdYtQq84vapD2PcfJSMaNXC/prU18bHpGA=;
        b=pvNjZJdT5HahOk+deXtpOb4zba73rI3I2lqXucA+z/9xSuF0kVSD9aUunk0sVpWMCy
         H87faVS98skibT487xRF71flvIjYVgjlcnTeSTGpBnVYhUZ1p36bGqZEbEp2+Ch1UAXw
         01vCTOiiE5wel7Z613EkByBeQlKvKvpfp2BScIN8ygboyeUh0EeTsRzsHQLAWtiPA69r
         mfeT1N04lq6vy4rKGo2ftNEkrY/m2v+KyHAkfKCffsWrNrUL2pcXX7rKR+XpEUyDV+jQ
         +DS8yZiBww0/7tvIJIeYIzVRLjn1jpuo0f7AulVkTcMip4ItukftVb6d2VccN7gCq1oI
         G/LA==
X-Gm-Message-State: AOAM533NJxSuu+bQ9wTp5QN/t7ZEa7p8GEV3JWfygPUtSWGqGFtxAP4p
        h9xCjSeAwvKQ+/wduyxB7FQ=
X-Google-Smtp-Source: ABdhPJyKnNWH86SGCr9vyNUEsTihT9AkVhNe6h7L2ATrdO71d0smP+t83hHxb5XxRRdSWeyPk0oisg==
X-Received: by 2002:a17:906:aac8:: with SMTP id kt8mr10704408ejb.402.1622239589733;
        Fri, 28 May 2021 15:06:29 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id l19sm1081420eja.62.2021.05.28.15.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 15:06:28 -0700 (PDT)
Date:   Sat, 29 May 2021 01:06:26 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-actions@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] regulator: atc260x: Fix n_voltages and min_sel for
 pickable linear ranges
Message-ID: <20210528220626.GA222540@BV030612LT>
References: <20210528123826.350771-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528123826.350771-1-axel.lin@ingics.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

On Fri, May 28, 2021 at 08:38:26PM +0800, Axel Lin wrote:
> The .n_voltages was missed for pickable linear ranges, fix it.

Nice spot! I'm not quite sure if this is really mandatory to be manually
specified or gets computed internally based on the provided linear
ranges, but let's be on the safe side.

> The min_sel for each pickable range should be starting from 0.

Right, although in this particular case the driver behaves correctly
because the overflow bit of every item in the 2nd range is exactly the
range selector (bit 5 - LDO<N>_VOL_SEL in datasheet). Additionally, this
bit is not cleared internally as the selector mask (vsel_mask) is not
applied directly, but in conjunction with the range mask, according to
the implementation of "regulator_set_voltage_sel_pickable_regmap()":

	[...]
		ret = regmap_update_bits(rdev->regmap,
					 rdev->desc->vsel_reg,
					 rdev->desc->vsel_range_mask |
					 rdev->desc->vsel_mask, sel | range);
	[...]

As a matter of fact, using 0-based ranges will break the driver because
the 2nd item in the range sel array "atc260x_ldo_voltage_range_sel" is
not correct, it should be 0x20 instead of 0x1 (0x1<<5, since it is not
shifted automatically as in the case of the voltage selectors).

> Fixes: 3b15ccac161a ("regulator: Add regulator driver for ATC260x PMICs")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Cristian,
> I don't have this h/w to test, please review and test this patch.

Unfortunately I can only test the ATC2603C variant, I haven't been able
to get a 2609A based board yet.

Thanks,
Cristi

> Thanks,
> Axel
>  drivers/regulator/atc260x-regulator.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/regulator/atc260x-regulator.c b/drivers/regulator/atc260x-regulator.c
> index d8b429955d33..5dee02394cd9 100644
> --- a/drivers/regulator/atc260x-regulator.c
> +++ b/drivers/regulator/atc260x-regulator.c
> @@ -28,12 +28,12 @@ static const struct linear_range atc2609a_dcdc_voltage_ranges[] = {
>  
>  static const struct linear_range atc2609a_ldo_voltage_ranges0[] = {
>  	REGULATOR_LINEAR_RANGE(700000, 0, 15, 100000),
> -	REGULATOR_LINEAR_RANGE(2100000, 16, 28, 100000),
> +	REGULATOR_LINEAR_RANGE(2100000, 0, 12, 100000),
>  };
>  
>  static const struct linear_range atc2609a_ldo_voltage_ranges1[] = {
>  	REGULATOR_LINEAR_RANGE(850000, 0, 15, 100000),
> -	REGULATOR_LINEAR_RANGE(2100000, 16, 27, 100000),
> +	REGULATOR_LINEAR_RANGE(2100000, 0, 11, 100000),
>  };
>  
>  static const unsigned int atc260x_ldo_voltage_range_sel[] = {
> @@ -411,7 +411,7 @@ enum atc2609a_reg_ids {
>  	.owner = THIS_MODULE, \
>  }
>  
> -#define atc2609a_reg_desc_ldo_range_pick(num, n_range) { \
> +#define atc2609a_reg_desc_ldo_range_pick(num, n_range, n_volt) { \
>  	.name = "LDO"#num, \
>  	.supply_name = "ldo"#num, \
>  	.of_match = of_match_ptr("ldo"#num), \
> @@ -421,6 +421,7 @@ enum atc2609a_reg_ids {
>  	.type = REGULATOR_VOLTAGE, \
>  	.linear_ranges = atc2609a_ldo_voltage_ranges##n_range, \
>  	.n_linear_ranges = ARRAY_SIZE(atc2609a_ldo_voltage_ranges##n_range), \
> +	.n_voltages = n_volt, \
>  	.vsel_reg = ATC2609A_PMU_LDO##num##_CTL0, \
>  	.vsel_mask = GENMASK(4, 1), \
>  	.vsel_range_reg = ATC2609A_PMU_LDO##num##_CTL0, \
> @@ -458,12 +459,12 @@ static const struct regulator_desc atc2609a_reg[] = {
>  	atc2609a_reg_desc_ldo_bypass(0),
>  	atc2609a_reg_desc_ldo_bypass(1),
>  	atc2609a_reg_desc_ldo_bypass(2),
> -	atc2609a_reg_desc_ldo_range_pick(3, 0),
> -	atc2609a_reg_desc_ldo_range_pick(4, 0),
> +	atc2609a_reg_desc_ldo_range_pick(3, 0, 29),
> +	atc2609a_reg_desc_ldo_range_pick(4, 0, 29),
>  	atc2609a_reg_desc_ldo(5),
> -	atc2609a_reg_desc_ldo_range_pick(6, 1),
> -	atc2609a_reg_desc_ldo_range_pick(7, 0),
> -	atc2609a_reg_desc_ldo_range_pick(8, 0),
> +	atc2609a_reg_desc_ldo_range_pick(6, 1, 28),
> +	atc2609a_reg_desc_ldo_range_pick(7, 0, 29),
> +	atc2609a_reg_desc_ldo_range_pick(8, 0, 29),
>  	atc2609a_reg_desc_ldo_fixed(9),
>  };
>  
> -- 
> 2.25.1
> 
