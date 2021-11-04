Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF02C4457CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhKDRD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbhKDRDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:03:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62E5C06120A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=jAkK58oLPAPMnBzy4dD+5+Rq3oK4YG8zOxnq5TC7IR8=; b=hvfv6w0LgRdXbOw5Ue6p6K2NPF
        TzSS6LV0OF0OCEhmH3ojQKhzwsIy0ZHXWp8Ki7pHfyUzMc1GHzxt8Da38PgLE00Su9/gYwnRpdkC1
        LVDCObNbWytLqf3oklyBoiscITOiQflqlv/XG9AO8bQbJRcKUK5PFwKHYP5SMTvmdUrD1o7RV2Q6Y
        2GS8WcGTiWFGexKDyjQvZXgQ0HujLBc2CrOI0hUm2j+uKboMlrxjPva9j/t9+JlLHytdscocp4+9B
        GWSIimLPH8qBySPe+al6CLWT2ph4vY1w69+XrAXOPdr0Ng2kZLawVUH401yyI+g2T5l/yp/rgM2NM
        qlI8UNeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2W-0060FI-MH; Thu, 04 Nov 2021 16:57:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5043130072B;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2255E2DD49FB8; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104165524.805412176@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 05/22] x86,entry_64: Remove .fixup usage
References: <20211104164729.226550532@infradead.org>
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


