Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F6F37F69C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhEMLUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:20:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231533AbhEMLU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:20:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8D67613CA;
        Thu, 13 May 2021 11:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620904758;
        bh=1DY1eVWYP757z7axkngnQdbTOZst1Izo014oZvuSrP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SSrpOmBhn99/rBSDiyUjMMGpnlA393P7pqKhCUmbwmBoHVYAyxmG0PxuFe6bac8zU
         ejPrmRwjy7kZwEtbOtadutYmnJgs3O4ebtZEcpTl9P/QPz0kxwZv5G7qAQWhknqLhS
         701yS8QR8qVySAgpBREaVxwbrF/d9c/P89QK/xIU=
Date:   Thu, 13 May 2021 13:19:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: Re: [PATCH v3 13/14] intel_gna: add file operations to a 'misc'
 device
Message-ID: <YJ0LNB0V113ky0FB@kroah.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
 <20210513110040.2268-14-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513110040.2268-14-maciej.kwapulinski@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 01:00:39PM +0200, Maciej Kwapulinski wrote:
> From: Tomasz Jankowski <tomasz1.jankowski@intel.com>
> 
> Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
> Tested-by: Savo Novakovic <savox.novakovic@intel.com>
> Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
> Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
> Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
> Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
> ---
>  drivers/misc/intel/gna/device.c | 60 +++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/intel/gna/device.c b/drivers/misc/intel/gna/device.c
> index 1e6345a8325b..c882055de8cf 100644
> --- a/drivers/misc/intel/gna/device.c
> +++ b/drivers/misc/intel/gna/device.c
> @@ -4,7 +4,9 @@
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
> +#include <linux/fs.h>
>  #include <linux/module.h>
> +#include <linux/slab.h>
>  
>  #include <uapi/misc/intel/gna.h>
>  
> @@ -20,16 +22,68 @@ module_param(recovery_timeout, int, 0644);
>  MODULE_PARM_DESC(recovery_timeout, "Recovery timeout in seconds");
>  #endif
>  
> -struct file;
> -
>  static int gna_open(struct inode *inode, struct file *f)
>  {
> -	return -EPERM;
> +	struct gna_file_private *file_priv;
> +	struct gna_private *gna_priv;
> +
> +	gna_priv = container_of(f->private_data, struct gna_private, misc);
> +
> +	file_priv = kzalloc(sizeof(*file_priv), GFP_KERNEL);
> +	if (!file_priv)
> +		return -ENOMEM;
> +
> +	file_priv->fd = f;
> +	file_priv->gna_priv = gna_priv;
> +
> +	mutex_init(&file_priv->memlist_lock);
> +	INIT_LIST_HEAD(&file_priv->memory_list);
> +
> +	INIT_LIST_HEAD(&file_priv->flist);
> +
> +	mutex_lock(&gna_priv->flist_lock);
> +	list_add_tail(&file_priv->flist, &gna_priv->file_list);
> +	mutex_unlock(&gna_priv->flist_lock);
> +
> +	f->private_data = file_priv;
> +
> +	return 0;
> +}
> +
> +static int gna_release(struct inode *inode, struct file *f)
> +{
> +	struct gna_memory_object *iter_mo, *temp_mo;
> +	struct gna_file_private *file_priv;
> +	struct gna_private *gna_priv;
> +
> +	/* free all memory objects created by that file */
> +	file_priv = (struct gna_file_private *)f->private_data;
> +	gna_priv = file_priv->gna_priv;
> +
> +	mutex_lock(&file_priv->memlist_lock);
> +	list_for_each_entry_safe(iter_mo, temp_mo, &file_priv->memory_list, file_mem_list) {
> +		queue_work(gna_priv->request_wq, &iter_mo->work);
> +		wait_event(iter_mo->waitq, true);
> +		gna_memory_free(gna_priv, iter_mo);
> +	}
> +	mutex_unlock(&file_priv->memlist_lock);
> +
> +	gna_delete_file_requests(f, gna_priv);
> +
> +	mutex_lock(&gna_priv->flist_lock);
> +	list_del_init(&file_priv->flist);
> +	mutex_unlock(&gna_priv->flist_lock);
> +	kfree(file_priv);
> +	f->private_data = NULL;
> +
> +	return 0;
>  }
>  
>  static const struct file_operations gna_file_ops = {
>  	.owner		=	THIS_MODULE,
>  	.open		=	gna_open,
> +	.release	=	gna_release,
> +	.unlocked_ioctl =	gna_ioctl,

Wait, where's the ioctl?  You added it earlier in the series?

gotta go dig now...


greg k-h
