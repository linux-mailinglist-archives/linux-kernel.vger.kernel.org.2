Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C683CB02A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 02:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhGPAoB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jul 2021 20:44:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:11427 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhGPAoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 20:44:00 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GQslY2KhZzcdXd;
        Fri, 16 Jul 2021 08:37:45 +0800 (CST)
Received: from dggema773-chm.china.huawei.com (10.1.198.217) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 08:41:03 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema773-chm.china.huawei.com (10.1.198.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 16 Jul 2021 08:41:02 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Fri, 16 Jul 2021 08:41:02 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        "Valentin Schneider" <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        tangchengchang <tangchengchang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        yangyicong <yangyicong@huawei.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v7 4/4] lib: test_bitmap: add bitmap_print_to_buf test
 cases
Thread-Topic: [PATCH v7 4/4] lib: test_bitmap: add bitmap_print_to_buf test
 cases
Thread-Index: AQHXeXDrOfBGqk3al0SA/L83bTtrzqtDa5SAgACQyoCAAAyKgIAAHvMAgACWHhA=
Date:   Fri, 16 Jul 2021 00:41:02 +0000
Message-ID: <624bf0321f204bc1b386ab36c84b4d58@hisilicon.com>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <20210715115856.11304-5-song.bao.hua@hisilicon.com>
 <YPAlg5c8uDSZ2WvZ@smile.fi.intel.com> <YPCe+f3GPDUuvwnW@yury-ThinkPad>
 <CAHp75VcoNPiKDaZzTVr3unV3F5u+LQwAjy1hKSq0WUw_tB6uAw@mail.gmail.com>
 <YPDDdAwgYEptz2Uq@yury-ThinkPad>
In-Reply-To: <YPDDdAwgYEptz2Uq@yury-ThinkPad>
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
> Sent: Friday, July 16, 2021 11:24 AM
> To: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Song Bao Hua (Barry
> Song) <song.bao.hua@hisilicon.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Andrew Morton <akpm@linux-foundation.org>;
> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Dave Hansen
> <dave.hansen@intel.com>; Rasmus Villemoes <linux@rasmusvillemoes.dk>; Rafael
> J. Wysocki <rafael@kernel.org>; Randy Dunlap <rdunlap@infradead.org>;
> Alexander Gordeev <agordeev@linux.ibm.com>; Stefano Brivio
> <sbrivio@redhat.com>; Ma, Jianpeng <jianpeng.ma@intel.com>; Valentin
> Schneider <valentin.schneider@arm.com>; Peter Zijlstra (Intel)
> <peterz@infradead.org>; Daniel Bristot de Oliveira <bristot@redhat.com>;
> Guodong Xu <guodong.xu@linaro.org>; tangchengchang
> <tangchengchang@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> yangyicong <yangyicong@huawei.com>; tim.c.chen@linux.intel.com; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [PATCH v7 4/4] lib: test_bitmap: add bitmap_print_to_buf test cases
> 
> On Fri, Jul 16, 2021 at 12:32:45AM +0300, Andy Shevchenko wrote:
> > On Thu, Jul 15, 2021 at 11:48 PM Yury Norov <yury.norov@gmail.com> wrote:
> > > On Thu, Jul 15, 2021 at 03:09:39PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Jul 15, 2021 at 11:58:56PM +1200, Barry Song wrote:
> > > > > The added test items cover both cases where bitmap buf of the printed
> > > > > result is greater than and less than 4KB.
> > > > > And it also covers the case where offset for bitmap_print_to_buf is
> > > > > non-zero which will happen when printed buf is larger than one page
> > > > > in sysfs bin_attribute.
> > > >
> > > > More test cases is always a good thing, thanks!
> > >
> > > Generally yes. But in this case... I believe, Barry didn't write that
> > > huge line below by himself. Most probably he copy-pasted the output of
> > > his bitmap_print_buf() into the test. If so, this code tests nothing,
> > > and just enforces current behavior of snprintf.
> >
> > I'm not sure I got what you are telling me. The big line is to test
> > strings that are bigger than 4k.
> 
> I'm trying to say that human are not able to verify correctness of
> this line. The test is supposed to check bitmap_print_to_buf(), but
> reference output itself is generated by bitmap_print_to_buf(). This
> test will always pass by design, even if there's an error somewhere
> in the middle, isn't it?

So would it be better to compare the output of bitmap_print_to_buf()
with the output of the direct scnprintf("pbl")?  In this case, we have
to assume scnprintf("pbl") is always right.

> 
> >
> > ...
> >
> > > > > +static const char large_list[] __initconst = /* more than 4KB */
> > > > > +
> "0,4,8,12,16,20,24,28,32-33,36-37,40-41,44-45,48-49,52-53,56-57,60-61,64,6
> 8,72,76,80,84,88,92,96-97,100-101,104-1"
> > > > > +
> "05,108-109,112-113,116-117,120-121,124-125,128,132,136,140,144,148,152,15
> 6,160-161,164-165,168-169,172-173,176-1"
> > > > > +
> "77,180-181,184-185,188-189,192,196,200,204,208,212,216,220,224-225,228-22
> 9,232-233,236-237,240-241,244-245,248-2"
> > >
> > > I don't like this behavior of the code: each individual line is not a
> > > valid bitmap_list. I would prefer to split original bitmap and print
> > > list representation of parts in a compatible format; considering a
> > > receiving part of this splitting machinery.
> >
> > I agree that split is not the best here, but after all it's only 1
> > line and this is on purpose.
> 
> What I see is that bitmap_print_to_buf() is called many times, and
> each time it returns something that is not a valid bitmap list string.
> If the caller was be able to concatenate all the lines returned by
> bitmap_print_to_buf(), he'd probably get correct result. But in such
> case, why don't he use scnprintf("pbl") directly?

I still don't understand what you mean, for a sys ABI like list, its
main users are random "cat" commands:
$ cat /sys/devices/system/cpu/cpu0/topology/thread_siblings_list
0-1

Users "cat" the file to get a human-readable list. Users who are
"catting" sysfs have no bitmap to run scnprintf("pbl").

> 
> If there exists a real case where scnprintf("pbl") output is too long
> (or execution time is too slow) that we need to split, the right
> approach is to split the original bitmap, not an output of
> scnprintf("pbl").

The whole patchset is printing bitmap to a list or bitmask
so that users can "cat" the files to get a human-readable list.
But due to the limit of sysfs attribute, the list will be
trimmed if the printed result is more than 4KB.

> 
> And I still don't understand, what prevents the higher levels from
> calling the scnprintf() directly in this specific case?

Again, I don't understand what you mean. Higher levels like those drivers
can, for sure, call scnprintf() directly, then we have to copy this kind
of code here and there. With a cpumap API, those drivers can simply call
an API.

Anyway, it is really difficult for me to understand the approach
you are expecting. I'd really appreciate you can post some pseudo
code for the modification of drivers to make it clear. In my personal
opinion, the current approach from tian tao for patch1-3 is the best
choice from the perspective of the API's users - sysfs bin_attribute.

Thanks
Barry

