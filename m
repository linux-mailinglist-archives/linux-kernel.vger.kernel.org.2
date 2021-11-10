Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02B444BE5A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhKJKTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhKJKTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9811C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ntkLV0JwnaiZKgK80tLD5qiEZSWsA+sw7wi17Zbzp+U=; b=D8WXuDl+pSg7hrhFiXKin3IH0R
        9gJyI2FH4pafE0XvchBGeWB7H79oUWdoaO2v/vj7TkFIwwIKH88TBJbTdBK4K0wMCEnAB8rSkS9RU
        ZXLRjODS9NpuQXPG3UmPp1JiXr7gwjM+ix/xMzYo2NsI84Ma6zPrB4/UF+Lkwa7GwtXX5A4ayxBFR
        XvM0C/h++gR3gp1WXQnADcGbbropbHj75v9qjGNphhb32N0F8SNRag76mRpwJokNv2IFwMIXes+3D
        MzrT8jmOAMQBEqasBI1EB8ixH2MgEjM6/MCjWv7wO1N5XpNYuWNQFJCD8I7n6yO29IIaDMiS2VU3C
        DPtts/Mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeG-001lkV-LL; Wed, 10 Nov 2021 10:16:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE99830281E;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A2B27202F85CB; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101325.899657959@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 17/23] x86,checksum_32: Remove .fixup usage
References: <20211110100102.250793167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply add EX_FLAG_CLEAR_AX to do as the .fixup used to do.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/checksum_32.S |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -260,9 +260,9 @@ unsigned int csum_partial_copy_generic (
  * Copy from ds while checksumming, otherwise like csum_partial
  */
 
-#define EXC(y...)			\
-	9999: y;			\
-	_ASM_EXTABLE_UA(9999b, 6001f)
+#define EXC(y...)						\
+	9999: y;						\
+	_ASM_EXTABLE_TYPE(9999b, 7f, EX_TYPE_UACCESS | EX_FLAG_CLEAR_AX)
 
 #ifndef CONFIG_X86_USE_PPRO_CHECKSUM
 
@@ -358,15 +358,6 @@ EXC(	movb %cl, (%edi)	)
 	adcl $0, %eax
 7:
 
-# Exception handler:
-.section .fixup, "ax"							
-
-6001:
-	xorl %eax, %eax
-	jmp 7b
-
-.previous
-
 	popl %ebx
 	popl %esi
 	popl %edi
@@ -439,10 +430,6 @@ EXC(	movb %dl, (%edi)         )
 6:	addl %edx, %eax
 	adcl $0, %eax
 7:
-.section .fixup, "ax"
-6001:	xorl %eax, %eax
-	jmp  7b			
-.previous				
 
 	popl %esi
 	popl %edi


