Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855F430D979
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhBCMFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbhBCMF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:05:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641FEC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=vb7kl+r70zVcwHQA3nPHUw9qBZRW9PptA8ud8I52zrA=; b=S9OKT3dmKdMPdP3DHxpChg7LmZ
        nb+MDWU+dTtcPTmPeiHbRFHCnclRFXJa9dlRL6Nx5UIxiZ46vyyq8LZP7KVq0iL+pdH80a0Q1j00d
        vTLOg3pLTVH541rjfXieVkNVVHu2tzNml3/nTUsdYhjqWNZw3lyTce5Yc8HABEh8a5LoDBcQbouDm
        KPwXFJpEDaxasMVs+Cp9LUP+YFvxOXgzyCTQOPtuxmiyMpxbXm1JuHRUB1KG4CDL1vAikf2As/8AC
        OlUy5wSbzWPlTkZr02t9fp3fAw6pOi64ZNkXgnUO/MMlmDavNoJjt0WBNFZjg9CSkSnnkSQUe5P0M
        KdYYKCIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7Gtl-0007gw-Jd; Wed, 03 Feb 2021 12:04:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6CB0B305C1C;
        Wed,  3 Feb 2021 13:04:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5ABCB2BD45B6E; Wed,  3 Feb 2021 13:04:40 +0100 (CET)
Message-ID: <20210203120401.200627050@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Feb 2021 13:02:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 3/5] objtool: Prepare for scratch regs
References: <20210203120222.451068583@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce __save_reg() which allows using the
!arch_callee_saved_reg()s and make sure they're wiped after every
stack op so they don't linger, allow for a single op exception so they
can be used on the very next stack-op.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1775,15 +1775,20 @@ static int update_cfi_state_regs(struct
 	return 0;
 }
 
-static void save_reg(struct cfi_state *cfi, unsigned char reg, int base, int offset)
+static void __save_reg(struct cfi_state *cfi, unsigned char reg, int base, int offset)
 {
-	if (arch_callee_saved_reg(reg) &&
-	    cfi->regs[reg].base == CFI_UNDEFINED) {
+	if (cfi->regs[reg].base == CFI_UNDEFINED) {
 		cfi->regs[reg].base = base;
 		cfi->regs[reg].offset = offset;
 	}
 }
 
+static void save_reg(struct cfi_state *cfi, unsigned char reg, int base, int offset)
+{
+	if (arch_callee_saved_reg(reg))
+		__save_reg(cfi, reg, base, offset);
+}
+
 static void restore_reg(struct cfi_state *cfi, unsigned char reg)
 {
 	cfi->regs[reg].base = initial_func_cfi.regs[reg].base;
@@ -1848,6 +1853,7 @@ static int update_cfi_state(struct instr
 {
 	struct cfi_reg *cfa = &cfi->cfa;
 	struct cfi_reg *regs = cfi->regs;
+	bool skip_wipe = false;
 
 	/* stack operations don't make sense with an undefined CFA */
 	if (cfa->base == CFI_UNDEFINED) {
@@ -2192,6 +2198,21 @@ static int update_cfi_state(struct instr
 		return -1;
 	}
 
+	/*
+	 * Only callee saved registers are preserved; the rest is scratch space
+	 * preserved at most one instruction.
+	 */
+	if (!skip_wipe) {
+		int i;
+
+		for (i = 0; i < CFI_NUM_REGS; i++) {
+			if (arch_callee_saved_reg(i))
+				continue;
+
+			restore_reg(cfi, i);
+		}
+	}
+
 	return 0;
 }
 


