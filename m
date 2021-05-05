Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B0937495F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhEEU1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbhEEU1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:27:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9A1C061343
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 13:26:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h4so3201054wrt.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 13:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NQ4i6VepGC85yKCiRGHCxje44Up7BPnW12yV53TjPfY=;
        b=bbinMmHThj9lVrlJfoVBtQBlNaO0BanDfEbacp8tPmg2IPh8Muf4yKF+OFVEXs44HV
         tTSNSDWgzneZ72u5oebPfFWGHXpIJHPix6BfAJnGzqwIA1hfWFzADQDJON2Dv4Op8t5Q
         7VLACgrfacsvIaJSGEvlq3yQBr2IxDFsPMQGgsfLMBT6kLpJ1CEfaRLmN6+olPEtfg4m
         znG9Szua8mXVqXtT/PMA5laiPHvqkZqCoaKNl8zvODueSVeOGV+RhqjB7oGc5XYMF3TJ
         uEykAr1QMqiep9DXZKM1AwIb0sZuDM26j554ZAAA6yQFKAvkr+sXMjTawezcfflek9pi
         MBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NQ4i6VepGC85yKCiRGHCxje44Up7BPnW12yV53TjPfY=;
        b=Vsil7QF9pT7eUWid+sFoXQDK22n/E1E1o+eJVkeYZKJTR9RA8It7aIfKW0vEKbEjXf
         hL3aU4s2bheg3NPLQYugg0NOFPXQTB7mA5XQKWlXnMTkiKFfoFIHEBWjmSrIYYMiZ6X3
         bfnDi23yWp3NlDWbcc3ZSiThGgc6Vt3luvWZxIBWDb/VOI+gj9XUO7w2ZUSPNEXIv5hF
         HX+IG3+H/vVuEpB90wuYuax2ews9/UQ2XaAmVtoa9RIHI3jp1PuS+q7mXGjNrUKd9M3y
         edexEavyqTLimOK5grOVGv4lAyLLh5OthYkd6JqZOp1nLCwFZOzTzKKNXsaB20SLs+ji
         +aSQ==
X-Gm-Message-State: AOAM532lmm8HEjOHqXpqUi7EfrEFRAcncci8d4oD0K8gpA8OBUULdkHA
        gPhMRchxra+0M4SkSH97p5mOYQ==
X-Google-Smtp-Source: ABdhPJypTFFnYBukviNVTtchvaTNHYaoNIQ/Aj1kL+QF/CK72HFyZIFHRlckd20mUX2gICF4AXVw2g==
X-Received: by 2002:adf:fa50:: with SMTP id y16mr927628wrr.63.1620246391655;
        Wed, 05 May 2021 13:26:31 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a15sm497245wrr.53.2021.05.05.13.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 13:26:31 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     chohnstaedt@innominate.com, davem@davemloft.net,
        herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 08/11] crypto: ixp4xx: remove brackets from single statement
Date:   Wed,  5 May 2021 20:26:15 +0000
Message-Id: <20210505202618.2663889-9-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505202618.2663889-1-clabbe@baylibre.com>
References: <20210505202618.2663889-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixes all single statement issues reported by checkpatch

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/ixp4xx_crypto.c | 47 +++++++++++++++-------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/ixp4xx_crypto.c b/drivers/crypto/ixp4xx_crypto.c
index 954696a39875..03ae9c3a8d97 100644
--- a/drivers/crypto/ixp4xx_crypto.c
+++ b/drivers/crypto/ixp4xx_crypto.c
@@ -378,9 +378,9 @@ static void one_packet(dma_addr_t phys)
 
 		free_buf_chain(dev, req_ctx->src, crypt->src_buf);
 		free_buf_chain(dev, req_ctx->dst, crypt->dst_buf);
-		if (req_ctx->hmac_virt) {
+		if (req_ctx->hmac_virt)
 			finish_scattered_hmac(crypt);
-		}
+
 		req->base.complete(&req->base, failed);
 		break;
 	}
@@ -402,9 +402,9 @@ static void one_packet(dma_addr_t phys)
 			}
 		}
 
-		if (req_ctx->dst) {
+		if (req_ctx->dst)
 			free_buf_chain(dev, req_ctx->dst, crypt->dst_buf);
-		}
+
 		free_buf_chain(dev, req_ctx->src, crypt->src_buf);
 		req->base.complete(&req->base, failed);
 		break;
@@ -497,14 +497,14 @@ static int init_ixp_crypto(struct device *dev)
 	buffer_pool = dma_pool_create("buffer", dev,
 			sizeof(struct buffer_desc), 32, 0);
 	ret = -ENOMEM;
-	if (!buffer_pool) {
+	if (!buffer_pool)
 		goto err;
-	}
+
 	ctx_pool = dma_pool_create("context", dev,
 			NPE_CTX_LEN, 16, 0);
-	if (!ctx_pool) {
+	if (!ctx_pool)
 		goto err;
-	}
+
 	ret = qmgr_request_queue(SEND_QID, NPE_QLEN_TOTAL, 0, 0,
 				 "ixp_crypto:out", NULL);
 	if (ret)
@@ -545,11 +545,10 @@ static void release_ixp_crypto(struct device *dev)
 
 	npe_release(npe_c);
 
-	if (crypt_virt) {
+	if (crypt_virt)
 		dma_free_coherent(dev,
 			NPE_QLEN * sizeof(struct crypt_ctl),
 			crypt_virt, crypt_phys);
-	}
 }
 
 static void reset_sa_dir(struct ix_sa_dir *dir)
@@ -562,9 +561,9 @@ static void reset_sa_dir(struct ix_sa_dir *dir)
 static int init_sa_dir(struct ix_sa_dir *dir)
 {
 	dir->npe_ctx = dma_pool_alloc(ctx_pool, GFP_KERNEL, &dir->npe_ctx_phys);
-	if (!dir->npe_ctx) {
+	if (!dir->npe_ctx)
 		return -ENOMEM;
-	}
+
 	reset_sa_dir(dir);
 	return 0;
 }
@@ -585,9 +584,9 @@ static int init_tfm(struct crypto_tfm *tfm)
 	if (ret)
 		return ret;
 	ret = init_sa_dir(&ctx->decrypt);
-	if (ret) {
+	if (ret)
 		free_sa_dir(&ctx->encrypt);
-	}
+
 	return ret;
 }
 
@@ -669,9 +668,8 @@ static int register_chain_var(struct crypto_tfm *tfm, u8 xpad, u32 target,
 
 	memcpy(pad, key, key_len);
 	memset(pad + key_len, 0, HMAC_PAD_BLOCKLEN - key_len);
-	for (i = 0; i < HMAC_PAD_BLOCKLEN; i++) {
+	for (i = 0; i < HMAC_PAD_BLOCKLEN; i++)
 		pad[i] ^= xpad;
-	}
 
 	crypt->data.tfm = tfm;
 	crypt->regist_ptr = pad;
@@ -751,9 +749,9 @@ static int gen_rev_aes_key(struct crypto_tfm *tfm)
 	struct ix_sa_dir *dir = &ctx->decrypt;
 
 	crypt = get_crypt_desc_emerg();
-	if (!crypt) {
+	if (!crypt)
 		return -EAGAIN;
-	}
+
 	*(u32 *)dir->npe_ctx |= cpu_to_be32(CIPH_ENCR);
 
 	crypt->data.tfm = tfm;
@@ -1004,9 +1002,9 @@ static int ablk_perform(struct skcipher_request *req, int encrypt)
 free_buf_src:
 	free_buf_chain(dev, req_ctx->src, crypt->src_buf);
 free_buf_dest:
-	if (req->src != req->dst) {
+	if (req->src != req->dst)
 		free_buf_chain(dev, req_ctx->dst, crypt->dst_buf);
-	}
+
 	crypt->ctl_flags = CTL_FLAG_UNUSED;
 	return -ENOMEM;
 }
@@ -1462,14 +1460,11 @@ static int __init ixp_module_init(void)
 		struct skcipher_alg *cra = &ixp4xx_algos[i].crypto;
 
 		if (snprintf(cra->base.cra_driver_name, CRYPTO_MAX_ALG_NAME,
-			"%s"IXP_POSTFIX, cra->base.cra_name) >=
-			CRYPTO_MAX_ALG_NAME)
-		{
+			     "%s"IXP_POSTFIX, cra->base.cra_name) >=
+			     CRYPTO_MAX_ALG_NAME)
 			continue;
-		}
-		if (!support_aes && (ixp4xx_algos[i].cfg_enc & MOD_AES)) {
+		if (!support_aes && (ixp4xx_algos[i].cfg_enc & MOD_AES))
 			continue;
-		}
 
 		/* block ciphers */
 		cra->base.cra_flags = CRYPTO_ALG_KERN_DRIVER_ONLY |
-- 
2.26.3

