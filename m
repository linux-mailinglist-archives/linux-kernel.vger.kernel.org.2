Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFD13F7190
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhHYJSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:18:11 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15213 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbhHYJSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:18:09 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GvgN03z70z1DDJf;
        Wed, 25 Aug 2021 17:16:48 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 17:17:21 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 17:17:21 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/4] ARM: mm: Provide is_write_fault()
Date:   Wed, 25 Aug 2021 17:21:14 +0800
Message-ID: <20210825092116.149975-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210825092116.149975-1-wangkefeng.wang@huawei.com>
References: <20210825092116.149975-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function will check whether the fault is caused by a write access.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mm/fault.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index bc8779d54a64..f7ab6dabe89f 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -207,6 +207,11 @@ static inline bool is_permission_fault(unsigned int fsr)
 	return false;
 }
 
+static inline bool is_write_fault(unsigned int fsr)
+{
+	return (fsr & FSR_WRITE) && !(fsr & FSR_CM);
+}
+
 static vm_fault_t __kprobes
 __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int flags,
 		unsigned long vma_flags, struct pt_regs *regs)
@@ -261,7 +266,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 
-	if ((fsr & FSR_WRITE) && !(fsr & FSR_CM)) {
+	if (is_write_fault(fsr)) {
 		flags |= FAULT_FLAG_WRITE;
 		vm_flags = VM_WRITE;
 	}
-- 
2.26.2

