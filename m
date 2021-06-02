Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C763B398B02
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFBNu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:50:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3513 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhFBNux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:50:53 -0400
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw9Kn3dVxzYrvs;
        Wed,  2 Jun 2021 21:46:21 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 2 Jun 2021 21:49:05 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <akpm@linux-foundation.org>
CC:     <jonathan.cameron@huawei.com>, <song.bao.hua@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH v2 0/3] use bin_attribute to avoid buff overflow
Date:   Wed, 2 Jun 2021 21:48:51 +0800
Message-ID: <1622641734-22538-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch #1 adds a new function cpumap_print_to_buf and patch #2 uses
this function in drivers/base/topology.c, and patch #3 uses this new
function in drivers/base/node.c.

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
 lib/bitmap.c            |  38 +++++++++++++++-
 5 files changed, 157 insertions(+), 72 deletions(-)

-- 
2.7.4

