Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AEB3CB03A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 02:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhGPBAl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jul 2021 21:00:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:11428 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhGPBAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:00:40 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GQt6n3Ty2zcdgN;
        Fri, 16 Jul 2021 08:54:25 +0800 (CST)
Received: from dggema721-chm.china.huawei.com (10.3.20.85) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 08:57:44 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema721-chm.china.huawei.com (10.3.20.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 16 Jul 2021 08:57:43 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Fri, 16 Jul 2021 08:57:43 +0800
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
Thread-Index: AQHXeXDit9Gt0OAGGEazhWq8ex3QcatDoywAgADd7JCAAETwQA==
Date:   Fri, 16 Jul 2021 00:57:43 +0000
Message-ID: <aae18c255c554dbaabbb0cd8ce3449f2@hisilicon.com>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <20210715115856.11304-2-song.bao.hua@hisilicon.com>
 <YPBUJmqk4akuX8cv@yury-ThinkPad> 
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
> From: Song Bao Hua (Barry Song)
> Sent: Friday, July 16, 2021 9:08 AM
> To: 'Yury Norov' <yury.norov@gmail.com>
> Cc: gregkh@linuxfoundation.org; akpm@linux-foundation.org;
> andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org;
> dave.hansen@intel.com; linux@rasmusvillemoes.dk; rafael@kernel.org;
> rdunlap@infradead.org; agordeev@linux.ibm.com; sbrivio@redhat.com;
> jianpeng.ma@intel.com; valentin.schneider@arm.com; peterz@infradead.org;
> bristot@redhat.com; guodong.xu@linaro.org; tangchengchang
> <tangchengchang@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> yangyicong <yangyicong@huawei.com>; tim.c.chen@linux.intel.com; Linuxarm
> <linuxarm@huawei.com>; tiantao (H) <tiantao6@hisilicon.com>
> Subject: RE: [PATCH v7 1/4] cpumask: introduce cpumap_print_to_buf to support
> large bitmask and list
> 
> 
> 
> > -----Original Message-----
> > From: Yury Norov [mailto:yury.norov@gmail.com]
> > Sent: Friday, July 16, 2021 3:29 AM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: gregkh@linuxfoundation.org; akpm@linux-foundation.org;
> > andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org;
> > dave.hansen@intel.com; linux@rasmusvillemoes.dk; rafael@kernel.org;
> > rdunlap@infradead.org; agordeev@linux.ibm.com; sbrivio@redhat.com;
> > jianpeng.ma@intel.com; valentin.schneider@arm.com; peterz@infradead.org;
> > bristot@redhat.com; guodong.xu@linaro.org; tangchengchang
> > <tangchengchang@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> > yangyicong <yangyicong@huawei.com>; tim.c.chen@linux.intel.com; Linuxarm
> > <linuxarm@huawei.com>; tiantao (H) <tiantao6@hisilicon.com>
> > Subject: Re: [PATCH v7 1/4] cpumask: introduce cpumap_print_to_buf to support
> > large bitmask and list
> >
> > On Thu, Jul 15, 2021 at 11:58:53PM +1200, Barry Song wrote:
> > > (10.1.198.147)
> > > X-CFilter-Loop: Reflected
> > > Status: O
> > > Content-Length: 10263
> > > Lines: 252
> > >
> > > From: Tian Tao <tiantao6@hisilicon.com>
> >
> > [...]
> >
> > > +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> > > +		int nmaskbits, loff_t off, size_t count)
> > > +{
> > > +	const char *fmt = list ? "%*pbl\n" : "%*pb\n";
> > > +	ssize_t size;
> > > +	void *data;
> > > +
> > > +	data = kasprintf(GFP_KERNEL, fmt, nmaskbits, maskp);
> > > +	if (!data)
> > > +		return -ENOMEM;
> > > +
> > > +	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) +
> 1);
> > > +	kfree(data);
> > > +
> > > +	return size;
> > > +}
> > > +EXPORT_SYMBOL(bitmap_print_to_buf);
> >
> > In discussion to v4 of this series I've pointed out inefficiency of
> > this approach. Now it's v7, but the problem is still there.
> >
> > 1. You make user of your API guess aboout proper @count without any
> >    hint. This is worse than how it works now with pure vsnprintf().
> 
> This isn't true. While this count comes from sysfs bin_attribute,
> sysfs show() entry guarantee the count is proper and inside the
> valid range of the buffer. Otherwise, sysfs bin_attribute has totally
> broken for all users.

In addition, "You make user of your API guess about proper @count
without any hint" isn't true either. For a sysfs ABI and other
files, users will get EOF when it arrives the end of the file.
This is exactly the hint for users to stop further reading.

The new APIs are serving ABI purpose. hardly other kernel modules
will want a printed list.

Thanks
Barry

