Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E206832AA42
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581763AbhCBTRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:17:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59917 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835118AbhCBQhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:37:34 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lH7yx-0008WF-5K; Tue, 02 Mar 2021 16:34:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: sun8i-ss: Fix memory leak of object d when dma_iv fails to map
Date:   Tue,  2 Mar 2021 16:34:46 +0000
Message-Id: <20210302163446.21047-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where the dma_iv mapping fails, the return error path leaks
the memory allocated to object d.  Fix this by adding a new error return
label and jumping to this to ensure d is free'd before the return.

Addresses-Coverity: ("Resource leak")
Fixes: ac2614d721de ("crypto: sun8i-ss - Add support for the PRNG")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
index 08a1473b2145..3191527928e4 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
@@ -103,7 +103,8 @@ int sun8i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 	dma_iv = dma_map_single(ss->dev, ctx->seed, ctx->slen, DMA_TO_DEVICE);
 	if (dma_mapping_error(ss->dev, dma_iv)) {
 		dev_err(ss->dev, "Cannot DMA MAP IV\n");
-		return -EFAULT;
+		err = -EFAULT;
+		goto err_free;
 	}
 
 	dma_dst = dma_map_single(ss->dev, d, todo, DMA_FROM_DEVICE);
@@ -167,6 +168,7 @@ int sun8i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 		memcpy(ctx->seed, d + dlen, ctx->slen);
 	}
 	memzero_explicit(d, todo);
+err_free:
 	kfree(d);
 
 	return err;
-- 
2.30.0

