Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D49532D8DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbhCDRqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbhCDRo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:44:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55883C0613D7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:42:58 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f5900f7833063514d8659.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:f783:3063:514d:8659])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E11111EC04E2;
        Thu,  4 Mar 2021 18:42:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614879777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8F4dFmJaJgP31TleGCXlkiVgHt5KnRoVyOa1IqQ26Do=;
        b=NeHcgyCJJgLL3JCfR8knOM1ZTXiqkzi9gX6b3e5Gy+nKkm8L8tvCW3V2M96sOyKm5pJlE6
        VS803FozKkohK2IkyB9R7Q0PcfIVG+Cs///KkNuPvy3L9QyHgTzkS9GDv/di3WoZGXJME9
        v2l+9WXplR5uf7sMVV0LsDr56EkVPfo=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 11/21] x86/kprobes: Convert to insn_decode()
Date:   Thu,  4 Mar 2021 18:42:27 +0100
Message-Id: <20210304174237.31945-12-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304174237.31945-1-bp@alien8.de>
References: <20210304174237.31945-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Simplify code, improve decoding error checking.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 17 +++++++++++------
 arch/x86/kernel/kprobes/opt.c  |  9 +++++++--
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index df776cdca327..60a540fcbd56 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -265,6 +265,8 @@ static int can_probe(unsigned long paddr)
 	/* Decode instructions */
 	addr = paddr - offset;
 	while (addr < paddr) {
+		int ret;
+
 		/*
 		 * Check if the instruction has been modified by another
 		 * kprobe, in which case we replace the breakpoint by the
@@ -276,8 +278,10 @@ static int can_probe(unsigned long paddr)
 		__addr = recover_probed_instruction(buf, addr);
 		if (!__addr)
 			return 0;
-		kernel_insn_init(&insn, (void *)__addr, MAX_INSN_SIZE);
-		insn_get_length(&insn);
+
+		ret = insn_decode(&insn, (void *)__addr, MAX_INSN_SIZE, INSN_MODE_KERN);
+		if (ret < 0)
+			return 0;
 
 		/*
 		 * Another debugging subsystem might insert this breakpoint.
@@ -301,8 +305,8 @@ static int can_probe(unsigned long paddr)
 int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 {
 	kprobe_opcode_t buf[MAX_INSN_SIZE];
-	unsigned long recovered_insn =
-		recover_probed_instruction(buf, (unsigned long)src);
+	unsigned long recovered_insn = recover_probed_instruction(buf, (unsigned long)src);
+	int ret;
 
 	if (!recovered_insn || !insn)
 		return 0;
@@ -312,8 +316,9 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 			MAX_INSN_SIZE))
 		return 0;
 
-	kernel_insn_init(insn, dest, MAX_INSN_SIZE);
-	insn_get_length(insn);
+	ret = insn_decode(insn, dest, MAX_INSN_SIZE, INSN_MODE_KERN);
+	if (ret < 0)
+		return 0;
 
 	/* We can not probe force emulate prefixed instruction */
 	if (insn_has_emulate_prefix(insn))
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 08eb23074f92..4299fc865732 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -312,6 +312,8 @@ static int can_optimize(unsigned long paddr)
 	addr = paddr - offset;
 	while (addr < paddr - offset + size) { /* Decode until function end */
 		unsigned long recovered_insn;
+		int ret;
+
 		if (search_exception_tables(addr))
 			/*
 			 * Since some fixup code will jumps into this function,
@@ -321,8 +323,11 @@ static int can_optimize(unsigned long paddr)
 		recovered_insn = recover_probed_instruction(buf, addr);
 		if (!recovered_insn)
 			return 0;
-		kernel_insn_init(&insn, (void *)recovered_insn, MAX_INSN_SIZE);
-		insn_get_length(&insn);
+
+		ret = insn_decode(&insn, (void *)recovered_insn, MAX_INSN_SIZE, INSN_MODE_KERN);
+		if (ret < 0)
+			return 0;
+
 		/*
 		 * In the case of detecting unknown breakpoint, this could be
 		 * a padding INT3 between functions. Let's check that all the
-- 
2.29.2

