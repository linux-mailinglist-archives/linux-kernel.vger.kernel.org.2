Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B664342C03A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhJMMmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhJMMm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:42:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F241DC061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=G+HVWoPX110ZJYpRLM+sKTpyBmxdCKkz/F6ltupv6FQ=; b=pxFQQaIYmh07y3BbSKEb7bpmhJ
        FHHOzqzy2bHv5USeAuG8qqfcqQVXMivoFH+XOMjr1mbkbKPB/FsBi/P8AkE57WT1se3Pa9ZYS+Q/H
        doCDdRcbf2npVgIB5cE3mFHY1x4F7HBUGTCRJ6mGMJT80a0gaySKl3DoXCDdy6Ztxru0pyvkhFl6k
        OFt9rZomsFpgWrlHRuQRt3sbgX0KmDsfWBuRAcOrr9ci5z/EW3SEyebqXLF7VynjBQBGqgPMB4PZy
        7RltXr0ZoY2lPqo6LnTbIVaKjaUt4i+qbBwuonrSmAXrBbvmsboSBzt5iwH3IONxZ0UY9Hm/I6j6+
        lHTV54yg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1madYM-009bnp-E0; Wed, 13 Oct 2021 12:40:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D5A7D3005CB;
        Wed, 13 Oct 2021 14:40:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B07B12083A884; Wed, 13 Oct 2021 14:40:13 +0200 (CEST)
Message-ID: <20211013123644.882036544@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 13 Oct 2021 14:22:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH 3/9] x86/asm: Fix register order
References: <20211013122217.304265366@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure the register order is correct; this allows for easy translation
between register number and trampoline and vice-versa.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/GEN-for-each-reg.h |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/GEN-for-each-reg.h
+++ b/arch/x86/include/asm/GEN-for-each-reg.h
@@ -1,11 +1,12 @@
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
@@ -16,10 +17,11 @@ GEN(r14)
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


