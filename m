Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F72399DA5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFCJYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:24:42 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7086 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhFCJYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:24:40 -0400
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FwgN93HZMzYqKG;
        Thu,  3 Jun 2021 17:20:09 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 3 Jun 2021 17:22:54 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <andriy.shevchenko@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>,
        <song.bao.hua@hisilicon.com>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH v3 0/3] use bin_attribute to avoid buff overflow
Date:   Thu, 3 Jun 2021 17:22:39 +0800
Message-ID: <1622712162-7028-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch #1 adds a new function cpumap_print_to_buf and patch #2 uses
this function in drivers/base/topology.c, and patch #3 uses this new
function in drivers/base/node.c.

v3：
fixed the strlen issue and patch #1,#2,#3 minor formatting issues, thanks
to Andy Shevchenko and Jonathan Cameron.

v2:
split the original patch #1 into two patches and use kasprintf() in
patch #1 to simplify the code. do some minor formatting adjustments.

Tian Tao (3):
  lib: bitmap: introduce bitmap_print_to_buf
  topology: use bin_attribute to avoid buff overflow
  drivers/base/node.c: use bin_attribute to avoid buff overflow

 drivers/base/node.c     |  52 ++++++++++++++--------
 drivers/base/topology.c | 115 ++++++++++++++++++++++++++----------------------
 include/linux/bitmap.h  |   3 ++
 include/linux/cpumask.h |  21 +++++++++
 lib/bitmap.c            |  37 +++++++++++++++-
 5 files changed, 156 insertions(+), 72 deletions(-)

-- 
2.7.4

