Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F41C3CB4B6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbhGPIxA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Jul 2021 04:53:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:11432 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhGPIw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:52:56 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GR4bh14d9zcf36;
        Fri, 16 Jul 2021 16:46:40 +0800 (CST)
Received: from dggema773-chm.china.huawei.com (10.1.198.217) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 16:49:59 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema773-chm.china.huawei.com (10.1.198.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 16 Jul 2021 16:49:58 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Fri, 16 Jul 2021 16:49:58 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "rafael@kernel.org" <rafael@kernel.org>,
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
        Linuxarm <linuxarm@huawei.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: RE: [PATCH v7 2/4] topology: use bin_attribute to break the size
 limitation of cpumap ABI
Thread-Topic: [PATCH v7 2/4] topology: use bin_attribute to break the size
 limitation of cpumap ABI
Thread-Index: AQHXeXDlNwZNI9Wk4UqsPQdyS/XZkqtFQm+Q
Date:   Fri, 16 Jul 2021 08:49:58 +0000
Message-ID: <a74b62ef71be4348889bfc8c620e7b77@hisilicon.com>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <20210715115856.11304-3-song.bao.hua@hisilicon.com>
In-Reply-To: <20210715115856.11304-3-song.bao.hua@hisilicon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.233]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,
Not sure if I have totally got your idea. But please see if the below
is closer to what you prefer.

I haven't really tested it. But this approach can somehow solve the
problem you mentioned(malloc/free and printing is done 1000times for
a 1MB buffer which is read 1K each time).

Bitmap provides some API to alloc and return print_buf:

+ssize_t bitmap_get_print_buf(bool list, char **buf, const unsigned long *maskp,
+               int nmaskbits)
+{
+       const char *fmt = list ? "%*pbl\n" : "%*pb\n";
+       ssize_t size;
+
+       size = snprintf(NULL, 0, fmt, nmaskbits, maskp);
+       *buf = kmalloc_track_caller(size + 1, GFP_KERNEL);
+       scnprintf(*buf, size + 1, fmt, nmaskbits, maskp);
+
+       return size + 1;
+}
+
+static inline ssize_t
+cpumap_get_print_buf(bool list, char **buf, const struct cpumask *mask)
+{
+       return bitmap_get_print_buf(list, buf, cpumask_bits(mask),
+                       nr_cpu_ids);
+}
+
+struct bitmap_print_buf
+{
+       char *buf;
+       ssize_t size;
+};
+

In bin_attribute, move to get and save the buffer while sysfs entry is
read at the first time and free it when file arrives EOF:

 #define define_id_show_func(name)                                      \
 static ssize_t name##_show(struct device *dev,                         \
                           struct device_attribute *attr, char *buf)    \
@@ -27,9 +53,27 @@ static ssize_t name##_read(struct file *file, struct kobject *kobj,          \
                                  loff_t off, size_t count)                     \
 {                                                                              \
        struct device *dev = kobj_to_dev(kobj);                                 \
-                                                                               \
-       return cpumap_print_to_buf(false, buf, topology_##mask(dev->id),        \
-                                  off, count);                                 \
+       struct bitmap_print_buf *bmb = dev_get_drvdata(dev);                    \
+       if (!bmb) {                                                             \
+               bmb = devm_kzalloc(dev, sizeof(*bmb), GFP_KERNEL);              \
+               if (!bmb)                                                       \
+                       return -ENOMEM;                                         \
+               dev_set_drvdata(dev, bmb);                                      \
+       }                                                                       \
+       /* for the 1st time, getting the printed buffer */                \
+       if (!bmb->buf)                                                           \
+               bmb->size = cpumap_get_print_buf(false, &bmb->buf,       \
+                                    topology_##mask(dev->id));                 \
+       /* when we arrive EOF, free the printed buffer */                       \
+       if (off >= bmb->size) {                                                 \
+               kfree(bmb->buf);  bmb->buf = NULL;                                   \
+               return 0;                                                       \
+       }                                                                       \
+       /* while a large printed buffer is read many times, we reuse         \
+        * the buffer we get at the 1st time                                    \
+        */                                                                     \
+       strncpy(buf, bmb->buf + off, count);                                    \
+       return min(count,  bmb->size - off);                                    \
 }                                                                              \
                                                                                \
This means a huge change in drivers though I am not sure Greg is
a fan of this approach. Anyway, "1000 times" is not a real case.
Typically we will arrive EOF after one time.

Thanks
Barry

> -----Original Message-----
> From: Song Bao Hua (Barry Song)
> Sent: Thursday, July 15, 2021 11:59 PM
> To: gregkh@linuxfoundation.org; akpm@linux-foundation.org;
> andriy.shevchenko@linux.intel.com; yury.norov@gmail.com;
> linux-kernel@vger.kernel.org
> Cc: dave.hansen@intel.com; linux@rasmusvillemoes.dk; rafael@kernel.org;
> rdunlap@infradead.org; agordeev@linux.ibm.com; sbrivio@redhat.com;
> jianpeng.ma@intel.com; valentin.schneider@arm.com; peterz@infradead.org;
> bristot@redhat.com; guodong.xu@linaro.org; tangchengchang
> <tangchengchang@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> yangyicong <yangyicong@huawei.com>; tim.c.chen@linux.intel.com; Linuxarm
> <linuxarm@huawei.com>; tiantao (H) <tiantao6@hisilicon.com>; Song Bao Hua
> (Barry Song) <song.bao.hua@hisilicon.com>
> Subject: [PATCH v7 2/4] topology: use bin_attribute to break the size limitation
> of cpumap ABI
> 
> From: Tian Tao <tiantao6@hisilicon.com>
> 
> Reading /sys/devices/system/cpu/cpuX/topology/ returns cpu topology.
> However, the size of this file is limited to PAGE_SIZE because of
> the limitation for sysfs attribute.
> This patch moves to use bin_attribute to extend the ABI to be more
> than one page so that cpumap bitmask and list won't be potentially
> trimmed.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  drivers/base/topology.c | 115 ++++++++++++++++++++++------------------
>  1 file changed, 63 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> index 4d254fcc93d1..dd3980124e33 100644
> --- a/drivers/base/topology.c
> +++ b/drivers/base/topology.c
> @@ -21,25 +21,27 @@ static ssize_t name##_show(struct device *dev,
> 	\
>  	return sysfs_emit(buf, "%d\n", topology_##name(dev->id));	\
>  }
> 
> -#define define_siblings_show_map(name, mask)				\
> -static ssize_t name##_show(struct device *dev,				\
> -			   struct device_attribute *attr, char *buf)	\
> -{									\
> -	return cpumap_print_to_pagebuf(false, buf, topology_##mask(dev->id));\
> +#define define_siblings_read_func(name, mask)					\
> +static ssize_t name##_read(struct file *file, struct kobject *kobj,		\
> +				  struct bin_attribute *attr, char *buf,	\
> +				  loff_t off, size_t count)			\
> +{										\
> +	struct device *dev = kobj_to_dev(kobj);                                 \
> +										\
> +	return cpumap_print_to_buf(false, buf, topology_##mask(dev->id),	\
> +				   off, count);                                 \
> +}										\
> +										\
> +static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
> +				  struct bin_attribute *attr, char *buf,	\
> +				  loff_t off, size_t count)			\
> +{										\
> +	struct device *dev = kobj_to_dev(kobj);					\
> +										\
> +	return cpumap_print_to_buf(true, buf, topology_##mask(dev->id),		\
> +				   off, count);					\
>  }
> 
> -#define define_siblings_show_list(name, mask)				\
> -static ssize_t name##_list_show(struct device *dev,			\
> -				struct device_attribute *attr,		\
> -				char *buf)				\
> -{									\
> -	return cpumap_print_to_pagebuf(true, buf, topology_##mask(dev->id));\
> -}
> -
> -#define define_siblings_show_func(name, mask)	\
> -	define_siblings_show_map(name, mask);	\
> -	define_siblings_show_list(name, mask)
> -
>  define_id_show_func(physical_package_id);
>  static DEVICE_ATTR_RO(physical_package_id);
> 
> @@ -49,71 +51,80 @@ static DEVICE_ATTR_RO(die_id);
>  define_id_show_func(core_id);
>  static DEVICE_ATTR_RO(core_id);
> 
> -define_siblings_show_func(thread_siblings, sibling_cpumask);
> -static DEVICE_ATTR_RO(thread_siblings);
> -static DEVICE_ATTR_RO(thread_siblings_list);
> +define_siblings_read_func(thread_siblings, sibling_cpumask);
> +static BIN_ATTR_RO(thread_siblings, 0);
> +static BIN_ATTR_RO(thread_siblings_list, 0);
> 
> -define_siblings_show_func(core_cpus, sibling_cpumask);
> -static DEVICE_ATTR_RO(core_cpus);
> -static DEVICE_ATTR_RO(core_cpus_list);
> +define_siblings_read_func(core_cpus, sibling_cpumask);
> +static BIN_ATTR_RO(core_cpus, 0);
> +static BIN_ATTR_RO(core_cpus_list, 0);
> 
> -define_siblings_show_func(core_siblings, core_cpumask);
> -static DEVICE_ATTR_RO(core_siblings);
> -static DEVICE_ATTR_RO(core_siblings_list);
> +define_siblings_read_func(core_siblings, core_cpumask);
> +static BIN_ATTR_RO(core_siblings, 0);
> +static BIN_ATTR_RO(core_siblings_list, 0);
> 
> -define_siblings_show_func(die_cpus, die_cpumask);
> -static DEVICE_ATTR_RO(die_cpus);
> -static DEVICE_ATTR_RO(die_cpus_list);
> +define_siblings_read_func(die_cpus, die_cpumask);
> +static BIN_ATTR_RO(die_cpus, 0);
> +static BIN_ATTR_RO(die_cpus_list, 0);
> 
> -define_siblings_show_func(package_cpus, core_cpumask);
> -static DEVICE_ATTR_RO(package_cpus);
> -static DEVICE_ATTR_RO(package_cpus_list);
> +define_siblings_read_func(package_cpus, core_cpumask);
> +static BIN_ATTR_RO(package_cpus, 0);
> +static BIN_ATTR_RO(package_cpus_list, 0);
> 
>  #ifdef CONFIG_SCHED_BOOK
>  define_id_show_func(book_id);
>  static DEVICE_ATTR_RO(book_id);
> -define_siblings_show_func(book_siblings, book_cpumask);
> -static DEVICE_ATTR_RO(book_siblings);
> -static DEVICE_ATTR_RO(book_siblings_list);
> +define_siblings_read_func(book_siblings, book_cpumask);
> +static BIN_ATTR_RO(book_siblings, 0);
> +static BIN_ATTR_RO(book_siblings_list, 0);
>  #endif
> 
>  #ifdef CONFIG_SCHED_DRAWER
>  define_id_show_func(drawer_id);
>  static DEVICE_ATTR_RO(drawer_id);
> -define_siblings_show_func(drawer_siblings, drawer_cpumask);
> -static DEVICE_ATTR_RO(drawer_siblings);
> -static DEVICE_ATTR_RO(drawer_siblings_list);
> +define_siblings_read_func(drawer_siblings, drawer_cpumask);
> +static BIN_ATTR_RO(drawer_siblings, 0);
> +static BIN_ATTR_RO(drawer_siblings_list, 0);
>  #endif
> 
> +static struct bin_attribute *bin_attrs[] = {
> +	&bin_attr_core_cpus,
> +	&bin_attr_core_cpus_list,
> +	&bin_attr_thread_siblings,
> +	&bin_attr_thread_siblings_list,
> +	&bin_attr_core_siblings,
> +	&bin_attr_core_siblings_list,
> +	&bin_attr_die_cpus,
> +	&bin_attr_die_cpus_list,
> +	&bin_attr_package_cpus,
> +	&bin_attr_package_cpus_list,
> +#ifdef CONFIG_SCHED_BOOK
> +	&bin_attr_book_siblings,
> +	&bin_attr_book_siblings_list,
> +#endif
> +#ifdef CONFIG_SCHED_DRAWER
> +	&bin_attr_drawer_siblings,
> +	&bin_attr_drawer_siblings_list,
> +#endif
> +	NULL
> +};
> +
>  static struct attribute *default_attrs[] = {
>  	&dev_attr_physical_package_id.attr,
>  	&dev_attr_die_id.attr,
>  	&dev_attr_core_id.attr,
> -	&dev_attr_thread_siblings.attr,
> -	&dev_attr_thread_siblings_list.attr,
> -	&dev_attr_core_cpus.attr,
> -	&dev_attr_core_cpus_list.attr,
> -	&dev_attr_core_siblings.attr,
> -	&dev_attr_core_siblings_list.attr,
> -	&dev_attr_die_cpus.attr,
> -	&dev_attr_die_cpus_list.attr,
> -	&dev_attr_package_cpus.attr,
> -	&dev_attr_package_cpus_list.attr,
>  #ifdef CONFIG_SCHED_BOOK
>  	&dev_attr_book_id.attr,
> -	&dev_attr_book_siblings.attr,
> -	&dev_attr_book_siblings_list.attr,
>  #endif
>  #ifdef CONFIG_SCHED_DRAWER
>  	&dev_attr_drawer_id.attr,
> -	&dev_attr_drawer_siblings.attr,
> -	&dev_attr_drawer_siblings_list.attr,
>  #endif
>  	NULL
>  };
> 
>  static const struct attribute_group topology_attr_group = {
>  	.attrs = default_attrs,
> +	.bin_attrs = bin_attrs,
>  	.name = "topology"
>  };
> 
> --
> 2.25.1

