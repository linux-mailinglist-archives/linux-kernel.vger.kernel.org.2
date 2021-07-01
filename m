Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E773B9164
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbhGAMCJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jul 2021 08:02:09 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:10233 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbhGAMCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 08:02:07 -0400
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GFxT22dQ6z1BSkW;
        Thu,  1 Jul 2021 19:54:14 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 1 Jul 2021 19:59:34 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Thu, 1 Jul 2021 19:59:34 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Yury Norov <yury.norov@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "sbrivio@redhat.com" <sbrivio@redhat.com>,
        "jianpeng.ma@intel.com" <jianpeng.ma@intel.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        tangchengchang <tangchengchang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        yangyicong <yangyicong@huawei.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v4 1/4] lib: bitmap: introduce bitmap_print_to_buf
Thread-Topic: [PATCH v4 1/4] lib: bitmap: introduce bitmap_print_to_buf
Thread-Index: AQHXY2Jr7LwcmgS3dkirmmhZsT5ZLKsYKOwAgBXiBsA=
Date:   Thu, 1 Jul 2021 11:59:34 +0000
Message-ID: <bd62f55457ef4c269db5bb752b7accc0@hisilicon.com>
References: <20210617101910.13228-1-song.bao.hua@hisilicon.com>
 <20210617101910.13228-2-song.bao.hua@hisilicon.com>
 <YMu2amhrdGZHJ5mY@yury-ThinkPad>
In-Reply-To: <YMu2amhrdGZHJ5mY@yury-ThinkPad>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.220]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Yury Norov [mailto:yury.norov@gmail.com]
> Sent: Friday, June 18, 2021 8:54 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: gregkh@linuxfoundation.org; andriy.shevchenko@linux.intel.com;
> linux-kernel@vger.kernel.org; linux@rasmusvillemoes.dk; rafael@kernel.org;
> akpm@linux-foundation.org; rdunlap@infradead.org; agordeev@linux.ibm.com;
> sbrivio@redhat.com; jianpeng.ma@intel.com; valentin.schneider@arm.com;
> peterz@infradead.org; bristot@redhat.com; guodong.xu@linaro.org;
> tangchengchang <tangchengchang@huawei.com>; Zengtao (B)
> <prime.zeng@hisilicon.com>; yangyicong <yangyicong@huawei.com>;
> tim.c.chen@linux.intel.com; tiantao (H) <tiantao6@hisilicon.com>; Jonathan
> Cameron <jonathan.cameron@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v4 1/4] lib: bitmap: introduce bitmap_print_to_buf
> 
> On Thu, Jun 17, 2021 at 10:19:07PM +1200, Barry Song wrote:
> > From: Tian Tao <tiantao6@hisilicon.com>
> >
> > New API bitmap_print_to_buf() with bin_attribute to avoid maskp
> > exceeding PAGE_SIZE. bitmap_print_to_pagebuf() is a special case
> > of bitmap_print_to_buf(), so in bitmap_print_to_pagebuf() call
> > bitmap_print_to_buf().
> >
> > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Stefano Brivio <sbrivio@redhat.com>
> > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > Cc: "Ma, Jianpeng" <jianpeng.ma@intel.com>
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > ---
> >  include/linux/bitmap.h  |  2 ++
> >  include/linux/cpumask.h | 21 +++++++++++++++++++++
> >  lib/bitmap.c            | 37 +++++++++++++++++++++++++++++++++++--
> >  3 files changed, 58 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > index a36cfcec4e77..0de6effa2797 100644
> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -226,6 +226,8 @@ void bitmap_copy_le(unsigned long *dst, const unsigned
> long *src, unsigned int n
> >  unsigned int bitmap_ord_to_pos(const unsigned long *bitmap, unsigned int ord,
> unsigned int nbits);
> >  int bitmap_print_to_pagebuf(bool list, char *buf,
> >  				   const unsigned long *maskp, int nmaskbits);
> > +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> > +			int nmaskbits, loff_t off, size_t count);
> >
> >  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG -
> 1)))
> >  #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG -
> 1)))
> > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > index bfc4690de4f4..1bef69e4b950 100644
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -983,6 +983,27 @@ cpumap_print_to_pagebuf(bool list, char *buf, const
> struct cpumask *mask)
> >  				      nr_cpu_ids);
> >  }
> >
> > +/**
> > + * cpumap_print_to_buf  - copies the cpumask into the buffer either
> > + *      as comma-separated list of cpus or hex values of cpumask
> > + * @list: indicates whether the cpumap must be list
> > + * @mask: the cpumask to copy
> > + * @buf: the buffer to copy into
> > + * @off: in the string from which we are copying, We copy to @buf + off
> > + * @count: the maximum number of bytes to print
> > + *
> > + * The role of cpumap_print_to_buf() and cpumap_print_to_pagebuf() is
> > + * the same, the difference is that buf of bitmap_print_to_buf()
> > + * can be more than one pagesize.
> > + */
> > +static inline ssize_t
> > +cpumap_print_to_buf(bool list, char *buf, const struct cpumask *mask,
> > +		    loff_t off, size_t count)
> > +{
> > +	return bitmap_print_to_buf(list, buf, cpumask_bits(mask),
> > +				   nr_cpu_ids, off, count);
> > +}
> > +
> >  #if NR_CPUS <= BITS_PER_LONG
> >  #define CPU_MASK_ALL							\
> >  (cpumask_t) { {								\
> > diff --git a/lib/bitmap.c b/lib/bitmap.c
> > index 74ceb02f45e3..ed7ef6e2edca 100644
> > --- a/lib/bitmap.c
> > +++ b/lib/bitmap.c
> > @@ -461,6 +461,40 @@ int bitmap_parse_user(const char __user *ubuf,
> >  }
> >  EXPORT_SYMBOL(bitmap_parse_user);
> >
> > +/**
> > + * bitmap_print_to_buf - convert bitmap to list or hex format ASCII string
> > + * @list: indicates whether the bitmap must be list
> > + * @buf: the kernel space buffer to read to
> > + * @maskp: pointer to bitmap to convert
> > + * @nmaskbits: size of bitmap, in bits
> > + * @off: offset in data buffer below
> 
> Below there's a @count parameter. Maybe above?
> 
> > + * @count: the maximum number of bytes to print
> > + *
> > + * The role of bitmap_print_to_buf() and bitmap_print_to_pagebuf() is
> > + * the same, the difference is that buf of bitmap_print_to_buf()
> > + * can be more than one pagesize.
> 
> You're introducing a function that duplicates an existing function.
> I can understand it only if there is important performance and/or
> security consideration. Otherwise, I'd recommend you to extend
> bitmap_print_to_pagebuf() with one more parameter.

This would be possible. The only problem is that once we extend
bitmap_print_to_pagebuf() with one more parameter, we have to
change all its users. By involving one new api, we don't need
to touch those.

On the other hand, if we extend bitmap_print_to_pagebuf()with
one more parameter, we probably need to do the same job on
cpumap_print_to_pagebuf().

One parameter is, for sure, not enough as bin_attribute has
offset and count.

> 
> > + */
> > +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> > +			int nmaskbits, loff_t off, size_t count)
> > +{
> > +	const char *fmt = list ? "%*pbl\n" : "%*pb\n";
> > +	ssize_t size;
> > +	void *data;
> > +
> > +	if (off == LLONG_MAX && count == PAGE_SIZE - offset_in_page(buf))
> > +		return scnprintf(buf, count, fmt, nmaskbits, maskp);
> 
> Agree with Greg. This requires explanation.

Explained in another email. This is a trick to let bitmap_print_to_buf
know bitmap_print_to_pagebuf is calling it.
But I'd remove it.

> 
> > +
> > +	data = kasprintf(GFP_KERNEL, fmt, nmaskbits, maskp);
> > +	if (!data)
> > +		return -ENOMEM;
> 
> So here:
>  - you make user of your function to guess about how much memory he needs
>    to provide to the function;
>  - then kasprintf() allocates enough memory for you automatically;
>  - then you copy the data to potentially insufficient buffer;
>  - and then free a valid 'data' buffer provided by kasprintf(), even if
>    the following memory_read_from_buffer() fails;
>  - goto 'So here'.
> 
> It doesn't look like a good design.
> 
> kasprintf() does everything you need. Why don't you use it directly in
> your driver?

I'm afraid I don't see the point of moving memory allocation to
the driver.
This api is mainly used by exporting cpumask bitmap to user in
a sysfs ABI. That means the destination buffer comes from sysfs,
and we have to copy the data to sysfs buf which is usually limited
to one page.

when cpumask bitmap or list is larger than one page, that means
sysfs's show entry will be called more than one time by different
offset and count. Not to mention user applications might
dynamically change the offset and count, then sysfs's show entry
might be called more than one time even though bitmap/list is
less than one page.

And drivers won't be able to re-use the allocated buffer in
multiple calling to the same sysfs show entry unless we make
some weird workaround to save the allocated memory address
somewhere.

Moving allocation to driver just means copying the same code
many times in different drivers. We have around 40 drivers
which are calling cpumap_print_to_pagebuf, all of them are
supposed to have the potential overflow issue and need update.

I'd argue putting the duplicated code of 40 drivers in the
common code is a better way.

But in this context, what is really useful is actually
cpumap_print_to_buf(). The safer way might be moving
kasprintf() to cpumap_print_to_buf(). Plus, I haven't
seen any other users of this new bitmap_print_to_buf()
API, so probably we can totally remove bitmap_print_to_buf()
and focus on making a better cpumap_print_to_buf.

The destination buffer which we are copying mask/list to
is actually quite safe in cpumap_print_to_buf() as
sysfs bin_attr guarantee the right offset and count.

If we remove bitmap_print_to_buf, we avoid the possible
abuse of this new bitmap API and avoid potential buffer
overflow issue. We are narrowing the scope of the
modification to cpumap.

I'd appreciate your further comments on that.

> 
> > +
> > +	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) + 1);
> 
> strlen() is O(n), just as memory_read_from_buffer(). In this line you introduce
> a 2*O(n) operation. Consider strncpy().
> 
> > +	kfree(data);
> > +
> > +	return size;
> > +}
> > +EXPORT_SYMBOL(bitmap_print_to_buf);
> > +
> >  /**
> >   * bitmap_print_to_pagebuf - convert bitmap to list or hex format ASCII string
> >   * @list: indicates whether the bitmap must be list
> > @@ -482,8 +516,7 @@ int bitmap_print_to_pagebuf(bool list, char *buf, const
> unsigned long *maskp,
> >  {
> >  	ptrdiff_t len = PAGE_SIZE - offset_in_page(buf);
> >
> > -	return list ? scnprintf(buf, len, "%*pbl\n", nmaskbits, maskp) :
> > -		      scnprintf(buf, len, "%*pb\n", nmaskbits, maskp);
> > +	return bitmap_print_to_buf(list, buf, maskp, nmaskbits, LLONG_MAX, len);
> >  }
> >  EXPORT_SYMBOL(bitmap_print_to_pagebuf);
> >
> > --
> > 2.25.1

Thanks
Barry

