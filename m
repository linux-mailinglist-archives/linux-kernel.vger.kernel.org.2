Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A1F44BE6E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhKJKUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhKJKTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43E0C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RqmJSWbS4BAG5HqGahrH4fgegjzrpuMGcapPmmb/yEQ=; b=rPjaV4GuxVeKF43aBYQEckIgaP
        9M+Tl6pFDjOgFOMYqp3f7CAXrZ1hLoyxFC9algZ3sSJiCG1Q1hXZEFp9A2xbuwh9/bS83RbA+Ir7D
        0pR9ciCCHVilNsn0iHPZmjC1qHgaEQgF7HR4L+wltqfD+AoSnW13xVPUBmbXz1Fu6qmYxXdiAb1Zq
        gp2yfDYp2MgkNuEITwjqvCn9CPivjjSSLK9XXHEfA2eoh/VnBlavegw1Qj3uSV5SDaOFRhLJHMO4z
        OfA8+y0xR52nhj3SsZ4T0Bcz64gCytoXYvKxdbcqND1cITJNUJp40ikfg0xl/D7Vyh9qzSgmSo+Bv
        9QnX16DA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeH-00FFpy-RV; Wed, 10 Nov 2021 10:16:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1194302A0E;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AD4DD203C8AA9; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101326.021517780@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 19/23] x86,usercopy_32: Simplify __copy_user_intel_nocache()
References: <20211110100102.250793167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have an exception jump to a .fixup to only immediately jump out is
daft, jump to the right place in one go.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/usercopy_32.c |   40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -257,28 +257,28 @@ static unsigned long __copy_user_intel_n
 	       "8:\n"
 	       ".section .fixup,\"ax\"\n"
 	       "9:      lea 0(%%eax,%0,4),%0\n"
-	       "16:     jmp 8b\n"
+	       "        jmp 8b\n"
 	       ".previous\n"
-	       _ASM_EXTABLE_UA(0b, 16b)
-	       _ASM_EXTABLE_UA(1b, 16b)
-	       _ASM_EXTABLE_UA(2b, 16b)
-	       _ASM_EXTABLE_UA(21b, 16b)
-	       _ASM_EXTABLE_UA(3b, 16b)
-	       _ASM_EXTABLE_UA(31b, 16b)
-	       _ASM_EXTABLE_UA(4b, 16b)
-	       _ASM_EXTABLE_UA(41b, 16b)
-	       _ASM_EXTABLE_UA(10b, 16b)
-	       _ASM_EXTABLE_UA(51b, 16b)
-	       _ASM_EXTABLE_UA(11b, 16b)
-	       _ASM_EXTABLE_UA(61b, 16b)
-	       _ASM_EXTABLE_UA(12b, 16b)
-	       _ASM_EXTABLE_UA(71b, 16b)
-	       _ASM_EXTABLE_UA(13b, 16b)
-	       _ASM_EXTABLE_UA(81b, 16b)
-	       _ASM_EXTABLE_UA(14b, 16b)
-	       _ASM_EXTABLE_UA(91b, 16b)
+	       _ASM_EXTABLE_UA(0b, 8b)
+	       _ASM_EXTABLE_UA(1b, 8b)
+	       _ASM_EXTABLE_UA(2b, 8b)
+	       _ASM_EXTABLE_UA(21b, 8b)
+	       _ASM_EXTABLE_UA(3b, 8b)
+	       _ASM_EXTABLE_UA(31b, 8b)
+	       _ASM_EXTABLE_UA(4b, 8b)
+	       _ASM_EXTABLE_UA(41b, 8b)
+	       _ASM_EXTABLE_UA(10b, 8b)
+	       _ASM_EXTABLE_UA(51b, 8b)
+	       _ASM_EXTABLE_UA(11b, 8b)
+	       _ASM_EXTABLE_UA(61b, 8b)
+	       _ASM_EXTABLE_UA(12b, 8b)
+	       _ASM_EXTABLE_UA(71b, 8b)
+	       _ASM_EXTABLE_UA(13b, 8b)
+	       _ASM_EXTABLE_UA(81b, 8b)
+	       _ASM_EXTABLE_UA(14b, 8b)
+	       _ASM_EXTABLE_UA(91b, 8b)
 	       _ASM_EXTABLE_UA(6b, 9b)
-	       _ASM_EXTABLE_UA(7b, 16b)
+	       _ASM_EXTABLE_UA(7b, 8b)
 	       : "=&c"(size), "=&D" (d0), "=&S" (d1)
 	       :  "1"(to), "2"(from), "0"(size)
 	       : "eax", "edx", "memory");


