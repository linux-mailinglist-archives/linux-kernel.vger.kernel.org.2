Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5103D9D35
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 07:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhG2FnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 01:43:25 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12422 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbhG2FnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 01:43:24 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GZzr73jP4zcjTH;
        Thu, 29 Jul 2021 13:39:51 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 13:43:20 +0800
Received: from SWX921481.china.huawei.com (10.126.201.210) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 29 Jul 2021 13:43:15 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <andriy.shevchenko@linux.intel.com>, <yury.norov@gmail.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <dave.hansen@intel.com>,
        <linux@rasmusvillemoes.dk>, <rafael@kernel.org>,
        <rdunlap@infradead.org>, <agordeev@linux.ibm.com>,
        <sbrivio@redhat.com>, <jianpeng.ma@intel.com>,
        <valentin.schneider@arm.com>, <peterz@infradead.org>,
        <bristot@redhat.com>, <guodong.xu@linaro.org>,
        <tangchengchang@huawei.com>, <prime.zeng@hisilicon.com>,
        <yangyicong@huawei.com>, <tim.c.chen@linux.intel.com>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v8 5/5] bitmap: extend comment to bitmap_print_to_buf
Date:   Thu, 29 Jul 2021 17:42:08 +1200
Message-ID: <20210729054208.1800-6-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20210729054208.1800-1-song.bao.hua@hisilicon.com>
References: <20210729054208.1800-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.210]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggemi761-chm.china.huawei.com (10.1.198.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>

Extend comment to new function to warn potential users about caveats.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 lib/bitmap.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 56bcffe2fa8c..608b79eabd43 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -545,6 +545,24 @@ EXPORT_SYMBOL(bitmap_print_to_pagebuf);
  * mainly serves bin_attribute which doesn't work with exact one page, and it
  * can break the size limit of converted decimal list and hexadecimal bitmask.
  *
+ * WARNING!
+ *
+ * This function is not a replacement for sprintf() or bitmap_print_to_pagebuf().
+ * It is intended to workaround sysfs limitations discussed above and should be
+ * used carefully in general case for the following reasons:
+ *  - Time complexity is O(nbits^2/count), comparing to O(nbits) for snprintf().
+ *  - Memory complexity is O(nbits), comparing to O(1) for snprintf().
+ *  - @off and @count are NOT offset and number of bits to print.
+ *  - If printing part of bitmap as list, the resulting string is not a correct
+ *    list representation of bitmap. Particularly, some bits within or out of
+ *    related interval may be erroneously set or unset. The format of the string
+ *    may be broken, so bitmap_parselist-like parser may fail parsing it.
+ *  - If printing the whole bitmap as list by parts, user must ensure the order
+ *    of calls of the function such that the offset is incremented linearly.
+ *  - If printing the whole bitmap as list by parts, user must keep bitmap
+ *    unchanged between the very first and very last call. Otherwise concatenated
+ *    result may be incorrect, and format may be broken.
+ *
  * Returns the number of characters actually printed to @buf
  */
 int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
-- 
2.25.1

