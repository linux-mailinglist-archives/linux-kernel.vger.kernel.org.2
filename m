Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7BE3C22C4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 13:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhGIL0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 07:26:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:53752 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhGIL0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 07:26:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="231453187"
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="231453187"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 04:23:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="458247325"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 04:23:52 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m1obi-00Ax6t-5D; Fri, 09 Jul 2021 14:23:46 +0300
Date:   Fri, 9 Jul 2021 14:23:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, linux@rasmusvillemoes.dk, rafael@kernel.org,
        rdunlap@infradead.org, agordeev@linux.ibm.com, sbrivio@redhat.com,
        jianpeng.ma@intel.com, valentin.schneider@arm.com,
        peterz@infradead.org, bristot@redhat.com, guodong.xu@linaro.org,
        tangchengchang@huawei.com, prime.zeng@hisilicon.com,
        yangyicong@huawei.com, tim.c.chen@linux.intel.com,
        linuxarm@huawei.com, Tian Tao <tiantao6@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v6 1/4] cpumask: introduce cpumap_print_to_buf to support
 large bitmask and list
Message-ID: <YOgxwlMIEMFRUJ0/@smile.fi.intel.com>
References: <20210709075544.11412-1-song.bao.hua@hisilicon.com>
 <20210709075544.11412-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709075544.11412-2-song.bao.hua@hisilicon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 07:55:41PM +1200, Barry Song wrote:
> From: Tian Tao <tiantao6@hisilicon.com>
> 
> The existing cpumap_print_to_pagebuf() is used by cpu topology and other
> drivers to export hexadecimal bitmask and decimal list to userspace by
> sysfs ABI.
> 
> Right now, those drivers are using a normal attribute for this kind of
> ABIs. A normal attribute typically has show entry as below:
> 
> static ssize_t example_dev_show(struct device *dev,
>                 struct device_attribute *attr, char *buf)
> {
> 	...
>         return cpumap_print_to_pagebuf(true, buf, &pmu_mmdc->cpu);
> }
> show entry of attribute has no offset and count parameters and this
> means the file is limited to one page only.
> 
> cpumap_print_to_pagebuf() API works terribly well for this kind of
> normal attribute with buf parameter and without offset, count:
> 
> static inline ssize_t
> cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
> {
>         return bitmap_print_to_pagebuf(list, buf, cpumask_bits(mask),
>                                       nr_cpu_ids);
> }
> 
> The problem is once we have many cpus, we have a chance to make bitmask
> or list more than one page. Especially for list, it could be as complex
> as 0,3,5,7,9,...... We have no simple way to know it exact size.
> 
> It turns out bin_attribute is a way to break this limit. bin_attribute
> has show entry as below:
> static ssize_t
> example_bin_attribute_show(struct file *filp, struct kobject *kobj,
>              struct bin_attribute *attr, char *buf,
>              loff_t offset, size_t count)
> {
>         ...
> }
> 
> With the new offset and count parameters, this makes sysfs ABI be able
> to support file size more than one page. For example, offset could be
> >= 4096.
> 
> This patch introduces cpumap_print_to_buf() so that those drivers can
> move to bin_attribute to support large bitmask and list. In result,
> we have to pass the corresponding parameters from bin_attribute to this
> new API.

This is rather good and explanatory commit message. I'm wondering if we can
make parts of it in some documentation.


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
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  -v6:
>   -minor cleanup doc according to Andy Shevchenko's comment;
>   -take bitmap_print_to_buf back according to Yury Norov's comment and
>    fix the documents;
>   -Sorry, Yury, I don't think it is doable to move memory allocation
>    to drivers.
>    Considering a driver like topology.c, we have M CPUs and each CPU
>    has N various nodes like core_siblings, package_cpus, die_cpus etc,
>    we can't know the size of each node of each CPU in advance. The best
>    time to get the size of each node is really when users read the sysfs
>    node. otherwise, we have to scan M*N nodes in drivers in advance to
>    figure out the exact size of buffers we need.
>    On the other hand, it is crazily tricky to ask a bundle of drivers to
>    find a proper place to save the pointer of allocated buffers so that
>    they can be re-used in second read of the same bin_attribute node.
>    And I doubt it is really useful to save the address of buffers
>    somewhere. Immediately freeing it seems to be a correct option to
>    avoid runtime waste of memory. We can't predict when users will read
>    topology ABI and which node users will read.
>    Finally, reading topology things wouldn't be the really cpu-bound
>    things in user applications, hardly this kind of ABI things can be
>    a performance bottleneck. Users use numactl and lstopo commands to
>    read ABIs but nobody will do it again and again. And a normal
>    application won't read topology repeatly. So the overhead caused by
>    malloc/free in the new bitmap API doesn't really matter.
>    if we really want a place to re-used the buffer and avoid malloc/free,
>    it seems this should be done in some common place rather than each
>    driver. still it is hard to find the best place.
> 
>    Thanks for the comments of Yury and Andy in v5.
> 
>  include/linux/bitmap.h  |  2 ++
>  include/linux/cpumask.h | 24 +++++++++++++++++++++++
>  lib/bitmap.c            | 43 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+)
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
> index bfc4690de4f4..8a89d133fa2d 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -983,6 +983,30 @@ cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
>  				      nr_cpu_ids);
>  }
>  
> +/**
> + * cpumap_print_to_buf  - copies the cpumask into the buffer
> + * @list: indicates whether the cpumap must be list

a list

> + *      true:  print in decimal list format
> + *      false: print in hexadecimal bitmask format

Perhaps explanation deserves to be a paragraph below?

> + * @mask: the cpumask to copy
> + * @buf: the buffer to copy into
> + * @off: in the string from which we are copying, We copy to @buf
> + * @count: the maximum number of bytes to print
> + *
> + * The function copies the cpumask into the buffer either as comma-separated
> + * list of cpus or hex values of cpumask; Typically used by bin_attribute to
> + * export cpumask bitmask and list ABI.
> + *
> + * Returns the length of how many bytes have been copied.
> + */
> +static inline ssize_t
> +cpumap_print_to_buf(bool list, char *buf, const struct cpumask *mask,
> +		loff_t off, size_t count)
> +{
> +	return bitmap_print_to_buf(list, buf, cpumask_bits(mask),
> +			nr_cpu_ids, off, count);
> +}
> +
>  #if NR_CPUS <= BITS_PER_LONG
>  #define CPU_MASK_ALL							\
>  (cpumask_t) { {								\
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 9401d39e4722..c64baa3a8606 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -487,6 +487,49 @@ int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
>  }
>  EXPORT_SYMBOL(bitmap_print_to_pagebuf);
>  
> +/**
> + * bitmap_print_to_buf  - convert bitmap to list or hex format ASCII string
> + * @list: indicates whether the bitmap must be list

a list

> + *      true:  print in decimal list format
> + *      false: print in hexadecimal bitmask format

Perhaps explanation deserves to be a paragraph below?

> + * @buf: buffer into which string is placed
> + * @maskp: pointer to bitmap to convert
> + * @nmaskbits: size of bitmap, in bits
> + * @off: in the string from which we are copying, We copy to @buf
> + * @count: the maximum number of bytes to print
> + *
> + * The role of cpumap_print_to_buf() and cpumap_print_to_pagebuf() is similar,
> + * the difference is that bitmap_print_to_pagebuf() mainly serves sysfs
> + * attribute with the assumption the destination buffer is exactly one page
> + * aligned with PAGE_SIZE and it won't be more than one page, thus,
> + * bitmap_print_to_pagebuf() needs neither offset to copy from nor count
> + * which is the length we are going to copy. cpumap_print_to_buf(), on the
> + * other hand, mainly serves bin_attribute which doesn't work with exact
> + * one page, and it has explicit parameters like "offset" to copy from and
> + * "count" bytes to copy. So cpumap_print_to_buf() can break the size limit
> + * of converted decimal list and hexadecimal bitmask. And buf doesn't have
> + * to be exactly one page.
> + *
> + * Returns the number of characters actually printed to @buf
> + */
> +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> +		int nmaskbits, loff_t off, size_t count)
> +{
> +	const char *fmt = list ? "%*pbl\n" : "%*pb\n";
> +	ssize_t size;
> +	void *data;
> +
> +	data = kasprintf(GFP_KERNEL, fmt, nmaskbits, maskp);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) + 1);
> +	kfree(data);
> +
> +	return size;
> +}
> +EXPORT_SYMBOL(bitmap_print_to_buf);
> +
>  /*
>   * Region 9-38:4/10 describes the following bitmap structure:
>   * 0	   9  12    18			38	     N
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


