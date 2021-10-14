Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4239F42D34E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJNHN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:13:58 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:41486
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229985AbhJNHN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:13:56 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1AD5E40021
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 07:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634195511;
        bh=FM8pSeToFOPUhDjYF23znrZE5dzxI9k0mVFzTSi5BcI=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=uN3loL0wxXImJV78Wx8oeqlYiPnAhACEXptB7gsNBCTlSLJavV6RG1eaVwnIAf3cu
         tZicGVxpPibK8tyigG/zHro1RetDJWlG/t+J7UimtA15T6krcCkVveOJnD/Vre5XtR
         SM3rNXdlufgGcggJCSebi9iE67r64Lg33vxtjE4aJpWH/Ui/jmv7YJCRLOwVRY91+P
         uz66VwQQgkLH1nrjvZsQ3ouU4F5DC42p8NMQj3FAGIY4ibGMBWQJBW3g4xZ1v85/5J
         b99rhIgZvD9ADJVFHLg9R6XLAnT/BHpmpGhM1lcnjgDZ+XeS4OeZ6xncxPG6lNI7Vt
         s7Sg1NqUCXsRg==
Received: by mail-lf1-f70.google.com with SMTP id m16-20020a056512115000b003fdb79f743fso1301509lfg.16
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 00:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FM8pSeToFOPUhDjYF23znrZE5dzxI9k0mVFzTSi5BcI=;
        b=hAbhevs4+y569G20vw0s9DoXk16+KBeAGc2frIdITlJdVUK2L3w80ZZlWMBEPjPm9q
         htYPHeg6K1kdhFvmA1Fdd5/756uR74FdqaIDdsaJ8Hw+bdxETB1deOpgYcIkRgUESvAR
         aEu2XYyi1ucXlFU4f2UyAg5nhrlTPj+GmTKozlMD27PQcosrlzIZm71ZN3XL+GvN0fqI
         EsQyvdiPorE3MzOlqMxzwy8GHu47IMUC4UK8atslXJroLPxBEcKRCBg/+nPqiXZVr1tq
         cdwlSEdPmkRV50hiHH4UwyG+uE0JNRZK6CZiMSOISh1IXjfvlufV0kjb+qCubEIo3XHZ
         c3oA==
X-Gm-Message-State: AOAM530nDQv/lOYsr8cMr+5W+SULMhmMIBwEiSLez1MNPDNNNB8LVZI6
        OMy+QELyw5Wc3O9hO7JUlh1WRaUUpH42BZMYEl6e4qRE+JsvM2iqfr2jqVCEL3K+TQ224XZy4vG
        GSLtUzjnANk+LLHCx8EInsH0OLGTRQUFS1GgYzgqjCw==
X-Received: by 2002:a05:6512:2307:: with SMTP id o7mr3430115lfu.595.1634195509107;
        Thu, 14 Oct 2021 00:11:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgSsaV15NSk47z5aPcuHSvstgvfiWkc6BkOCzPyQ4J2LhnPiscCdV+nbNisZxYgXByuDZ7Eg==
X-Received: by 2002:a05:6512:2307:: with SMTP id o7mr3430101lfu.595.1634195508926;
        Thu, 14 Oct 2021 00:11:48 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id 2sm150078lfz.145.2021.10.14.00.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 00:11:48 -0700 (PDT)
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211013202110.31701-1-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 1/3] soc: samsung: exynos-chipid: Pass revision reg
 offsets
Message-ID: <1cd31098-ba9d-f2e3-e34c-5bada00a2696@canonical.com>
Date:   Thu, 14 Oct 2021 09:11:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211013202110.31701-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2021 22:21, Sam Protsenko wrote:
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
> index 5c1d0f97f766..7837331fb753 100644
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
> +	unsigned int main_rev_shift;	/* main revision offset in rev_reg */
> +	unsigned int sub_rev_shift;	/* sub revision offset in rev_reg */
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

Isn't this the same register as EXYNOS_CHIPID_REG_PRO_ID?

> +	if (ret < 0)
> +		return ret;
> +	main_rev = (val >> data->main_rev_shift) & EXYNOS_REV_PART_MASK;
> +	sub_rev = (val >> data->sub_rev_shift) & EXYNOS_REV_PART_MASK;
> +	soc_info->revision = (main_rev << EXYNOS_REV_PART_SHIFT) | sub_rev;
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
> +	.main_rev_shift	= 0,
> +	.sub_rev_shift	= 4,

The code does not look correct here. Subrev is at 0:3 bits, mainrev is
at 4:7.

Did you test it that it produces same result? Looks not - I gave it a
try and got wrong revision.


Best regards,
Krzysztof
