Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776E73B9839
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 23:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhGAVg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 17:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbhGAVgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 17:36:55 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE38C061762;
        Thu,  1 Jul 2021 14:34:23 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 110-20020a9d0a770000b0290466fa79d098so8039952otg.9;
        Thu, 01 Jul 2021 14:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zHaOcbhEOP65MYJ0K1yzWm33CLB3MFmc9gWhgP2wXaY=;
        b=rkqHUlsGlzPxAhoH7T5uLJncAlKgs9ugPtSWKeoCmE4L0ZBdZCM98Pza7jQAMAf42d
         z0dnAxtAHQSHh+HsTLphvB8rTGgxIv4z0tSC+kgeuSLCbWEnaePN5omIk0OQiJyURsUB
         Rqi9IqDosvCi8f4JlSGnxdPwK+AqXHHgq19JUG6SFouuy6JPZutmSKtDInzpIQMQZBW4
         1AUL24mk+M5JM9FY8p9OzG+Ogo18RM9tLY7pUgT6Qt4rEjOuNi5bYHkT+Bdhxi6HhLnv
         gzYsvjn2Gxgt1w7kALIPmpdicLoOD3iyOXjAdGWClYT4XlDuwzHzarXwq56jYRXrOOuQ
         UVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zHaOcbhEOP65MYJ0K1yzWm33CLB3MFmc9gWhgP2wXaY=;
        b=BDKV6r4clmJlLBHtJS4zsuIRHcm7bcIihgGS6TPZGvOtyZ5f2eftiVPnDOnCq1bzFH
         P/xRf6FdOf5+MS4VHM1SATkUNJtc+b3SpSiG1uiXmySKOJWV4GoMZz43mJzGPzfFgPhp
         emvlZq7jBa93esVPF0cC7lZrbjAJIMMmgj5f5aKdocZ2pXmp88xPS7xk15hlcAsRFesg
         IMp7NIOT3t6Bl602Gj6isyi5rWNvFBmE2C01g3ULwj/G5AfuKXJEo7U2yECpgd732qqG
         QYGs/SkPcFnRBG8XCrJn0/9F2SLApuZ1oI0fszJbMEHZKP4BLpNa1g0a58uTbkh7rxIh
         5ChA==
X-Gm-Message-State: AOAM5337xLLwGgX9QBHH3+WD/oCnRquflAaKSSAauRyUJrfBXW/kJT3D
        MSi6VjCtQguTsdiUH0BT4uE=
X-Google-Smtp-Source: ABdhPJyoSr8NM2yT52A+wLopriUYiot4+d+HlIMbiI5BEev+z6QMQpUN36Pmfe1GSV6Y3RHLDk7V1A==
X-Received: by 2002:a9d:6244:: with SMTP id i4mr1664023otk.136.1625175262965;
        Thu, 01 Jul 2021 14:34:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g1sm209321otq.22.2021.07.01.14.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 14:34:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 1 Jul 2021 14:34:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 5/5] mtd: core: add OTP nvmem provider support
Message-ID: <20210701213420.GA1131789@roeck-us.net>
References: <20210424110608.15748-1-michael@walle.cc>
 <20210424110608.15748-6-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210424110608.15748-6-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Apr 24, 2021 at 01:06:08PM +0200, Michael Walle wrote:
> Flash OTP regions can already be read via user space. Some boards have
> their serial number or MAC addresses stored in the OTP regions. Add
> support for them being a (read-only) nvmem provider.
> 
> The API to read the OTP data is already in place. It distinguishes
> between factory and user OTP, thus there are up to two different
> providers.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

This patch causes a boot failure with one of my qemu tests.
With the patch in place, the flash fails to instantiate.

[    1.156578] Creating 3 MTD partitions on "physmap-flash":
[    1.157192] 0x000000000000-0x000000040000 : "U-Boot Bootloader"
[    1.184632] 0x000000040000-0x000000060000 : "U-Boot Environment"
[    1.201767] 0x000000060000-0x000000800000 : "Flash"
[    1.222320] Deleting MTD partitions on "physmap-flash":
[    1.222744] Deleting U-Boot Bootloader MTD partition
[    1.303597] Deleting U-Boot Environment MTD partition
[    1.368751] Deleting Flash MTD partition
[    1.430619] physmap-flash: probe of physmap-flash failed with error -61

-61 is -ENODATA.

Other boot tests with different flash chips can still boot.
Reverting this patch (as well as the follow-up patches) fixes
the problem.

I do not know if this is a problem with qemu or a problem with the
patch, but, as I mentioned, other flash chips do still instantiate.

Do you have an idea what to look for when I try to track down the problem ?

Thanks,
Guenter

> ---
> Changes since v1:
>  - combine name and compatible string in mtd_otp_nvmem_register()
> 
> Changes since RFC:
>  - none
> 
>  drivers/mtd/mtdcore.c   | 148 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/mtd.h |   2 +
>  2 files changed, 150 insertions(+)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 9aaeadd53eb4..72e7000a86fd 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -777,6 +777,146 @@ static void mtd_set_dev_defaults(struct mtd_info *mtd)
>  	mutex_init(&mtd->master.chrdev_lock);
>  }
>  
> +static ssize_t mtd_otp_size(struct mtd_info *mtd, bool is_user)
> +{
> +	struct otp_info *info = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	ssize_t size = 0;
> +	unsigned int i;
> +	size_t retlen;
> +	int ret;
> +
> +	if (is_user)
> +		ret = mtd_get_user_prot_info(mtd, PAGE_SIZE, &retlen, info);
> +	else
> +		ret = mtd_get_fact_prot_info(mtd, PAGE_SIZE, &retlen, info);
> +	if (ret)
> +		goto err;
> +
> +	for (i = 0; i < retlen / sizeof(*info); i++) {
> +		size += info->length;
> +		info++;
> +	}
> +
> +	kfree(info);
> +	return size;
> +
> +err:
> +	kfree(info);
> +	return ret;
> +}
> +
> +static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
> +						   const char *compatible,
> +						   int size,
> +						   nvmem_reg_read_t reg_read)
> +{
> +	struct nvmem_device *nvmem = NULL;
> +	struct nvmem_config config = {};
> +	struct device_node *np;
> +
> +	/* DT binding is optional */
> +	np = of_get_compatible_child(mtd->dev.of_node, compatible);
> +
> +	/* OTP nvmem will be registered on the physical device */
> +	config.dev = mtd->dev.parent;
> +	/* just reuse the compatible as name */
> +	config.name = compatible;
> +	config.id = NVMEM_DEVID_NONE;
> +	config.owner = THIS_MODULE;
> +	config.type = NVMEM_TYPE_OTP;
> +	config.root_only = true;
> +	config.reg_read = reg_read;
> +	config.size = size;
> +	config.of_node = np;
> +	config.priv = mtd;
> +
> +	nvmem = nvmem_register(&config);
> +	/* Just ignore if there is no NVMEM support in the kernel */
> +	if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EOPNOTSUPP)
> +		nvmem = NULL;
> +
> +	of_node_put(np);
> +
> +	return nvmem;
> +}
> +
> +static int mtd_nvmem_user_otp_reg_read(void *priv, unsigned int offset,
> +				       void *val, size_t bytes)
> +{
> +	struct mtd_info *mtd = priv;
> +	size_t retlen;
> +	int ret;
> +
> +	ret = mtd_read_user_prot_reg(mtd, offset, bytes, &retlen, val);
> +	if (ret)
> +		return ret;
> +
> +	return retlen == bytes ? 0 : -EIO;
> +}
> +
> +static int mtd_nvmem_fact_otp_reg_read(void *priv, unsigned int offset,
> +				       void *val, size_t bytes)
> +{
> +	struct mtd_info *mtd = priv;
> +	size_t retlen;
> +	int ret;
> +
> +	ret = mtd_read_fact_prot_reg(mtd, offset, bytes, &retlen, val);
> +	if (ret)
> +		return ret;
> +
> +	return retlen == bytes ? 0 : -EIO;
> +}
> +
> +static int mtd_otp_nvmem_add(struct mtd_info *mtd)
> +{
> +	struct nvmem_device *nvmem;
> +	ssize_t size;
> +	int err;
> +
> +	if (mtd->_get_user_prot_info && mtd->_read_user_prot_reg) {
> +		size = mtd_otp_size(mtd, true);
> +		if (size < 0)
> +			return size;
> +
> +		if (size > 0) {
> +			nvmem = mtd_otp_nvmem_register(mtd, "user-otp", size,
> +						       mtd_nvmem_user_otp_reg_read);
> +			if (IS_ERR(nvmem)) {
> +				dev_err(&mtd->dev, "Failed to register OTP NVMEM device\n");
> +				return PTR_ERR(nvmem);
> +			}
> +			mtd->otp_user_nvmem = nvmem;
> +		}
> +	}
> +
> +	if (mtd->_get_fact_prot_info && mtd->_read_fact_prot_reg) {
> +		size = mtd_otp_size(mtd, false);
> +		if (size < 0) {
> +			err = size;
> +			goto err;
> +		}
> +
> +		if (size > 0) {
> +			nvmem = mtd_otp_nvmem_register(mtd, "factory-otp", size,
> +						       mtd_nvmem_fact_otp_reg_read);
> +			if (IS_ERR(nvmem)) {
> +				dev_err(&mtd->dev, "Failed to register OTP NVMEM device\n");
> +				err = PTR_ERR(nvmem);
> +				goto err;
> +			}
> +			mtd->otp_factory_nvmem = nvmem;
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	if (mtd->otp_user_nvmem)
> +		nvmem_unregister(mtd->otp_user_nvmem);
> +	return err;
> +}
> +
>  /**
>   * mtd_device_parse_register - parse partitions and register an MTD device.
>   *
> @@ -852,6 +992,8 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
>  		register_reboot_notifier(&mtd->reboot_notifier);
>  	}
>  
> +	ret = mtd_otp_nvmem_add(mtd);
> +
>  out:
>  	if (ret && device_is_registered(&mtd->dev))
>  		del_mtd_device(mtd);
> @@ -873,6 +1015,12 @@ int mtd_device_unregister(struct mtd_info *master)
>  	if (master->_reboot)
>  		unregister_reboot_notifier(&master->reboot_notifier);
>  
> +	if (master->otp_user_nvmem)
> +		nvmem_unregister(master->otp_user_nvmem);
> +
> +	if (master->otp_factory_nvmem)
> +		nvmem_unregister(master->otp_factory_nvmem);
> +
>  	err = del_mtd_partitions(master);
>  	if (err)
>  		return err;
> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index a89955f3cbc8..88227044fc86 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -380,6 +380,8 @@ struct mtd_info {
>  	int usecount;
>  	struct mtd_debug_info dbg;
>  	struct nvmem_device *nvmem;
> +	struct nvmem_device *otp_user_nvmem;
> +	struct nvmem_device *otp_factory_nvmem;
>  
>  	/*
>  	 * Parent device from the MTD partition point of view.
