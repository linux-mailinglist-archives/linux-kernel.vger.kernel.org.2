Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377BD434BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhJTNCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27019 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbhJTNCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634734796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ct6AzxsLZvZzaTtpXmpX/t4/3JdzVca+UxLIgdtMXLM=;
        b=YDGsucE7hDkTMzO9tLKYdKAlUUIEKW8BafSLSG7L0BIGqyVXTfl2DH/FEFDf2jKqSZdO7D
        jDdKn1xMcXv91NSt+AO7nTBlRBwaF3TA7wZVWMQ0woJxzNqf8+SHUtatowpzZYFxgJ3Za0
        4cYBfl0zEBKnrVh1DXo2+i8trrOoR+k=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-NFgJEYrEMOecsQX6q147ww-1; Wed, 20 Oct 2021 08:59:55 -0400
X-MC-Unique: NFgJEYrEMOecsQX6q147ww-1
Received: by mail-pl1-f197.google.com with SMTP id r11-20020a170902be0b00b0013f4f30d71cso9517258pls.21
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ct6AzxsLZvZzaTtpXmpX/t4/3JdzVca+UxLIgdtMXLM=;
        b=J6QJhmdHinNOJM8bA8JLwVrlNag2iefWeJ7dcDm0YkBXCU5MOGgpcE6dr5WbRvEiJx
         LBQDaZMdo+pdCIODlxVHnjl52zt/Q6rj0cWVOkRbS3Dacw7gDnHg48jdWz3EUmFpL+1Z
         nL9oAlxFe1aVUQFYJKpzR7cVjB5okTHqMP9ikJ+ZIOfrFnN0FcpnfY2IQYjumMa6u0Ho
         WQZnTq6XuDTYt7kPQ35lWQHICwS8qg2leKfZt39MdCBB5toijnCXgmHmUrgpI7dOmLqy
         pAiUaotbN7EQV3O14DjqwKmIuYgxuXpM7bZTxZYfFqXKNNuD5Pm1DLpXuuvvFanfPpjS
         Bhgw==
X-Gm-Message-State: AOAM531S21+j378lyFMv68CABg0Rl47yv3snefgjbdNZ6BfU9DdNmr3m
        7/BfpapEvfc4fNVb2c5bCpDFUlbrcjhU6ObA4PhJr6wVaMoPkZaKFiNWbVK76PhFwTOG3EZM5Nj
        y9tzE6WAmeVDPuJc+9IO/DD5w
X-Received: by 2002:a17:90b:3e85:: with SMTP id rj5mr7227126pjb.104.1634734794571;
        Wed, 20 Oct 2021 05:59:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqOZtXOyH6mb3QAlfIxTB2ohMzAcq6IrqWoqI+2PTacRqzqUfEWH0x962GShvqgmR6u6JaaA==
X-Received: by 2002:a17:90b:3e85:: with SMTP id rj5mr7227072pjb.104.1634734794020;
        Wed, 20 Oct 2021 05:59:54 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i13sm2257483pgf.77.2021.10.20.05.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:59:53 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] fpga: dfl: fme: Clear fme global errors at driver
 init
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20211019231545.47118-1-russell.h.weight@intel.com>
 <20211019231545.47118-3-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0b911b70-1cea-2d9e-1dfa-d1c743eae396@redhat.com>
Date:   Wed, 20 Oct 2021 05:59:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211019231545.47118-3-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/19/21 4:15 PM, Russ Weight wrote:
> When the fme-error driver initializes, log any pre-existing errors and
> clear them. To avoid code replication, common code is gathered into
> a common fme_err_clear() function and a structure (err_reg) is created
> to describe each of the error registers, the corresponding mask
> registers, and the default mask for each register.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>   drivers/fpga/dfl-fme-error.c | 128 +++++++++++++++++++++++------------
>   1 file changed, 84 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
> index 51c2892ec06d..44da7b30c469 100644
> --- a/drivers/fpga/dfl-fme-error.c
> +++ b/drivers/fpga/dfl-fme-error.c
> @@ -39,6 +39,27 @@
>   
>   #define ERROR_MASK		GENMASK_ULL(63, 0)
>   
> +struct err_reg {
> +	char *name;
> +	u32 err_offset;
> +	u32 mask_offset;
> +	u32 mask_value;
> +};
> +
> +static struct err_reg pcie0_reg = {
> +	.name = "PCIE0",
> +	.err_offset = PCIE0_ERROR,
> +	.mask_offset = PCIE0_ERROR_MASK,
> +	.mask_value = 0ULL
> +};
> +
> +static struct err_reg pcie1_reg = {
> +	.name = "PCIE1",
> +	.err_offset = PCIE1_ERROR,
> +	.mask_offset = PCIE1_ERROR_MASK,
> +	.mask_value = 0ULL
> +};
> +
Can these be stored in an array ?
>   static ssize_t pcie0_errors_show(struct device *dev,
>   				 struct device_attribute *attr, char *buf)
>   {
> @@ -55,31 +76,48 @@ static ssize_t pcie0_errors_show(struct device *dev,
>   	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
>   }
>   
> -static ssize_t pcie0_errors_store(struct device *dev,
> -				  struct device_attribute *attr,
> -				  const char *buf, size_t count)
> +static int fme_err_clear(struct device *dev, struct err_reg *reg,
> +			 u64 err, bool clear_all)
>   {
>   	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
>   	void __iomem *base;
>   	int ret = 0;
> -	u64 v, val;
> -
> -	if (kstrtou64(buf, 0, &val))
> -		return -EINVAL;
> +	u64 v;
>   
>   	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
>   
>   	mutex_lock(&pdata->lock);
> -	writeq(GENMASK_ULL(63, 0), base + PCIE0_ERROR_MASK);
> +	writeq(GENMASK_ULL(63, 0), base + reg->mask_offset);
>   
> -	v = readq(base + PCIE0_ERROR);
> -	if (val == v)
> -		writeq(v, base + PCIE0_ERROR);
> -	else
> +	v = readq(base + reg->err_offset);
> +	if (clear_all || err == v) {
> +		if (clear_all && v)
clear_all will over report.
> +			dev_warn(dev, "%s: %s Errors: 0x%llx\n",
> +				 __func__, reg->name, v);
> +
> +		writeq(v, base + reg->err_offset);
> +	} else {
>   		ret = -EINVAL;
> +	}
>   
> -	writeq(0ULL, base + PCIE0_ERROR_MASK);
> +	writeq(reg->mask_value, base + reg->mask_offset);
>   	mutex_unlock(&pdata->lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t pcie0_errors_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	u64 val;
> +	int ret;
> +
> +	if (kstrtou64(buf, 0, &val))
> +		return -EINVAL;
> +
> +	ret = fme_err_clear(dev, &pcie0_reg, val, false);
> +
>   	return ret ? ret : count;
>   }
>   static DEVICE_ATTR_RW(pcie0_errors);
> @@ -104,27 +142,14 @@ static ssize_t pcie1_errors_store(struct device *dev,
>   				  struct device_attribute *attr,
>   				  const char *buf, size_t count)
>   {
This looks like a copy of pcie0_errors_store can these functions be 
consolidated ?
> -	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> -	void __iomem *base;
> -	int ret = 0;
> -	u64 v, val;
> +	u64 val;
> +	int ret;
>   
>   	if (kstrtou64(buf, 0, &val))
>   		return -EINVAL;
>   
> -	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
> +	ret = fme_err_clear(dev, &pcie1_reg, val, false);
>   
> -	mutex_lock(&pdata->lock);
> -	writeq(GENMASK_ULL(63, 0), base + PCIE1_ERROR_MASK);
> -
> -	v = readq(base + PCIE1_ERROR);
> -	if (val == v)
> -		writeq(v, base + PCIE1_ERROR);
> -	else
> -		ret = -EINVAL;
> -
> -	writeq(0ULL, base + PCIE1_ERROR_MASK);
> -	mutex_unlock(&pdata->lock);
>   	return ret ? ret : count;
>   }
>   static DEVICE_ATTR_RW(pcie1_errors);
> @@ -218,29 +243,26 @@ static ssize_t fme_errors_store(struct device *dev,
>   				struct device_attribute *attr,
>   				const char *buf, size_t count)
>   {
> -	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> +	static struct err_reg fme_reg = {
> +		.name = "FME",
> +		.err_offset = FME_ERROR,
> +		.mask_offset = FME_ERROR_MASK,
> +		.mask_value = 0ULL
> +	};
>   	void __iomem *base;
> -	u64 v, val;
> -	int ret = 0;
> +	u64 val;
> +	int ret;
>   
>   	if (kstrtou64(buf, 0, &val))
>   		return -EINVAL;
>   
> +	/* Workaround: disable MBP_ERROR if feature revision is 0 */
>   	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
> +	if (!dfl_feature_revision(base))
> +		fme_reg.mask_value = MBP_ERROR;
>   
> -	mutex_lock(&pdata->lock);
> -	writeq(GENMASK_ULL(63, 0), base + FME_ERROR_MASK);
> +	ret = fme_err_clear(dev, &fme_reg, val, false);
>   
> -	v = readq(base + FME_ERROR);
> -	if (val == v)
> -		writeq(v, base + FME_ERROR);
> -	else
> -		ret = -EINVAL;
> -
> -	/* Workaround: disable MBP_ERROR if feature revision is 0 */
> -	writeq(dfl_feature_revision(base) ? 0ULL : MBP_ERROR,
> -	       base + FME_ERROR_MASK);
> -	mutex_unlock(&pdata->lock);
>   	return ret ? ret : count;
>   }
>   static DEVICE_ATTR_RW(fme_errors);
> @@ -338,6 +360,24 @@ static void fme_err_mask(struct device *dev, bool mask)
>   static int fme_global_err_init(struct platform_device *pdev,
>   			       struct dfl_feature *feature)
>   {
> +	static struct err_reg fme_reg = {
> +		.name = "FME",
> +		.err_offset = FME_ERROR,
> +		.mask_offset = FME_ERROR_MASK,
> +		.mask_value = 0ULL
> +	};
> +	void __iomem *base;
> +
> +	/* Workaround: disable MBP_ERROR if feature revision is 0 */
> +	base = dfl_get_feature_ioaddr_by_id(&pdev->dev,
> +					    FME_FEATURE_ID_GLOBAL_ERR);
> +	if (!dfl_feature_revision(base))
> +		fme_reg.mask_value = MBP_ERROR;

A similar block above to set fme_reg.mask_value.

These should be consolidated.

> +
> +	(void)fme_err_clear(&pdev->dev, &pcie0_reg, 0ULL, true);

remove casting return to (void)

Tom

> +	(void)fme_err_clear(&pdev->dev, &pcie1_reg, 0ULL, true);
> +	(void)fme_err_clear(&pdev->dev, &fme_reg, 0ULL, true);
> +
>   	fme_err_mask(&pdev->dev, false);
>   
>   	return 0;

