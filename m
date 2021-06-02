Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40002398105
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhFBGUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhFBGUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:20:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3717060FDC;
        Wed,  2 Jun 2021 06:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622614719;
        bh=P00OJKebPaoDXPSWHr36v9HnV2o0zqAMU+3w6jNtJdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Hv97PF+WY4JSkpbOp4VqH9RxjHZ9tEOfHeeK/qhER7E0RlM+9R+X653bM7DE48r7
         HFX31i+sfcKAZjBn4knS7a6eYp7OpOgtSsfDrcHc6sYudUNhNInuFAsmdIwuucWv88
         yna6QIo9mKaS1x2OW1lHTgkoOipX+5HYNZIj23/k=
Date:   Wed, 2 Jun 2021 08:18:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, song.bao.hua@hisilicon.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 1/2] topology: use bin_attribute to avoid buff overflow
Message-ID: <YLcivXNwm75V+I2m@kroah.com>
References: <1622516210-10886-1-git-send-email-tiantao6@hisilicon.com>
 <1622516210-10886-2-git-send-email-tiantao6@hisilicon.com>
 <YLW+hZwoImx2wjwS@kroah.com>
 <4c9c7c17-e8d1-d601-6262-8064293a06a9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c9c7c17-e8d1-d601-6262-8064293a06a9@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 02:14:49PM +0800, tiantao (H) wrote:
> 
> 在 2021/6/1 12:58, Greg KH 写道:
> > On Tue, Jun 01, 2021 at 10:56:49AM +0800, Tian Tao wrote:
> > > Reading sys/devices/system/cpu/cpuX/topology/ returns cpu topology.
> > > However, the size of this file is limited to PAGE_SIZE because of the
> > > limitation for sysfs attribute. so we use bin_attribute instead of
> > > attribute to avoid NR_CPUS too big to cause buff overflow.
> > > 
> > > This patch is based on the following discussion.
> > > https://www.spinics.net/lists/linux-doc/msg95921.html
> > Please use lore.kernel.org for links as we have no control over other
> > sites to ensure that they will work in the future.  Use the message id
> > in the link as well, so that if something were to happen to lore, we can
> > figure it out.
> > 
> > Also, you are modifying a bunch of different files here, do you mean to
> > do it for all of them?
> > 
> > > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > ---
> > >   drivers/base/topology.c | 115 ++++++++++++++++++++++++++----------------------
> > >   include/linux/bitmap.h  |   3 ++
> > >   include/linux/cpumask.h |  25 +++++++++++
> > >   lib/bitmap.c            |  34 ++++++++++++++
> > >   4 files changed, 125 insertions(+), 52 deletions(-)
> > > 
> > > diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> > > index 4d254fc..013edbb 100644
> > > --- a/drivers/base/topology.c
> > > +++ b/drivers/base/topology.c
> > > @@ -21,25 +21,27 @@ static ssize_t name##_show(struct device *dev,				\
> > >   	return sysfs_emit(buf, "%d\n", topology_##name(dev->id));	\
> > >   }
> > > -#define define_siblings_show_map(name, mask)				\
> > > -static ssize_t name##_show(struct device *dev,				\
> > > -			   struct device_attribute *attr, char *buf)	\
> > > -{									\
> > > -	return cpumap_print_to_pagebuf(false, buf, topology_##mask(dev->id));\
> > > +#define define_siblings_read_func(name, mask)					\
> > > +static ssize_t name##_read(struct file *file, struct kobject *kobj,		\
> > > +				  struct bin_attribute *attr, char *buf,	\
> > > +				  loff_t off, size_t count)			\
> > > +{										\
> > > +	struct device *dev = kobj_to_dev(kobj);                                 \
> > > +										\
> > > +	return cpumap_print_to_buf(false, buf, topology_##mask(dev->id),	\
> > > +				   off, count);                                 \
> > > +}										\
> > > +										\
> > > +static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
> > > +				  struct bin_attribute *attr, char *buf,	\
> > > +				  loff_t off, size_t count)			\
> > > +{										\
> > > +	struct device *dev = kobj_to_dev(kobj);					\
> > > +										\
> > > +	return cpumap_print_to_buf(true, buf, topology_##mask(dev->id),		\
> > > +				   off, count);					\
> > >   }
> > > -#define define_siblings_show_list(name, mask)				\
> > > -static ssize_t name##_list_show(struct device *dev,			\
> > > -				struct device_attribute *attr,		\
> > > -				char *buf)				\
> > > -{									\
> > > -	return cpumap_print_to_pagebuf(true, buf, topology_##mask(dev->id));\
> > > -}
> > > -
> > > -#define define_siblings_show_func(name, mask)	\
> > > -	define_siblings_show_map(name, mask);	\
> > > -	define_siblings_show_list(name, mask)
> > > -
> > >   define_id_show_func(physical_package_id);
> > >   static DEVICE_ATTR_RO(physical_package_id);
> > > @@ -49,71 +51,80 @@ static DEVICE_ATTR_RO(die_id);
> > >   define_id_show_func(core_id);
> > >   static DEVICE_ATTR_RO(core_id);
> > > -define_siblings_show_func(thread_siblings, sibling_cpumask);
> > > -static DEVICE_ATTR_RO(thread_siblings);
> > > -static DEVICE_ATTR_RO(thread_siblings_list);
> > > +define_siblings_read_func(thread_siblings, sibling_cpumask);
> > > +static BIN_ATTR_RO(thread_siblings, 0);
> > > +static BIN_ATTR_RO(thread_siblings_list, 0);
> > > -define_siblings_show_func(core_cpus, sibling_cpumask);
> > > -static DEVICE_ATTR_RO(core_cpus);
> > > -static DEVICE_ATTR_RO(core_cpus_list);
> > > +define_siblings_read_func(core_cpus, sibling_cpumask);
> > > +static BIN_ATTR_RO(core_cpus, 0);
> > > +static BIN_ATTR_RO(core_cpus_list, 0);
> > > -define_siblings_show_func(core_siblings, core_cpumask);
> > > -static DEVICE_ATTR_RO(core_siblings);
> > > -static DEVICE_ATTR_RO(core_siblings_list);
> > > +define_siblings_read_func(core_siblings, core_cpumask);
> > > +static BIN_ATTR_RO(core_siblings, 0);
> > > +static BIN_ATTR_RO(core_siblings_list, 0);
> > > -define_siblings_show_func(die_cpus, die_cpumask);
> > > -static DEVICE_ATTR_RO(die_cpus);
> > > -static DEVICE_ATTR_RO(die_cpus_list);
> > > +define_siblings_read_func(die_cpus, die_cpumask);
> > > +static BIN_ATTR_RO(die_cpus, 0);
> > > +static BIN_ATTR_RO(die_cpus_list, 0);
> > > -define_siblings_show_func(package_cpus, core_cpumask);
> > > -static DEVICE_ATTR_RO(package_cpus);
> > > -static DEVICE_ATTR_RO(package_cpus_list);
> > > +define_siblings_read_func(package_cpus, core_cpumask);
> > > +static BIN_ATTR_RO(package_cpus, 0);
> > > +static BIN_ATTR_RO(package_cpus_list, 0);
> > >   #ifdef CONFIG_SCHED_BOOK
> > >   define_id_show_func(book_id);
> > >   static DEVICE_ATTR_RO(book_id);
> > > -define_siblings_show_func(book_siblings, book_cpumask);
> > > -static DEVICE_ATTR_RO(book_siblings);
> > > -static DEVICE_ATTR_RO(book_siblings_list);
> > > +define_siblings_read_func(book_siblings, book_cpumask);
> > > +static BIN_ATTR_RO(book_siblings, 0);
> > > +static BIN_ATTR_RO(book_siblings_list, 0);
> > >   #endif
> > >   #ifdef CONFIG_SCHED_DRAWER
> > >   define_id_show_func(drawer_id);
> > >   static DEVICE_ATTR_RO(drawer_id);
> > > -define_siblings_show_func(drawer_siblings, drawer_cpumask);
> > > -static DEVICE_ATTR_RO(drawer_siblings);
> > > -static DEVICE_ATTR_RO(drawer_siblings_list);
> > > +define_siblings_read_func(drawer_siblings, drawer_cpumask);
> > > +static BIN_ATTR_RO(drawer_siblings, 0);
> > > +static BIN_ATTR_RO(drawer_siblings_list, 0);
> > >   #endif
> > > +static struct bin_attribute *bin_attrs[] = {
> > > +	&bin_attr_core_cpus,
> > > +	&bin_attr_core_cpus_list,
> > > +	&bin_attr_thread_siblings,
> > > +	&bin_attr_thread_siblings_list,
> > > +	&bin_attr_core_siblings,
> > > +	&bin_attr_core_siblings_list,
> > > +	&bin_attr_die_cpus,
> > > +	&bin_attr_die_cpus_list,
> > > +	&bin_attr_package_cpus,
> > > +	&bin_attr_package_cpus_list,
> > > +#ifdef CONFIG_SCHED_BOOK
> > > +	&bin_attr_book_siblings,
> > > +	&bin_attr_book_siblings_list,
> > > +#endif
> > > +#ifdef CONFIG_SCHED_DRAWER
> > > +	&bin_attr_drawer_siblings,
> > > +	&bin_attr_drawer_siblings_list,
> > > +#endif
> > > +	NULL,
> > > +};
> > > +
> > >   static struct attribute *default_attrs[] = {
> > >   	&dev_attr_physical_package_id.attr,
> > >   	&dev_attr_die_id.attr,
> > >   	&dev_attr_core_id.attr,
> > > -	&dev_attr_thread_siblings.attr,
> > > -	&dev_attr_thread_siblings_list.attr,
> > > -	&dev_attr_core_cpus.attr,
> > > -	&dev_attr_core_cpus_list.attr,
> > > -	&dev_attr_core_siblings.attr,
> > > -	&dev_attr_core_siblings_list.attr,
> > > -	&dev_attr_die_cpus.attr,
> > > -	&dev_attr_die_cpus_list.attr,
> > > -	&dev_attr_package_cpus.attr,
> > > -	&dev_attr_package_cpus_list.attr,
> > >   #ifdef CONFIG_SCHED_BOOK
> > >   	&dev_attr_book_id.attr,
> > > -	&dev_attr_book_siblings.attr,
> > > -	&dev_attr_book_siblings_list.attr,
> > >   #endif
> > >   #ifdef CONFIG_SCHED_DRAWER
> > >   	&dev_attr_drawer_id.attr,
> > > -	&dev_attr_drawer_siblings.attr,
> > > -	&dev_attr_drawer_siblings_list.attr,
> > >   #endif
> > >   	NULL
> > >   };
> > >   static const struct attribute_group topology_attr_group = {
> > >   	.attrs = default_attrs,
> > > +	.bin_attrs = bin_attrs,
> > >   	.name = "topology"
> > >   };
> > > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > > index 70a9324..bc401bd9b 100644
> > > --- a/include/linux/bitmap.h
> > > +++ b/include/linux/bitmap.h
> > > @@ -219,6 +219,9 @@ extern unsigned int bitmap_ord_to_pos(const unsigned long *bitmap, unsigned int
> > >   extern int bitmap_print_to_pagebuf(bool list, char *buf,
> > >   				   const unsigned long *maskp, int nmaskbits);
> > > +extern int bitmap_print_to_buf(bool list, char *buf,
> > > +			       const unsigned long *maskp, int nmaskbits, loff_t off, size_t count);
> > > +
> > >   #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
> > >   #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
> > > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > > index 383684e..e4810b3e 100644
> > > --- a/include/linux/cpumask.h
> > > +++ b/include/linux/cpumask.h
> > > @@ -928,6 +928,31 @@ cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
> > >   				      nr_cpu_ids);
> > >   }
> > > +/**
> > > + * cpumap_print_to_buf  - copies the cpumask into the buffer either
> > > + *      as comma-separated list of cpus or hex values of cpumask
> > > + * @list: indicates whether the cpumap must be list
> > > + * @mask: the cpumask to copy
> > > + * @buf: the buffer to copy into
> > > + * @off: the offset that buffer to copy into
> > > + * @count: the count thatbuffer to copy into
> > > + *
> > > + * the role of cpumap_print_to_buf and cpumap_print_to_pagebuf is
> > > + * the same, the difference is that the second parameter of
> > > + * bitmap_print_to_buf can be more than one pagesize.
> > > + *
> > > + * Returns the length of the (null-terminated) @buf string, zero if
> > > + * nothing is copied.
> > > + */
> > > +
> > > +static inline ssize_t
> > > +cpumap_print_to_buf(bool list, char *buf, const struct cpumask *mask,
> > > +		    loff_t off, size_t count)
> > > +{
> > > +	return bitmap_print_to_buf(list, buf, cpumask_bits(mask),
> > > +				   nr_cpu_ids, off, count);
> > > +}
> > > +
> > >   #if NR_CPUS <= BITS_PER_LONG
> > >   #define CPU_MASK_ALL							\
> > >   (cpumask_t) { {								\
> > > diff --git a/lib/bitmap.c b/lib/bitmap.c
> > > index 75006c4..5bf89f1 100644
> > > --- a/lib/bitmap.c
> > > +++ b/lib/bitmap.c
> > > @@ -460,6 +460,40 @@ int bitmap_parse_user(const char __user *ubuf,
> > >   EXPORT_SYMBOL(bitmap_parse_user);
> > >   /**
> > > + * bitmap_print_to_buf - convert bitmap to list or hex format ASCII string
> > > + * @list: indicates whether the bitmap must be list
> > > + * @buf: page aligned buffer into which string is placed
> > > + * @maskp: pointer to bitmap to convert
> > > + * @nmaskbits: size of bitmap, in bits
> > > + * @off: offset in buf
> > > + * @count: count that already output
> > > + *
> > > + * the role of bitmap_print_to_buf and bitmap_print_to_pagebuf is
> > > + * the same, the difference is that the second parameter of
> > > + * bitmap_print_to_buf can be more than one pagesize.
> > > + */
> > > +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> > > +			int nmaskbits, loff_t off, size_t count)
> > > +{
> > > +	int len, size;
> > > +	void *data;
> > > +	char *fmt = list ? "%*pbl\n" : "%*pb\n";
> > > +
> > > +	len = snprintf(NULL, 0, fmt, nmaskbits, maskp);
> > > +
> > > +	data = kvmalloc(len+1, GFP_KERNEL);
> > > +	if (!data)
> > > +		return -ENOMEM;
> > > +
> > > +	size = scnprintf(data, len+1, fmt, nmaskbits, maskp);
> > > +	size = memory_read_from_buffer(buf, count, &off, data, size);
> > > +	kvfree(data);
> > > +
> > > +	return size;
> > Why is this so different from bitmap_print_to_pagebuf()?  Can't you just
> > use this function as the "real" function and then change
> > bitmap_print_to_pagebuf() to call it with a size of PAGE_SIZE?
> 
> Do you mean do following change, is that correct? :-)

Maybe, it is whitespace corrupted, and it still feels like this function
is much bigger than it needs to be given the function it is replacing is
only a simple sprintf() call.

> +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> +                       int nmaskbits, loff_t off, size_t count)
> +{
> +       int len, size;
> +       void *data;
> +       const char *fmt = list ? "%*pbl\n" : "%*pb\n";
> +
> +       if (off == LLONG_MAX && count == PAGE_SIZE - offset_in_page(buf))
> +               return scnprintf(buf, count, fmt, nmaskbits, maskp);
> +
> +       len = snprintf(NULL, 0, fmt, nmaskbits, maskp);
> +
> +       data = kvmalloc(len+1, GFP_KERNEL);

Why do you need to allocate more memory?  And why kvmalloc()?

> +       if (!data)
> +               return -ENOMEM;
> +
> +       size = scnprintf(data, len+1, fmt, nmaskbits, maskp);
> +
> +       size = memory_read_from_buffer(buf, count, &off, data, size);
> +       kvfree(data);
> +
> +       return size;
> +}
> +EXPORT_SYMBOL(bitmap_print_to_buf);

thanks,

greg k-h
