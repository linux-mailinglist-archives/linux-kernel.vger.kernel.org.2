Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953DE34382D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 06:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCVFOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 01:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhCVFN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 01:13:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAA5561930;
        Mon, 22 Mar 2021 05:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616390036;
        bh=swuzV5EcaNZWS3RrTQ3X/7Hc8ZdWHJlVaGVOm4GrSVg=;
        h=From:To:Cc:Subject:Date:From;
        b=BqLzlYPtWWJqI9Vh+X/fgywOFGwaoqqxGWUiA+ziLU5+fkuf+EK5ZEkHHQM+zZrn0
         OFaCj5Pabg5gX6yDwuB7iwu+4vBKzinAHeznBt/S2Kps9B/DVH2Wvw3BV6+sfxtQCx
         3/lQQzsED+KSFuViY1Nt/xICJUMtFME9TyzJ6brd2l6Kjy8nNi22Bv0lZlCem+6Si1
         X6Si0jjR3TTSaDewjuy9rcM0/ZEAXsn0mJx6BxJsoYIjFa9/Z3EZXTzLP9KoHKmYDH
         kVwywfTLCMiHqNvM2xijxxTf0fuXjlJrW4dOWavmqju9noTXAIQNGkX/6feqk1Q3xm
         puT14p6BuVahQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH RESEND] random: initialize ChaCha20 constants with correct endianness
Date:   Sun, 21 Mar 2021 22:13:47 -0700
Message-Id: <20210322051347.266831-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

On big endian CPUs, the ChaCha20-based CRNG is using the wrong
endianness for the ChaCha20 constants.

This doesn't matter cryptographically, but technically it means it's not
ChaCha20 anymore.  Fix it to always use the standard constants.

Cc: linux-crypto@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/char/random.c   | 4 ++--
 include/crypto/chacha.h | 9 +++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0fe9e200e4c84..5d6acfecd919b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -819,7 +819,7 @@ static bool __init crng_init_try_arch_early(struct crng_state *crng)
 
 static void __maybe_unused crng_initialize_secondary(struct crng_state *crng)
 {
-	memcpy(&crng->state[0], "expand 32-byte k", 16);
+	chacha_init_consts(crng->state);
 	_get_random_bytes(&crng->state[4], sizeof(__u32) * 12);
 	crng_init_try_arch(crng);
 	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
@@ -827,7 +827,7 @@ static void __maybe_unused crng_initialize_secondary(struct crng_state *crng)
 
 static void __init crng_initialize_primary(struct crng_state *crng)
 {
-	memcpy(&crng->state[0], "expand 32-byte k", 16);
+	chacha_init_consts(crng->state);
 	_extract_entropy(&input_pool, &crng->state[4], sizeof(__u32) * 12, 0);
 	if (crng_init_try_arch_early(crng) && trust_cpu) {
 		invalidate_batched_entropy();
diff --git a/include/crypto/chacha.h b/include/crypto/chacha.h
index 3a1c72fdb7cf5..dabaee6987186 100644
--- a/include/crypto/chacha.h
+++ b/include/crypto/chacha.h
@@ -47,13 +47,18 @@ static inline void hchacha_block(const u32 *state, u32 *out, int nrounds)
 		hchacha_block_generic(state, out, nrounds);
 }
 
-void chacha_init_arch(u32 *state, const u32 *key, const u8 *iv);
-static inline void chacha_init_generic(u32 *state, const u32 *key, const u8 *iv)
+static inline void chacha_init_consts(u32 *state)
 {
 	state[0]  = 0x61707865; /* "expa" */
 	state[1]  = 0x3320646e; /* "nd 3" */
 	state[2]  = 0x79622d32; /* "2-by" */
 	state[3]  = 0x6b206574; /* "te k" */
+}
+
+void chacha_init_arch(u32 *state, const u32 *key, const u8 *iv);
+static inline void chacha_init_generic(u32 *state, const u32 *key, const u8 *iv)
+{
+	chacha_init_consts(state);
 	state[4]  = key[0];
 	state[5]  = key[1];
 	state[6]  = key[2];
-- 
2.31.0

