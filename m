Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB1340C9D9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhIOQOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhIOQOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:14:54 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC8EC061574;
        Wed, 15 Sep 2021 09:13:35 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso4242838ots.5;
        Wed, 15 Sep 2021 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f5j9pmkOAqt4HPRqqP3RnxpS4TDHQzlivEcyh/ldwwM=;
        b=Xb80JKUD+Wq/R+yERF3nbHjDk0gWJ+xSwoikohp5JAoR7zWHGWXpjQVKrCi+gRGnBY
         uAYErlt/HnHX6NL1FrsK0+TEXl7NiJ3mEQi6OHCkJIRI5bjxkhscj4NkMvDnL91Fa1Iu
         n4BiFtyK6o0nbW65xDHfAhsRaOXGu1qFDTpCcl6+OkjwlQBe1VXQKf5+1omsbV0fGOPI
         ZrrkAepmA02C8WIFlbyQa1zZzfF/7Y5AISrGu6Lwd0vWpZ44EfpEcz2zwG3liLE3kwKi
         DvVwoLS6Sw2H8B+WaqGgB/GTjQiUkNfs/3omk2sTiCcGfgI30G/GmoP/13doAGCgpL8q
         sRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=f5j9pmkOAqt4HPRqqP3RnxpS4TDHQzlivEcyh/ldwwM=;
        b=4a6opGjQGBeGGnhkSjWHRhMTIIoalgjpHZYV9bqPv1bitCPmI9WMZsOlecdLC+rbk/
         DdSsOyZIS8VMczdPOO/Gz0PGkKJ92TYeXfvt3dq9XGku2NByrUslTm98+rAdCm33cF93
         PToVIJK+JCzvasEUdU9LNCmMZs7AmjyTclp9J3DnO06XIV8QeFkyBmmDhB1s6IgChj0Y
         fp1ERM3tVj9w3fSKykzl7K6uXVMm1KyyycrydwMyH1yTnn680Nl6/XlW8rSs8Skb+Znl
         KZsPBVg/tcCC9Ujlm9Cr5KHuSBpaB5MWljCzgDTTtIW4RjLhgD3DYgS5jPUlk/wYjUBy
         rUDA==
X-Gm-Message-State: AOAM5311YYOiSFVpog3QtANXq+rxWBj0EsFpuWtJyfpcST/8NQRoJxlg
        EYB5Dz4dLGpZ/tyWyBNH9AY=
X-Google-Smtp-Source: ABdhPJyj6BVkpzEwpd5DfGbaZ0ObDbJOMNqKGd2M95HRO170prZw/WxZVQ91wEd614tHtzk9480bjQ==
X-Received: by 2002:a9d:4e97:: with SMTP id v23mr684205otk.236.1631722415086;
        Wed, 15 Sep 2021 09:13:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j10sm109155oog.13.2021.09.15.09.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:13:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Sep 2021 09:13:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@jms.id.au, jdelvare@suse.com,
        alistair@popple.id.au, jk@ozlabs.org
Subject: Re: [PATCH 3/3] hwmon: (occ) Provide the SBEFIFO FFDC in binary sysfs
Message-ID: <20210915161333.GA3712393@roeck-us.net>
References: <20210914213543.73351-1-eajames@linux.ibm.com>
 <20210914213543.73351-4-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914213543.73351-4-eajames@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 04:35:43PM -0500, Eddie James wrote:
> Save any FFDC provided by the OCC driver, and provide it to userspace
> through a binary sysfs entry. Do some basic state management to
> ensure that userspace can always collect the data if there was an
> error. Notify polling userspace when there is an error too.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

This is now the 2nd series that we have pending, and the first series
(from July) still didn't make it into the upstream kernel because the fsi code
seems to go nowhere. Any chance to address that ?

Additional comment inline.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/p9_sbe.c | 98 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
> index 9709f2b9c052..505f489832a4 100644
> --- a/drivers/hwmon/occ/p9_sbe.c
> +++ b/drivers/hwmon/occ/p9_sbe.c
> @@ -4,18 +4,54 @@
>  #include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/fsi-occ.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
>  
>  #include "common.h"
>  
> +enum sbe_error_state {
> +	SBE_ERROR_NONE = 0,
> +	SBE_ERROR_PENDING,
> +	SBE_ERROR_COLLECTED
> +};
> +
>  struct p9_sbe_occ {
>  	struct occ occ;
> +	int sbe_error;
> +	void *ffdc;
> +	size_t ffdc_len;
> +	size_t ffdc_size;
> +	struct mutex sbe_error_lock;	/* lock access to ffdc data */
> +	u32 no_ffdc_magic;
>  	struct device *sbe;
>  };
>  
>  #define to_p9_sbe_occ(x)	container_of((x), struct p9_sbe_occ, occ)
>  
> +static ssize_t sbe_error_read(struct file *filp, struct kobject *kobj,
> +			      struct bin_attribute *battr, char *buf,
> +			      loff_t pos, size_t count)
> +{
> +	ssize_t rc = 0;
> +	struct occ *occ = dev_get_drvdata(kobj_to_dev(kobj));
> +	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
> +
> +	mutex_lock(&ctx->sbe_error_lock);
> +	if (ctx->sbe_error == SBE_ERROR_PENDING) {
> +		rc = memory_read_from_buffer(buf, count, &pos, ctx->ffdc,
> +					     ctx->ffdc_len);
> +		ctx->sbe_error = SBE_ERROR_COLLECTED;
> +	}
> +	mutex_unlock(&ctx->sbe_error_lock);
> +
> +	return rc;
> +}
> +static BIN_ATTR_RO(sbe_error, OCC_MAX_RESP_WORDS * 4);
> +
>  static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>  {
>  	struct occ_response *resp = &occ->resp;
> @@ -24,8 +60,47 @@ static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>  	int rc;
>  
>  	rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		if (resp_len) {
> +			bool notify = false;
> +
> +			mutex_lock(&ctx->sbe_error_lock);
> +			if (ctx->sbe_error != SBE_ERROR_PENDING)
> +				notify = true;
> +			ctx->sbe_error = SBE_ERROR_PENDING;
> +
> +			if (resp_len > ctx->ffdc_size) {
> +				if (ctx->ffdc_size)
> +					kvfree(ctx->ffdc);
> +				ctx->ffdc = kvmalloc(resp_len, GFP_KERNEL);
> +				if (!ctx->ffdc) {
> +					ctx->ffdc_size = 0;
> +					ctx->ffdc_len = sizeof(u32);
> +					ctx->ffdc = &ctx->no_ffdc_magic;
> +					goto unlock;
> +				}
> +
> +				ctx->ffdc_size = resp_len;
> +			}
> +
> +			ctx->ffdc_len = resp_len;
> +			memcpy(ctx->ffdc, resp, resp_len);
> +
> +unlock:
> +			mutex_unlock(&ctx->sbe_error_lock);
> +
> +			if (notify)
> +				sysfs_notify(&occ->bus_dev->kobj, NULL,
> +					     bin_attr_sbe_error.attr.name);
> +		}
> +
>  		return rc;
> +	}
> +
> +	mutex_lock(&ctx->sbe_error_lock);
> +	if (ctx->sbe_error == SBE_ERROR_COLLECTED)
> +		ctx->sbe_error = SBE_ERROR_NONE;
> +	mutex_unlock(&ctx->sbe_error_lock);

I am not entirely sure I understand the benefit of SBE_ERROR_COLLECTED.
Can you explain why it is needed, and why the status is not just set
to SBE_ERROR_NONE after the error data was collected ?

>  
>  	switch (resp->return_status) {
>  	case OCC_RESP_CMD_IN_PRG:
> @@ -65,6 +140,13 @@ static int p9_sbe_occ_probe(struct platform_device *pdev)
>  	if (!ctx)
>  		return -ENOMEM;
>  
> +	ctx->no_ffdc_magic = OCC_NO_FFDC_MAGIC;

This is ... odd. Why not just return a file size of 0 if there is no data ?
The binary file is an ABI and needs to be documented, including the use
of this "magic". The use of that magic needs to be explained because it
does add a lot of what sems to be unnecessary complexity to the code.

Besides, most of that complexity seems unnecessary: If the magic is really
needed, the read code could just write it into the buffer if ctx->ffdc
is NULL. There is a lot of complexity just to avoid an if statement in
sbe_error_read().

> +	ctx->sbe_error = SBE_ERROR_NONE;
> +	ctx->ffdc = &ctx->no_ffdc_magic;
> +	ctx->ffdc_len = sizeof(u32);
> +	ctx->ffdc_size = 0;
> +	mutex_init(&ctx->sbe_error_lock);
> +
>  	ctx->sbe = pdev->dev.parent;
>  	occ = &ctx->occ;
>  	occ->bus_dev = &pdev->dev;
> @@ -78,6 +160,15 @@ static int p9_sbe_occ_probe(struct platform_device *pdev)
>  	if (rc == -ESHUTDOWN)
>  		rc = -ENODEV;	/* Host is shutdown, don't spew errors */
>  
> +	if (!rc) {
> +		rc = device_create_bin_file(occ->bus_dev, &bin_attr_sbe_error);
> +		if (rc) {
> +			dev_warn(occ->bus_dev,
> +				 "failed to create SBE error ffdc file\n");
> +			rc = 0;
> +		}
> +	}
> +
>  	return rc;
>  }
>  
> @@ -86,9 +177,14 @@ static int p9_sbe_occ_remove(struct platform_device *pdev)
>  	struct occ *occ = platform_get_drvdata(pdev);
>  	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
>  
> +	device_remove_bin_file(occ->bus_dev, &bin_attr_sbe_error);
> +
>  	ctx->sbe = NULL;
>  	occ_shutdown(occ);
>  
> +	if (ctx->ffdc_size)
> +		kvfree(ctx->ffdc);
> +
>  	return 0;
>  }
>  
> -- 
> 2.27.0
> 
