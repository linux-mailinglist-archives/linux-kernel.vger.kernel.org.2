Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7293949E8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 04:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhE2CGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 22:06:07 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2400 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhE2CGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 22:06:06 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FsPsX6bGRz66Gh;
        Sat, 29 May 2021 10:00:48 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 10:04:27 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 29 May
 2021 10:04:27 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <vincent.chen@sifive.com>, <sunnanyong@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Bixuan Cui <cuibixuan@huawei.com>
Subject: [PATCH -next] module: fix build error when CONFIG_SMP is disabled
Date:   Sat, 29 May 2021 10:03:28 +0800
Message-ID: <20210529020328.36863-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error when disable CONFIG_SMP:
mm/pgtable-generic.o: In function `.L19':
pgtable-generic.c:(.text+0x42): undefined reference to `flush_pmd_tlb_range'
mm/pgtable-generic.o: In function `pmdp_huge_clear_flush':
pgtable-generic.c:(.text+0x6c): undefined reference to `flush_pmd_tlb_range'
mm/pgtable-generic.o: In function `pmdp_invalidate':
pgtable-generic.c:(.text+0x162): undefined reference to `flush_pmd_tlb_range'

Fixes: e88b333142e4 ("riscv: mm: add THP support on 64-bit")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 arch/riscv/include/asm/tlbflush.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index c84218ad7afc..9d5801f6e2c3 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -44,6 +44,12 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
 	local_flush_tlb_all();
 }
 
+static inline void flush_pmd_tlb_range(struct vm_area_struct *vma,
+		unsigned long start, unsigned long end)
+{
+	local_flush_tlb_all();
+}
+
 #define flush_tlb_mm(mm) flush_tlb_all()
 #endif /* !CONFIG_SMP || !CONFIG_MMU */
 
-- 
2.17.1

