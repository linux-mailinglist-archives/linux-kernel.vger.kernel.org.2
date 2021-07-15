Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E450F3CAE5A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 23:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhGOVLn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jul 2021 17:11:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:11284 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhGOVLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:11:41 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GQmzr2l3rz1CJRf;
        Fri, 16 Jul 2021 05:03:04 +0800 (CST)
Received: from dggema723-chm.china.huawei.com (10.3.20.87) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 05:08:43 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema723-chm.china.huawei.com (10.3.20.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 16 Jul 2021 05:08:43 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Fri, 16 Jul 2021 05:08:43 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Yury Norov <yury.norov@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: RE: [PATCH v7 1/4] cpumask: introduce cpumap_print_to_buf to support
 large bitmask and list
Thread-Topic: [PATCH v7 1/4] cpumask: introduce cpumap_print_to_buf to support
 large bitmask and list
Thread-Index: AQHXeXDit9Gt0OAGGEazhWq8ex3QcatDoywAgADd7JA=
Date:   Thu, 15 Jul 2021 21:08:43 +0000
Message-ID: <6adb10ab3f4b44a2b884ab256dbd68b1@hisilicon.com>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <20210715115856.11304-2-song.bao.hua@hisilicon.com>
 <YPBUJmqk4akuX8cv@yury-ThinkPad>
In-Reply-To: <YPBUJmqk4akuX8cv@yury-ThinkPad>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.67]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Yury Norov [mailto:yury.norov@gmail.com]
> Sent: Friday, July 16, 2021 3:29 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: gregkh@linuxfoundation.org; akpm@linux-foundation.org;
> andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org;
> dave.hansen@intel.com; linux@rasmusvillemoes.dk; rafael@kernel.org;
> rdunlap@infradead.org; agordeev@linux.ibm.com; sbrivio@redhat.com;
> jianpeng.ma@intel.com; valentin.schneider@arm.com; peterz@infradead.org;
> bristot@redhat.com; guodong.xu@linaro.org; tangchengchang
> <tangchengchang@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> yangyicong <yangyicong@huawei.com>; tim.c.chen@linux.intel.com; Linuxarm
> <linuxarm@huawei.com>; tiantao (H) <tiantao6@hisilicon.com>
> Subject: Re: [PATCH v7 1/4] cpumask: introduce cpumap_print_to_buf to support
> large bitmask and list
> 
> On Thu, Jul 15, 2021 at 11:58:53PM +1200, Barry Song wrote:
> > (10.1.198.147)
> > X-CFilter-Loop: Reflected
> > Status: O
> > Content-Length: 10263
> > Lines: 252
> >
> > From: Tian Tao <tiantao6@hisilicon.com>
> 
> [...]
> 
> > +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> > +		int nmaskbits, loff_t off, size_t count)
> > +{
> > +	const char *fmt = list ? "%*pbl\n" : "%*pb\n";
> > +	ssize_t size;
> > +	void *data;
> > +
> > +	data = kasprintf(GFP_KERNEL, fmt, nmaskbits, maskp);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) + 1);
> > +	kfree(data);
> > +
> > +	return size;
> > +}
> > +EXPORT_SYMBOL(bitmap_print_to_buf);
> 
> In discussion to v4 of this series I've pointed out inefficiency of
> this approach. Now it's v7, but the problem is still there.
> 
> 1. You make user of your API guess aboout proper @count without any
>    hint. This is worse than how it works now with pure vsnprintf().

This isn't true. While this count comes from sysfs bin_attribute,
sysfs show() entry guarantee the count is proper and inside the
valid range of the buffer. Otherwise, sysfs bin_attribute has totally
broken for all users.

> 2. For big bitmaps and small @count, your code will make enormous
>    amount of unneeded work. For example, if the full length of string
>    representation of bitmap is 1M, and length of the output buffer is
>    1k, one will have to call bitmap_print_to_buf() 1000 times.  With
>    current design it assumes that you allocate the full amount of memory
>    1000 times, free it 1000 times and print huge bitmap 1000 times to
>    just return small part of it.

This isn't true either. Nobody is actually holding a cpumap like 1MB.
4KB has been used in current kernel for a long time, no machine
has really complained it is not enough. So I would expect the real
case would be one time for majority, perhaps twice for some machines
which we haven't seen yet.

> 
> NAK for this, and please stop submitting wrong approach again and
> again.

I have always answered your email and explained with a lot of word,
but you totally ignored my explanation and didn't even answer my
explanation in v5 and v6. That seems quite unfair.

Considering a driver which has M cpus and N different topology 
entries in its show entry:

example_bin_attribute_show(struct file *filp, struct kobject *kobj,
             struct bin_attribute *attr, char *buf,
             loff_t offset, size_t count)
{
	...
}
In case what you say is true and this show() is called 1000 times
with different offset if the buffer is as big as 1MB.
How would the code work by reusing a buffer allocated in advance,
like below?

example_bin_attribute_show(struct file *filp, struct kobject *kobj,
             struct bin_attribute *attr, char *buf,
             loff_t offset, size_t count)
{
    //1st time:
	char *bitmap_buf = bitmap_buffer_allocate(....);
	save bitmap_buf to somewhere?

    //2nd~1000 time
    reuse the bitmap_buf?
    
    //1000time
    Free the bitmap buf?
}

Or like below?

char *global_bitmap_buf = bitmap_buffer_allocate(....)?

example_bin_attribute_show(struct file *filp, struct kobject *kobj,
             struct bin_attribute *attr, char *buf,
             loff_t offset, size_t count)
{
    //1st - 1000 time?
    Reuse the global_bitmap_buf?
}

Neither of the above way is good to me. The 1st one is not doable
at all. The second one is not doable either. M*N entries will have
different size and the buffer being re-used seems to be wasting
memory.

I'd appreciate if you could post some pseudo code so that v8 could
make some actual difference and go to the way you prefer.
On the other hand, we also need Greg's Ack on driver changes which
might happen afterwards.

So please post some pseudo code rather than simply put a NAK
by ignoring my long explanation.

Thanks
Barry

