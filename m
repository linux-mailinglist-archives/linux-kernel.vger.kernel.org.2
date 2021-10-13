Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3E642C5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbhJMQGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:06:20 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49044
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhJMQGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:06:17 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BAF7040016
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634141053;
        bh=7Uea0bdproVv4z3WyZyxDDyqLGB33jk6EQEyoqX83Q8=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=qk4R8TBf/6ieVnTRFAbWPPfBA6/a5qfIJAistaK9lLbAQTWJQvZEw+dRdy41QVXTn
         74exK9VnOIehnBCvMXioLvaCrs0d59im0mPBYP1odg8Tr+/0pTwnDhM4Zj8gv4LTiF
         96HZeiddqnTBrPMD129DfU8G4bf7UVr6pzbfy/7C/02SH9ZcqUBOopfl5tCJHgL5xO
         1r0OScRfNEUrYZJ2Plf33Oj8zpWBJ9G+ygUAUqEsworQ6u2bmFi5j6/dnBwZnOtrcA
         J6RCt1u7GVQSBhdSEN1gvq7izKf31PzyFCj1tmQcCu301OVZnHi6vKsLwoN26V4JOk
         wBLn6BZHHCBpg==
Received: by mail-lf1-f72.google.com with SMTP id f17-20020a0565123b1100b003fda40b659aso2314635lfv.23
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Uea0bdproVv4z3WyZyxDDyqLGB33jk6EQEyoqX83Q8=;
        b=NN0BOARjEfA7dPVOaIK/pDltMa1na+9rnr5tLlIThNKl4ZSJ/BWVvOKTByaAd4x4XN
         Gl7cm8D6U65WMqHKtGLN2pM01pL+hcOSO5xyHr874HwBfN7Jm1d5sUwxnmQlOlCYfzNy
         Yf44320im0+2JRrHcpsYl75uhWNlM+C2NeLGSWnkGVHk/1lUbH2zM9xKJAZ8+JbEGzyo
         +ZTMr64WEFMzbkqTIt3FgFqQ79ZdyvnKQQv+aN9j60WWaPChZE5lgF7pU9iPUdtY2Yua
         r/UWB0klWJV5RbUg7Z4XyI1tf4+P9q0Baul2EF2kFafje44xqE/Hh5Lho3EhAD1q3YcC
         /TUA==
X-Gm-Message-State: AOAM5327Y+iuNDwYdYw0r+jbDArMl2wayXIVA4EFppxspyX6Dv3bCVnC
        uIPQpSYCVokDn5XSncYprZ1x0fuOsLDhW4415sFg2IP08zKrxfaLceRNc1+yOEYJz6L4AIbtG3p
        i1VQDKZa93GEO6j/EFndjbf+XwRwzxMb/4QOSqSVEWA==
X-Received: by 2002:a05:651c:17a5:: with SMTP id bn37mr217487ljb.514.1634141051695;
        Wed, 13 Oct 2021 09:04:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqeU5lTKPPHhDYtsr9AjlGUCbeSplPdIXbDQSgZed89xJEEMa5nqP3SFKE7uZcDSEN/4aKYQ==
X-Received: by 2002:a05:651c:17a5:: with SMTP id bn37mr217462ljb.514.1634141051467;
        Wed, 13 Oct 2021 09:04:11 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v6sm1505098ljv.96.2021.10.13.09.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 09:04:11 -0700 (PDT)
Subject: Re: [PATCH 1/3] soc: samsung: exynos-chipid: Pass revision reg
 offsets
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211012171624.14338-1-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <677711d4-61d6-1bb8-f638-c4911ef5e1cb@canonical.com>
Date:   Wed, 13 Oct 2021 18:04:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012171624.14338-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2021 19:16, Sam Protsenko wrote:
> Old Exynos SoCs have both Product ID and Revision ID in one single
> register, while new SoCs tend to have two separate registers for those
> IDs. Implement handling of both cases by passing Revision ID register
> offsets in driver data.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/soc/samsung/exynos-chipid.c       | 67 +++++++++++++++++++----
>  include/linux/soc/samsung/exynos-chipid.h |  6 +-
>  2 files changed, 58 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
> index 5c1d0f97f766..1264a18aef97 100644
> --- a/drivers/soc/samsung/exynos-chipid.c
> +++ b/drivers/soc/samsung/exynos-chipid.c
> @@ -16,6 +16,7 @@
>  #include <linux/errno.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> @@ -24,6 +25,17 @@
>  
>  #include "exynos-asv.h"
>  
> +struct exynos_chipid_variant {
> +	unsigned int rev_reg;		/* revision register offset */
> +	unsigned int main_rev_bit;	/* main revision offset */

I understand it is offset of a bit within register, so how about:

unsigned int main_rev_shift;	/* main revision offset within rev_reg
unsigned int sub_rev_shift;	/* sub revision offset within rev_reg */

> +	unsigned int sub_rev_bit;	/* sub revision offset */
> +};
> +
> +struct exynos_chipid_info {
> +	u32 product_id;
> +	u32 revision;
> +};
> +
>  static const struct exynos_soc_id {
>  	const char *name;
>  	unsigned int id;
> @@ -49,31 +61,55 @@ static const char *product_id_to_soc_id(unsigned int product_id)
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(soc_ids); i++)
> -		if ((product_id & EXYNOS_MASK) == soc_ids[i].id)
> +		if (product_id == soc_ids[i].id)
>  			return soc_ids[i].name;
>  	return NULL;
>  }
>  
> +static int exynos_chipid_get_chipid_info(struct regmap *regmap,
> +		const struct exynos_chipid_variant *data,
> +		struct exynos_chipid_info *soc_info)
> +{
> +	int ret;
> +	unsigned int val, main_rev, sub_rev;
> +
> +	ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &val);
> +	if (ret < 0)
> +		return ret;
> +	soc_info->product_id = val & EXYNOS_MASK;
> +
> +	ret = regmap_read(regmap, data->rev_reg, &val);
> +	if (ret < 0)
> +		return ret;
> +	main_rev = (val >> data->main_rev_bit) & EXYNOS_REV_PART_LEN;
> +	sub_rev = (val >> data->sub_rev_bit) & EXYNOS_REV_PART_LEN;
> +	soc_info->revision = (main_rev << EXYNOS_REV_PART_OFF) | sub_rev;
> +
> +	return 0;
> +}
> +
>  static int exynos_chipid_probe(struct platform_device *pdev)
>  {
> +	const struct exynos_chipid_variant *drv_data;
> +	struct exynos_chipid_info soc_info;
>  	struct soc_device_attribute *soc_dev_attr;
>  	struct soc_device *soc_dev;
>  	struct device_node *root;
>  	struct regmap *regmap;
> -	u32 product_id;
> -	u32 revision;
>  	int ret;
>  
> +	drv_data = of_device_get_match_data(&pdev->dev);
> +	if (!drv_data)
> +		return -EINVAL;
> +
>  	regmap = device_node_to_regmap(pdev->dev.of_node);
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> -	ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &product_id);
> +	ret = exynos_chipid_get_chipid_info(regmap, drv_data, &soc_info);
>  	if (ret < 0)
>  		return ret;
>  
> -	revision = product_id & EXYNOS_REV_MASK;
> -
>  	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
>  				    GFP_KERNEL);
>  	if (!soc_dev_attr)
> @@ -86,8 +122,8 @@ static int exynos_chipid_probe(struct platform_device *pdev)
>  	of_node_put(root);
>  
>  	soc_dev_attr->revision = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> -						"%x", revision);
> -	soc_dev_attr->soc_id = product_id_to_soc_id(product_id);
> +						"%x", soc_info.revision);
> +	soc_dev_attr->soc_id = product_id_to_soc_id(soc_info.product_id);
>  	if (!soc_dev_attr->soc_id) {
>  		pr_err("Unknown SoC\n");
>  		return -ENODEV;
> @@ -106,7 +142,7 @@ static int exynos_chipid_probe(struct platform_device *pdev)
>  
>  	dev_info(soc_device_to_device(soc_dev),
>  		 "Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
> -		 soc_dev_attr->soc_id, product_id, revision);
> +		 soc_dev_attr->soc_id, soc_info.product_id, soc_info.revision);
>  
>  	return 0;
>  
> @@ -125,9 +161,18 @@ static int exynos_chipid_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct exynos_chipid_variant exynos4210_chipid_drv_data = {
> +	.rev_reg	= 0x0,
> +	.main_rev_bit	= 0,
> +	.sub_rev_bit	= 4,
> +};
> +
>  static const struct of_device_id exynos_chipid_of_device_ids[] = {
> -	{ .compatible = "samsung,exynos4210-chipid" },
> -	{}
> +	{
> +		.compatible	= "samsung,exynos4210-chipid",
> +		.data		= &exynos4210_chipid_drv_data,
> +	},
> +	{ }
>  };
>  
>  static struct platform_driver exynos_chipid_driver = {
> diff --git a/include/linux/soc/samsung/exynos-chipid.h b/include/linux/soc/samsung/exynos-chipid.h
> index 8bca6763f99c..5270725ba408 100644
> --- a/include/linux/soc/samsung/exynos-chipid.h
> +++ b/include/linux/soc/samsung/exynos-chipid.h
> @@ -9,10 +9,8 @@
>  #define __LINUX_SOC_EXYNOS_CHIPID_H
>  
>  #define EXYNOS_CHIPID_REG_PRO_ID	0x00
> -#define EXYNOS_SUBREV_MASK		(0xf << 4)
> -#define EXYNOS_MAINREV_MASK		(0xf << 0)
> -#define EXYNOS_REV_MASK			(EXYNOS_SUBREV_MASK | \
> -					 EXYNOS_MAINREV_MASK)
> +#define EXYNOS_REV_PART_LEN		0xf

EXYNOS_REV_PART_MASK

> +#define EXYNOS_REV_PART_OFF		4

define EXYNOS_REV_PART_SHIFT

>  #define EXYNOS_MASK			0xfffff000
>  
>  #define EXYNOS_CHIPID_REG_PKG_ID	0x04
> 


Best regards,
Krzysztof
