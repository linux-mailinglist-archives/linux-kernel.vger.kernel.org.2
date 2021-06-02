Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CAF3991B9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhFBReN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:34:13 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:42497 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhFBReM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:34:12 -0400
Received: by mail-pl1-f179.google.com with SMTP id v13so1457827ple.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 10:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tt4Knbco8jltVFuXBy6keGgbL9Kdul7C1y1WYAEE+Cc=;
        b=c4XGCHVJTa8U3ZFnw5huGuxfN5oEw7heGBJ2zGhAVBG5lUqQs0DS7ynKDG72i0324N
         o84Vr3Y/j2RarKS8A0HVeb7tyRf/35ZBvRndWtIQZPpqmGMaod8wlBpc23GkcXkTz8GA
         7bMM4y8c88ZUZQQ+EIJOBCpcN3roFFXLsPp/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tt4Knbco8jltVFuXBy6keGgbL9Kdul7C1y1WYAEE+Cc=;
        b=nqFh9FdSlbWdyWy2OBcNsj7HY2DkZcQHp8qdrI/fdqL6jNoVHPbmhpQcrDn+0VbweI
         eegGtvhBjrhyLhRxnAoxLA6oERp+kFJj6K6al9JwIk8lDgjuD7l0QwQLzygwsRf8zaUZ
         rMTaLPwr+C4LIgGzZy7weHY9272FtUcPBAqw2IxBItUOAyD9a0BmPpSTZO03r9QUj/mj
         AX5QZG6KMqCCiO1uK6WGCKsVd8YYQEVhBwiY8fAkU9RVtcM2wdO4O5vlvw09iXkj8YWT
         VPnGkDq+urk/sunmzn8nMyMKwkYkStEV5xvKNRe3by0r+ZseAMSPj4V8LZoykSMqqpIX
         7Gfw==
X-Gm-Message-State: AOAM531y+bcmejyll7yDQ8Rwl2wiL6pOfTgU42zxAxf8zK6WDPyayzF7
        63U9+DluZWVON55vqQG/mvJqzQ==
X-Google-Smtp-Source: ABdhPJxui5STc1xlAqhouIG+XZ/2xJmskQkFii5alTP18XeJ6jM5j4gUaq/75TS/+RgNoXdFnJr43A==
X-Received: by 2002:a17:90a:ae11:: with SMTP id t17mr6591604pjq.85.1622655081153;
        Wed, 02 Jun 2021 10:31:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y1sm236817pfn.13.2021.06.02.10.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 10:31:20 -0700 (PDT)
Date:   Wed, 2 Jun 2021 10:31:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [PATCH 1/1] pgo: Fix sleep in atomic section in prf_open()
Message-ID: <202106021009.A556DFB7F2@keescook>
References: <20210602162640.170752-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602162640.170752-1-jarmo.tiitto@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 07:26:40PM +0300, Jarmo Tiitto wrote:
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

Ah-ha; nice catch!

> 
> This patch avoids holding the prf_lock() while calling
> vzalloc(). Problem with that is prf_buffer_size()
> *must* be called with prf_lock() held and the buffer
> size may change while we call vzalloc()
> 
> So first get buffer size, release the lock and allocate.
> Then re-lock and call prf_serialize() that now checks if
> the buffer is big enough. If not, the code loops.
> 
> Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> ---
>  kernel/pgo/fs.c | 45 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
> index ef985159dad3..e8ac07637423 100644
> --- a/kernel/pgo/fs.c
> +++ b/kernel/pgo/fs.c
> @@ -227,16 +227,15 @@ static unsigned long prf_buffer_size(void)
>   * Serialize the profiling data into a format LLVM's tools can understand.
>   * Note: caller *must* hold pgo_lock.
>   */
> -static int prf_serialize(struct prf_private_data *p)
> +static int prf_serialize(struct prf_private_data *p, unsigned long *buf_size)
>  {
>  	int err = 0;
>  	void *buffer;
>  
> -	p->size = prf_buffer_size();
> -	p->buffer = vzalloc(p->size);
> +	*buf_size = prf_buffer_size();
>  
> -	if (!p->buffer) {
> -		err = -ENOMEM;
> +	if (p->size < *bufsize) {

Nit: please change prf_private_data::size to size_t while you're
touching this code.

> +		err = -EAGAIN;
>  		goto out;
>  	}
>  
> @@ -259,6 +258,7 @@ static int prf_open(struct inode *inode, struct file *file)
>  {
>  	struct prf_private_data *data;
>  	unsigned long flags;
> +	unsigned long buf_size;
>  	int err;
>  
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
> @@ -267,14 +267,39 @@ static int prf_open(struct inode *inode, struct file *file)
>  		goto out;
>  	}
>  
> +	/* note: vzalloc() can be used in atomic section.
> +	 * However to get the buffer size prf_lock() *must*
> +	 * be taken. So take lock, get buffer size, release
> +	 * the lock and allocate.
> +	 * prf_serialize() then checks if buffer has enough space.
> +	 */
>  	flags = prf_lock();
> +	buf_size = prf_buffer_size();
>  
> -	err = prf_serialize(data);
> -	if (unlikely(err)) {
> -		kfree(data);
> -		goto out_unlock;
> -	}
> +	do {
> +		prf_unlock(flags);
> +
> +		/* resize buffer */
> +		if (data->size < buf_size && data->buffer) {
> +			vfree(data->buffer);
> +			data->buffer = NULL;
> +		}
> +
> +		if (!data->buffer) {
> +			data->size = buf_size;
> +			data->buffer = vzalloc(data->size);
> +
> +			if (!data->buffer) {
> +				err = -ENOMEM;
> +				kfree(data);
> +				goto out;
> +			}
> +		}
> +		/* try serialize */
> +		flags = prf_lock();
> +	} while (prf_serialize(data, &buf_size));

I'm not a fan of loops where it's hard to answer the question "how do we
know this loop will always terminate?"

Given that vmalloc allocates PAGE_SIZE-granular regions, how about
rounding up to likely avoid multiple passes and put the growth explicitly
in the loop, rather than just looking at "any" prf_serialize() failure.

e.g.:

	struct prf_private_data *data;
	int err = -ENOMEM;

	data = kzalloc(sizeof(*data), GFP_KERNEL);
	if (!data)
		goto out_free;

	do {
		unsigned long flags;
		size_t size;

		size = PAGE_ALIGN(prf_buffer_size());
		/* Required buffer size must be growing with each loop. */
		if (WARN_ON_ONCE(size <= data->size)) {
			err = -ENOMEM;
			goto out_free;
		}

		if (data->buf)
			vfree(data->buf);
		data->buf = vzalloc(size);
		if (!data->buf) {
			err = -ENOMEM;
			goto out_free;
		}
		data->size = size;

		flags = prf_lock();
		err = prf_serialize(data);
		prf_unlock(flags);
	} while (err == -EAGAIN);

	if (err)
		goto out_free;

	file->private_data = data;
	return 0;

out_free:
	if (data)
		vfree(data->buf);
	kfree(data);
	return err;


>  
> +	data->size = buf_size;
>  	file->private_data = data;
>  
>  out_unlock:
> 
> base-commit: e1af496cbe9b4517428601a4e44fee3602dd3c15
> prerequisite-patch-id: fccc1bd89bbd33af13a4ce9bc3c913e6e3cdecee
> prerequisite-patch-id: a2e53c0b44ad39c78ed7bc7aad40d133548a13b5
> prerequisite-patch-id: 12f0e468a3d0ff12c7f5bc640f213be3b5dd261b
> prerequisite-patch-id: 707b836b1969958b5131dfa1b9f044eae5f4a76a
> -- 
> 2.31.1
> 

-- 
Kees Cook
