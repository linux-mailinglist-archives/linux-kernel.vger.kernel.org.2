Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CFC434996
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhJTLDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJTLDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:03:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C9BC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=sSPpIlnxeithq5XeNgDPv1cvgvuq9BxShsfXpWZBIeQ=; b=Xbt8GPklJhaHVX41B+FFYiL+88
        Lo92Y+M8/sabzPmvoSEcQdoit4t93mRrsIWsgMW0eBIJGLxjayWE0WAdNUPXQERhLI1yA9adF+cFr
        +hHAsWbF/CNHbBskj/hYQKoOmCvsm3pPszFDre3UaYvE9v9BRnBeBegO8+IWfxiPY7C26du0QZjSe
        tRkhNCGlOSzXT8oo8KXFG1VkHS6BfBjslmKHj6mE8XBJJ6+Z+PG7oGC6wjpIRym61gY1c+mcWOL86
        NU0i7NZVQa7T0gmienQjzoZAX6x/9jDUrXdutZ67yujP2TM9zt1OCxu4f4m81NJLlqN99GDXA9dm1
        WaAbcVLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md9L1-00Aw17-H7; Wed, 20 Oct 2021 11:00:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 282A930077D;
        Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EEBFA201BB3CB; Wed, 20 Oct 2021 13:00:49 +0200 (CEST)
Message-ID: <20211020105842.859476776@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 20 Oct 2021 12:44:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH v2 06/14] x86/asm: Fix register order
References: <20211020104442.021802560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure the register order is correct; this allows for easy translation
between register number and trampoline and vice-versa.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/GEN-for-each-reg.h |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/GEN-for-each-reg.h
+++ b/arch/x86/include/asm/GEN-for-each-reg.h
@@ -1,11 +1,15 @@
+/*
+ * These are in machine order; things rely on that.
+ */
 #ifdef CONFIG_64BIT
 GEN(rax)
-GEN(rbx)
 GEN(rcx)
 GEN(rdx)
+GEN(rbx)
+GEN(rsp)
+GEN(rbp)
 GEN(rsi)
 GEN(rdi)
-GEN(rbp)
 GEN(r8)
 GEN(r9)
 GEN(r10)
@@ -16,10 +20,11 @@ GEN(r14)
 GEN(r15)
 #else
 GEN(eax)
-GEN(ebx)
 GEN(ecx)
 GEN(edx)
+GEN(ebx)
+GEN(esp)
+GEN(ebp)
 GEN(esi)
 GEN(edi)
-GEN(ebp)
 #endif


