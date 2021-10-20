Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EF043499D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhJTLDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhJTLDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:03:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242C8C061746
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zcL1XtwLrjmXuW5LKPdyWIq96pq2FPUachkJV48zldc=; b=jv4hrgxyRu0jPXqxp+5/sXqie9
        HIbQ6r3aQodBe86wLHfVc7qGDOu7K6mrQAjOFBitUKfbHPwSI0XgrlGYBO7y8JTBQd2q2Z7s8LJzm
        ck/z4ugU/u0kX+KkkHXqk5MBcr96Yd0TTAka5W/51JzPX4PJ3v+pvkbR/7LUcZZqCiTNqPD7adyja
        YWu1LdjOHjJsL5EgiYj5tVmS4IuWiJ+Ie+gfrVb5rdM9rTud/n7+/gLjyg7HPEEiam4eH2oRZbDig
        H26idSLwQ44yO/+QN+cQV9XSdnGX8RwbB5eLgPMql+CepsbCcq28BqSvJrE7amHIzz9CvTua6wAR6
        kuPbVTgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md9L1-00Aw1B-S9; Wed, 20 Oct 2021 11:00:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28322300792;
        Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 07E88201BB3CE; Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Message-ID: <20211020105842.981215247@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 20 Oct 2021 12:44:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH v2 08/14] x86/retpoline: Create a retpoline thunk array
References: <20211020104442.021802560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stick all the retpolines in a single symbol and have the individual
thunks as inner labels, this should guarantee thunk order and layout.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/retpoline.S |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -30,7 +30,7 @@
 
 	.align 32
 
-SYM_FUNC_START(__x86_indirect_thunk_\reg)
+SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
 
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
 		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
@@ -55,10 +55,16 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 #define __EXPORT_THUNK(sym)	_ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
 #define EXPORT_THUNK(reg)	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
 
+	.align 32
+SYM_CODE_START(__x86_indirect_thunk_array)
+
 #define GEN(reg) THUNK reg
 #include <asm/GEN-for-each-reg.h>
 #undef GEN
 
+	.align 32
+SYM_CODE_END(__x86_indirect_thunk_array)
+
 #define GEN(reg) EXPORT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
 #undef GEN


