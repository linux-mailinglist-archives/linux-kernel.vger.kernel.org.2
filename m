Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4B4396C07
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 06:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhFAESY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 00:18:24 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3362 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhFAESX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 00:18:23 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FvJfd6t4gz630D;
        Tue,  1 Jun 2021 12:12:57 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 12:16:35 +0800
Received: from SWX921481.china.huawei.com (10.126.201.217) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 1 Jun 2021 12:16:32 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <hpa@zytor.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] x86/kprobes: remove free_insn_page since it is same with the common weak function
Date:   Tue, 1 Jun 2021 16:08:56 +1200
Message-ID: <20210601040856.22080-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.217]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggemi761-chm.china.huawei.com (10.1.198.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_insn_page() in x86 is same with the common weak function in
kernel/kprobes.c. Plus, its comment "Recover page to RW mode before
releasing it" seems insensible to be there since resetting mapping
is done by common code in vfree() of module_memfree().
So drop the strong function and its comment in x86 totally.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 arch/x86/kernel/kprobes/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index d3d65545cb8b..3bce67d3a03c 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -422,12 +422,6 @@ void *alloc_insn_page(void)
 	return page;
 }
 
-/* Recover page to RW mode before releasing it */
-void free_insn_page(void *page)
-{
-	module_memfree(page);
-}
-
 /* Kprobe x86 instruction emulation - only regs->ip or IF flag modifiers */
 
 static void kprobe_emulate_ifmodifiers(struct kprobe *p, struct pt_regs *regs)
-- 
2.25.1

