Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93C037F69A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhEMLTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233342AbhEMLTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:19:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6730D613D6;
        Thu, 13 May 2021 11:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620904687;
        bh=fJ1K6OK2GLOTGB4kKNjzkYtLV2Dyx0X/T8PFP6DCmZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYkobjBNhi7rzPAOQGhKrsWcKLVi0shW1XHL7ya3DeTl7Lm6xLvhb7m+DXTGwh7vr
         M8BY4HCKbS3TUZUyl1qn1ULPBoBuvnFx32kNc7JTJQ9Q8kBR6roR5dldP9yZZNniez
         gqOHpYc2keAd30ZdXKIR4itM2CpNzUvG16sjh/hs=
Date:   Thu, 13 May 2021 13:18:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Savo Novakovic <savox.novakovic@intel.com>
Subject: Re: [PATCH v3 12/14] intel_gna: add a 'misc' device
Message-ID: <YJ0K7f0NiRwQBPPA@kroah.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
 <20210513110040.2268-13-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513110040.2268-13-maciej.kwapulinski@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 01:00:38PM +0200, Maciej Kwapulinski wrote:
> The new 'misc' device is the node for applications in user space to
> interact with the driver.
> 
> Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
> Tested-by: Savo Novakovic <savox.novakovic@intel.com>
> ---
>  drivers/misc/intel/gna/device.c | 52 +++++++++++++++++++++++++++++++--
>  drivers/misc/intel/gna/device.h | 11 +++----
>  2 files changed, 55 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/intel/gna/device.c b/drivers/misc/intel/gna/device.c
> index 0e31b8c6bb70..1e6345a8325b 100644
> --- a/drivers/misc/intel/gna/device.c
> +++ b/drivers/misc/intel/gna/device.c
> @@ -20,6 +20,18 @@ module_param(recovery_timeout, int, 0644);
>  MODULE_PARM_DESC(recovery_timeout, "Recovery timeout in seconds");
>  #endif
>  
> +struct file;
> +
> +static int gna_open(struct inode *inode, struct file *f)
> +{
> +	return -EPERM;
> +}

That sucks, why have an open that does nothing but fail?

> +
> +static const struct file_operations gna_file_ops = {
> +	.owner		=	THIS_MODULE,
> +	.open		=	gna_open,
> +};
> +
>  static void gna_devm_idr_destroy(void *data)
>  {
>  	struct idr *idr = data;
> @@ -27,6 +39,36 @@ static void gna_devm_idr_destroy(void *data)
>  	idr_destroy(idr);
>  }
>  
> +static void gna_devm_deregister_misc_dev(void *data)

Why is this a void *?

This isn't windows, use real pointer types everywhere in the kernel
please.

> +{
> +	struct miscdevice *misc = data;
> +
> +	misc_deregister(misc);
> +}
> +
> +static int gna_devm_register_misc_dev(struct device *parent, struct miscdevice *misc)
> +{
> +	int ret;
> +
> +	ret = misc_register(misc);
> +	if (ret) {
> +		dev_err(parent, "misc device %s registering failed. errcode: %d\n",
> +			misc->name, ret);
> +		gna_devm_deregister_misc_dev(misc);
> +	} else {
> +		dev_dbg(parent, "device: %s registered\n",
> +			misc->name);

You have loads of debugging in this driver still, is it really needed?

> +	}
> +
> +	ret = devm_add_action(parent, gna_devm_deregister_misc_dev, misc);

Why do you need this?


thanks,

greg k-h
