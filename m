Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCF93D0BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 12:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbhGUIzu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jul 2021 04:55:50 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7409 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbhGUIvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:51:02 -0400
Received: from dggeme766-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GV9G01tmTz7xbg;
        Wed, 21 Jul 2021 17:27:04 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme766-chm.china.huawei.com (10.3.19.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 21 Jul 2021 17:30:43 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Wed, 21 Jul 2021 17:30:43 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Yury Norov <yury.norov@gmail.com>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
Thread-Index: AQHXeXDlNwZNI9Wk4UqsPQdyS/XZkqtFQm+QgABABACAAMKqIP//k3qAgAOpXQCAAKbSAP//4B8AgAMmn3A=
Date:   Wed, 21 Jul 2021 09:30:43 +0000
Message-ID: <617707849f504158b1db320439b44247@hisilicon.com>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <20210715115856.11304-3-song.bao.hua@hisilicon.com>
 <a74b62ef71be4348889bfc8c620e7b77@hisilicon.com>
 <YPHmMu4OWPHwQXtT@yury-ThinkPad>
 <3d83c6b11dae4a83add9d8dcc04bbd80@hisilicon.com>
 <YPIudYST90WC4k4U@yury-ThinkPad> <YPVAxnR95M0mZWDY@smile.fi.intel.com>
 <4ab537937f344893bf5bdcb13e46ce04@hisilicon.com>
 <YPWx+Ams2VRXSZ8k@yury-ThinkPad>
In-Reply-To: <YPWx+Ams2VRXSZ8k@yury-ThinkPad>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.118]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Yury Norov [mailto:yury.norov@gmail.com]
> Sent: Tuesday, July 20, 2021 5:10 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: andriy.shevchenko@linux.intel.com; gregkh@linuxfoundation.org;
> akpm@linux-foundation.org; linux-kernel@vger.kernel.org;
> dave.hansen@intel.com; linux@rasmusvillemoes.dk; rafael@kernel.org;
> rdunlap@infradead.org; agordeev@linux.ibm.com; sbrivio@redhat.com;
> jianpeng.ma@intel.com; valentin.schneider@arm.com; peterz@infradead.org;
> bristot@redhat.com; guodong.xu@linaro.org; tangchengchang
> <tangchengchang@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> yangyicong <yangyicong@huawei.com>; tim.c.chen@linux.intel.com; Linuxarm
> <linuxarm@huawei.com>; tiantao (H) <tiantao6@hisilicon.com>
> Subject: Re: [PATCH v7 2/4] topology: use bin_attribute to break the size
> limitation of cpumap ABI
> 
> On Mon, Jul 19, 2021 at 11:10:45AM +0000, Song Bao Hua (Barry Song) wrote:
> >
> >
> > > -----Original Message-----
> > > From: andriy.shevchenko@linux.intel.com
> > > [mailto:andriy.shevchenko@linux.intel.com]
> > > Sent: Monday, July 19, 2021 9:07 PM
> > > To: Yury Norov <yury.norov@gmail.com>
> > > Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> > > gregkh@linuxfoundation.org; akpm@linux-foundation.org;
> > > linux-kernel@vger.kernel.org; dave.hansen@intel.com;
> > > linux@rasmusvillemoes.dk; rafael@kernel.org; rdunlap@infradead.org;
> > > agordeev@linux.ibm.com; sbrivio@redhat.com; jianpeng.ma@intel.com;
> > > valentin.schneider@arm.com; peterz@infradead.org; bristot@redhat.com;
> > > guodong.xu@linaro.org; tangchengchang <tangchengchang@huawei.com>;
> Zengtao (B)
> > > <prime.zeng@hisilicon.com>; yangyicong <yangyicong@huawei.com>;
> > > tim.c.chen@linux.intel.com; Linuxarm <linuxarm@huawei.com>; tiantao (H)
> > > <tiantao6@hisilicon.com>
> > > Subject: Re: [PATCH v7 2/4] topology: use bin_attribute to break the size
> > > limitation of cpumap ABI
> > >
> > > On Fri, Jul 16, 2021 at 06:12:21PM -0700, Yury Norov wrote:
> > > > On Sat, Jul 17, 2021 at 12:16:48AM +0000, Song Bao Hua (Barry Song) wrote:
> > > > > > From: Yury Norov [mailto:yury.norov@gmail.com]
> > > > > > Sent: Saturday, July 17, 2021 8:04 AM
> > > > > > On Fri, Jul 16, 2021 at 08:49:58AM +0000, Song Bao Hua (Barry Song)
> wrote:
> > >
> > > ...
> > >
> > > > > Generally good idea. However, for sysfs ABI entries, it might not be
> > > > > that true.
> > > > >
> > > > > A sysfs entry might never be read for its whole life. As I explained
> > > > > before, a sysfs entry - especially for list,  is randomly "cat" by users.
> > > > > Many of them won't be read forever. And after they are read once, they
> > > > > will probably never be read again. The operations to read ABI could
> be
> > > > > random and rare. Performance wouldn't be a concern.
> > > > >
> > > > > To avoid holding the memory which might never be used, it is better
> to
> > > > > allocate and free the memory during runtime. I mean to allocate in show()
> > > > > and free in show(), aka, to do it on demand.
> > > > >
> > > > > For example, for a server with 256CPU and each cpu has dozens of sysfs
> ABI
> > > > > entries, only a few of sysfs list entries might be randomly "cat" by
> users.
> > > > > Holding 256*entries memory doesn't look good.
> > > >
> > > > Ok, makes sense.
> > > >
> > > > > > This would require to add bitmap_max_string_size(list, bitmap, nbits),
> > > > > > but it's O(1), and I think, others will find it helpful.
> > > > >
> > > > > What about getting size and memory at the same time?
> > > >
> > > > 1. We already have kasprintf()
> > > > 2. It breaks coding style.
> > > >
> > > > Documentation/process/coding-style.rst:
> > > >         Functions should be short and sweet, and do just one thing.
> > > >
> > > > From practical point of view, there should be some balance between
> > > > granularity and ease-of-use. But in this case, bitmap_list cries for
> > > > a function that will help to estimate size of output buffer.
> > >
> > > According to the vsnprintf() logic the estimated size is what it returns.
> If
> > > user supplies too few bytes available, the comparison with the returned
> value
> > > can tell caller that space wasn't big enough.
> 
> snprintf(NULL, 0, "pbl", ...) also works, but it's O(nbits), and user is not
> guaranteed that allocated memory would be always sufficient. I mean max possible
> length for given nbits, not a length of a specific string.
> 
> In case of lists, the length may grow. Consider:
>         0-8 -> 0-3,5-8 -> 0,2,4,6,8
> 
> If we want to allocate a storage for strings that may change, it would be
> helpful to allocate memory for the lengthiest string in advance.
> 
> So, bitmap_max_string_len() may be a convenient O(1) alternative for
> those who interested in printing the same bitmap in the same buffer.
> 
> > As far as my understanding, for estimated size in bitmap_max_string_size()
> > Yury might mean something as below?
> >
> > * For bitmask:
> > Each 32bit needs 9 bytes "11111111,", so the max size of mask would be:
> > 9*nr_cpus / 32 ?
> 
> 11111 -> "f1", but your formula gives 1.
> I think it should be like this (not tested):
>         DIV_ROUND_UP(nbits, 4) + nbits < 32 ? 0 : nbits / 32 - 1

I am not quite sure this is correct, in case nbits=64,
we will need:
ffffffff,ffffffff   9+8=17

your formula is ignoring the "," for each 32bits?

> 
> > * For list:
> > Maximally  cpu0-9 need 2bytes, like "1,"
> > Maximally cpu10-99 need 3bytes, like "50,"
> > Maximally cpu100-999 need 4bytes, like "101,"
> > Maximally cpu1000-9999 need 5 bytes..
> >
> > So once we know the size of the bitmap, we can figure out the maximum
> > size of its string for mask and list?
> >
> > Pls correct me if you don't mean this, yury.
> 
> Assuming that longest possible strings are of the form 0,2,4,6,... I
> think it's correct except for the last comma, so substract 1.

I don't think 0,2,4,6,8 takes maximum length,
0-1,3-4,6-7 are longer.

It seems maximum bitmap pattern is(binary):
110110110110...

In this case, each 3bits takes 4 bytes.

For cpu 10-99, it would be: 10-11,13-14,16-17,19-20,

Each 3bits takes "6 bytes".

For cpu100-999, it would be: 100-101, 103-104, 106-107,....
Each 3bits takes "8 bytes"?

Anyway, It seems be quite tricky :-)

> 
> If we decide to go on with this bitmap_max_strlen(), the list part
> should be tested extensively.
> 

Btw, sysfs core code needs changes to support pre-allocated
memory in customized size and seq read on it. This needs a lot
of efforts I am looking at.

> > > > And it's
> > > > easy to imagine a case where the estimated length of bitmap is needed
> > > > explicitly:
> > > >
> > > >         size_t max_size = bitmap_max_string_size(nbits);
> > > >         char *buf = kmalloc(PAGE_ALIGN(max_size) * nr_cpus);
> > > >
> > > > Thought, I don't insist. In your driver you can do:
> > > >
> > > >         size_t size = snprintf(NULL, 0, ...);
> > > >         void *buf = kmalloc(size);
> > > >
> > > > It will be fully correct, and you already have everything you need.
> > > >
> > > > > ssize_t bitmap_get_print_buf(bool list, char **buf, const unsigned long
> > > > >  *maskp, int nmaskbits)
> > > > >
> > > > > ssize_t cpumap_get_print_buf(bool list, char **buf, const struct cpumask
> > > *mask);
> > > > >
> > > > > This API returns the size of printed buffer, and it also gets the
> > > > > printed result saved in *buf. Then drivers don't need to do three
> > > > > steps:
> > > > >
> > > > > 1. get cpumap buffer size which is your cpumap_max_string_size()
> > > > > 2. allocate memory for buffer according to size got in step 1
> > > > > 3. print bitmap(cpumap) to buffer by "pbl"
> > > > >
> > > > > It will only need to call bitmap_get_print_buf() and all three
> > > > > things are done inside bitmap_get_print_buf().
> > > > >
> > > > > How to use the size and memory allocated in cpumap_get_print_buf
> > > > > will be totally up to users.
> > > > >
> > > > > The other benefit for this is that if we get string size during
> initialization,
> > > > > and then we print in show() entries, the size got at the beginning might
> > > be not
> > > > > enough as system topology might have changed. Sysfs ABI reflects the
> status
> > > of
> > > > > system at this moment.
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> >


Thanks
Barry
