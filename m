Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F3332423D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhBXQhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:37:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36086 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234870AbhBXQbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614184192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gcsCAQPDZMD8BF6K4lOC+A/wlgHSo8oWdnRV/pLzh84=;
        b=W1t4VrutVd8I+D26/FVZmg8PFz1a8wBDtlHA8ltPDUZLoFQ92fEz7IQISgpBgQ0FTwZwBa
        uLjpeq6WQneqodWWSoWBcHnVJdwplMv9tNfFDhVYne5Bkoj9Qn4g7HOz1WBKdOf1UKkEm1
        50ZsHLoTVcaE5sntXY/UHwnG7Lt3WsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-N1u4lq1CMI2y_ddWYYqZAg-1; Wed, 24 Feb 2021 11:29:47 -0500
X-MC-Unique: N1u4lq1CMI2y_ddWYYqZAg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E80D9107ACE8;
        Wed, 24 Feb 2021 16:29:45 +0000 (UTC)
Received: from treble.redhat.com (ovpn-118-134.rdu2.redhat.com [10.10.118.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5A7660862;
        Wed, 24 Feb 2021 16:29:44 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-crypto@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 09/13] x86/crypto/sha256-avx2: Standardize stack alignment prologue
Date:   Wed, 24 Feb 2021 10:29:22 -0600
Message-Id: <8048e7444c49a8137f05265262b83dc50f8fb7f3.1614182415.git.jpoimboe@redhat.com>
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
 arch/x86/crypto/sha256-avx2-asm.S | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
index 11ff60c29c8b..4087f7432a7e 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -117,15 +117,13 @@ _XMM_SAVE_SIZE	= 0
 _INP_END_SIZE	= 8
 _INP_SIZE	= 8
 _CTX_SIZE	= 8
-_RSP_SIZE	= 8
 
 _XFER		= 0
 _XMM_SAVE	= _XFER     + _XFER_SIZE
 _INP_END	= _XMM_SAVE + _XMM_SAVE_SIZE
 _INP		= _INP_END  + _INP_END_SIZE
 _CTX		= _INP      + _INP_SIZE
-_RSP		= _CTX      + _CTX_SIZE
-STACK_SIZE	= _RSP      + _RSP_SIZE
+STACK_SIZE	= _CTX      + _CTX_SIZE
 
 # rotate_Xs
 # Rotate values of symbols X0...X3
@@ -533,11 +531,11 @@ SYM_FUNC_START(sha256_transform_rorx)
 	pushq	%r14
 	pushq	%r15
 
-	mov	%rsp, %rax
+	push	%rbp
+	mov	%rsp, %rbp
+
 	subq	$STACK_SIZE, %rsp
 	and	$-32, %rsp	# align rsp to 32 byte boundary
-	mov	%rax, _RSP(%rsp)
-
 
 	shl	$6, NUM_BLKS	# convert to bytes
 	jz	done_hash
@@ -704,7 +702,8 @@ only_one_block:
 
 done_hash:
 
-	mov	_RSP(%rsp), %rsp
+	mov	%rbp, %rsp
+	pop	%rbp
 
 	popq	%r15
 	popq	%r14
-- 
2.29.2

