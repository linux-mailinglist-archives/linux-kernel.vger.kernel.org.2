Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F7E3AB13E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhFQKWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:22:21 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4835 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhFQKWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:22:20 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5Hx35Zb4zXfMq;
        Thu, 17 Jun 2021 18:15:03 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 18:20:06 +0800
Received: from SWX921481.china.huawei.com (10.126.201.234) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 17 Jun 2021 18:20:00 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux@rasmusvillemoes.dk>, <rafael@kernel.org>,
        <akpm@linux-foundation.org>, <rdunlap@infradead.org>,
        <agordeev@linux.ibm.com>, <sbrivio@redhat.com>,
        <jianpeng.ma@intel.com>, <yury.norov@gmail.com>,
        <valentin.schneider@arm.com>, <peterz@infradead.org>,
        <bristot@redhat.com>, <guodong.xu@linaro.org>,
        <tangchengchang@huawei.com>, <prime.zeng@hisilicon.com>,
        <yangyicong@huawei.com>, <tim.c.chen@linux.intel.com>,
        <tiantao6@hisilicon.com>, <Jonathan.Cameron@huawei.com>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v4 0/4] use bin_attribute to avoid cpumap buff overflow
Date:   Thu, 17 Jun 2021 22:19:06 +1200
Message-ID: <20210617101910.13228-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.234]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggemi761-chm.china.huawei.com (10.1.198.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch #1 adds a new function cpumap_print_to_buf and patch #2 uses
this function in drivers/base/topology.c, and patch #3 uses this new
function in drivers/base/node.c.
patch #4 adds test cases for the new API.

v4:
add test cases for bitmap_print_to_buf API;
add Reviewed-by of Jonathan Cameron for patches 1-3, thanks!

v3:
fixed the strlen issue and patch #1,#2,#3 minor formatting issues, thanks
to Andy Shevchenko and Jonathan Cameron.

v2:
split the original patch #1 into two patches and use kasprintf() in
patch #1 to simplify the code. do some minor formatting adjustments.

Barry Song (1):
  lib: test_bitmap: add bitmap_print_to_buf test cases

Tian Tao (3):
  lib: bitmap: introduce bitmap_print_to_buf
  topology: use bin_attribute to avoid buff overflow
  drivers/base/node.c: use bin_attribute to avoid buff overflow

 drivers/base/node.c     |  52 +++++++++-----
 drivers/base/topology.c | 115 +++++++++++++++++--------------
 include/linux/bitmap.h  |   2 +
 include/linux/cpumask.h |  21 ++++++
 lib/bitmap.c            |  37 +++++++++-
 lib/test_bitmap.c       | 149 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 304 insertions(+), 72 deletions(-)

-- 
2.25.1

