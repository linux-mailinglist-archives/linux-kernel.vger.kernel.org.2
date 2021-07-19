Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916BA3CD37E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 13:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhGSKaK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jul 2021 06:30:10 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7034 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbhGSKaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:09 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GSzWz2W9lzYcnZ;
        Mon, 19 Jul 2021 19:05:03 +0800 (CST)
Received: from dggemm751-chm.china.huawei.com (10.1.198.57) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 19:10:46 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemm751-chm.china.huawei.com (10.1.198.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 19:10:45 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Mon, 19 Jul 2021 19:10:45 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
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
Subject: RE: [PATCH v7 2/4] topology: use bin_attribute to break the size
 limitation of cpumap ABI
Thread-Topic: [PATCH v7 2/4] topology: use bin_attribute to break the size
 limitation of cpumap ABI
Thread-Index: AQHXeXDlNwZNI9Wk4UqsPQdyS/XZkqtFQm+QgABABACAAMKqIP//k3qAgAOpXQCAAKbSAA==
Date:   Mon, 19 Jul 2021 11:10:45 +0000
Message-ID: <4ab537937f344893bf5bdcb13e46ce04@hisilicon.com>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <20210715115856.11304-3-song.bao.hua@hisilicon.com>
 <a74b62ef71be4348889bfc8c620e7b77@hisilicon.com>
 <YPHmMu4OWPHwQXtT@yury-ThinkPad>
 <3d83c6b11dae4a83add9d8dcc04bbd80@hisilicon.com>
 <YPIudYST90WC4k4U@yury-ThinkPad> <YPVAxnR95M0mZWDY@smile.fi.intel.com>
In-Reply-To: <YPVAxnR95M0mZWDY@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.8]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: andriy.shevchenko@linux.intel.com
> [mailto:andriy.shevchenko@linux.intel.com]
> Sent: Monday, July 19, 2021 9:07 PM
> To: Yury Norov <yury.norov@gmail.com>
> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> gregkh@linuxfoundation.org; akpm@linux-foundation.org;
> linux-kernel@vger.kernel.org; dave.hansen@intel.com;
> linux@rasmusvillemoes.dk; rafael@kernel.org; rdunlap@infradead.org;
> agordeev@linux.ibm.com; sbrivio@redhat.com; jianpeng.ma@intel.com;
> valentin.schneider@arm.com; peterz@infradead.org; bristot@redhat.com;
> guodong.xu@linaro.org; tangchengchang <tangchengchang@huawei.com>; Zengtao (B)
> <prime.zeng@hisilicon.com>; yangyicong <yangyicong@huawei.com>;
> tim.c.chen@linux.intel.com; Linuxarm <linuxarm@huawei.com>; tiantao (H)
> <tiantao6@hisilicon.com>
> Subject: Re: [PATCH v7 2/4] topology: use bin_attribute to break the size
> limitation of cpumap ABI
> 
> On Fri, Jul 16, 2021 at 06:12:21PM -0700, Yury Norov wrote:
> > On Sat, Jul 17, 2021 at 12:16:48AM +0000, Song Bao Hua (Barry Song) wrote:
> > > > From: Yury Norov [mailto:yury.norov@gmail.com]
> > > > Sent: Saturday, July 17, 2021 8:04 AM
> > > > On Fri, Jul 16, 2021 at 08:49:58AM +0000, Song Bao Hua (Barry Song) wrote:
> 
> ...
> 
> > > Generally good idea. However, for sysfs ABI entries, it might not be
> > > that true.
> > >
> > > A sysfs entry might never be read for its whole life. As I explained
> > > before, a sysfs entry - especially for list,  is randomly "cat" by users.
> > > Many of them won't be read forever. And after they are read once, they
> > > will probably never be read again. The operations to read ABI could be
> > > random and rare. Performance wouldn't be a concern.
> > >
> > > To avoid holding the memory which might never be used, it is better to
> > > allocate and free the memory during runtime. I mean to allocate in show()
> > > and free in show(), aka, to do it on demand.
> > >
> > > For example, for a server with 256CPU and each cpu has dozens of sysfs ABI
> > > entries, only a few of sysfs list entries might be randomly "cat" by users.
> > > Holding 256*entries memory doesn't look good.
> >
> > Ok, makes sense.
> >
> > > > This would require to add bitmap_max_string_size(list, bitmap, nbits),
> > > > but it's O(1), and I think, others will find it helpful.
> > >
> > > What about getting size and memory at the same time?
> >
> > 1. We already have kasprintf()
> > 2. It breaks coding style.
> >
> > Documentation/process/coding-style.rst:
> >         Functions should be short and sweet, and do just one thing.
> >
> > From practical point of view, there should be some balance between
> > granularity and ease-of-use. But in this case, bitmap_list cries for
> > a function that will help to estimate size of output buffer.
> 
> According to the vsnprintf() logic the estimated size is what it returns. If
> user supplies too few bytes available, the comparison with the returned value
> can tell caller that space wasn't big enough.

As far as my understanding, for estimated size in bitmap_max_string_size()
Yury might mean something as below?

* For bitmask:
Each 32bit needs 9 bytes "11111111,", so the max size of mask would be:
9*nr_cpus / 32 ?

* For list:
Maximally  cpu0-9 need 2bytes, like "1,"
Maximally cpu10-99 need 3bytes, like "50,"
Maximally cpu100-999 need 4bytes, like "101,"
Maximally cpu1000-9999 need 5 bytes..
 
So once we know the size of the bitmap, we can figure out the maximum
size of its string for mask and list?

Pls correct me if you don't mean this, yury.


> 
> > And it's
> > easy to imagine a case where the estimated length of bitmap is needed
> > explicitly:
> >
> >         size_t max_size = bitmap_max_string_size(nbits);
> >         char *buf = kmalloc(PAGE_ALIGN(max_size) * nr_cpus);
> >
> > Thought, I don't insist. In your driver you can do:
> >
> >         size_t size = snprintf(NULL, 0, ...);
> >         void *buf = kmalloc(size);
> >
> > It will be fully correct, and you already have everything you need.
> >
> > > ssize_t bitmap_get_print_buf(bool list, char **buf, const unsigned long
> > >  *maskp, int nmaskbits)
> > >
> > > ssize_t cpumap_get_print_buf(bool list, char **buf, const struct cpumask
> *mask);
> > >
> > > This API returns the size of printed buffer, and it also gets the
> > > printed result saved in *buf. Then drivers don't need to do three
> > > steps:
> > >
> > > 1. get cpumap buffer size which is your cpumap_max_string_size()
> > > 2. allocate memory for buffer according to size got in step 1
> > > 3. print bitmap(cpumap) to buffer by "pbl"
> > >
> > > It will only need to call bitmap_get_print_buf() and all three
> > > things are done inside bitmap_get_print_buf().
> > >
> > > How to use the size and memory allocated in cpumap_get_print_buf
> > > will be totally up to users.
> > >
> > > The other benefit for this is that if we get string size during initialization,
> > > and then we print in show() entries, the size got at the beginning might
> be not
> > > enough as system topology might have changed. Sysfs ABI reflects the status
> of
> > > system at this moment.
> 
> --
> With Best Regards,
> Andy Shevchenko
> 

Thanks
Barry

