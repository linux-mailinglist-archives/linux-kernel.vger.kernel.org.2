Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3660395423
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 05:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhEaDMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 23:12:19 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2795 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEaDMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 23:12:13 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FtgCh5Sb1zWqmk;
        Mon, 31 May 2021 11:05:52 +0800 (CST)
Received: from dggpemm500012.china.huawei.com (7.185.36.89) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 11:10:31 +0800
Received: from DESKTOP-EFRLNPK.china.huawei.com (10.174.176.189) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 11:10:31 +0800
From:   Qiheng Lin <linqiheng@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>
CC:     <linux-kernel@vger.kernel.org>, Qiheng Lin <linqiheng@huawei.com>
Subject: [PATCH -next] x86/kprobes: functions should not be declared extern
Date:   Mon, 31 May 2021 11:10:09 +0800
Message-ID: <20210531031009.21737-1-linqiheng@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.174.176.189]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function declaration in kprobes.h is already marked extern, thus its
definition should not have the keyword.

This quiets the following sparse warning:
 function 'arch_unoptimize_kprobes' with external linkage has definition

Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
---
 arch/x86/kernel/kprobes/opt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 71425ebba98a..7d962c884505 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -539,8 +539,8 @@ void arch_unoptimize_kprobe(struct optimized_kprobe *op)
  * Recover original instructions and breakpoints from relative jumps.
  * Caller must call with locking kprobe_mutex.
  */
-extern void arch_unoptimize_kprobes(struct list_head *oplist,
-				    struct list_head *done_list)
+void arch_unoptimize_kprobes(struct list_head *oplist,
+			     struct list_head *done_list)
 {
 	struct optimized_kprobe *op, *tmp;
 
-- 
2.31.1

