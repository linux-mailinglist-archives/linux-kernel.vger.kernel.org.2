Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F633AC0B8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 04:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhFRCQv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Jun 2021 22:16:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5031 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFRCQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 22:16:51 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5j6T2RnszXg6d;
        Fri, 18 Jun 2021 10:09:37 +0800 (CST)
Received: from dggema722-chm.china.huawei.com (10.3.20.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 10:14:40 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema722-chm.china.huawei.com (10.3.20.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 10:14:40 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Fri, 18 Jun 2021 10:14:40 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "sbrivio@redhat.com" <sbrivio@redhat.com>,
        "jianpeng.ma@intel.com" <jianpeng.ma@intel.com>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>,
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
Thread-Index: AQHXY2Jr7LwcmgS3dkirmmhZsT5ZLKsXf2oAgAGEYrA=
Date:   Fri, 18 Jun 2021 02:14:40 +0000
Message-ID: <1d0f246d448149b5a54a68d349ba8e86@hisilicon.com>
References: <20210617101910.13228-1-song.bao.hua@hisilicon.com>
 <20210617101910.13228-2-song.bao.hua@hisilicon.com>
 <YMsoOK+LtX548px6@kroah.com>
In-Reply-To: <YMsoOK+LtX548px6@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.227]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday, June 17, 2021 10:47 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org;
> linux@rasmusvillemoes.dk; rafael@kernel.org; akpm@linux-foundation.org;
> rdunlap@infradead.org; agordeev@linux.ibm.com; sbrivio@redhat.com;
> jianpeng.ma@intel.com; yury.norov@gmail.com; valentin.schneider@arm.com;
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
> > exceeding PAGE_SIZE.
> 
> I can not parse this sentance at all, sorry.
> 
> What does a "bin_attribute" mean to this change?  What does PAGE_SIZE
> have to do with anything at all here?
> 
> > bitmap_print_to_pagebuf() is a special case
> > of bitmap_print_to_buf(), so in bitmap_print_to_pagebuf() call
> > bitmap_print_to_buf().
> 
> Again, I can not parse this, sorry.  Can you please try writing this in
> a different way to be more descriptive?
> 
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
> 
> How do you choose between a comma or a hex value?
> 
> > + * @list: indicates whether the cpumap must be list
> 
> Should this be the thing that determines a comma or not?  If true does
> that mean a comma?  Or if false?  Can you please document this?
> 
> 
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
> > + * @count: the maximum number of bytes to print
> > + *
> > + * The role of bitmap_print_to_buf() and bitmap_print_to_pagebuf() is
> > + * the same, the difference is that buf of bitmap_print_to_buf()
> > + * can be more than one pagesize.
> 
> "pagesize" does not make sense here.
> 
> Why does PAGE_SIZE have anything to do with this function at all?
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
> I do not understand this check, can you please comment why you are doing
> it this way?

Discussed with Tiantao and figured out the reason. In the previous
version, this trick didn't exist.

In order that bitmap_print_to_pagebuf() can directly call
bitmap_print_to_buf() with the awareness of 
" ptrdiff_t len = PAGE_SIZE - offset_in_page(buf);" of the
original code:

int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
			    int nmaskbits)
{
	ptrdiff_t len = PAGE_SIZE - offset_in_page(buf);

	return list ? scnprintf(buf, len, "%*pbl\n", nmaskbits, maskp) :
		      scnprintf(buf, len, "%*pb\n", nmaskbits, maskp);
}
EXPORT_SYMBOL(bitmap_print_to_pagebuf);

This version is playing the trick by using LLONG_MAX as a "magic"
offset so that bitmap_print_to_buf() can do the particular job for
bitmap_print_to_pagebuf(). bitmap_print_to_pagebuf is working
under the assumption the buffer is just ONE page so it always
uses the unfinished part of the page as the length to print.

So the trick in bitmap_print_to_pagebuf() is like:

@@ -482,8 +516,7 @@ int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
 {
 	ptrdiff_t len = PAGE_SIZE - offset_in_page(buf);
 
-	return list ? scnprintf(buf, len, "%*pbl\n", nmaskbits, maskp) :
-		      scnprintf(buf, len, "%*pb\n", nmaskbits, maskp);
+	return bitmap_print_to_buf(list, buf, maskp, nmaskbits, LLONG_MAX, len);
 }
 EXPORT_SYMBOL(bitmap_print_to_pagebuf);

This is weird and this is ugly. So my understanding is that
is no necessity to touch bitmap_print_to_pagebuf? We can keep
bitmap_print_to_pagebuf as is. If users are quite sure their
ABIs won't be more than 1 page, they can still use this version
which doesn't have the complexity to calculate the exact
size of the final bitmap.


> 
> 
> thanks,
> 
> greg k-h

Thanks
Barry

