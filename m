Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48B242924B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243011AbhJKOnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244507AbhJKOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:43:36 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8F9C06161C;
        Mon, 11 Oct 2021 07:38:44 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id z11so24947823oih.1;
        Mon, 11 Oct 2021 07:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KJ+wtNs2FXm9PQqB8Ks5XiBM40+Egmp/mhiSUATFJC0=;
        b=IxAQzuJwuf3ITi2kE1/RQgSNkMIW2auvNZHk7nuIA/PRGiriDeVGQSHV6b6/mb8RzA
         3bMMv4/Pz/PHK9IukmYqZU9ge2gePjr5lOokByjPIznhF8aUAB2y0tUjbvknE3kbMZ92
         3fuK5byaKladMoKw5ln80/8iA47IVV9+BfdCRGO7+sJR6JkT35jfms4oo5bbg9cg0Jhx
         zCYXhnsZQY11f8km7rBqdSGoKELRdo8Pez77z+9ML/dQJVKzRLdyYD8i145l4FCo4ijI
         Xx57CAhkvM+ABzcn0SIiSfdTaHbzyjxK02PIefRlg93UeoB19fqopGSu+ID3hSPHYF/P
         3Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KJ+wtNs2FXm9PQqB8Ks5XiBM40+Egmp/mhiSUATFJC0=;
        b=280KggJ+7JUuYgyziHXqbFe6znOPkZ46TIkxyfVNRGn+7NeuJ/jzVfNRsPBfx+NmUb
         bS3LLZF0eyuokYghNXVooUH2BP3dxlj77Yuo3mDsEq/IgiOeo5kidiHX0YSFK5enMDyU
         feUup0xRxneV2iRagGUYWVyDAmlpoA1BJDX6DeJYpoWtMa32gxnWIozFfbpFX12d3ir9
         piKWRRGbpu57cARB/8QTIEA/C7ViOb7zI8P4e3P1QAu9W1Zy3a/hzBEjFLTlH2I6P1z6
         KgwGRebFTXOA0sMa5YzL3ZkCha8EAv49C00S10+iMWYMWNw8o9nHehuAKKAAaU+is8i8
         dGLg==
X-Gm-Message-State: AOAM532bDoPWM0N2/QitlCdcumpwFD2AtYN7Uvv5SACFTSx/nUUk/lPD
        97e+h+BIkyVKDWUtNGKPS7T5PHQ+pCI=
X-Google-Smtp-Source: ABdhPJz4T79yPGJNmWyYX8NFjHda8iwub9rBVidMmeHd0CFRmqRr8PR3C9yZvlReq/+5EF4wRJxmFQ==
X-Received: by 2002:aca:c28b:: with SMTP id s133mr25610965oif.17.1633963124361;
        Mon, 11 Oct 2021 07:38:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w141sm1726846oif.20.2021.10.11.07.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 07:38:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 11 Oct 2021 07:38:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, jdelvare@suse.com
Subject: Re: [PATCH v3 4/4] hwmon: (occ) Provide the SBEFIFO FFDC in binary
 sysfs
Message-ID: <20211011143843.GA2443520@roeck-us.net>
References: <20210927155925.15485-1-eajames@linux.ibm.com>
 <20210927155925.15485-5-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927155925.15485-5-eajames@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:59:25AM -0500, Eddie James wrote:
> Save any FFDC provided by the OCC driver, and provide it to userspace
> through a binary sysfs entry. Notify userspace pollers when there is an
> error too.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

For my reference (waiting for infra patches to be accepted/acked):

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
> Changes since v1:
>  - Remove "collected" error state in favor of a boolean
>  - Clear the error flag once the FFDC has been completely read once
>  - Only store FFDC if there is no FFDC waiting to be retrieved
> 
>  drivers/hwmon/occ/p9_sbe.c | 86 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
> index 9709f2b9c052..e50243580269 100644
> --- a/drivers/hwmon/occ/p9_sbe.c
> +++ b/drivers/hwmon/occ/p9_sbe.c
> @@ -4,18 +4,79 @@
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
>  struct p9_sbe_occ {
>  	struct occ occ;
> +	bool sbe_error;
> +	void *ffdc;
> +	size_t ffdc_len;
> +	size_t ffdc_size;
> +	struct mutex sbe_error_lock;	/* lock access to ffdc data */
>  	struct device *sbe;
>  };
>  
>  #define to_p9_sbe_occ(x)	container_of((x), struct p9_sbe_occ, occ)
>  
> +static ssize_t ffdc_read(struct file *filp, struct kobject *kobj,
> +			 struct bin_attribute *battr, char *buf, loff_t pos,
> +			 size_t count)
> +{
> +	ssize_t rc = 0;
> +	struct occ *occ = dev_get_drvdata(kobj_to_dev(kobj));
> +	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
> +
> +	mutex_lock(&ctx->sbe_error_lock);
> +	if (ctx->sbe_error) {
> +		rc = memory_read_from_buffer(buf, count, &pos, ctx->ffdc,
> +					     ctx->ffdc_len);
> +		if (pos >= ctx->ffdc_len)
> +			ctx->sbe_error = false;
> +	}
> +	mutex_unlock(&ctx->sbe_error_lock);
> +
> +	return rc;
> +}
> +static BIN_ATTR_RO(ffdc, OCC_MAX_RESP_WORDS * 4);
> +
> +static bool p9_sbe_occ_save_ffdc(struct p9_sbe_occ *ctx, const void *resp,
> +				 size_t resp_len)
> +{
> +	bool notify = false;
> +
> +	mutex_lock(&ctx->sbe_error_lock);
> +	if (!ctx->sbe_error) {
> +		if (resp_len > ctx->ffdc_size) {
> +			if (ctx->ffdc)
> +				kvfree(ctx->ffdc);
> +			ctx->ffdc = kvmalloc(resp_len, GFP_KERNEL);
> +			if (!ctx->ffdc) {
> +				ctx->ffdc_len = 0;
> +				ctx->ffdc_size = 0;
> +				goto done;
> +			}
> +
> +			ctx->ffdc_size = resp_len;
> +		}
> +
> +		notify = true;
> +		ctx->sbe_error = true;
> +		ctx->ffdc_len = resp_len;
> +		memcpy(ctx->ffdc, resp, resp_len);
> +	}
> +
> +done:
> +	mutex_unlock(&ctx->sbe_error_lock);
> +	return notify;
> +}
> +
>  static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>  {
>  	struct occ_response *resp = &occ->resp;
> @@ -24,8 +85,15 @@ static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>  	int rc;
>  
>  	rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		if (resp_len) {
> +			if (p9_sbe_occ_save_ffdc(ctx, resp, resp_len))
> +				sysfs_notify(&occ->bus_dev->kobj, NULL,
> +					     bin_attr_ffdc.attr.name);
> +		}
> +
>  		return rc;
> +	}
>  
>  	switch (resp->return_status) {
>  	case OCC_RESP_CMD_IN_PRG:
> @@ -65,6 +133,8 @@ static int p9_sbe_occ_probe(struct platform_device *pdev)
>  	if (!ctx)
>  		return -ENOMEM;
>  
> +	mutex_init(&ctx->sbe_error_lock);
> +
>  	ctx->sbe = pdev->dev.parent;
>  	occ = &ctx->occ;
>  	occ->bus_dev = &pdev->dev;
> @@ -78,6 +148,15 @@ static int p9_sbe_occ_probe(struct platform_device *pdev)
>  	if (rc == -ESHUTDOWN)
>  		rc = -ENODEV;	/* Host is shutdown, don't spew errors */
>  
> +	if (!rc) {
> +		rc = device_create_bin_file(occ->bus_dev, &bin_attr_ffdc);
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
> @@ -86,9 +165,14 @@ static int p9_sbe_occ_remove(struct platform_device *pdev)
>  	struct occ *occ = platform_get_drvdata(pdev);
>  	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
>  
> +	device_remove_bin_file(occ->bus_dev, &bin_attr_ffdc);
> +
>  	ctx->sbe = NULL;
>  	occ_shutdown(occ);
>  
> +	if (ctx->ffdc)
> +		kvfree(ctx->ffdc);
> +
>  	return 0;
>  }
>  
