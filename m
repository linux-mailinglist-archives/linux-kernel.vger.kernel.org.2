Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A849434FB07
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhCaIAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:00:53 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:50879 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234327AbhCaIAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:00:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UTwL9zf_1617177629;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UTwL9zf_1617177629)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 31 Mar 2021 16:00:29 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] x86/kernel: remove unneeded dead-store initialization
Date:   Wed, 31 Mar 2021 16:00:24 +0800
Message-Id: <1617177624-24670-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make clang-analyzer on x86_64 defconfig caught my attention with:

arch/x86/kernel/cpu/cacheinfo.c:880:24: warning: Value stored to
'this_cpu_ci' during its initialization is never read
[clang-analyzer-deadcode.DeadStores]
struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
^

So, simply remove this unneeded dead-store initialization to make
clang-analyzer happy.

As compilers will detect this unneeded assignment and optimize this anyway,
the resulting object code is identical before and after this change.

No functional change. No change to object code.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/x86/kernel/cpu/cacheinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 3ca9be4..d66af29 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -877,7 +877,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 				    struct _cpuid4_info_regs *base)
 {
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cpu_cacheinfo *this_cpu_ci;
 	struct cacheinfo *this_leaf;
 	int i, sibling;
 
-- 
1.8.3.1

