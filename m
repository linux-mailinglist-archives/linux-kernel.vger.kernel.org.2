Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909144457AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhKDQ7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhKDQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:59:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66911C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RqmJSWbS4BAG5HqGahrH4fgegjzrpuMGcapPmmb/yEQ=; b=mbID8pZKOnFlwEEklRo5H+ES8y
        oF2ec+E4u+iL+CTaMgcpjRVbqgn/Xkgj0h/3HfkIPwBuMguh3VazeK2L4W8SRPy7T2Ev0fPSrWH1y
        ub+5eOZqUgfqcmYeTfnpQfcbWI2LdP382y6N9igPkNilgrQOEUxMUMvae79fFWm/2rUCjhWYXvuO/
        ruQhlZwLqav39NoqNz0euhpPph7hol8H9TOSoWND+UYY+p9SqmgsV8RBsWr+lMcAolS/4pOMFUe+z
        nLC5Iub8HItVdtvtz092+QC+QqZSzjl+kdOKHXaRDheSdPHMOQdCF//aPHbjOz3K9tU+OJV5DytTm
        qqmPHb/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2Z-00EC8N-5j; Thu, 04 Nov 2021 16:56:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D867302A0E;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5CDCA2DD49FB7; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104165525.648351842@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 19/22] x86,usercopy_32: Simplify..
References: <20211104164729.226550532@infradead.org>
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


