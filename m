Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8D242ECCD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhJOIyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:54:02 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:25191 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbhJOIyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:54:00 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HW0NN2DXGz8tgt;
        Fri, 15 Oct 2021 16:50:44 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 16:51:53 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 16:51:52 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <moyufeng@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH v2] arm64: barrier: add macro dgh() to control memory accesses merging
Date:   Fri, 15 Oct 2021 17:05:11 +0800
Message-ID: <20211015090511.92421-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DGH (Data Gathering Hint) prohibits merging memory accesses with
Normal-NC or Device-GRE attributes before the hint instruction with any
memory accesses appearing after the hint instruction. It can be used for
performance benefit to prevent the prior access waiting too long just to
be merged. This patch provide a macro to expose it to the arch code.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
Signed-off-by: Yufeng Mo <moyufeng@huawei.com>

---
v1->v2:
    extract this single patch from the origin patchset.
    remove the macro in the assemble code.
    add comments for macro dgh().
    modify the commit message a little bit.
---
 arch/arm64/include/asm/barrier.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 451e11e5fd23..d71a7457d619 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -18,6 +18,14 @@
 #define wfe()		asm volatile("wfe" : : : "memory")
 #define wfi()		asm volatile("wfi" : : : "memory")
 
+/*
+ * Data Gathering Hint:
+ * This instruction prohibits merging memory accesses with Normal-NC or
+ * Device-GRE attributes before the hint instruction with any memory accesses
+ * appearing after the hint instruction.
+ */
+#define dgh()		asm volatile("hint #6" : : : "memory")
+
 #define isb()		asm volatile("isb" : : : "memory")
 #define dmb(opt)	asm volatile("dmb " #opt : : : "memory")
 #define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
-- 
2.20.1

