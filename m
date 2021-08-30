Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D53E3FB2AB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 10:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbhH3Ip6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 04:45:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18986 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbhH3Ipv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 04:45:51 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GykLP5rC9zbkb9;
        Mon, 30 Aug 2021 16:41:01 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 Aug 2021 16:44:55 +0800
Received: from huawei.com (10.67.174.117) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 30 Aug
 2021 16:44:55 +0800
From:   "GONG, Ruiqi" <gongruiqi1@huawei.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Yi Yang <yiyang13@huawei.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH] mtd: Remove obsolete macros only used by the old nand_ecclayout struct
Date:   Mon, 30 Aug 2021 16:33:56 +0800
Message-ID: <20210830083356.31702-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.117]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All uses of MTD_MAX_{OOBFREE,ECCPOS}_ENTRIES_LARGE have been removed as
commit ef5eeea6e911 ("mtd: nand: brcm: switch to mtd_ooblayout_ops") and
commit aab616e31d1c ("mtd: kill the nand_ecclayout struct") replaced
struct nand_ecclayout by the new mtd_ooblayout_ops interface. Remove
these two macros therefore.

Reported-by: Yi Yang <yiyang13@huawei.com>
Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 include/linux/mtd/mtd.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 88227044fc86..f5e7dfc2e4e9 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -72,8 +72,6 @@ struct mtd_oob_ops {
 	uint8_t		*oobbuf;
 };
 
-#define MTD_MAX_OOBFREE_ENTRIES_LARGE	32
-#define MTD_MAX_ECCPOS_ENTRIES_LARGE	640
 /**
  * struct mtd_oob_region - oob region definition
  * @offset: region offset
-- 
2.17.1

