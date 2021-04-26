Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238C536B122
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhDZJ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232333AbhDZJ5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:57:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B309B61103;
        Mon, 26 Apr 2021 09:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619430984;
        bh=5dnhKqlnt1tMhdnaH2csD5e6d46+28b304GMJrShDZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/EWF+O158O52xru7jbhVdaReN3VQQ1nLVOD5Dnol9yOMo4VVPH3n+1VHmWU1xacG
         SohYr+hiM4kxnTYM/JA9X8OSJWmbrPRWvViaCLNSFrznvyHOOmYwR//iUTflcSWCay
         18AukQMhdzQXarPjo9rltxSYX1+9Axpf8YSMrMOg=
Date:   Mon, 26 Apr 2021 11:56:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        David Kershner <david.kershner@unisys.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Outreachy kernel] [RFC PATCH] staging: unisys: visorhba:
 Convert module from IDR to XArray
Message-ID: <YIaORY3B6+6vMvFj@kroah.com>
References: <20210426095015.18556-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426095015.18556-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:50:15AM +0200, Fabio M. De Francesco wrote:
> Converted visorhba from IDR to XArray. The abstract data type XArray is
> more memory-efficient, parallelisable and cache friendly. It takes 
> advantage of RCU to perform lookups without locking.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  .../staging/unisys/visorhba/visorhba_main.c   | 107 +++++++-----------
>  1 file changed, 44 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
> index 4455d26f7c96..851e60ab0c46 100644
> --- a/drivers/staging/unisys/visorhba/visorhba_main.c
> +++ b/drivers/staging/unisys/visorhba/visorhba_main.c
> @@ -6,10 +6,10 @@
>  
>  #include <linux/debugfs.h>
>  #include <linux/kthread.h>
> -#include <linux/idr.h>
>  #include <linux/module.h>
>  #include <linux/seq_file.h>
>  #include <linux/visorbus.h>
> +#include <linux/xarray.h>
>  #include <scsi/scsi.h>
>  #include <scsi/scsi_host.h>
>  #include <scsi/scsi_cmnd.h>
> @@ -23,6 +23,8 @@
>  #define MAX_PENDING_REQUESTS (MIN_NUMSIGNALS * 2)
>  #define VISORHBA_ERROR_COUNT 30
>  
> +static DEFINE_XARRAY_ALLOC(xa_dtstr);
> +
>  static struct dentry *visorhba_debugfs_dir;
>  
>  /* GUIDS for HBA channel type supported by this driver */
> @@ -78,12 +80,6 @@ struct visorhba_devdata {
>  	unsigned int max_buff_len;
>  	int devnum;
>  	struct uiscmdrsp *cmdrsp;
> -	/*
> -	 * allows us to pass int handles back-and-forth between us and
> -	 * iovm, instead of raw pointers
> -	 */
> -	struct idr idr;
> -
>  	struct dentry *debugfs_dir;
>  	struct dentry *debugfs_info;
>  };
> @@ -183,32 +179,16 @@ static struct uiscmdrsp *get_scsipending_cmdrsp(struct visorhba_devdata *ddata,
>  }
>  
>  /*
> - * simple_idr_get - Associate a provided pointer with an int value
> - *		    1 <= value <= INT_MAX, and return this int value;
> - *		    the pointer value can be obtained later by passing
> - *		    this int value to idr_find()
> - * @idrtable: The data object maintaining the pointer<-->int mappings
> - * @p:	      The pointer value to be remembered
> - * @lock:     A spinlock used when exclusive access to idrtable is needed
> - *
> - * Return: The id number mapped to pointer 'p', 0 on failure
> + * simple_xa_dtstr_get - Store a pointer to xa_dtstr xarray
> + * @id: Pointer to ID
> + * @entry: New entry
>   */
> -static unsigned int simple_idr_get(struct idr *idrtable, void *p,
> -				   spinlock_t *lock)
> +static int simple_xa_dtstr_get(u32 *id, void *entry)

What are you trying to really "get" here?  We shouldn't name the
function based on the data type being used.  All we want is some sort of
"token" or hash or something else?  It's hard to tell...

>  {
> -	int id;
> -	unsigned long flags;
> +	int ret = xa_alloc_irq(&xa_dtstr, id, entry, xa_limit_32b, GFP_NOWAIT);
> +	/* TODO: check for and manage errors */

That's a nice TODO, which means we really should not be considering this
patch to be merged, right?

thanks,

greg k-h
