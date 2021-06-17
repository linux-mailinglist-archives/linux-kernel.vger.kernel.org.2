Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B23A3ABFC0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 01:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhFQXvG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Jun 2021 19:51:06 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5029 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhFQXvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 19:51:05 -0400
Received: from dggeme760-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5dtG6sM6zXgkv;
        Fri, 18 Jun 2021 07:43:50 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme760-chm.china.huawei.com (10.3.19.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 07:48:54 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Fri, 18 Jun 2021 07:48:53 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Yury Norov <yury.norov@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
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
        "tiantao (H)" <tiantao6@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v4 0/4] use bin_attribute to avoid cpumap buff overflow
Thread-Topic: [PATCH v4 0/4] use bin_attribute to avoid cpumap buff overflow
Thread-Index: AQHXY2JXHCXlfAtLaEKo2fWK5TTMIasYL4qAgACqQFA=
Date:   Thu, 17 Jun 2021 23:48:53 +0000
Message-ID: <4ab928f1fb3e4420974dfafe4b32f5b7@hisilicon.com>
References: <20210617101910.13228-1-song.bao.hua@hisilicon.com>
 <YMu790ZvgzYWrJXV@yury-ThinkPad>
In-Reply-To: <YMu790ZvgzYWrJXV@yury-ThinkPad>
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
> From: Yury Norov [mailto:yury.norov@gmail.com]
> Sent: Friday, June 18, 2021 9:18 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: gregkh@linuxfoundation.org; andriy.shevchenko@linux.intel.com;
> linux-kernel@vger.kernel.org; linux@rasmusvillemoes.dk; rafael@kernel.org;
> akpm@linux-foundation.org; rdunlap@infradead.org; agordeev@linux.ibm.com;
> sbrivio@redhat.com; jianpeng.ma@intel.com; valentin.schneider@arm.com;
> peterz@infradead.org; bristot@redhat.com; guodong.xu@linaro.org;
> tangchengchang <tangchengchang@huawei.com>; Zengtao (B)
> <prime.zeng@hisilicon.com>; yangyicong <yangyicong@huawei.com>;
> tim.c.chen@linux.intel.com; tiantao (H) <tiantao6@hisilicon.com>; Jonathan
> Cameron <jonathan.cameron@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v4 0/4] use bin_attribute to avoid cpumap buff overflow
> 
> On Thu, Jun 17, 2021 at 10:19:06PM +1200, Barry Song wrote:
> > patch #1 adds a new function cpumap_print_to_buf and patch #2 uses
> > this function in drivers/base/topology.c, and patch #3 uses this new
> > function in drivers/base/node.c.
> > patch #4 adds test cases for the new API.
> 
> So, the root problem here is that some machines have so many CPUs that
> their cpumask text representation may not fit into the full page in the
> worst case. Is my understanding correct? Can you share an example of
> such configuration?

in my understanding, I have not found any machine which has really
caused the problem till now. But the whole story began from this
thread when Jonatah and me tried to add a new topology level-cluster
which exists on kunpeng920 and X86 Jacobsville:
https://lore.kernel.org/lkml/YFRGIedW1fUlnmi+@kroah.com/
https://lore.kernel.org/lkml/YFR2kwakbcGiI37w@kroah.com/

in the discussion, Greg had some concern about the potential
overflow of sysfs ABI for topology. Greg's comment is reasonable
and I think we should address the problem.

For this moment, both numa node and cpu use cpu bitmap like 3,ffffffff to
expose hardware topology. When cpu number is large, the page buffer of
sysfs will overflow. This doesn't really happen nowadays as the maximum
NR_CPUS is 8196 for X86_64 and 4096 for ARM64 since 8196 * 9 / 32 = 2305
is still smaller than 4KB page size.

So the existing BUILD_BUG_ON() in drivers/base/node.c is pretty much
preventing future problems similar with Y2K when hardware gets more
and more CPUs:
static ssize_t node_read_cpumap(struct device *dev, bool list, char *buf)
{
 	cpumask_var_t mask;
 	struct node *node_dev = to_node(dev);
 
	/* 2008/04/07: buf currently PAGE_SIZE, need 9 chars per 32 bits. */
	BUILD_BUG_ON((NR_CPUS/32 * 9) > (PAGE_SIZE-1));
}

But other ABIs exposing cpu lists are much more tricky, they could be
like: 0, 3, 5, 7, 9, 11... etc. so nobody knows the size till the last
moment.

So in the previous discussion, we agreed to remove this kind of
limitation totally and remove the BUILD_BUG_ON().

> 
> I think that the proper solution would be to create a function like
> void *cpumap_alloc_pagebuf(bool list), so that cpumap_print_to_pagebuf()
> will be always passed with enough portion of memory, and we'll just drop
> the PAGE_SIZE limit in cpumap_print_to_pagebuf().

I am sorry we missed you in the previous discussion:
https://lore.kernel.org/lkml/1619679819-45256-1-git-send-email-tiantao6@hisilicon.com/#t

I think we have figured out bin_attribute is the way to workaround
the limitation of sysfs:

https://lore.kernel.org/lkml/fd78ac30-dd3b-a7d7-eae8-193b09a7d49a@intel.com/
https://lore.kernel.org/lkml/YIueOR4fOYa1dSAb@kroah.com/

Again sorry for you were missed in the previous discussion.

> 
> >
> > v4:
> > add test cases for bitmap_print_to_buf API;
> > add Reviewed-by of Jonathan Cameron for patches 1-3, thanks!
> >
> > v3:
> > fixed the strlen issue and patch #1,#2,#3 minor formatting issues, thanks
> > to Andy Shevchenko and Jonathan Cameron.
> >
> > v2:
> > split the original patch #1 into two patches and use kasprintf() in
> > patch #1 to simplify the code. do some minor formatting adjustments.
> >
> > Barry Song (1):
> >   lib: test_bitmap: add bitmap_print_to_buf test cases
> >
> > Tian Tao (3):
> >   lib: bitmap: introduce bitmap_print_to_buf
> >   topology: use bin_attribute to avoid buff overflow
> >   drivers/base/node.c: use bin_attribute to avoid buff overflow
> >
> >  drivers/base/node.c     |  52 +++++++++-----
> >  drivers/base/topology.c | 115 +++++++++++++++++--------------
> >  include/linux/bitmap.h  |   2 +
> >  include/linux/cpumask.h |  21 ++++++
> >  lib/bitmap.c            |  37 +++++++++-
> >  lib/test_bitmap.c       | 149 ++++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 304 insertions(+), 72 deletions(-)
> >
> > --
> > 2.25.1

Thanks
Barry

