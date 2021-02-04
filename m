Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3813930FF7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhBDVpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhBDVom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:44:42 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7623CC061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 13:44:02 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id t126so2380715qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 13:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aN4Ar0ko3Rto1g1pRIsQic5bApXWaoyHtlgB9BLpWjA=;
        b=yUMuvKiBaGvWTtXR69jwfs1lH+chT2TiyqXcS9n/roPUX8Qq4e6SzDSN/klWgUgB4t
         gmrySONcyLl7VpLN3BRQBAh0w66aPu//TWU5yl2BorlRPIYUicZbze8+rv/1CvGbyO8o
         4MHJK4QYDnStgmNPo3YPfTlSwogAnWO/ENtPvsix/JNvegprLPF8/nK6ccm1O885I0DD
         h07aHyRQBnAsUXT+CvQq74oQnFbJld5mOfNlJbPooBBppy3mzgKkhRGC3L8q2GO6FUgU
         Gwjk5nDy72mCE1OQDIYK1RGT5ha5UlACUhJvh4nEaa0hKj3Kk5xX17aKLq9yPcm++zVW
         zCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aN4Ar0ko3Rto1g1pRIsQic5bApXWaoyHtlgB9BLpWjA=;
        b=KYSrK4DybTLzNTZLKGDGuGh8WY32jvdi77SPEmd48ponm1v1FqJGupS3fQILvsBTZc
         M8b/9VyNmS2jjirdo3BQzzFVqNk3yUl50ngLRJ1xxwa2xygqhEFc0PIJtm3c5bO0tlje
         tDCnDpKPzz5OekTtQWIxQsRQsOGk1xkh0U+xDh6iAj20ocCnZptaGWmcZf1eZ76TtqqV
         pdeMA9N+Jwin3dofXPPW9XBsV9VS5341zTUIaCz5b8XczuqY6xmPeafQLMKYN9Xm0L7r
         Fzxs6YbPKMEq0ZtbRTwS66TXY53IpZXKBxJ6QbSXbXNO6Is8uEqZ8BwojE3rmXU0JYhO
         +akg==
X-Gm-Message-State: AOAM530aqoT2qFh/mRkfCSIY15wWj2XBt/gUNDxkmVWqvTfc/f5ugMe1
        bYxUO4y2P53U8Gfkf+FHKk68Tw==
X-Google-Smtp-Source: ABdhPJz1XvpME+zlV4NeMZc9KPZIVYiNs6JWkdHOcYUmt9d9L6bTG6DBF50RLeUcl804L11rUMKscQ==
X-Received: by 2002:a37:345:: with SMTP id 66mr1245842qkd.358.1612475041699;
        Thu, 04 Feb 2021 13:44:01 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id h185sm6353858qkd.122.2021.02.04.13.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:44:01 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/11] crypto: qce: sha: Restore/save ahash state with custom struct in export/import
Date:   Thu,  4 Feb 2021 16:43:49 -0500
Message-Id: <20210204214359.1993065-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204214359.1993065-1-thara.gopinath@linaro.org>
References: <20210204214359.1993065-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export and import interfaces save and restore partial transformation
states. The partial states were being stored and restored in struct
sha1_state for sha1/hmac(sha1) transformations and sha256_state for
sha256/hmac(sha256) transformations.This led to a bunch of corner cases
where improper state was being stored and restored. A few of the corner
cases that turned up during testing are:

- wrong byte_count restored if export/import is called twice without h/w
transaction in between
- wrong buflen restored back if the pending buffer
length is exactly the block size.
- wrong state restored if buffer length is 0.

To fix these issues, save and restore the partial transformation state
using the newly introduced qce_sha_saved_state struct. This ensures that
all the pieces required to properly restart the transformation is captured
and restored back

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v4->v5:
	- Fixed build warning/error in patch for wrong assignment of const
	  pointer as reported by kernel test robot <lkp@intel.com>.
v1->v2:
	- Introduced custom struct qce_sha_saved_state to store and
	  restore partial sha transformation. v1 was re-using
	  qce_sha_reqctx to save and restore partial states and this
	  could lead to potential memcpy issues around pointer copying.


 drivers/crypto/qce/sha.c | 122 +++++++++++----------------------------
 1 file changed, 34 insertions(+), 88 deletions(-)

diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index 61c418c12345..7da562dca740 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -12,9 +12,15 @@
 #include "core.h"
 #include "sha.h"
 
-/* crypto hw padding constant for first operation */
-#define SHA_PADDING		64
-#define SHA_PADDING_MASK	(SHA_PADDING - 1)
+struct qce_sha_saved_state {
+	u8 pending_buf[QCE_SHA_MAX_BLOCKSIZE];
+	u8 partial_digest[QCE_SHA_MAX_DIGESTSIZE];
+	__be32 byte_count[2];
+	unsigned int pending_buflen;
+	unsigned int flags;
+	u64 count;
+	bool first_blk;
+};
 
 static LIST_HEAD(ahash_algs);
 
@@ -139,97 +145,37 @@ static int qce_ahash_init(struct ahash_request *req)
 
 static int qce_ahash_export(struct ahash_request *req, void *out)
 {
-	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
 	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
-	unsigned long flags = rctx->flags;
-	unsigned int digestsize = crypto_ahash_digestsize(ahash);
-	unsigned int blocksize =
-			crypto_tfm_alg_blocksize(crypto_ahash_tfm(ahash));
-
-	if (IS_SHA1(flags) || IS_SHA1_HMAC(flags)) {
-		struct sha1_state *out_state = out;
-
-		out_state->count = rctx->count;
-		qce_cpu_to_be32p_array((__be32 *)out_state->state,
-				       rctx->digest, digestsize);
-		memcpy(out_state->buffer, rctx->buf, blocksize);
-	} else if (IS_SHA256(flags) || IS_SHA256_HMAC(flags)) {
-		struct sha256_state *out_state = out;
-
-		out_state->count = rctx->count;
-		qce_cpu_to_be32p_array((__be32 *)out_state->state,
-				       rctx->digest, digestsize);
-		memcpy(out_state->buf, rctx->buf, blocksize);
-	} else {
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int qce_import_common(struct ahash_request *req, u64 in_count,
-			     const u32 *state, const u8 *buffer, bool hmac)
-{
-	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
-	unsigned int digestsize = crypto_ahash_digestsize(ahash);
-	unsigned int blocksize;
-	u64 count = in_count;
-
-	blocksize = crypto_tfm_alg_blocksize(crypto_ahash_tfm(ahash));
-	rctx->count = in_count;
-	memcpy(rctx->buf, buffer, blocksize);
-
-	if (in_count <= blocksize) {
-		rctx->first_blk = 1;
-	} else {
-		rctx->first_blk = 0;
-		/*
-		 * For HMAC, there is a hardware padding done when first block
-		 * is set. Therefore the byte_count must be incremened by 64
-		 * after the first block operation.
-		 */
-		if (hmac)
-			count += SHA_PADDING;
-	}
+	struct qce_sha_saved_state *export_state = out;
 
-	rctx->byte_count[0] = (__force __be32)(count & ~SHA_PADDING_MASK);
-	rctx->byte_count[1] = (__force __be32)(count >> 32);
-	qce_cpu_to_be32p_array((__be32 *)rctx->digest, (const u8 *)state,
-			       digestsize);
-	rctx->buflen = (unsigned int)(in_count & (blocksize - 1));
+	memcpy(export_state->pending_buf, rctx->buf, rctx->buflen);
+	memcpy(export_state->partial_digest, rctx->digest, sizeof(rctx->digest));
+	export_state->byte_count[0] = rctx->byte_count[0];
+	export_state->byte_count[1] = rctx->byte_count[1];
+	export_state->pending_buflen = rctx->buflen;
+	export_state->count = rctx->count;
+	export_state->first_blk = rctx->first_blk;
+	export_state->flags = rctx->flags;
 
 	return 0;
 }
 
 static int qce_ahash_import(struct ahash_request *req, const void *in)
 {
-	struct qce_sha_reqctx *rctx;
-	unsigned long flags;
-	bool hmac;
-	int ret;
-
-	ret = qce_ahash_init(req);
-	if (ret)
-		return ret;
-
-	rctx = ahash_request_ctx(req);
-	flags = rctx->flags;
-	hmac = IS_SHA_HMAC(flags);
-
-	if (IS_SHA1(flags) || IS_SHA1_HMAC(flags)) {
-		const struct sha1_state *state = in;
-
-		ret = qce_import_common(req, state->count, state->state,
-					state->buffer, hmac);
-	} else if (IS_SHA256(flags) || IS_SHA256_HMAC(flags)) {
-		const struct sha256_state *state = in;
+	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
+	const struct qce_sha_saved_state *import_state = in;
 
-		ret = qce_import_common(req, state->count, state->state,
-					state->buf, hmac);
-	}
+	memset(rctx, 0, sizeof(*rctx));
+	rctx->count = import_state->count;
+	rctx->buflen = import_state->pending_buflen;
+	rctx->first_blk = import_state->first_blk;
+	rctx->flags = import_state->flags;
+	rctx->byte_count[0] = import_state->byte_count[0];
+	rctx->byte_count[1] = import_state->byte_count[1];
+	memcpy(rctx->buf, import_state->pending_buf, rctx->buflen);
+	memcpy(rctx->digest, import_state->partial_digest, sizeof(rctx->digest));
 
-	return ret;
+	return 0;
 }
 
 static int qce_ahash_update(struct ahash_request *req)
@@ -450,7 +396,7 @@ static const struct qce_ahash_def ahash_def[] = {
 		.drv_name	= "sha1-qce",
 		.digestsize	= SHA1_DIGEST_SIZE,
 		.blocksize	= SHA1_BLOCK_SIZE,
-		.statesize	= sizeof(struct sha1_state),
+		.statesize	= sizeof(struct qce_sha_saved_state),
 		.std_iv		= std_iv_sha1,
 	},
 	{
@@ -459,7 +405,7 @@ static const struct qce_ahash_def ahash_def[] = {
 		.drv_name	= "sha256-qce",
 		.digestsize	= SHA256_DIGEST_SIZE,
 		.blocksize	= SHA256_BLOCK_SIZE,
-		.statesize	= sizeof(struct sha256_state),
+		.statesize	= sizeof(struct qce_sha_saved_state),
 		.std_iv		= std_iv_sha256,
 	},
 	{
@@ -468,7 +414,7 @@ static const struct qce_ahash_def ahash_def[] = {
 		.drv_name	= "hmac-sha1-qce",
 		.digestsize	= SHA1_DIGEST_SIZE,
 		.blocksize	= SHA1_BLOCK_SIZE,
-		.statesize	= sizeof(struct sha1_state),
+		.statesize	= sizeof(struct qce_sha_saved_state),
 		.std_iv		= std_iv_sha1,
 	},
 	{
@@ -477,7 +423,7 @@ static const struct qce_ahash_def ahash_def[] = {
 		.drv_name	= "hmac-sha256-qce",
 		.digestsize	= SHA256_DIGEST_SIZE,
 		.blocksize	= SHA256_BLOCK_SIZE,
-		.statesize	= sizeof(struct sha256_state),
+		.statesize	= sizeof(struct qce_sha_saved_state),
 		.std_iv		= std_iv_sha256,
 	},
 };
-- 
2.25.1

