Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC493B9E30
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 11:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhGBJ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 05:29:02 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13053 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhGBJ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:29:01 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GGV4S16dBzZmCC;
        Fri,  2 Jul 2021 17:23:20 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 2 Jul 2021 17:26:28 +0800
Received: from SWX921481.china.huawei.com (10.126.203.116) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 2 Jul 2021 17:26:23 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <andriy.shevchenko@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC:     <dave.hansen@intel.com>, <yury.norov@gmail.com>,
        <linux@rasmusvillemoes.dk>, <rafael@kernel.org>,
        <rdunlap@infradead.org>, <agordeev@linux.ibm.com>,
        <sbrivio@redhat.com>, <jianpeng.ma@intel.com>,
        <valentin.schneider@arm.com>, <peterz@infradead.org>,
        <bristot@redhat.com>, <guodong.xu@linaro.org>,
        <tangchengchang@huawei.com>, <prime.zeng@hisilicon.com>,
        <yangyicong@huawei.com>, <tim.c.chen@linux.intel.com>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v5 0/3] use bin_attribute to break the size limitation of cpumap ABI
Date:   Fri, 2 Jul 2021 21:25:56 +1200
Message-ID: <20210702092559.8776-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.116]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggemi761-chm.china.huawei.com (10.1.198.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Tian Tao (3):
  cpumask: introduce cpumap_print_to_buf to support large bitmask and
    list
  topology: use bin_attribute to break the size limitation of cpumap ABI
  drivers/base/node.c: use bin_attribute to break the size limitation of
    cpumap ABI

 drivers/base/node.c     |  52 +++++++++++-------
 drivers/base/topology.c | 115 ++++++++++++++++++++++------------------
 include/linux/cpumask.h |  19 +++++++
 lib/cpumask.c           |  18 +++++++
 4 files changed, 133 insertions(+), 70 deletions(-)

-- 
2.25.1

