Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E465742CCB0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhJMVWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhJMVWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:22:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A43C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8n2bxVvejAFsktDXqZWXVisMVWh608OCO+sO8EhVJOA=; b=WREqjZBchw09LZIcK+QYFo5o8r
        imgdC38qsZ7FaPF6Y0GlJpq1JNwlddLpT1MQ2pOceTYDPJ/PtovJ449IBlw+eBGeUKFQKW/AoRs36
        Um109Ua70VSOJ6/fu/p+Sse/SG2dcoVTtBN255myTexP4v/IZsv+8Hrg+xKjswipG/M4p0dOLs4aF
        0T6f5G2PgZERWRs9fStXyoiG7GtrrF/gbmt2DwfWlgJ0BTCHgCrNTxhxp0rP8YFrRGJwNzMiSXbou
        PzF26RSu9MdGbkAbjTCh/xe9WkGvvm3pPabwen+Lw6mn/c5OC5sYtW4ZMLt9DXA3MQg23QBdiwUxc
        CqlyR6yg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1malfP-009fy1-BZ; Wed, 13 Oct 2021 21:20:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F42330026A;
        Wed, 13 Oct 2021 23:20:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5904C2D1ECE95; Wed, 13 Oct 2021 23:20:02 +0200 (CEST)
Date:   Wed, 13 Oct 2021 23:20:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <YWdNgt47MhYTttux@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <20211013203927.zbruy2ux7dug6ljk@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013203927.zbruy2ux7dug6ljk@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 01:39:27PM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 13, 2021 at 02:22:21PM +0200, Peter Zijlstra wrote:
> > +static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
> > +{
> > +	void (*target)(void);
> > +	int reg, i = 0;
> > +
> > +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> > +		return -1;
> 
> Better to do this check further up the call stack in apply_retpolines()
> before looping through all the call sites?

In fact, I've pushed it further down, in order to always validate the
absense of rsp.

> > +
> > +	target = addr + insn->length + insn->immediate.value;
> > +	reg = (target - &__x86_indirect_thunk_rax) /
> > +	      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);
> > +
> > +	if (WARN_ON_ONCE(reg & ~0xf))
> > +		return -1;
> 
> It would be more robust and less magical to just have a basic lookup
> table array which converts a thunk address to a reg.  Then you can just
> avoid all the safety checks because it's no longer insane ;-)

Andrew suggested the reverse lookup to validate. That should give the
same robustness but lacks the linear lookup.

---
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -392,6 +392,12 @@ static int emit_indirect(int op, int reg
  */
 static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 {
+	static const void *reg_to_thunk[] = {
+#undef GEN
+#define GEN(reg) &__x86_indirect_thunk_ ## reg,
+#include <asm/GEN-for-each-reg.h>
+	};
+
 	void (*target)(void);
 	int reg, i = 0;
 
@@ -402,6 +408,8 @@ static int patch_retpoline(void *addr, s
 	if (WARN_ON_ONCE(reg & ~0xf))
 		return -1;
 
+	BUG_ON(target != reg_to_thunk[reg]);
+
 	/*
 	 * If anyone ever does: CALL/JMP *%rsp, we're in deep trouble.
 	 */
