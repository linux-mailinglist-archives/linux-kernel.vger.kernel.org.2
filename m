Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C934B553
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 09:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhC0IAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 04:00:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14570 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhC0IAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 04:00:11 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6rmB6CZVzPqjx;
        Sat, 27 Mar 2021 15:57:30 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Sat, 27 Mar 2021
 15:59:58 +0800
From:   Shixin Liu <liushixin2@huawei.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Potapenko <glider@google.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
CC:     <kasan-dev@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Shixin Liu <liushixin2@huawei.com>
Subject: [PATCH] arm: 9016/2: Make symbol 'tmp_pmd_table' static
Date:   Sat, 27 Mar 2021 16:30:18 +0800
Message-ID: <20210327083018.1922539-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Symbol 'tmp_pmd_table' is not used outside of kasan_init.c and only used
when CONFIG_ARM_LPAE enabled. So marks it static and add it into CONFIG_ARM_LPAE.

Signed-off-by: Shixin Liu <liushixin2@huawei.com>
---
 arch/arm/mm/kasan_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 9c348042a724..3a06d3b51f97 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -27,7 +27,9 @@
 
 static pgd_t tmp_pgd_table[PTRS_PER_PGD] __initdata __aligned(PGD_SIZE);
 
-pmd_t tmp_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
+#ifdef CONFIG_ARM_LPAE
+static pmd_t tmp_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
+#endif
 
 static __init void *kasan_alloc_block(size_t size)
 {
-- 
2.25.1

