Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E3B32422C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhBXQeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:34:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234748AbhBXQbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614184191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I38yLyos8nKXeXwG/pZDKWvlhlgiM/lKSNW5bUlm4hQ=;
        b=OAWz/2PtiOEG+AL+1eOHfqycJZAjBvdAiiQavoNnoYjVc0FVAkgiE6yRDIwDfOmr3nmS58
        jIliGXhnxrpkZAzz8b+XGizpg/2u1WLiScF0d+2Cnvn38XEJUdfmCqb1m2kr/v37TpMoWC
        9gTuYUprHLuPUh9qBEaGU3RqauRIr2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-XTKiW_nXPWmbyaYOqBO0Hw-1; Wed, 24 Feb 2021 11:29:49 -0500
X-MC-Unique: XTKiW_nXPWmbyaYOqBO0Hw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D1431936B71;
        Wed, 24 Feb 2021 16:29:47 +0000 (UTC)
Received: from treble.redhat.com (ovpn-118-134.rdu2.redhat.com [10.10.118.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2154460CE7;
        Wed, 24 Feb 2021 16:29:46 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-crypto@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 10/13] x86/crypto/sha512-avx: Standardize stack alignment prologue
Date:   Wed, 24 Feb 2021 10:29:23 -0600
Message-Id: <d36e9ea1c819d87fa89b3df3fa83e2a1ede18146.1614182415.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1614182415.git.jpoimboe@redhat.com>
References: <cover.1614182415.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a more standard prologue for saving the stack pointer before
realigning the stack.

This enables ORC unwinding by allowing objtool to understand the stack
realignment.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/crypto/sha512-avx-asm.S | 41 +++++++++++++++-----------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/crypto/sha512-avx-asm.S b/arch/x86/crypto/sha512-avx-asm.S
index 684d58c8bc4f..3d8f0fd4eea8 100644
--- a/arch/x86/crypto/sha512-avx-asm.S
+++ b/arch/x86/crypto/sha512-avx-asm.S
@@ -76,14 +76,10 @@ tmp0	= %rax
 W_SIZE = 80*8
 # W[t] + K[t] | W[t+1] + K[t+1]
 WK_SIZE = 2*8
-RSPSAVE_SIZE = 1*8
-GPRSAVE_SIZE = 5*8
 
 frame_W = 0
 frame_WK = frame_W + W_SIZE
-frame_RSPSAVE = frame_WK + WK_SIZE
-frame_GPRSAVE = frame_RSPSAVE + RSPSAVE_SIZE
-frame_size = frame_GPRSAVE + GPRSAVE_SIZE
+frame_size = frame_WK + WK_SIZE
 
 # Useful QWORD "arrays" for simpler memory references
 # MSG, DIGEST, K_t, W_t are arrays
@@ -281,18 +277,18 @@ SYM_FUNC_START(sha512_transform_avx)
 	test msglen, msglen
 	je nowork
 
+	# Save GPRs
+	push	%rbx
+	push	%r12
+	push	%r13
+	push	%r14
+	push	%r15
+
 	# Allocate Stack Space
-	mov	%rsp, %rax
+	push	%rbp
+	mov	%rsp, %rbp
 	sub     $frame_size, %rsp
 	and	$~(0x20 - 1), %rsp
-	mov	%rax, frame_RSPSAVE(%rsp)
-
-	# Save GPRs
-	mov     %rbx, frame_GPRSAVE(%rsp)
-	mov     %r12, frame_GPRSAVE +8*1(%rsp)
-	mov     %r13, frame_GPRSAVE +8*2(%rsp)
-	mov     %r14, frame_GPRSAVE +8*3(%rsp)
-	mov     %r15, frame_GPRSAVE +8*4(%rsp)
 
 updateblock:
 
@@ -353,15 +349,16 @@ updateblock:
 	dec     msglen
 	jnz     updateblock
 
-	# Restore GPRs
-	mov     frame_GPRSAVE(%rsp),      %rbx
-	mov     frame_GPRSAVE +8*1(%rsp), %r12
-	mov     frame_GPRSAVE +8*2(%rsp), %r13
-	mov     frame_GPRSAVE +8*3(%rsp), %r14
-	mov     frame_GPRSAVE +8*4(%rsp), %r15
-
 	# Restore Stack Pointer
-	mov	frame_RSPSAVE(%rsp), %rsp
+	mov	%rbp, %rsp
+	pop	%rbp
+
+	# Restore GPRs
+	pop	%r15
+	pop	%r14
+	pop	%r13
+	pop	%r12
+	pop	%rbx
 
 nowork:
 	ret
-- 
2.29.2

