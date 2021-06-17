Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72CC3ABDB8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 22:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhFQU4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 16:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhFQU4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 16:56:13 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908F7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 13:54:04 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id y11so190200qvv.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 13:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xk4XzMP3NJKe4DF2aLLNfuzC8EHL57dxsLL5r8WjD3c=;
        b=oj287Y+3fvBVLMtVU3ZVewhhJ2gJmiwRswP4sqTUktIuQixnbreflxGx0W1biFDaWF
         ziWgGL7Q6zYkrraiGIcPh5kIjtTMTTOjCtq4YvNsOT+B+df3TWv+zZ/B/sdOCT/GpQWs
         eTOwZnjDDkKEprZ6k+kc99nW1lcMlRLVCsbOICQkQdNEbYKs5dtZdM/So6BWSnGJCouU
         Mlg3J64TBtc1tSd8rC0TQobRA781nCm3LrQPZf3EKLkpD4h9OxHHls9g5x2SxOVKob7r
         M4P1IeprCrGaeGYd7jSL2SwH/oHbB9ca3QX6AMArjOv6GRdckHYknzrdXyz/ce2AvlbG
         gBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xk4XzMP3NJKe4DF2aLLNfuzC8EHL57dxsLL5r8WjD3c=;
        b=Bha5/tvTsStCRCxzcDeEYAuUY6caAymScGwZvVhXRYdRoI0rffrOEHYhXJmj9g77Oo
         xTRzpRyW+T/PBhW7dEdqbSM7zSuft3WK/M/r+lVr0oY63wNciN3NKA/3Y/jN6mbRcqEp
         cBSpm7LS4KPtiek5BeqQTpVZb5aqYYxvREp5fXzBtpFsrC4E4i6G1iJPUt5Hxdh0pu5P
         cuCKl0iZqcDxGTsEN2k0QuqbQYzy7P62vqX8kEotQ+U5ca5hFA++G+sdtXAlrdFQCDP1
         BKph4RgAd9D5cSNjdsLo0+3ZAGlimEESGf2+9lxz5tayI2ha4tc2fnBrHy9T3PCZXkJr
         UpYw==
X-Gm-Message-State: AOAM530NPas0mrlbVQ+DE8ASCpWZWYCMNLmlJ9OLr6/uXjz34V70doMA
        gqNZLXDuH4Sz7d2Oz9NfipE=
X-Google-Smtp-Source: ABdhPJx0J/5C/wZ3ZqwR+0lwm+0IdNAQOsnnYtrEvzK/QxxcuCk3EIiMFnb1A6nraE8cYxbja1yDDA==
X-Received: by 2002:a0c:fa0d:: with SMTP id q13mr1863977qvn.43.1623963243661;
        Thu, 17 Jun 2021 13:54:03 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id b132sm2558571qkg.116.2021.06.17.13.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 13:54:03 -0700 (PDT)
Date:   Thu, 17 Jun 2021 13:54:02 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        rafael@kernel.org, akpm@linux-foundation.org,
        rdunlap@infradead.org, agordeev@linux.ibm.com, sbrivio@redhat.com,
        jianpeng.ma@intel.com, valentin.schneider@arm.com,
        peterz@infradead.org, bristot@redhat.com, guodong.xu@linaro.org,
        tangchengchang@huawei.com, prime.zeng@hisilicon.com,
        yangyicong@huawei.com, tim.c.chen@linux.intel.com,
        tiantao6@hisilicon.com, Jonathan.Cameron@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH v4 1/4] lib: bitmap: introduce bitmap_print_to_buf
Message-ID: <YMu2amhrdGZHJ5mY@yury-ThinkPad>
References: <20210617101910.13228-1-song.bao.hua@hisilicon.com>
 <20210617101910.13228-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617101910.13228-2-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:19:07PM +1200, Barry Song wrote:
> From: Tian Tao <tiantao6@hisilicon.com>
> 
> New API bitmap_print_to_buf() with bin_attribute to avoid maskp
> exceeding PAGE_SIZE. bitmap_print_to_pagebuf() is a special case
> of bitmap_print_to_buf(), so in bitmap_print_to_pagebuf() call
> bitmap_print_to_buf().
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stefano Brivio <sbrivio@redhat.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: "Ma, Jianpeng" <jianpeng.ma@intel.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> ---
>  include/linux/bitmap.h  |  2 ++
>  include/linux/cpumask.h | 21 +++++++++++++++++++++
>  lib/bitmap.c            | 37 +++++++++++++++++++++++++++++++++++--
>  3 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index a36cfcec4e77..0de6effa2797 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -226,6 +226,8 @@ void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int n
>  unsigned int bitmap_ord_to_pos(const unsigned long *bitmap, unsigned int ord, unsigned int nbits);
>  int bitmap_print_to_pagebuf(bool list, char *buf,
>  				   const unsigned long *maskp, int nmaskbits);
> +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> +			int nmaskbits, loff_t off, size_t count);
>  
>  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
>  #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index bfc4690de4f4..1bef69e4b950 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -983,6 +983,27 @@ cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
>  				      nr_cpu_ids);
>  }
>  
> +/**
> + * cpumap_print_to_buf  - copies the cpumask into the buffer either
> + *      as comma-separated list of cpus or hex values of cpumask
> + * @list: indicates whether the cpumap must be list
> + * @mask: the cpumask to copy
> + * @buf: the buffer to copy into
> + * @off: in the string from which we are copying, We copy to @buf + off
> + * @count: the maximum number of bytes to print
> + *
> + * The role of cpumap_print_to_buf() and cpumap_print_to_pagebuf() is
> + * the same, the difference is that buf of bitmap_print_to_buf()
> + * can be more than one pagesize.
> + */
> +static inline ssize_t
> +cpumap_print_to_buf(bool list, char *buf, const struct cpumask *mask,
> +		    loff_t off, size_t count)
> +{
> +	return bitmap_print_to_buf(list, buf, cpumask_bits(mask),
> +				   nr_cpu_ids, off, count);
> +}
> +
>  #if NR_CPUS <= BITS_PER_LONG
>  #define CPU_MASK_ALL							\
>  (cpumask_t) { {								\
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 74ceb02f45e3..ed7ef6e2edca 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -461,6 +461,40 @@ int bitmap_parse_user(const char __user *ubuf,
>  }
>  EXPORT_SYMBOL(bitmap_parse_user);
>  
> +/**
> + * bitmap_print_to_buf - convert bitmap to list or hex format ASCII string
> + * @list: indicates whether the bitmap must be list
> + * @buf: the kernel space buffer to read to
> + * @maskp: pointer to bitmap to convert
> + * @nmaskbits: size of bitmap, in bits
> + * @off: offset in data buffer below

Below there's a @count parameter. Maybe above?

> + * @count: the maximum number of bytes to print
> + *
> + * The role of bitmap_print_to_buf() and bitmap_print_to_pagebuf() is
> + * the same, the difference is that buf of bitmap_print_to_buf()
> + * can be more than one pagesize.

You're introducing a function that duplicates an existing function.
I can understand it only if there is important performance and/or
security consideration. Otherwise, I'd recommend you to extend
bitmap_print_to_pagebuf() with one more parameter.

> + */
> +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> +			int nmaskbits, loff_t off, size_t count)
> +{
> +	const char *fmt = list ? "%*pbl\n" : "%*pb\n";
> +	ssize_t size;
> +	void *data;
> +
> +	if (off == LLONG_MAX && count == PAGE_SIZE - offset_in_page(buf))
> +		return scnprintf(buf, count, fmt, nmaskbits, maskp);

Agree with Greg. This requires explanation.

> +
> +	data = kasprintf(GFP_KERNEL, fmt, nmaskbits, maskp);
> +	if (!data)
> +		return -ENOMEM;

So here:
 - you make user of your function to guess about how much memory he needs
   to provide to the function;
 - then kasprintf() allocates enough memory for you automatically;
 - then you copy the data to potentially insufficient buffer;
 - and then free a valid 'data' buffer provided by kasprintf(), even if
   the following memory_read_from_buffer() fails;
 - goto 'So here'. 

It doesn't look like a good design.

kasprintf() does everything you need. Why don't you use it directly in
your driver?

> +
> +	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) + 1);

strlen() is O(n), just as memory_read_from_buffer(). In this line you introduce
a 2*O(n) operation. Consider strncpy().

> +	kfree(data);
> +
> +	return size;
> +}
> +EXPORT_SYMBOL(bitmap_print_to_buf);
> +
>  /**
>   * bitmap_print_to_pagebuf - convert bitmap to list or hex format ASCII string
>   * @list: indicates whether the bitmap must be list
> @@ -482,8 +516,7 @@ int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
>  {
>  	ptrdiff_t len = PAGE_SIZE - offset_in_page(buf);
>  
> -	return list ? scnprintf(buf, len, "%*pbl\n", nmaskbits, maskp) :
> -		      scnprintf(buf, len, "%*pb\n", nmaskbits, maskp);
> +	return bitmap_print_to_buf(list, buf, maskp, nmaskbits, LLONG_MAX, len);
>  }
>  EXPORT_SYMBOL(bitmap_print_to_pagebuf);
>  
> -- 
> 2.25.1
