Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437BF3458C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhCWHcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:32:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14070 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhCWHbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:31:55 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4NKW4DWszNqTF;
        Tue, 23 Mar 2021 15:29:19 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Tue, 23 Mar 2021
 15:31:41 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <guohanjun@huawei.com>, <yangyingliang@huawei.com>
Subject: [PATCH 3/3] arm64: lib: improve copy performance when size is less than 128 and ge 64 bytes
Date:   Tue, 23 Mar 2021 15:34:32 +0800
Message-ID: <20210323073432.3422227-4-yangyingliang@huawei.com>
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

When copy less than 128 and ge than 64 bytes, add src/dst after
load and store 64 bytes to improve performance.

Copy 127 bytes cost on Kunpeng920 (ms):
Without this patch:
memcpy: 14.62 copy_from_user: 14.23 copy_to_user: 14.42

With this patch:
memcpy: 13.85 copy_from_user: 13.26 copy_to_user: 13.84

It's about 5.27% improvement in memcpy().

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/arm64/lib/copy_template.S | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/lib/copy_template.S b/arch/arm64/lib/copy_template.S
index c3cd6f84c9c0..a9cbd47473f0 100644
--- a/arch/arm64/lib/copy_template.S
+++ b/arch/arm64/lib/copy_template.S
@@ -132,14 +132,16 @@ D_h	.req	x14
 	* Less than 128 bytes to copy, so handle 64 here and then jump
 	* to the tail.
 	*/
-	ldp1	A_l, A_h, src, #16
-	stp1	A_l, A_h, dst, #16
-	ldp1	B_l, B_h, src, #16
-	ldp1	C_l, C_h, src, #16
-	stp1	B_l, B_h, dst, #16
-	stp1	C_l, C_h, dst, #16
-	ldp1	D_l, D_h, src, #16
-	stp1	D_l, D_h, dst, #16
+	ldp2	A_l, A_h, src, #0,  #8
+	stp2	A_l, A_h, dst, #0,  #8
+	ldp2	B_l, B_h, src, #16, #24
+	ldp2	C_l, C_h, src, #32, #40
+	stp2	B_l, B_h, dst, #16, #24
+	stp2	C_l, C_h, dst, #32, #40
+	ldp2	D_l, D_h, src, #48, #56
+	stp2	D_l, D_h, dst, #48, #56
+	add	src, src, #64
+	add	dst, dst, #64
 
 	tst	count, #0x3f
 	b.ne	.Ltail63
-- 
2.25.1

