Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BE64467B2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbhKERWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhKERWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:22:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCC8C061208
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=jAkK58oLPAPMnBzy4dD+5+Rq3oK4YG8zOxnq5TC7IR8=; b=psb7XbqFZ/G+Xa++Hu3QZEuQkS
        Pn7gCZeDfJrhJXs2k9zjaJJjcn6XrZ54CpX2SZMHHn+ExHL9gcrmVc8DvQQlPXoHSuDKsOhaQUElT
        y8fVsKPkspBUFoVZVJTlD7mOKIWkHGK7q26rLsJ+oHGrK92OwWTriR25kaHla5l0s7PtRjP4Xtf6I
        xFUH5/fw3XQjohJlD/aFKaBMseiDtP25+TrOq9PhVOb6ha/gptr+GcF0MBAa4GdLtSikPr5y4tynb
        I5+r3kSx9JPr71/d88s6VuhnGlI5LrP7HyfgvjHWjP/1W05sMcNgDgW4nN6rHchJCFIyDxB0dlTh9
        ascrrfTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sY-00ENAU-Gl; Fri, 05 Nov 2021 17:19:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF7D9300950;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 49448201C7B52; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171820.748630606@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 05/22] x86,entry_64: Remove .fixup usage
References: <20211105171023.989862879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Place the anonymous .fixup code at the tail of the regular functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -735,13 +735,9 @@ SYM_FUNC_START(asm_load_gs_index)
 	swapgs
 	FRAME_END
 	ret
-SYM_FUNC_END(asm_load_gs_index)
-EXPORT_SYMBOL(asm_load_gs_index)
 
-	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
-	.section .fixup, "ax"
 	/* running with kernelgs */
-SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
+.Lbad_gs:
 	swapgs					/* switch back to user gs */
 .macro ZAP_GS
 	/* This can't be a string because the preprocessor needs to see it. */
@@ -752,8 +748,11 @@ SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
 	xorl	%eax, %eax
 	movl	%eax, %gs
 	jmp	2b
-SYM_CODE_END(.Lbad_gs)
-	.previous
+
+	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
+
+SYM_FUNC_END(asm_load_gs_index)
+EXPORT_SYMBOL(asm_load_gs_index)
 
 #ifdef CONFIG_XEN_PV
 /*


