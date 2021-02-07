Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8B83124C7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhBGOmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhBGOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:41:13 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12553C0617AB
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:39:54 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id s77so11944990qke.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZiqftGjZZeqxnGuzUfAaT6stfdHVGYnoCL8kLsn0Ng=;
        b=HV2LKtCSh+i1BvBIs4cdUJkJ7QqIfp3lQD/DvNQHYyBC+hrpMdTYljRJiXIIcUyos5
         K4LzMW38DczfHw5ppQpwECuSmoxypC+Tm1blEz3JnUaIkBZgUG3SvSCUcf/ZofzjHPex
         p7BYKI+7aArG29y6+g/GzRStkTLmuO2ZedWLsTKKvigu5zj2tkOolNiorSmuu7Tx8aF7
         MbaMBDUh5R4EBNV2FMHBk1qImlb5ula8JpFnEKog46j9PCQd0lDwXvMUaXlYLeuzYg8r
         ky7ZzvOyJ56M956kGCf69h8iVMZjaJ61OwJbvKaTB0CFA6weUM5ilBd3dwOek7/6LF4c
         Jdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZiqftGjZZeqxnGuzUfAaT6stfdHVGYnoCL8kLsn0Ng=;
        b=kUSR0Xh/bCrDhGZGv7rUBCBUE0nIMH6Geh16/thei8kWFAHDiSNGT7FC/VIZc27PST
         YKM5fc3QljRLYlc7WHVZF8w0HzE8Oshc85YSTAiJJFSdS8nN/ZWC1bo6qFmgE8+p7MAo
         z3+YvIL/NL678yVkpIrApJzg9PAqAe00U7LJgODFRWSYJamNLTNnW7PHwmj0Ga5jV1Bh
         1ir4ihgQWDgZkBMl/JzswrbLtyKEo/EhPFt2jHW2JnRv2Xl6BWH55rFiK0AwwoRwxiNb
         mIveDKtFM+RdFjPi6xpM0oCnkZ+nLisO+ovnEVTcZLm7cFmMOf2xm2u4Plndqg6IuOmT
         7X8w==
X-Gm-Message-State: AOAM533MO1iB9sgfJCOsg6pMMYxJQoSnLTTk7lQP7yLoQEXOR8udOg2/
        858VMYb/sqp9sExE7oi5JKoc7A==
X-Google-Smtp-Source: ABdhPJx2s2EoII5A0YjyhT3DLNdDEe2ZR+4vcfIY+5nPVvfh3kIJdeqcVV3GQSKkW+oS/fU3HPVZ2w==
X-Received: by 2002:a37:6f06:: with SMTP id k6mr12929201qkc.458.1612708793337;
        Sun, 07 Feb 2021 06:39:53 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id c81sm13941493qkb.88.2021.02.07.06.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:39:52 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/11] crypto: qce: skcipher: Return error for non-blocksize data(ECB/CBC algorithms)
Date:   Sun,  7 Feb 2021 09:39:41 -0500
Message-Id: <20210207143946.2099859-7-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210207143946.2099859-1-thara.gopinath@linaro.org>
References: <20210207143946.2099859-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ECB/CBC encryption/decryption requires the data to be blocksize aligned.
Crypto engine hangs on non-block sized operations for these algorithms.
Return invalid data if data size is not blocksize aligned for these
algorithms.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v5->v6:
	- Remove the wrong TODO which implied that AES CBC can do partial
	  block sizes when it is actually CTS mode that can as pointed
	  out by Eric Biggers.

 drivers/crypto/qce/skcipher.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 96af40c2c8f3..d24d96ed5be9 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -254,6 +254,7 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	struct qce_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct qce_cipher_reqctx *rctx = skcipher_request_ctx(req);
 	struct qce_alg_template *tmpl = to_cipher_tmpl(tfm);
+	unsigned int blocksize = crypto_skcipher_blocksize(tfm);
 	int keylen;
 	int ret;
 
@@ -265,6 +266,14 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	if (!req->cryptlen)
 		return 0;
 
+	/*
+	 * ECB and CBC algorithms require message lengths to be
+	 * multiples of block size.
+	 */
+	if (IS_ECB(rctx->flags) || IS_CBC(rctx->flags))
+		if (!IS_ALIGNED(req->cryptlen, blocksize))
+			return -EINVAL;
+
 	/* qce is hanging when AES-XTS request len > QCE_SECTOR_SIZE and
 	 * is not a multiple of it; pass such requests to the fallback
 	 */
-- 
2.25.1

