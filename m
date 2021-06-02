Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1C8398E11
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhFBPQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:16:09 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:44715 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhFBPQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:16:07 -0400
Received: by mail-pg1-f171.google.com with SMTP id 29so2463146pgu.11;
        Wed, 02 Jun 2021 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EY89WvFPXItdyL7n52M5NUf6/h0uiQx9JjQhgnr22JY=;
        b=KwFqdi2QeEjmXUXeSJjiszKwvxb25mTEyUFX64eOGEdR5GcefzXcN48k+CcD7fmk8Y
         oZKwE5P8yvBLJ9SZlAp5kkg3/eeJABXOjC+AhaxH9+00oW1j/Hw3sDMI0OqZU8k3Rkn2
         +0PHSBkJCmoM9lM/5z1TvvA3p6WgOGdQvJen4ZLW84EBgvL/3exaQC0goHX/RVh8/YAI
         f5IDlGG5KU0tiNneiC6/f1GmffdkuDGyBrj3Xpji6Xs/EzZYqhPC6Ju6jtxFeMD5Y7gX
         kjjNo0MWBB1Ho8Xqw/ufSwE7P2oNnGhNNOySCvX+jDxhLot7CWJBtD+vUZWAC3ZKVQKB
         IWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EY89WvFPXItdyL7n52M5NUf6/h0uiQx9JjQhgnr22JY=;
        b=r7sIsm+zxsJuOBEQKu9x1aJhqNnPNzIgzW0sO47VtY2PB/yj3S56HMwj6nWVTy4D1X
         vczKDSjbXW+sWh3MJmoDb3PKs+vEO9lBB9XJpUuCoM5/IjdYC0p9hOkOM5IBuGqf4Hh4
         YoBoblnvYjJv67BADF/pBwxJ0SrQ+dnRZcwJ9ocEEeLeRKfEETau/ciyVKrBQ14b3GlI
         RHonM/POwZ6YdPv2YjtKlXh5fty8UhhJJjfqjZtWFamlC5HshVlC1C8ePC0lvIL/rGQX
         tHc0undiCNbhb5+HGS/91bD6M44wBHNcESHwyhJDRKDb9tU7+eMwK2LlZLhClY5Hv7+a
         9vuA==
X-Gm-Message-State: AOAM531V8KgBiFV6E0W3n/Vh09y/NK/7NBo5uakTtqyfr3zAt3egSTdD
        dIidiFxjFf8d0C6599JTycMo9caN3xU=
X-Google-Smtp-Source: ABdhPJxtaSanZi8Be5s2D+w8EQ0HqXEmErF7seavVsPW78lcs1gD9m4H8EhHVxdP+Dsq+074J8inUw==
X-Received: by 2002:a05:6a00:1350:b029:2e9:ac26:a5ba with SMTP id k16-20020a056a001350b02902e9ac26a5bamr21769069pfu.15.1622646803821;
        Wed, 02 Jun 2021 08:13:23 -0700 (PDT)
Received: from [172.30.1.14] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id f6sm33475pfb.28.2021.06.02.08.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 08:13:23 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] extcon: sm5502: Refactor driver to use
 chip-specific struct
To:     Stephan Gerhold <stephan@gerhold.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20210601200007.218802-1-stephan@gerhold.net>
 <20210601200007.218802-3-stephan@gerhold.net>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <b3a9eed8-0d7c-e935-36d4-13918f5b7b21@gmail.com>
Date:   Thu, 3 Jun 2021 00:13:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210601200007.218802-3-stephan@gerhold.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 6. 2. 오전 5:00, Stephan Gerhold wrote:
> Prepare for supporting SM5504 in the extcon-sm5502 driver by replacing
> enum sm5504_types with a struct sm5504_type that stores the chip-specific
> definitions. This struct can then be defined separately for SM5504
> without having to add if (type == TYPE_SM5504) everywhere in the code.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Changes in v3: New patch to simplify diff on next patch
> ---
>   drivers/extcon/extcon-sm5502.c | 64 +++++++++++++++++++++-------------
>   drivers/extcon/extcon-sm5502.h |  4 ---
>   2 files changed, 40 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
> index 9f40bb9f1f81..951f6ca4c479 100644
> --- a/drivers/extcon/extcon-sm5502.c
> +++ b/drivers/extcon/extcon-sm5502.c
> @@ -40,17 +40,13 @@ struct sm5502_muic_info {
>   	struct i2c_client *i2c;
>   	struct regmap *regmap;
>   
> +	const struct sm5502_type *type;
>   	struct regmap_irq_chip_data *irq_data;
> -	struct muic_irq *muic_irqs;
> -	unsigned int num_muic_irqs;
>   	int irq;
>   	bool irq_attach;
>   	bool irq_detach;
>   	struct work_struct irq_work;
>   
> -	struct reg_data *reg_data;
> -	unsigned int num_reg_data;
> -
>   	struct mutex mutex;
>   
>   	/*
> @@ -62,6 +58,17 @@ struct sm5502_muic_info {
>   	struct delayed_work wq_detcable;
>   };
>   
> +struct sm5502_type {
> +	struct muic_irq *muic_irqs;
> +	unsigned int num_muic_irqs;
> +	const struct regmap_irq_chip *irq_chip;
> +
> +	struct reg_data *reg_data;
> +	unsigned int num_reg_data;
> +
> +	int (*parse_irq)(struct sm5502_muic_info *info, int irq_type);
> +};
> +
>   /* Default value of SM5502 register to bring up MUIC device. */
>   static struct reg_data sm5502_reg_data[] = {
>   	{
> @@ -502,11 +509,11 @@ static irqreturn_t sm5502_muic_irq_handler(int irq, void *data)
>   	struct sm5502_muic_info *info = data;
>   	int i, irq_type = -1, ret;
>   
> -	for (i = 0; i < info->num_muic_irqs; i++)
> -		if (irq == info->muic_irqs[i].virq)
> -			irq_type = info->muic_irqs[i].irq;
> +	for (i = 0; i < info->type->num_muic_irqs; i++)
> +		if (irq == info->type->muic_irqs[i].virq)
> +			irq_type = info->type->muic_irqs[i].irq;
>   
> -	ret = sm5502_parse_irq(info, irq_type);
> +	ret = info->type->parse_irq(info, irq_type);

Looks good to me. But there is only one comment.
Need to check the 'parse_irq' as following:

If you agree this suggestion, I'll apply with following changes by myself:

	if (!info->type->parse_irq) {
		dev_err(info->dev, "failed to handle irq due to parse_irq\n",
		return IRQ_NONE;
	}


(snip)

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
