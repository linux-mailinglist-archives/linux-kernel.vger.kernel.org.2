Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3F631EF2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhBRTFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbhBRR3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:29:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758B2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YEInAX1TNsWLHLuKB9znbZuL4BCWo/ES66gUmiHDjkc=; b=vn4N/Tppv+FbRAmhhWqjTcOvoA
        wdDHNQFzXedToiTfjwwcv5aBXR76AydbTEBvLsjlbbhpePgajlyyZPtV6F01P9zqgl4XsOZ6MEB6G
        6swu9ssKyosBfRoLW/gMUZjSzpJQwrBMljGB1RL8TPxJcxYSK8Q44TVLx1sMjrZQkqlLhX0BXhpud
        yBVJHy7nwxLIv3FPwuDucRq6mAFpyfRUea1e/8BH24mz20rU7nc10MCqi09zK3YJUPjn8RyzGhcyX
        F0DpHMVH4xIFcmLd4xIJsZ99Nau2B8TP4KJiu7efpiaGQ9ROqownDL0lh7c3hUaAAvSqPvrb18SDe
        sZLIFNTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lCn3U-001uKA-BM; Thu, 18 Feb 2021 17:25:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA0B2305C22;
        Thu, 18 Feb 2021 18:25:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 98515202549DD; Thu, 18 Feb 2021 18:25:29 +0100 (CET)
Message-ID: <20210218172151.942060087@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Feb 2021 17:59:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, tony.luck@intel.com, pjt@google.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        r.marek@assembler.cz, jpoimboe@redhat.com, jikos@kernel.org
Subject: [RFC][PATCH 2/2] x86/retpoline: Compress retpolines
References: <20210218165938.213678824@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using int3 as a speculation fence instead of lfence, we can shrink
the longest alternative to just 15 bytes:

  0:   e8 05 00 00 00          callq  a <.altinstr_replacement+0xa>
  5:   f3 90                   pause  
  7:   cc                      int3   
  8:   eb fb                   jmp    5 <.altinstr_replacement+0x5>
  a:   48 89 04 24             mov    %rax,(%rsp)
  e:   c3                      retq   

This means we can change the alignment from 32 to 16 bytes and get 4
retpolines per cacheline, $I win.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/retpoline.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -16,7 +16,7 @@
 .Lspec_trap_\@:
 	UNWIND_HINT_EMPTY
 	pause
-	lfence
+	int3
 	jmp .Lspec_trap_\@
 .Ldo_rop_\@:
 	mov     %\reg, (%_ASM_SP)
@@ -27,7 +27,7 @@
 .macro THUNK reg
 	.section .text.__x86.indirect_thunk
 
-	.align 32
+	.align 16
 SYM_FUNC_START(__x86_indirect_thunk_\reg)
 
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \


