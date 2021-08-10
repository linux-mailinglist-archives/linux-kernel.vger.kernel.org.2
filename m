Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4A23E5B73
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbhHJNZ1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Aug 2021 09:25:27 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8392 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241409AbhHJNZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:25:15 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GkYVZ1GChz813p;
        Tue, 10 Aug 2021 21:20:54 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 21:24:50 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 10 Aug 2021 21:24:50 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Tue, 10 Aug 2021 21:24:49 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
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
        "tiantao (H)" <tiantao6@hisilicon.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v9 1/5] cpumask: introduce
 cpumap_print_list/bitmask_to_buf to support large bitmask and list
Thread-Topic: [PATCH v9 1/5] cpumask: introduce
 cpumap_print_list/bitmask_to_buf to support large bitmask and list
Thread-Index: AQHXirK6LfP8uGs3C0uIGivdv2MjYqtl8KiAgADt/kCABd+cAA==
Date:   Tue, 10 Aug 2021 13:24:49 +0000
Message-ID: <6e04c09ce1714b35bd740fbf6a9ce654@hisilicon.com>
References: <20210806110251.560-1-song.bao.hua@hisilicon.com>
 <20210806110251.560-2-song.bao.hua@hisilicon.com>
 <YQ03ixksDJyVwCEv@kroah.com> 
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.37]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Song Bao Hua (Barry Song)
> Sent: Saturday, August 7, 2021 7:39 AM
> To: 'Greg KH' <gregkh@linuxfoundation.org>
> Cc: andriy.shevchenko@linux.intel.com; yury.norov@gmail.com;
> linux-kernel@vger.kernel.org; akpm@linux-foundation.org;
> dave.hansen@intel.com; linux@rasmusvillemoes.dk; rafael@kernel.org;
> rdunlap@infradead.org; agordeev@linux.ibm.com; sbrivio@redhat.com;
> jianpeng.ma@intel.com; valentin.schneider@arm.com; peterz@infradead.org;
> bristot@redhat.com; guodong.xu@linaro.org; tangchengchang
> <tangchengchang@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> yangyicong <yangyicong@huawei.com>; tim.c.chen@linux.intel.com; Linuxarm
> <linuxarm@huawei.com>; tiantao (H) <tiantao6@hisilicon.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>
> Subject: RE: [PATCH v9 1/5] cpumask: introduce
> cpumap_print_list/bitmask_to_buf to support large bitmask and list
> 
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Saturday, August 7, 2021 1:22 AM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: andriy.shevchenko@linux.intel.com; yury.norov@gmail.com;
> > linux-kernel@vger.kernel.org; akpm@linux-foundation.org;
> > dave.hansen@intel.com; linux@rasmusvillemoes.dk; rafael@kernel.org;
> > rdunlap@infradead.org; agordeev@linux.ibm.com; sbrivio@redhat.com;
> > jianpeng.ma@intel.com; valentin.schneider@arm.com; peterz@infradead.org;
> > bristot@redhat.com; guodong.xu@linaro.org; tangchengchang
> > <tangchengchang@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> > yangyicong <yangyicong@huawei.com>; tim.c.chen@linux.intel.com; Linuxarm
> > <linuxarm@huawei.com>; tiantao (H) <tiantao6@hisilicon.com>; Jonathan
> Cameron
> > <jonathan.cameron@huawei.com>
> > Subject: Re: [PATCH v9 1/5] cpumask: introduce
> > cpumap_print_list/bitmask_to_buf to support large bitmask and list
> >
> > On Fri, Aug 06, 2021 at 11:02:47PM +1200, Barry Song wrote:
> > > From: Tian Tao <tiantao6@hisilicon.com>
> > >
> > > The existing cpumap_print_to_pagebuf() is used by cpu topology and other
> > > drivers to export hexadecimal bitmask and decimal list to userspace by
> > > sysfs ABI.
> > >
> > > Right now, those drivers are using a normal attribute for this kind of
> > > ABIs. A normal attribute typically has show entry as below:
> > >
> > > static ssize_t example_dev_show(struct device *dev,
> > >                 struct device_attribute *attr, char *buf)
> > > {
> > > 	...
> > > 	return cpumap_print_to_pagebuf(true, buf, &pmu_mmdc->cpu);
> > > }
> > > show entry of attribute has no offset and count parameters and this
> > > means the file is limited to one page only.
> > >
> > > cpumap_print_to_pagebuf() API works terribly well for this kind of
> > > normal attribute with buf parameter and without offset, count:
> > >
> > > static inline ssize_t
> > > cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
> > > {
> > > 	return bitmap_print_to_pagebuf(list, buf, cpumask_bits(mask),
> > > 				       nr_cpu_ids);
> > > }
> > >
> > > The problem is once we have many cpus, we have a chance to make bitmask
> > > or list more than one page. Especially for list, it could be as complex
> > > as 0,3,5,7,9,...... We have no simple way to know it exact size.
> > >
> > > It turns out bin_attribute is a way to break this limit. bin_attribute
> > > has show entry as below:
> > > static ssize_t
> > > example_bin_attribute_show(struct file *filp, struct kobject *kobj,
> > >              struct bin_attribute *attr, char *buf,
> > >              loff_t offset, size_t count)
> > > {
> > > 	...
> > > }
> > >
> > > With the new offset and count parameters, this makes sysfs ABI be able
> > > to support file size more than one page. For example, offset could be
> > > >= 4096.
> > >
> > > This patch introduces cpumap_print_bitmask/list_to_buf() and their bitmap
> > > infrastructure bitmap_print_bitmask/list_to_buf() so that those drivers
> > > can move to bin_attribute to support large bitmask and list. At the same
> > > time, we have to pass those corresponding parameters such as offset, count
> > > from bin_attribute to this new API.
> > >
> > > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > Cc: Stefano Brivio <sbrivio@redhat.com>
> > > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > > Cc: "Ma, Jianpeng" <jianpeng.ma@intel.com>
> > > Cc: Yury Norov <yury.norov@gmail.com>
> > > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > > ---
> > >  include/linux/bitmap.h  |   6 +++
> > >  include/linux/cpumask.h |  38 +++++++++++++++
> > >  lib/bitmap.c            | 103 ++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 147 insertions(+)
> > >
> > > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > > index a36cfcec4e77..37f36dad18bd 100644
> > > --- a/include/linux/bitmap.h
> > > +++ b/include/linux/bitmap.h
> > > @@ -227,6 +227,12 @@ unsigned int bitmap_ord_to_pos(const unsigned long
> > *bitmap, unsigned int ord, un
> > >  int bitmap_print_to_pagebuf(bool list, char *buf,
> > >  				   const unsigned long *maskp, int nmaskbits);
> > >
> > > +extern int bitmap_print_bitmask_to_buf(char *buf, const unsigned long
> > *maskp,
> > > +				      int nmaskbits, loff_t off, size_t count);
> > > +
> > > +extern int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
> > > +				      int nmaskbits, loff_t off, size_t count);
> > > +
> >
> > Why are you adding bitmap_print_list_to_buf() when no one uses it in
> > this patch series?
> >
> > Did I miss it somewhere?
> 
> Yes. It is used in every patch except the last one from Yury
> which is only extending comment.
> 
> drivers/base/topology.c:
> +static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
> +				struct bin_attribute *attr, char *buf,		\
> +				loff_t off, size_t count)			\
> +{										\
> +	struct device *dev = kobj_to_dev(kobj);					\
> +										\
> +	return cpumap_print_list_to_buf(buf, topology_##mask(dev->id),		\
> +					off, count);				\
>  }
> 
> 
> drivers/base/node.c:
> +static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
> +				   struct bin_attribute *attr, char *buf,
> +				   loff_t off, size_t count)
>  {
> -	...
> +	cpumask_and(mask, cpumask_of_node(node_dev->dev.id), cpu_online_mask);
> +	n = cpumap_print_list_to_buf(buf, mask, off, count);
> +	free_cpumask_var(mask);
> 
> >

And correspondingly, Linux has bitmask and list ABIs for cpus, eg:

root@ubuntu:/sys/devices/system/cpu/cpu0/topology# cat core_siblings
ff
root@ubuntu:/sys/devices/system/cpu/cpu0/topology# cat core_siblings_list
0-7

and for nodes, eg:
root@ubuntu:/sys/devices/system/node/node0# cat cpumap
ff
root@ubuntu:/sys/devices/system/node/node0# cat cpulist
0-7


> > thanks,
> >
> > greg k-h
> 

Thanks
Barry

