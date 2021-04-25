Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7E36A96D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 23:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhDYVPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 17:15:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:19384 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231207AbhDYVPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 17:15:18 -0400
IronPort-SDR: TdsI7wFLIeihIn8whtuO05w0H59Uac6RzQuiFCg37EE9JcsWDxp3GJX2FCg8Jo5zuRx8ebch46
 qUyVwcUk3aEA==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="183389561"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="183389561"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 14:14:38 -0700
IronPort-SDR: 3lri++PEimlFXLU6xrKjmpjm1WLysVjZzSX5kbm0infzdj+ZDc1jBN4Inf71CkQn1lHIS9QTta
 sYRAWR7IdHNw==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="402698384"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 14:14:38 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>
Subject: [PATCH] x86/msr: Make prototypes match header files
Date:   Sun, 25 Apr 2021 14:14:29 -0700
Message-Id: <20210425211429.3157952-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <andi@firstfloor.org>

gcc 11 complains when arrays in prototypes do not match the function.
Fix two occurrences here.

Signed-off-by: Andi Kleen <andi@firstfloor.org>
---
 arch/x86/lib/msr-smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 75a0915b0d01..40bbe56bde32 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -252,7 +252,7 @@ static void __wrmsr_safe_regs_on_cpu(void *info)
 	rv->err = wrmsr_safe_regs(rv->regs);
 }
 
-int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 *regs)
+int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8])
 {
 	int err;
 	struct msr_regs_info rv;
@@ -265,7 +265,7 @@ int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 *regs)
 }
 EXPORT_SYMBOL(rdmsr_safe_regs_on_cpu);
 
-int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 *regs)
+int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8])
 {
 	int err;
 	struct msr_regs_info rv;
-- 
2.25.4

