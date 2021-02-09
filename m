Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD77314BEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBIJlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhBIJhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:37:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FA4C06178C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 01:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=1P4P/cy29drlxxc3ppbwCj3ikbdl1jvZEDjD5fv13Uc=; b=JHXRt0ZCMNs1mgx8AHvdPeLEOo
        3iazgUU8QRMHWgUoiDj23YIksOE8m1U6IYPNYhmrsfpw58UGOqrcnum9ippzhJZl40yNnXduoYf+y
        23BCEyrXlJ1yDQ+wpIk9KmYy87QC6EwEoV12EYcSxKk5qcr70y5ymNCm8nNpexI/TkmdisY45WsHz
        a7vvnmg511GBLaiRcqaHxzcQ+XwgR29gRyALfwleyITIycZBlsnMnumzd1F4Q8/G1EyeeEh8NoFb/
        Y0ZqLypdt+2eBjnWcdnBI1nNFqbqX8ivgxQAupYRd2klypGkEwelKnEP305gVCYLV69w9I3KnRSnk
        46N2udLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l9PRc-007F7O-47; Tue, 09 Feb 2021 09:36:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 824B6304BAE;
        Tue,  9 Feb 2021 10:36:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 68D092040C5A5; Tue,  9 Feb 2021 10:36:25 +0100 (CET)
Message-ID: <20210209093521.847687811@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 09 Feb 2021 10:16:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 1/3] x86/unwind/orc: Change REG_SP_INDIRECT
References: <20210209091600.075402197@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently REG_SP_INDIRECT is unused but means (%rsp + offset),
change it to mean (%rsp) + offset.

The reason is that we're going to swizzle stack in the middle of a C
function with non-trivial stack footprint. This means that when the
unwinder finds the ToS, it needs to dereference it (%rsp) and then add
the offset to the next frame, resulting in: (%rsp) + offset

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


