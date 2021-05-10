Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11151377F14
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhEJJLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:11:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2748 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhEJJLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:11:02 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FdwCZ5N2LzqV1T;
        Mon, 10 May 2021 17:06:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 17:09:46 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/8] crypto: hisilicon/hpre - init a structure member each line
Date:   Mon, 10 May 2021 17:06:45 +0800
Message-ID: <1620637611-41643-3-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1620637611-41643-1-git-send-email-tanghui20@huawei.com>
References: <1620637611-41643-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only init a structure member each line, just to keep the code neat.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 56 +++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index c914e00..47a169c 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -122,21 +122,49 @@ static const char * const hpre_debug_file_name[] = {
 };
 
 static const struct hpre_hw_error hpre_hw_errors[] = {
-	{ .int_msk = BIT(0), .msg = "core_ecc_1bit_err_int_set" },
-	{ .int_msk = BIT(1), .msg = "core_ecc_2bit_err_int_set" },
-	{ .int_msk = BIT(2), .msg = "dat_wb_poison_int_set" },
-	{ .int_msk = BIT(3), .msg = "dat_rd_poison_int_set" },
-	{ .int_msk = BIT(4), .msg = "bd_rd_poison_int_set" },
-	{ .int_msk = BIT(5), .msg = "ooo_ecc_2bit_err_int_set" },
-	{ .int_msk = BIT(6), .msg = "cluster1_shb_timeout_int_set" },
-	{ .int_msk = BIT(7), .msg = "cluster2_shb_timeout_int_set" },
-	{ .int_msk = BIT(8), .msg = "cluster3_shb_timeout_int_set" },
-	{ .int_msk = BIT(9), .msg = "cluster4_shb_timeout_int_set" },
-	{ .int_msk = GENMASK(15, 10), .msg = "ooo_rdrsp_err_int_set" },
-	{ .int_msk = GENMASK(21, 16), .msg = "ooo_wrrsp_err_int_set" },
-	{ .int_msk = BIT(22), .msg = "pt_rng_timeout_int_set"},
-	{ .int_msk = BIT(23), .msg = "sva_fsm_timeout_int_set"},
 	{
+		.int_msk = BIT(0),
+		.msg = "core_ecc_1bit_err_int_set"
+	}, {
+		.int_msk = BIT(1),
+		.msg = "core_ecc_2bit_err_int_set"
+	}, {
+		.int_msk = BIT(2),
+		.msg = "dat_wb_poison_int_set"
+	}, {
+		.int_msk = BIT(3),
+		.msg = "dat_rd_poison_int_set"
+	}, {
+		.int_msk = BIT(4),
+		.msg = "bd_rd_poison_int_set"
+	}, {
+		.int_msk = BIT(5),
+		.msg = "ooo_ecc_2bit_err_int_set"
+	}, {
+		.int_msk = BIT(6),
+		.msg = "cluster1_shb_timeout_int_set"
+	}, {
+		.int_msk = BIT(7),
+		.msg = "cluster2_shb_timeout_int_set"
+	}, {
+		.int_msk = BIT(8),
+		.msg = "cluster3_shb_timeout_int_set"
+	}, {
+		.int_msk = BIT(9),
+		.msg = "cluster4_shb_timeout_int_set"
+	}, {
+		.int_msk = GENMASK(15, 10),
+		.msg = "ooo_rdrsp_err_int_set"
+	}, {
+		.int_msk = GENMASK(21, 16),
+		.msg = "ooo_wrrsp_err_int_set"
+	}, {
+		.int_msk = BIT(22),
+		.msg = "pt_rng_timeout_int_set"
+	}, {
+		.int_msk = BIT(23),
+		.msg = "sva_fsm_timeout_int_set"
+	}, {
 		/* sentinel */
 	}
 };
-- 
2.8.1

