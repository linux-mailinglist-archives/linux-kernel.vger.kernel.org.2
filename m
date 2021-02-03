Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CE730DCD5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhBCOd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbhBCOdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:33:51 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A086C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:33:11 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id l23so17612388qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ud736rWi4YDStkQGLZirsnezpcvto+zhQzFWozsJkhA=;
        b=o0CcDUWn+FgqLVl+GqBu8O5LFJYo0piLJdLfdXdq9PZsNB8/HtSiWrelFpUnVb0Nmc
         hfTUxezk16C7Hf9A0k7pz1SYyk4+0Xc3K5yt/MzBe7k5EJGxcyw24XJ257uicfuRjSiZ
         UTJ2OtkobIrWd6ikqqyWvyAobIoLmauHR25VmnIZtcXzWXwXCT0VMo0ALpM+7UtKE1jD
         ivxHAOfOm6JhTgAs3YMxmUiIE/DSb2Uh4rxduatMMgqP8Z5BP7X2UKVveR+444VB+ctG
         NmcQjDJEoejF0rxWf73EBQRjAW1wCcQSj5D6ZcH1VoaKIxCW51ECsEjhPbP/fp47DMcr
         l+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ud736rWi4YDStkQGLZirsnezpcvto+zhQzFWozsJkhA=;
        b=E8ibmBlMKI7WaYsT+YThHbOMr1h3jI7tTWPLZxWTqv5N/9IUVuurQ8OfoONs3yNBzM
         UezgsRHNujNYt34mMB9UaYz9Kldh5cy8SMq7vU03/fE7fF4bUzFpJChwjWScKT3tBN9J
         8SkngUCX/BYr1aJfdQgUf5RUwDJhoQHFgIyF1icYI464eJiojvFDgd4qr+MoHAkKeYFV
         GTRcYsKYqqXnKOwaVxMJ/4qR3gCoNB5MXzhkTdiFl0H7uASqwlZn2XdRBeaLyIlBKA9F
         M0rq/sxg7dmWy3oOIfA8YJJoMKDDznAE5RwahCdpxf19+5ukYHPbu4VkhkKoEUhIE9qC
         CulA==
X-Gm-Message-State: AOAM533wVkCXhGiZHsK/cL5IZzTP3JYjUAyi5Mkm652xf0iFKYvbR+Lg
        02budk8n2EBiKceEjUMuwWRdyQ==
X-Google-Smtp-Source: ABdhPJymWPqGQGUeQJ+yIfdH/bZck75nq8OUryhrM0F2YOce41bOEpHdnlUc+3j/K0e5kxt60mjfmA==
X-Received: by 2002:ac8:508:: with SMTP id u8mr2834615qtg.138.1612362790489;
        Wed, 03 Feb 2021 06:33:10 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id v15sm1775433qkv.36.2021.02.03.06.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:33:09 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/11] crypto: qce: sha: Restore/save ahash state with custom struct in export/import
Date:   Wed,  3 Feb 2021 09:32:57 -0500
Message-Id: <20210203143307.1351563-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210203143307.1351563-1-thara.gopinath@linaro.org>
References: <20210203143307.1351563-1-thara.gopinath@linaro.org>
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
v3->v4:
	- Fixed the bug where only two bytes of byte_count were getting
	  saved and restored instead of all eight bytes. Thanks Bjorn for
	  catching this.
v1->v2:
	- Introduced custom struct qce_sha_saved_state to store and
	  restore partial sha transformation. v1 was re-using
	  qce_sha_reqctx to save and restore partial states and this
	  could lead to potential memcpy issues around pointer copying.

 drivers/crypto/qce/sha.c | 122 +++++++++++----------------------------
 1 file changed, 34 insertions(+), 88 deletions(-)

diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index 61c418c12345..500290b40916 100644
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
+	struct qce_sha_saved_state *import_state = in;
 
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

