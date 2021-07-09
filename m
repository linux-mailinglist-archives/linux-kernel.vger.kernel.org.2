Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB5A3C2A8E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 22:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhGIU6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 16:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGIU6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 16:58:22 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83B9C0613DD;
        Fri,  9 Jul 2021 13:55:37 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 53-20020a9d0eb80000b02904b6c4d33e84so2096852otj.13;
        Fri, 09 Jul 2021 13:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tvcIHr6YH3zNc1GXtO/udnQUIauq93syHMnkj2AT5yo=;
        b=t6mHzxxtqy0vJAmL6L+f/Ht3qrCAA0aIREZl9tHbj2WWwfQuqj9LcfZrfRjHCX/GML
         yxhefakOoCRweoOhwtqHcuutkEhBNLlZBFWPEJiubfjnHEWzns1aL1tVBpFN8zLYAQ4I
         eC7j6TEMDsBrvPxhxp39JnFhFR3pBDh2JgAdjhj6F22Xm8N0dt7VDDXZsFAw4/EBMt+W
         RLsL4GrE3liR3l0kvLk0AHHHz58R1idcxtiF/UW6lgGWN1ok4+JTAac0cUxUxk4ihexY
         nwYYL1M0GUBKeojqOhu7TeWPLCtjaoSYfAb9U/Ek2iomHGG4p4xWhSzB1WtwQFgd8X5f
         4raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tvcIHr6YH3zNc1GXtO/udnQUIauq93syHMnkj2AT5yo=;
        b=WLcroy3L4VPH4K54ZCxfT3LMmBAYaniV8lgFvhz8y+BS1tPgoa05WdHNg7s61Vh4CH
         Et4MtjTRD/lVrqDN9drDnu43beOsr3tv6jsz8YOsl2Jg2aSWzyk5U57IB8LeVoz9JRHA
         LvwAbB1omZH1MRSCXF/r3CFc1x2WE8N8uJ2m4Shbi8dbhAeQWofnYAlEzM8UPcX1zlqY
         p4cPuTCQFs/XIQ6FTbcSMEZkZ2ZEExCZgHSrnmz9FESIoVOG9Am+At25mqgyDo0CltD3
         ylKwpAOKGm1fTKahLZBK0p2aW5t/RixBm+LJJKYSNufvEsV7PUWGWfapy104ZpHU4Gqs
         BJwQ==
X-Gm-Message-State: AOAM532lvDV5/ZOC/0lOo4UXirrm50KVJ1dGPxd31xFsyBsjFswbPiy8
        qE4UnmQFwOt+GVQ7e4UqPIRGMn8L6wU=
X-Google-Smtp-Source: ABdhPJy1JnE/4SHLBkptcotSgu7WjVfaOEmaGy+bwO8LwwsUWebyQZVQUXyv3lXjyUMijKPiHSRGaw==
X-Received: by 2002:a05:6830:1e6d:: with SMTP id m13mr18788758otr.186.1625864137331;
        Fri, 09 Jul 2021 13:55:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u132sm1036990oib.29.2021.07.09.13.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 13:55:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 9 Jul 2021 13:55:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus/bpa-rs600): Support BPD-RS600
Message-ID: <20210709205532.GA2995848@roeck-us.net>
References: <20210708220618.23576-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708220618.23576-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 10:06:18AM +1200, Chris Packham wrote:
> The BPD-RS600 is the DC version of the BPA-RS600. The PMBUS interface is
> the same between the two models. Keep the same compatible string but
> accept either BPA-RS600 or BPD-RS600 in the PMBUS_MFR_MODEL.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/bpa-rs600.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/bpa-rs600.c b/drivers/hwmon/pmbus/bpa-rs600.c
> index 2be69fedfa36..d205b41540ce 100644
> --- a/drivers/hwmon/pmbus/bpa-rs600.c
> +++ b/drivers/hwmon/pmbus/bpa-rs600.c
> @@ -21,6 +21,8 @@
>  #define BPARS600_MFR_IOUT_MAX	0xa6
>  #define BPARS600_MFR_POUT_MAX	0xa7
>  
> +enum chips { bpa_rs600, bpd_rs600 };
> +
>  static int bpa_rs600_read_byte_data(struct i2c_client *client, int page, int reg)
>  {
>  	int ret;
> @@ -146,11 +148,19 @@ static struct pmbus_driver_info bpa_rs600_info = {
>  	.read_word_data = bpa_rs600_read_word_data,
>  };
>  
> +static const struct i2c_device_id bpa_rs600_id[] = {
> +	{ "bpa-rs600", bpa_rs600 },
> +	{ "bpd-rs600", bpd_rs600 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, bpa_rs600_id);
> +
>  static int bpa_rs600_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
>  	int ret;
> +	const struct i2c_device_id *mid;
>  
>  	if (!i2c_check_functionality(client->adapter,
>  				     I2C_FUNC_SMBUS_READ_BYTE_DATA
> @@ -164,7 +174,11 @@ static int bpa_rs600_probe(struct i2c_client *client)
>  		return ret;
>  	}
>  
> -	if (strncmp(buf, "BPA-RS600", 8)) {
> +	for (mid = bpa_rs600_id; mid->name[0]; mid++) {
> +		if (!strncasecmp(buf, mid->name, strlen(mid->name)))
> +			break;
> +	}
> +	if (!mid->name[0]) {
>  		buf[ret] = '\0';
>  		dev_err(dev, "Unsupported Manufacturer Model '%s'\n", buf);
>  		return -ENODEV;
> @@ -173,12 +187,6 @@ static int bpa_rs600_probe(struct i2c_client *client)
>  	return pmbus_do_probe(client, &bpa_rs600_info);
>  }
>  
> -static const struct i2c_device_id bpa_rs600_id[] = {
> -	{ "bpars600", 0 },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(i2c, bpa_rs600_id);
> -
>  static const struct of_device_id __maybe_unused bpa_rs600_of_match[] = {
>  	{ .compatible = "blutek,bpa-rs600" },
>  	{},
