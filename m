Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1F83458BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhCWHcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:32:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14068 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCWHbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:31:55 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4NKW4VsSzNqT8;
        Tue, 23 Mar 2021 15:29:19 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Tue, 23 Mar 2021
 15:31:40 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <guohanjun@huawei.com>, <yangyingliang@huawei.com>
Subject: [PATCH 2/3] arm64: lib: improve copy performance when size is ge 128 bytes
Date:   Tue, 23 Mar 2021 15:34:31 +0800
Message-ID: <20210323073432.3422227-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323073432.3422227-1-yangyingliang@huawei.com>
References: <20210323073432.3422227-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When copy over 128 bytes, src/dst is added after
each ldp/stp instruction, it will cost more time.
To improve this, we only add src/dst after load
or store 64 bytes.

Copy 4096 bytes cost on Kunpeng920 (ms):
Without this patch:
memcpy: 143.85 copy_from_user: 172.69 copy_to_user: 199.23

With this patch:
memcpy: 107.12 copy_from_user: 157.50 copy_to_user: 198.85

It's about 25% improvement in memcpy().

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/arm64/lib/copy_template.S | 36 +++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/lib/copy_template.S b/arch/arm64/lib/copy_template.S
index 488df234c49a..c3cd6f84c9c0 100644
--- a/arch/arm64/lib/copy_template.S
+++ b/arch/arm64/lib/copy_template.S
@@ -152,29 +152,33 @@ D_h	.req	x14
 	.p2align	L1_CACHE_SHIFT
 .Lcpy_body_large:
 	/* pre-get 64 bytes data. */
-	ldp1	A_l, A_h, src, #16
-	ldp1	B_l, B_h, src, #16
-	ldp1	C_l, C_h, src, #16
-	ldp1	D_l, D_h, src, #16
+	ldp2	A_l, A_h, src, #0,  #8
+	ldp2	B_l, B_h, src, #16, #24
+	ldp2	C_l, C_h, src, #32, #40
+	ldp2	D_l, D_h, src, #48, #56
+	add	src, src, #64
 1:
 	/*
 	* interlace the load of next 64 bytes data block with store of the last
 	* loaded 64 bytes data.
 	*/
-	stp1	A_l, A_h, dst, #16
-	ldp1	A_l, A_h, src, #16
-	stp1	B_l, B_h, dst, #16
-	ldp1	B_l, B_h, src, #16
-	stp1	C_l, C_h, dst, #16
-	ldp1	C_l, C_h, src, #16
-	stp1	D_l, D_h, dst, #16
-	ldp1	D_l, D_h, src, #16
+	stp2	A_l, A_h, dst, #0,  #8
+	ldp2	A_l, A_h, src, #0,  #8
+	stp2	B_l, B_h, dst, #16, #24
+	ldp2	B_l, B_h, src, #16, #24
+	stp2	C_l, C_h, dst, #32, #40
+	ldp2	C_l, C_h, src, #32, #40
+	stp2	D_l, D_h, dst, #48, #56
+	ldp2	D_l, D_h, src, #48, #56
+	add	src, src, #64
+	add	dst, dst, #64
 	subs	count, count, #64
 	b.ge	1b
-	stp1	A_l, A_h, dst, #16
-	stp1	B_l, B_h, dst, #16
-	stp1	C_l, C_h, dst, #16
-	stp1	D_l, D_h, dst, #16
+	stp2	A_l, A_h, dst, #0,  #8
+	stp2	B_l, B_h, dst, #16, #24
+	stp2	C_l, C_h, dst, #32, #40
+	stp2	D_l, D_h, dst, #48, #56
+	add	dst, dst, #64
 
 	tst	count, #0x3f
 	b.ne	.Ltail63
-- 
2.25.1

