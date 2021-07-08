Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1140A3C1407
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhGHNQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:16:49 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:10434 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhGHNQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:16:47 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GLGr86xySzcb9Z;
        Thu,  8 Jul 2021 21:10:48 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 8 Jul
 2021 21:14:01 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <David.Woodhouse@intel.com>, <Artem.Bityutskiy@nokia.com>,
        <ext-adrian.hunter@nokia.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linmiaohe@huawei.com>,
        <linfeilong@huawei.com>
Subject: [PATCH] mtd: fix size in mtd_info_user to support 64-bit
Date:   Thu, 8 Jul 2021 21:13:59 +0800
Message-ID: <20210708131359.21591-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feilong Lin <linfeilong@huawei.com>

The size in struct mtd_info_user is 32-bit, which will cause errors
when obtaining the size of large-capacity MTD devices, such as TLC
NAND FLASH-2048Gb.

Fixes: 69423d99fc18 ("[MTD] update internal API to support 64-bit device size")
Signed-off-by: Feilong Lin <linfeilong@huawei.com>
---
 include/uapi/mtd/mtd-abi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index b869990c2db2..efe0b53b10c1 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -128,7 +128,7 @@ struct mtd_write_req {
 struct mtd_info_user {
 	__u8 type;
 	__u32 flags;
-	__u32 size;	/* Total size of the MTD */
+	__u64 size;	/* Total size of the MTD */
 	__u32 erasesize;
 	__u32 writesize;
 	__u32 oobsize;	/* Amount of OOB data per block (e.g. 16) */
-- 
2.23.0

