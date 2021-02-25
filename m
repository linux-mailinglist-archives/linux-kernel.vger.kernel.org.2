Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9C7324239
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhBXQgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:36:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234654AbhBXQbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614184180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EoUyH4tB9klRBpxMdtA+3ioOLqqMzutoUlyl1zVvLUo=;
        b=ZT6aV0ofJ/iXEiDKkSAwOm5dy1lqO6U5+D/V5UOL6m65C1p37M6YK/twvu7yXYb5K4B5my
        VKYaikcKWjU81fu6sg3kcF0bfP9Nn3RucLz0N5aQI7eDtFrXTZEaSeoT7Kba997xm2CUm8
        DuJ8STA78D+EnRHtWSiWrY8Cpu1ekdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-zYRW8OXmOjWnjx0U8NBX4w-1; Wed, 24 Feb 2021 11:29:38 -0500
X-MC-Unique: zYRW8OXmOjWnjx0U8NBX4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 655BF801965;
        Wed, 24 Feb 2021 16:29:36 +0000 (UTC)
Received: from treble.redhat.com (ovpn-118-134.rdu2.redhat.com [10.10.118.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2877960862;
        Wed, 24 Feb 2021 16:29:35 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-crypto@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 03/13] x86/crypto/aesni-intel_avx: Fix register usage comments
Date:   Wed, 24 Feb 2021 10:29:16 -0600
Message-Id: <8655d4513a0ed1eddec609165064153973010aa2.1614182415.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1614182415.git.jpoimboe@redhat.com>
References: <cover.1614182415.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix register usage comments to match reality.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aesni-intel_avx-x86_64.S
index 4fdf38e92d51..188f1848a730 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -286,7 +286,7 @@ VARIABLE_OFFSET = 16*8
 
 # combined for GCM encrypt and decrypt functions
 # clobbering all xmm registers
-# clobbering r10, r11, r12, r13, r14, r15
+# clobbering r10, r11, r12, r13, r15, rax
 .macro  GCM_ENC_DEC INITIAL_BLOCKS GHASH_8_ENCRYPT_8_PARALLEL GHASH_LAST_8 GHASH_MUL ENC_DEC REP
         vmovdqu AadHash(arg2), %xmm8
         vmovdqu  HashKey(arg2), %xmm13      # xmm13 = HashKey
@@ -988,7 +988,7 @@ _partial_block_done_\@:
 ## num_initial_blocks = b mod 4#
 ## encrypt the initial num_initial_blocks blocks and apply ghash on the ciphertext
 ## r10, r11, r12, rax are clobbered
-## arg1, arg3, arg4, r14 are used as a pointer only, not modified
+## arg1, arg2, arg3, arg4 are used as pointers only, not modified
 
 .macro INITIAL_BLOCKS_AVX REP num_initial_blocks T1 T2 T3 T4 T5 CTR XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T6 T_key ENC_DEC
 	i = (8-\num_initial_blocks)
@@ -1223,7 +1223,7 @@ _initial_blocks_done\@:
 
 # encrypt 8 blocks at a time
 # ghash the 8 previously encrypted ciphertext blocks
-# arg1, arg3, arg4 are used as pointers only, not modified
+# arg1, arg2, arg3, arg4 are used as pointers only, not modified
 # r11 is the data offset value
 .macro GHASH_8_ENCRYPT_8_PARALLEL_AVX REP T1 T2 T3 T4 T5 T6 CTR XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T7 loop_idx ENC_DEC
 
@@ -1936,7 +1936,7 @@ SYM_FUNC_END(aesni_gcm_finalize_avx_gen2)
 ## num_initial_blocks = b mod 4#
 ## encrypt the initial num_initial_blocks blocks and apply ghash on the ciphertext
 ## r10, r11, r12, rax are clobbered
-## arg1, arg3, arg4, r14 are used as a pointer only, not modified
+## arg1, arg2, arg3, arg4 are used as pointers only, not modified
 
 .macro INITIAL_BLOCKS_AVX2 REP num_initial_blocks T1 T2 T3 T4 T5 CTR XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T6 T_key ENC_DEC VER
 	i = (8-\num_initial_blocks)
@@ -2178,7 +2178,7 @@ _initial_blocks_done\@:
 
 # encrypt 8 blocks at a time
 # ghash the 8 previously encrypted ciphertext blocks
-# arg1, arg3, arg4 are used as pointers only, not modified
+# arg1, arg2, arg3, arg4 are used as pointers only, not modified
 # r11 is the data offset value
 .macro GHASH_8_ENCRYPT_8_PARALLEL_AVX2 REP T1 T2 T3 T4 T5 T6 CTR XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T7 loop_idx ENC_DEC
 
-- 
2.29.2

