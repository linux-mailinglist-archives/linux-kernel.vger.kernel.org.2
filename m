Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8708F39AD1F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFCVtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhFCVtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:49:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5977C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 14:47:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 69so3594837plc.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 14:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ICOo9Kt6hh7DOvP5GK5QasKiSWWyI7zKiYm0MWO58+U=;
        b=XLBmp/q3MzIMl5vJAruMkK9DeUXBn3Nb3ZaCv7EYn3pRSrYrrIqDU+MLri4vHy3zAZ
         hV0nyLITwIt2tvV/+l8SfwpMf/vQkNYCw2pfxRWhi4jUPTZaOmfv5yUxdLj9ScyskSE0
         t5Cf3gkEtGwPNJtB3cULaqXHFUs7gab+/LVgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ICOo9Kt6hh7DOvP5GK5QasKiSWWyI7zKiYm0MWO58+U=;
        b=FXGDzTGQ1dX2CQGuBFuZn/aJy8btAJtBeo7YmXZl6QGZygDK8Pk4FGmw/y1HMTsWzF
         qZAdhS6QFiIMHrlfaTsxq2+ZN/JbaINmwJ8ikoXX2MBPnmkcPwDPNE1oxh/cbCLMFpkw
         6hr5NQMdWgEkiUhPn91B3lwp1ScZhPNWqNdcQiySiitj2BGshP+bMuYj+sOhqXS2o0gr
         NrpTzyM6j2uGG64cWvvruNO7YbLrcU/PZKmWyduh5dO/wR5CxAOcarQXn+kd4kzNkwrm
         L5PY9DzxOctvaipnKBT5InYjFsqHWWW7etIWRsLOV0PJz9SU0MgYPMuVoJsPpYTDKz3X
         hgMA==
X-Gm-Message-State: AOAM531YOsGetkWCYZkK2yY784Gp30Zg94hDWEw7g2Y653jyIKIYHMJO
        7tkRVVvYgnLtMopw3smpC5jvPA==
X-Google-Smtp-Source: ABdhPJzvFGdRceCdLWOeJJPbHEgkMYg84RWkwLWfTsL/+I4jjzVyCacOcL3V59fJKFsuP/v51+R9sw==
X-Received: by 2002:a17:90a:8c97:: with SMTP id b23mr1375326pjo.74.1622756845225;
        Thu, 03 Jun 2021 14:47:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k1sm45749pfa.30.2021.06.03.14.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 14:47:24 -0700 (PDT)
Date:   Thu, 3 Jun 2021 14:47:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [PATCH v2 1/1] pgo: Fix sleep in atomic section in prf_open()
Message-ID: <202106031441.FA95440A@keescook>
References: <20210603155318.46346-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603155318.46346-1-jarmo.tiitto@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 06:53:17PM +0300, Jarmo Tiitto wrote:
> In prf_open() the required buffer size can be so large that
> vzalloc() may sleep thus triggering bug:
> 
> ======
>  BUG: sleeping function called from invalid context at include/linux/sched/mm.h:201
>  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 337, name: cat
>  CPU: 1 PID: 337 Comm: cat Not tainted 5.13.0-rc2-24-hack+ #154
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>  Call Trace:
>   dump_stack+0xc7/0x134
>   ___might_sleep+0x177/0x190
>   __might_sleep+0x5a/0x90
>   kmem_cache_alloc_node_trace+0x6b/0x3a0
>   ? __get_vm_area_node+0xcd/0x1b0
>   ? dput+0x283/0x300
>   __get_vm_area_node+0xcd/0x1b0
>   __vmalloc_node_range+0x7b/0x420
>   ? prf_open+0x1da/0x580
>   ? prf_open+0x32/0x580
>   ? __llvm_profile_instrument_memop+0x36/0x50
>   vzalloc+0x54/0x60
>   ? prf_open+0x1da/0x580
>   prf_open+0x1da/0x580
>   full_proxy_open+0x211/0x370
>   ....
> ======
> 
> Since we can't vzalloc while holding pgo_lock,
> split the code into steps:
> * First get buffer size via prf_buffer_size()
>   and release the lock.
> * Round up to the page size and allocate the buffer.
> * Finally re-acquire the pgo_lock and call prf_serialize().
>   prf_serialize() will now check if the buffer is large enough
>   and returns -EAGAIN if it is not.
> 
> New in this v2 patch:
> The -EAGAIN case was determined to be such rare event that
> running following in a loop:
> 
> $cat /sys/kernel/debug/pgo/vmlinux.profraw > vmlinux.profdata;
> 
> Didn't trigger it, and I don't know if it ever may occur at all.

Hm, I remain nervous that it'll pop up when we least expect it. But, I
went to go look at this, and I don't understand why we need a lock at
all for prf_buffer_size(). These appear to be entirely static in size.

> 
> Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> ---
>  kernel/pgo/fs.c | 52 ++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
> index ef985159dad3..9afd6f001a1b 100644
> --- a/kernel/pgo/fs.c
> +++ b/kernel/pgo/fs.c
> @@ -24,13 +24,14 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> +#include <linux/mm.h>
>  #include "pgo.h"
>  
>  static struct dentry *directory;
>  
>  struct prf_private_data {
>  	void *buffer;
> -	unsigned long size;
> +	size_t size;
>  };
>  
>  /*
> @@ -213,6 +214,7 @@ static inline unsigned long prf_get_padding(unsigned long size)
>  	return 7 & (sizeof(u64) - size % sizeof(u64));
>  }
>  
> +/* Note: caller *must* hold pgo_lock */
>  static unsigned long prf_buffer_size(void)
>  {
>  	return sizeof(struct llvm_prf_header) +
> @@ -225,18 +227,21 @@ static unsigned long prf_buffer_size(void)
>  
>  /*
>   * Serialize the profiling data into a format LLVM's tools can understand.
> + * Note: p->buffer must point into vzalloc()'d
> + * area of at least prf_buffer_size() in size.
>   * Note: caller *must* hold pgo_lock.
>   */
> -static int prf_serialize(struct prf_private_data *p)
> +static int prf_serialize(struct prf_private_data *p, size_t buf_size)
>  {
>  	int err = 0;
>  	void *buffer;
>  
> +	/* get buffer size, again. */
>  	p->size = prf_buffer_size();
> -	p->buffer = vzalloc(p->size);
>  
> -	if (!p->buffer) {
> -		err = -ENOMEM;
> +	/* check for unlikely overflow. */
> +	if (p->size > buf_size) {
> +		err = -EAGAIN;

This can just be ENOMEM instead -- it'll never change in size. (But we
should absolutely keep the check.)

>  		goto out;
>  	}
>  
> @@ -259,27 +264,46 @@ static int prf_open(struct inode *inode, struct file *file)
>  {
>  	struct prf_private_data *data;
>  	unsigned long flags;
> -	int err;
> +	size_t buf_size;
> +	int err = 0;
>  
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data) {
>  		err = -ENOMEM;
> -		goto out;
> +		goto out_free;
>  	}
>  
> +	/* get buffer size */
>  	flags = prf_lock();
> +	buf_size = prf_buffer_size();
> +	prf_unlock(flags);

And there's no locking needed here.

>  
> -	err = prf_serialize(data);
> -	if (unlikely(err)) {
> -		kfree(data);
> -		goto out_unlock;
> +	/* allocate, round up to page size. */
> +	buf_size = PAGE_ALIGN(buf_size);
> +	data->buffer = vzalloc(buf_size);
> +
> +	if (!data->buffer) {
> +		err = -ENOMEM;
> +		goto out_free;
>  	}
>  
> +	/* try serialize and get actual
> +	 * data length in data->size
> +	 */
> +	flags = prf_lock();
> +	err = prf_serialize(data, buf_size);
> +	prf_unlock(flags);
> +
> +	if (err)
> +		goto out_free;
> +
>  	file->private_data = data;
> +	return 0;
>  
> -out_unlock:
> -	prf_unlock(flags);
> -out:
> +out_free:
> +	if (data)
> +		vfree(data->buffer);
> +	kfree(data);
>  	return err;
>  }
>  
> 
> base-commit: 5d0cda65918279ada060417c5fecb7e86ccb3def
> -- 
> 2.31.1
> 

-- 
Kees Cook
