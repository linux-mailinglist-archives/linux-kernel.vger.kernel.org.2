Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154A230D978
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhBCMFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbhBCMF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:05:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6314BC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=nktg3rHJS0akn6VJaCyKq7LBpyGGub1o0Ww2UYWsFxc=; b=BJOnxNylJJw+zI4fPCj8KwDf8x
        4VVO1+uvlDZBbViPml/09Fu7SjgSVG1pvWb+oMPfrY1ZkcukS57Y5cRh68t/ImsmV6OsTVtlC/T+O
        EAvyZ96rmq7dvSewkwR6AdzqxfNlGHMHuzcLh28YrIndQxb1FBCoH7S2xnWZxRKUHojAXCZO3Fuqk
        x32RY/XRQeNaUXyfDXByBge0m78vSdYY2sQehEcVERw+Q90SHM3T8h6ugQ/YSwbF0dr35mJ5kD8HD
        Pyxgh4kpR8saoDpj0gqjJaShmp23pwzpHYwj0O9U3/So45uKDw+GqiE4pq2MURS7josIdfJIvhCgE
        7h+bVCfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7Gtl-0007gu-IM; Wed, 03 Feb 2021 12:04:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 63F27301179;
        Wed,  3 Feb 2021 13:04:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 500002BD45B69; Wed,  3 Feb 2021 13:04:40 +0100 (CET)
Message-ID: <20210203120401.062155900@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Feb 2021 13:02:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 1/5] objtool: Change REG_SP_INDIRECT
References: <20210203120222.451068583@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently REG_SP_INDIRECT is unused but means (%rsp + offset),
change it to mean (%rsp) + offset.

This is somewhat unfortunate, since REG_BP_INDIRECT is used (by DRAP)
and thus needs to retain the current (%rbp + offset).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/unwind_orc.c |    5 ++++-
 tools/objtool/orc_dump.c     |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -471,7 +471,7 @@ bool unwind_next_frame(struct unwind_sta
 		break;
 
 	case ORC_REG_SP_INDIRECT:
-		sp = state->sp + orc->sp_offset;
+		sp = state->sp;
 		indirect = true;
 		break;
 
@@ -521,6 +521,9 @@ bool unwind_next_frame(struct unwind_sta
 	if (indirect) {
 		if (!deref_stack_reg(state, sp, &sp))
 			goto err;
+
+		if (orc->sp_reg == ORC_REG_SP_INDIRECT)
+			sp += orc->sp_offset;
 	}
 
 	/* Find IP, SP and possibly regs: */
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -54,7 +54,7 @@ static void print_reg(unsigned int reg,
 	if (reg == ORC_REG_BP_INDIRECT)
 		printf("(bp%+d)", offset);
 	else if (reg == ORC_REG_SP_INDIRECT)
-		printf("(sp%+d)", offset);
+		printf("(sp)%+d", offset);
 	else if (reg == ORC_REG_UNDEFINED)
 		printf("(und)");
 	else


