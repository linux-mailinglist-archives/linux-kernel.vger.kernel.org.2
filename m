Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF4E3E2911
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245363AbhHFLE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:04:28 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:13292 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245322AbhHFLEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:04:23 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gh2Xw6ml0z83Pr;
        Fri,  6 Aug 2021 18:59:12 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 19:04:06 +0800
Received: from SWX921481.china.huawei.com (10.126.203.82) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 6 Aug 2021 19:04:01 +0800
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
Subject: [PATCH v9 5/5] bitmap: extend comment to bitmap_print_bitmask/list_to_buf
Date:   Fri, 6 Aug 2021 23:02:51 +1200
Message-ID: <20210806110251.560-6-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20210806110251.560-1-song.bao.hua@hisilicon.com>
References: <20210806110251.560-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.82]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
index 73746d96af81..663dd81967d4 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -568,6 +568,24 @@ static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
  * and it can break the size limit of converted decimal list and hexadecimal
  * bitmask.
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
 int bitmap_print_bitmask_to_buf(char *buf, const unsigned long *maskp,
-- 
2.25.1

