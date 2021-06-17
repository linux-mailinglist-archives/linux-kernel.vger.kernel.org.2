Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825763AB19E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhFQKtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhFQKta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:49:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5313613BA;
        Thu, 17 Jun 2021 10:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623926842;
        bh=9MSDM0GQP20OY726w7PhP4UhIjbXDc4p0WbTwQaVjmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ryz02vwqwSxyhFwuXhqPB2akTq+svn+607d3ZrAR9fM2H4xxKsT5VBJMZwRkFXNky
         OVmbn/krcwXEs7zwAXLQst3LPBTK5Zmxd0jNdGR8sOTzcEsZrGBr/6mmJUzstehRVU
         wrM2r8Dw4MXxwq7liRGpkud/7sBirOwBUWpQ5QKs=
Date:   Thu, 17 Jun 2021 12:47:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, rafael@kernel.org,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        agordeev@linux.ibm.com, sbrivio@redhat.com, jianpeng.ma@intel.com,
        yury.norov@gmail.com, valentin.schneider@arm.com,
        peterz@infradead.org, bristot@redhat.com, guodong.xu@linaro.org,
        tangchengchang@huawei.com, prime.zeng@hisilicon.com,
        yangyicong@huawei.com, tim.c.chen@linux.intel.com,
        tiantao6@hisilicon.com, Jonathan.Cameron@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH v4 1/4] lib: bitmap: introduce bitmap_print_to_buf
Message-ID: <YMsoOK+LtX548px6@kroah.com>
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
> exceeding PAGE_SIZE.

I can not parse this sentance at all, sorry.

What does a "bin_attribute" mean to this change?  What does PAGE_SIZE
have to do with anything at all here?

> bitmap_print_to_pagebuf() is a special case
> of bitmap_print_to_buf(), so in bitmap_print_to_pagebuf() call
> bitmap_print_to_buf().

Again, I can not parse this, sorry.  Can you please try writing this in
a different way to be more descriptive?

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

How do you choose between a comma or a hex value?

> + * @list: indicates whether the cpumap must be list

Should this be the thing that determines a comma or not?  If true does
that mean a comma?  Or if false?  Can you please document this?


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
> + * @count: the maximum number of bytes to print
> + *
> + * The role of bitmap_print_to_buf() and bitmap_print_to_pagebuf() is
> + * the same, the difference is that buf of bitmap_print_to_buf()
> + * can be more than one pagesize.

"pagesize" does not make sense here.

Why does PAGE_SIZE have anything to do with this function at all?

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

I do not understand this check, can you please comment why you are doing
it this way?


thanks,

greg k-h
