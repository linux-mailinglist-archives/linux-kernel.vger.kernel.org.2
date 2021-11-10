Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8A744BE69
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhKJKTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhKJKTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB37C06127A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=jAkK58oLPAPMnBzy4dD+5+Rq3oK4YG8zOxnq5TC7IR8=; b=OyIRQ3TuwjmwMF4Qh9fY0o4gQZ
        u0uos0+zlWGs5decil2/1dQpY8kJ9dtUfAY2Z6jnCGwrS0yneRfBuA2wuPkHsuxuo0uyNbNhx6mgk
        nGqqmCBzGmtKswScvIHa050l2w5YGPkI80qZjQXcdqplMjWyvztjdyUFwDOKv6g4eOeiiXYaweU/O
        wBOtov6Eic9c/Gj7XXfMyH5KJlnDozCzVIydGRUF0qCNjKTXcqf5mFzKvMf2WAf5+zzQm7J6rZTvi
        PdO7eb4RH+Bu5xaEyJY9S95c9P+6+g8kR/AIsSnynpL2+mOWDrsl+yLWk1mCKCdw9YJo3ZhkeHJVd
        SL7/H89A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeG-00FFpd-9F; Wed, 10 Nov 2021 10:16:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC807300ECB;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6BBF9203BF7FB; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101325.186049322@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 05/23] x86,entry_64: Remove .fixup usage
References: <20211110100102.250793167@infradead.org>
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


