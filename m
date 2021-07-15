Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4FF3C9E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhGOMC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:02:29 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:15021 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhGOMC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:02:28 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GQXrv0dsmzbbpd;
        Thu, 15 Jul 2021 19:56:15 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 19:59:33 +0800
Received: from SWX921481.china.huawei.com (10.126.202.216) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 15 Jul 2021 19:59:28 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <andriy.shevchenko@linux.intel.com>, <yury.norov@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     <dave.hansen@intel.com>, <linux@rasmusvillemoes.dk>,
        <rafael@kernel.org>, <rdunlap@infradead.org>,
        <agordeev@linux.ibm.com>, <sbrivio@redhat.com>,
        <jianpeng.ma@intel.com>, <valentin.schneider@arm.com>,
        <peterz@infradead.org>, <bristot@redhat.com>,
        <guodong.xu@linaro.org>, <tangchengchang@huawei.com>,
        <prime.zeng@hisilicon.com>, <yangyicong@huawei.com>,
        <tim.c.chen@linux.intel.com>, <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v7 0/4] use bin_attribute to break the size limitation of cpumap ABI
Date:   Thu, 15 Jul 2021 23:58:52 +1200
Message-ID: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.216]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggemi761-chm.china.huawei.com (10.1.198.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v7:
  - update doc in code for new APIs according to the comments of
    Andy Shevchenko;
  - other minor cleanup and commit log fix according to the comments
    of Andy Shevchenko

v6:
  -minor cleanup according to Andy Shevchenko's comment;
  -take bitmap_print_to_buf back according to Yury Norov's comment and
   fix the documents; and also take the bitmap testcase back.
  -Sorry, Yury, I don't think it is doable to move memory allocation
   to drivers.
   Considering a driver like topology.c, we have M CPUs and each CPU
   has N various nodes like core_siblings, package_cpus, die_cpus etc,
   we can't know the size of each node of each CPU in advance. The best
   time to get the size of each node is really when users read the sysfs
   node. otherwise, we have to scan M*N nodes in drivers in advance to
   figure out the exact size of buffers we need.
   On the other hand, it is crazily tricky to ask a bundle of drivers to
   find a proper place to save the pointer of allocated buffers so that
   they can be re-used in second read of the same bin_attribute node.
   And I doubt it is really useful to save the address of buffers
   somewhere. Immediately freeing it seems to be a correct option to
   avoid runtime waste of memory. We can't predict when users will read
   topology ABI and which node users will read.
   Finally, reading topology things wouldn't be the really cpu-bound
   things in user applications, hardly this kind of ABI things can be
   a performance bottleneck. Users use numactl and lstopo commands to
   read ABIs but nobody will do it again and again. And a normal
   application won't do topology repeatly. So the overhead caused by
   malloc/free in the new bitmap API doesn't really matter.
   if we really want a place to re-used the buffer and avoid malloc/free,
   it seems this should be done in some common place rather than each
   driver. still it is hard to find the best place.

   Thanks for the comments of Yury and Andy in v5.

v5:
  -remove the bitmap API bitmap_print_to_buf, alternatively, only provide
   cpumap_print_to_buf API as what we really care about is cpumask for
   this moment. we can freely take bitmap_print_to_buf back once we find
   the second user.
   hopefully this can alleviate Yury's worries on possible abuse of a new
   bitmap API.
  -correct the document of cpumap_print_to_buf;
  -In patch1, clearly explain why we need this new API in commit log;
  -Also refine the commit log of patch 2 and 3;
  -As the modification is narrowed to the scope of cpumask, the kunit
   test of bitmap_print_to_buf doesn't apply in the new patchset. so
   test case patch4/4 is removed.

   Thanks for the comments of Greg, Yury, Andy. Thanks for Jonathan's
   review.

v4:
  -add test cases for bitmap_print_to_buf API;
  -add Reviewed-by of Jonathan Cameron for patches 1-3, thanks!

v3:
  -fixed the strlen issue and patch #1,#2,#3 minor formatting issues, thanks
   to Andy Shevchenko and Jonathan Cameron.

v2:
  -split the original patch #1 into two patches and use kasprintf() in
  -patch #1 to simplify the code. do some minor formatting adjustments.

Background:

the whole story began from this thread when Jonatah and me tried to add a
new topology level-cluster which exists on kunpeng920 and X86 Jacobsville:
https://lore.kernel.org/lkml/YFRGIedW1fUlnmi+@kroah.com/
https://lore.kernel.org/lkml/YFR2kwakbcGiI37w@kroah.com/

in the discussion, Greg had some concern about the potential one page size
limitation of sysfs ABI for topology. Greg's comment is reasonable
and I think we should address the problem.

For this moment, numa node, cpu topology and some other drivers are using
cpu bitmap and list to expose hardware topology. When cpu number is large,
the page buffer of sysfs won't be able to hold the whole bitmask or list.
This doesn't really happen nowadays for bitmask as the maximum NR_CPUS
is 8196 for X86_64 and 4096 for ARM64 since
8196 * 9 / 32 = 2305
is still smaller than 4KB page size.

So the existing BUILD_BUG_ON() in drivers/base/node.c is pretty much
preventing future problems when hardware gets more and more CPUs:
static ssize_t node_read_cpumap(struct device *dev, bool list, char *buf)
{
 	cpumask_var_t mask;
 	struct node *node_dev = to_node(dev);

	/* 2008/04/07: buf currently PAGE_SIZE, need 9 chars per 32 bits. */
	BUILD_BUG_ON((NR_CPUS/32 * 9) > (PAGE_SIZE-1));
}

But those ABIs exposing cpu lists are much more tricky as a list could be
like: 0, 3, 5, 7, 9, 11... etc. so nobody knows the size till the last
moment. Comparing to bitmask, list is easier to exceed one page.

In the previous discussion, Greg and Dave Hansen preferred to remove this
kind of limitation totally and remove the BUILD_BUG_ON() in
drivers/base/node.c together:
https://lore.kernel.org/lkml/1619679819-45256-2-git-send-email-tiantao6@hisilicon.com/
https://lore.kernel.org/lkml/YIueOR4fOYa1dSAb@kroah.com/

Todo:

right now, only topology and node are addressed. there are many other
drivers are calling cpumap_print_to_pagebuf() and have the similar
problems. we are going to address them one by one after this patchset
settles down.

Barry Song (1):
  lib: test_bitmap: add bitmap_print_to_buf test cases

Tian Tao (3):
  cpumask: introduce cpumap_print_to_buf to support large bitmask and
    list
  topology: use bin_attribute to break the size limitation of cpumap ABI
  drivers/base/node.c: use bin_attribute to break the size limitation of
    cpumap ABI

 drivers/base/node.c     |  51 +++++++++-----
 drivers/base/topology.c | 115 ++++++++++++++++--------------
 include/linux/bitmap.h  |   2 +
 include/linux/cpumask.h |  63 +++++++++++++++++
 lib/bitmap.c            |  78 +++++++++++++++++++++
 lib/test_bitmap.c       | 150 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 389 insertions(+), 70 deletions(-)

-- 
2.25.1

