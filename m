Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016EE30D97A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhBCMFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbhBCMF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:05:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEE7C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+bvaNR9JprD0bCLqTgFyKWOCyenQTp554Cpjg7oiXd8=; b=BzofkuWSV8ZTZFR3jEYrn663Yx
        IynhgnuiUkKY1swRUE4lR+UIKaXlqUq76wT3+O6HRBcW6X61WRqZyRYp/XTZ+dMg0Vt6xhPV2WCqf
        NtMv5/LuWFuWAoxUzVZdJaz2FRe3mEXuU2c/xp+I3+U+b3UZasIhiBL7TTr9zSewxbNdyk5phESua
        1Zq/ZFE3rrXV4Z2tqgMIDS98bxClrnS/p9nd5AReAYNlswzpaNtbzCkMRBLoKtU2TZhhmVotTa98T
        XVXupFh97arP3ivfvGnZiZMOcLOdAHnJBDS/RdDhMmpD7wAL1CNozdAo/W+xXbgFHOr65QtW+uYnk
        ogR1+Y/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7Gtl-0007gv-Iu; Wed, 03 Feb 2021 12:04:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67B3C3059DD;
        Wed,  3 Feb 2021 13:04:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 550992BD45B6A; Wed,  3 Feb 2021 13:04:40 +0100 (CET)
Message-ID: <20210203120401.134132370@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Feb 2021 13:02:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 2/5] objtool: More consistent use of arch_callee_saved_reg()
References: <20210203120222.451068583@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since save_regs() will only ever set a reg when it is
arch_callee_saved_reg() all the other regs will always be unused and
are effectively scratch space.

No point in comparing them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1725,6 +1725,9 @@ static bool has_modified_stack_frame(str
 		return false;
 
 	for (i = 0; i < CFI_NUM_REGS; i++) {
+		if (!arch_callee_saved_reg(i))
+			continue;
+
 		if (cfi->regs[i].base != initial_func_cfi.regs[i].base ||
 		    cfi->regs[i].offset != initial_func_cfi.regs[i].offset)
 			return true;
@@ -2248,6 +2251,9 @@ static bool insn_cfi_match(struct instru
 
 	} else if (memcmp(&cfi1->regs, &cfi2->regs, sizeof(cfi1->regs))) {
 		for (i = 0; i < CFI_NUM_REGS; i++) {
+			if (!arch_callee_saved_reg(i))
+				continue;
+
 			if (!memcmp(&cfi1->regs[i], &cfi2->regs[i],
 				    sizeof(struct cfi_reg)))
 				continue;


