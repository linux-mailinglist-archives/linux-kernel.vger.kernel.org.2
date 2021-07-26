Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A113D5CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 17:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbhGZOrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 10:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbhGZOrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:47:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C49C061757;
        Mon, 26 Jul 2021 08:27:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso11826774pjq.2;
        Mon, 26 Jul 2021 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dCTh5U/iGuKWRcR2nhzuD0tyEm/pZKUN9sg890BPhTU=;
        b=TdhyHBmbYPMzpz/G0ui1idg6UMmMpm0Cd+SFfazSJcZNMYwttYcWMgvtBShHreHymz
         NLog1TPOoSJD2q8jR2kcCNWntyPC9fUzHkxRRFWa7istFiSOFKfWVriHGGBBzAanJJes
         Ixrc6DUH2J6Io8LYo+kop5vFChAgIG3nMq3KHK998MPNo6N4V27iLJpyPTSMsKt7yjaR
         3EJTO1xGuEggaD5SVIdcW9vBswR3k2bj2dbAEAF2Ww7y7fVYO0cfOj0atAUBL7fktyto
         7fA6v9f/YU9+DRhMKQR3uW4ipzfJX0u5H2H1NnqMk57Qq8wXHWyHH/O+QUDHh/hT1BMF
         tiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dCTh5U/iGuKWRcR2nhzuD0tyEm/pZKUN9sg890BPhTU=;
        b=NVXKtYn5FxDF1/m0rn0EiahysCLNY/KftIp+hqF/HjUVPrBDTD6Ng3DeUqlpn3NDvg
         PZQideaj7UqoKh22AhoIA0haR94Kw3Sk71sifDGe4dV0IUSykWoFjdvaP77z8cTGL9yd
         MC9IL2yiF9hP2kmwpAAIYmqftVvhTmisVX87qf2lfm1mAzba1Ntkf2iq4mIbg1ljZyLq
         Z2CjU94WoL93PDRrR9RYO2Jm/hB+SeUYUzJVadwVqgIusSHJvySjuzGxJcp9ojAfMYBK
         z8mhzJRYTCH3PJNUZqbLqJTa1xCNCeDbtyO0lR0fqP2zWMsNeC33Ht8mOAb6eG5eDZpc
         60AQ==
X-Gm-Message-State: AOAM5328Jca78fEN/TF/+6x7nMK5j7Z1+irRvjtt9H1goLhtBmZmRsfL
        Bn4PhUMqvkDOJOa5cJcvK8s=
X-Google-Smtp-Source: ABdhPJz1vgJ/+fGv+lsImtB0jkdmaRIz+oOMbuajZVC4n/Pvyn866Ie5Zy9FlQKNUd1lplRvpY8l7Q==
X-Received: by 2002:a63:1e57:: with SMTP id p23mr18603279pgm.41.1627313259385;
        Mon, 26 Jul 2021 08:27:39 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.171])
        by smtp.gmail.com with ESMTPSA id b3sm335525pfi.179.2021.07.26.08.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 08:27:38 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Biggers <ebiggers@google.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: sun8i-ce: fix multiple memory leaks in sun8i_ce_hash_run
Date:   Mon, 26 Jul 2021 23:27:12 +0800
Message-Id: <20210726152724.2281408-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sun8i_ce_hash_run, all the dma_mmap_sg/single will cause memory leak
due to no corresponding unmap operation if errors happen.

Fix this by adding error handling part for all the dma_mmap_sg/single.

Fixes: 56f6d5aee88d ("crypto: sun8i-ce - support hash algorithms")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 .../crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 28 +++++++++----------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
index 88194718a806..d454ad99deee 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
@@ -286,16 +286,14 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 
 	/* the padding could be up to two block. */
 	buf = kzalloc(bs * 2, GFP_KERNEL | GFP_DMA);
-	if (!buf) {
-		err = -ENOMEM;
-		goto theend;
-	}
+	if (!buf)
+		return -ENOMEM;
 	bf = (__le32 *)buf;
 
 	result = kzalloc(digestsize, GFP_KERNEL | GFP_DMA);
 	if (!result) {
-		err = -ENOMEM;
-		goto theend;
+		kfree(buf);
+		return -ENOMEM;
 	}
 
 	flow = rctx->flow;
@@ -321,7 +319,7 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
 		dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
 		err = -EINVAL;
-		goto theend;
+		goto err_result;
 	}
 
 	len = areq->nbytes;
@@ -334,7 +332,7 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	if (len > 0) {
 		dev_err(ce->dev, "remaining len %d\n", len);
 		err = -EINVAL;
-		goto theend;
+		goto err_unmap_sg;
 	}
 	addr_res = dma_map_single(ce->dev, result, digestsize, DMA_FROM_DEVICE);
 	cet->t_dst[0].addr = cpu_to_le32(addr_res);
@@ -342,7 +340,7 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	if (dma_mapping_error(ce->dev, addr_res)) {
 		dev_err(ce->dev, "DMA map dest\n");
 		err = -EINVAL;
-		goto theend;
+		goto err_unmap_sg;
 	}
 
 	byte_count = areq->nbytes;
@@ -392,7 +390,7 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	if (dma_mapping_error(ce->dev, addr_pad)) {
 		dev_err(ce->dev, "DMA error on padding SG\n");
 		err = -EINVAL;
-		goto theend;
+		goto err_addr_res;
 	}
 
 	if (ce->variant->hash_t_dlen_in_bits)
@@ -405,15 +403,15 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	err = sun8i_ce_run_task(ce, flow, crypto_tfm_alg_name(areq->base.tfm));
 
 	dma_unmap_single(ce->dev, addr_pad, j * 4, DMA_TO_DEVICE);
+err_addr_res:
+	dma_unmap_single(ce->dev, addr_res, digestsize, DMA_FROM_DEVICE);
+err_unmap_sg:
 	dma_unmap_sg(ce->dev, areq->src, sg_nents(areq->src),
 		     DMA_TO_DEVICE);
-	dma_unmap_single(ce->dev, addr_res, digestsize, DMA_FROM_DEVICE);
-
-
 	memcpy(areq->result, result, algt->alg.hash.halg.digestsize);
-theend:
-	kfree(buf);
+err_result:
 	kfree(result);
+	kfree(buf);
 	crypto_finalize_hash_request(engine, breq, err);
 	return 0;
 }
-- 
2.25.1

