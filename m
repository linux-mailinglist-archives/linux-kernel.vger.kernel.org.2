Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6453A315D6A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbhBJChu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:37:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235236AbhBJCec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:34:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CBB964E4F;
        Wed, 10 Feb 2021 02:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612924430;
        bh=pxRvt0tsVaEuuk2qoLNHxBo/G7OEcqiXIfY7y7MzhWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RxXy1/kKWVHC3c9/4U5f+o4auHqMfsjhjj4/7fNQSUmxqE5CFGwEx0IahtuK0GwID
         Jp5NVbGGv8SqkojdNv+41XMDODuLEzAoSHx4Ia1RlODTWLOrU07KTccc2oNw4fw+qD
         43KnI9dMCJUFU6LXakdlgHJusTiEiygWlQYkdq4i55jsP1dkI732W3Ssx84SxTPjLF
         6BUy3VYtSNHaEPhvYL3YxcHkC0JqkFU00IIOZSzEwsBmNsK0kAPb2mEVEGYjjqF3Qv
         SKqBJGYTKXnB2VbJMz5il19EM4m49qSH3lm2G3Jr4DppHPDn9MwkirZs7viUWnmYbj
         z150x8QMlitew==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 02/14] x86/fault: Skip the AMD erratum #91 workaround on unaffected CPUs
Date:   Tue,  9 Feb 2021 18:33:34 -0800
Message-Id: <477173b7784bc28afb3e53d76ae5ef143917e8dd.1612924255.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612924255.git.luto@kernel.org>
References: <cover.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Revision Guide for AMD Athlon™ 64 and AMD Opteron™
Processors, only early revisions of family 0xF are affected.  This will
avoid unnecessarily fetching instruction bytes before sending SIGSEGV to
user programs.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 441c3e9b8971..818902b08c52 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -106,6 +106,15 @@ check_prefetch_opcode(struct pt_regs *regs, unsigned char *instr,
 	}
 }
 
+static bool is_amd_k8_pre_npt(void)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+
+	return unlikely(IS_ENABLED(CONFIG_CPU_SUP_AMD) &&
+			c->x86_vendor == X86_VENDOR_AMD &&
+			c->x86 == 0xf && c->x86_model < 0x40);
+}
+
 static int
 is_prefetch(struct pt_regs *regs, unsigned long error_code, unsigned long addr)
 {
@@ -113,6 +122,10 @@ is_prefetch(struct pt_regs *regs, unsigned long error_code, unsigned long addr)
 	unsigned char *instr;
 	int prefetch = 0;
 
+	/* Erratum #91 affects AMD K8, pre-NPT CPUs */
+	if (!is_amd_k8_pre_npt())
+		return 0;
+
 	/*
 	 * If it was a exec (instruction fetch) fault on NX page, then
 	 * do not ignore the fault:
-- 
2.29.2

