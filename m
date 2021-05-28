Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DE8393EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbhE1IZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbhE1IZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:25:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AF0C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:23:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n2so2478681wrm.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0oUI3u53bdG3Er4AB4Y5LXzzXv5yuaYsKkPzABPRhCQ=;
        b=tw34OSi23570DQBPYXaWAZ3fG/p2ZOYMmmX2Ra8ithPpG/tV3sQ432VisVXT0mjS7t
         4weRFc3VhNUlI8Hu0v68F0pzCA24MukNnXnOBnsydL8k/6ku3aMTfeUQurzVEYNlf78+
         L22yk/4iKg7sJuQAw1dH4JxaNbPefI00Nqi9zrZbUuclo59O+16Iim1xJ9puezFF1QaD
         H2UyK0vSK0uDKm7tuekYYq1FZR4t99Mihsn2/fStyt+wyYNXgNStBAZZhhvz6pzf6PLf
         vWs1qisw7Be+ES//lFLh3DyBzHrXvta4PppUE+b1Ikf0onevsxX3zhKHc+0CHPSoCAL7
         QIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0oUI3u53bdG3Er4AB4Y5LXzzXv5yuaYsKkPzABPRhCQ=;
        b=jAzhC0XycEQIJmhxx3NbpSnZc+eOh6x2Ad+jxIRe+NegBirw/lu1AfP0BEcLp8cPRh
         hqyPaRsshYBQO/5W6MfZriirgSJUfCYmAGt4BYi5wb6Iljqvtc+Lkp7VR9BSCMt4vwv3
         FIMkJEs+DE5NLvCRsC0vHAtSQ1HLYU2eaS+07s1McDsPnwoz1aZwTGUdWoX5OPR1Hji5
         FECT4n5HpyEJpqpqpMprMcVa48auwwvV1IgW8xHUHS2E4ok4aAyHPqkA4zvm4pN+WrfV
         nrrkyLh3tRyaUk5tBlH77vf0LbQnkZofifXGbn3VnuQfLavFuruDbAiiO/PRLKLf5bN5
         PugQ==
X-Gm-Message-State: AOAM530++OkYf25GUZEw9Fdfkbz/kXOz8MUzG7kK3wzx7OhxTY+KQeod
        topLJKCu7eAMu9yxECQaBf+6pA==
X-Google-Smtp-Source: ABdhPJxozhmHQYrxSpOXxyrPf380ZSAIcXhVaT5EeouK5WgNmz/l3aylZMYlLVoApOZ8NRboQ8vnnA==
X-Received: by 2002:a5d:6d84:: with SMTP id l4mr7267282wrs.213.1622190229864;
        Fri, 28 May 2021 01:23:49 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id s83sm5778721wms.16.2021.05.28.01.23.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 May 2021 01:23:49 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] nvmem: bootcount: add bootcount driver
To:     Nandor Han <nandor.han@vaisala.com>, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= 
        <vesa.jaaskelainen@vaisala.com>,
        Tomas Melin <tomas.melin@vaisala.com>
References: <cover.1620211180.git.nandor.han@vaisala.com>
 <43e36704e9acbf89b3b29113554d3a79417d42db.1620211180.git.nandor.han@vaisala.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b973f433-5aa6-5c93-4d60-1017495ae0a7@linaro.org>
Date:   Fri, 28 May 2021 09:23:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <43e36704e9acbf89b3b29113554d3a79417d42db.1620211180.git.nandor.han@vaisala.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/2021 11:42, Nandor Han wrote:
> In order to have a robust system we want to be able to identify and take
> actions if a boot loop occurs. This is possible by using the bootcount
> feature, which can be used to identify the number of times device has
> booted since bootcount was last time reset. Bootcount feature (1)
> requires a collaboration between bootloader and user-space, where
> the bootloader will increase a counter and user-space reset it.
> If the counter is not reset and a pre-established threshold is reached,
> bootloader can react and take action.
> 
> This is the kernel side implementation, which can be used to
> identify the number of times device has booted since bootcount was
> last time reset.
> 

If I understand this correctly, this driver is basically exposing a 
nvmem cell via sysfs.

Firstly, This sounds like totally a generic functionality that needs to 
go into nvmem core rather than individual drivers.

Do you see any reason for this not be in core?

Secondly, creating sysfs entries like this in probe will race with 
userspace udev. udev might not notice this new entry in such cases.

Thirdly, You would need to document this in Documentation/ABI/

Finally I noticed that the changes to snvs_lpgpr.c  have not been cced 
to the original author.


--srini

> The driver supports both 16 and 32 bits NVMEM cell size.
> 
> 1) https://www.denx.de/wiki/DULG/UBootBootCountLimit
> 
> Signed-off-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> Signed-off-by: Nandor Han <nandor.han@vaisala.com>
> ---
>   drivers/nvmem/Kconfig           |  10 ++
>   drivers/nvmem/Makefile          |   1 +
>   drivers/nvmem/bootcount-nvmem.c | 195 ++++++++++++++++++++++++++++++++
>   3 files changed, 206 insertions(+)
>   create mode 100644 drivers/nvmem/bootcount-nvmem.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index dd2019006838..d5413c937350 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -288,4 +288,14 @@ config NVMEM_BRCM_NVRAM
>   	  This driver provides support for Broadcom's NVRAM that can be accessed
>   	  using I/O mapping.
>   
> +config BOOTCOUNT_NVMEM
> +	bool "Bootcount driver using nvmem registers"
> +	depends on OF
> +	depends on NVMEM
> +	help
> +	  Driver that implements the bootcount feature support using a
> +	  NVMEM cell as a backend. The driver supports 2 and 4 bytes
> +	  size cells.
> +
> +	  Say y here to enable bootcount support.
>   endif
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index bbea1410240a..4c77679bbf0d 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -59,3 +59,4 @@ obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
>   nvmem-rmem-y			:= rmem.o
>   obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
>   nvmem_brcm_nvram-y		:= brcm_nvram.o
> +obj-$(CONFIG_BOOTCOUNT_NVMEM)	+= bootcount-nvmem.o
> diff --git a/drivers/nvmem/bootcount-nvmem.c b/drivers/nvmem/bootcount-nvmem.c
> new file mode 100644
> index 000000000000..7d9b6caefc2b
> --- /dev/null
> +++ b/drivers/nvmem/bootcount-nvmem.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Vaisala Oyj. All rights reserved.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +/* Default magic values from u-boot bootcount drivers */
> +#define BOOTCOUNT_NVMEM_DEFAULT_MAGIC_VAL16 0xBC00
> +#define BOOTCOUNT_NVMEM_DEFAULT_MAGIC_VAL32 0xB001C041
> +
> +struct bootcount_nvmem {
> +	struct nvmem_cell *nvmem;
> +	u32 magic;
> +	u32 mask;
> +	size_t bytes_count;
> +};
> +
> +static ssize_t value_store(struct device *dev, struct device_attribute *attr,
> +			   const char *buf, size_t count)
> +{
> +	struct bootcount_nvmem *bootcount = dev_get_drvdata(dev);
> +	u32 regval;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 0, &regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Check if the value fits */
> +	if ((regval & ~(bootcount->mask)) != 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * In case we use 2 bytes for saving the value we need to take
> +	 * in consideration the endianness of the system. Because of this
> +	 * we mirror the 2 bytes from one side to another.
> +	 * This way, regardless of endianness, the value will be written
> +	 * in the correct order.
> +	 */
> +	if (bootcount->bytes_count == 2) {
> +		regval &= 0xffff;
> +		regval |= (regval & 0xffff) << 16;
> +	}
> +
> +	regval = (~bootcount->mask & bootcount->magic) |
> +		 (regval & bootcount->mask);
> +	ret = nvmem_cell_write(bootcount->nvmem, &regval,
> +			       bootcount->bytes_count);
> +	if (ret < 0)
> +		return ret;
> +	else if (ret != bootcount->bytes_count)
> +		ret = -EIO;
> +	else
> +		ret = count;
> +
> +	return ret;
> +}
> +
> +static ssize_t value_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct bootcount_nvmem *bootcount = dev_get_drvdata(dev);
> +	u32 regval;
> +	void *val;
> +	size_t len;
> +	int ret;
> +
> +	val = nvmem_cell_read(bootcount->nvmem, &len);
> +	if (IS_ERR(val))
> +		return PTR_ERR(val);
> +
> +	if (len != bootcount->bytes_count) {
> +		kfree(val);
> +		return -EINVAL;
> +	}
> +
> +	if (bootcount->bytes_count == 2)
> +		regval = *(u16 *)val;
> +	else
> +		regval = *(u32 *)val;
> +
> +	kfree(val);
> +
> +	if ((regval & ~bootcount->mask) == bootcount->magic)
> +		ret = scnprintf(buf, PAGE_SIZE, "%u\n",
> +				(unsigned int)(regval & bootcount->mask));
> +	else {
> +		dev_warn(dev, "invalid magic value\n");
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static DEVICE_ATTR_RW(value);
> +
> +static int bootcount_nvmem_probe(struct platform_device *pdev)
> +{
> +	struct bootcount_nvmem *bootcount;
> +	int ret;
> +	u32 bits;
> +	void *val = NULL;
> +	size_t len;
> +
> +	bootcount = devm_kzalloc(&pdev->dev, sizeof(struct bootcount_nvmem),
> +				 GFP_KERNEL);
> +	if (!bootcount)
> +		return -ENOMEM;
> +
> +	bootcount->nvmem = devm_nvmem_cell_get(&pdev->dev, "bootcount-regs");
> +	if (IS_ERR(bootcount->nvmem)) {
> +		if (PTR_ERR(bootcount->nvmem) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "cannot get 'bootcount-regs'\n");
> +		return PTR_ERR(bootcount->nvmem);
> +	}
> +
> +	/* detect cell dimensions */
> +	val = nvmem_cell_read(bootcount->nvmem, &len);
> +	if (IS_ERR(val))
> +		return PTR_ERR(val);
> +	kfree(val);
> +	val = NULL;
> +
> +	if (len != 2 && len != 4) {
> +		dev_err(&pdev->dev, "unsupported register size\n");
> +		return -EINVAL;
> +	}
> +
> +	bootcount->bytes_count = len;
> +
> +	platform_set_drvdata(pdev, bootcount);
> +
> +	ret = device_create_file(&pdev->dev, &dev_attr_value);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to export bootcount value\n");
> +		return ret;
> +	}
> +
> +	bits = bootcount->bytes_count << 3;
> +	bootcount->mask = GENMASK((bits >> 1) - 1, 0);
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "linux,bootcount-magic",
> +				   &bootcount->magic);
> +	if (ret == -EINVAL) {
> +		if (bootcount->bytes_count == 2)
> +			bootcount->magic = BOOTCOUNT_NVMEM_DEFAULT_MAGIC_VAL16;
> +		else
> +			bootcount->magic = BOOTCOUNT_NVMEM_DEFAULT_MAGIC_VAL32;
> +		ret = 0;
> +	} else if (ret) {
> +		dev_err(&pdev->dev,
> +			"failed to parse linux,bootcount-magic, error: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	bootcount->magic &= ~bootcount->mask;
> +
> +	return ret;
> +}
> +
> +static int bootcount_nvmem_remove(struct platform_device *pdev)
> +{
> +	device_remove_file(&pdev->dev, &dev_attr_value);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id bootcount_nvmem_match[] = {
> +	{ .compatible = "linux,bootcount-nvmem" },
> +	{},
> +};
> +
> +static struct platform_driver bootcount_nvmem_driver = {
> +	.driver = {
> +		.name = "bootcount-nvmem",
> +		.of_match_table = bootcount_nvmem_match,
> +	},
> +	.probe = bootcount_nvmem_probe,
> +	.remove = bootcount_nvmem_remove,
> +};
> +
> +module_platform_driver(bootcount_nvmem_driver);
> +
> +MODULE_DEVICE_TABLE(of, bootcount_nvmem_match);
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Vaisala Oyj");
> +MODULE_DESCRIPTION("Bootcount driver using nvmem compatible registers");
> 
