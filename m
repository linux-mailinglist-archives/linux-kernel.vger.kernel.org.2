Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4BD30FF8A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhBDVqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhBDVps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:45:48 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA536C061222
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 13:44:09 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id w11so2486888qvz.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 13:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H4BViZmMHUNQYYu9VpJJKST4ly897JCfdbGhTeJJKpE=;
        b=qSmPUBrYZyY3E7e0B+TomSazy4rmNtQf+cbA4jP7UBTtDjl9PiOpNAr3+Bqq7oNlt1
         VJVc2nQb82J0ITH+RisAG1+YoQiQxXURBSGzutmFYFfXV+ALtlvZD6sh7SsZ2kGu/P4V
         QbfbZWGT9myU5nsQNwQSONpdrm2lqM/SgULmU/XMJ6UiPsowWnwa7WgZ3B1KnJr2AM8j
         ddoBalsHmb1Cuxn3qx3JQ+wwscXVwBfWAIkDoYD1EtYFtMUSgNOTzYKnlSwCjE5f+ODz
         2PeT5v0smAxAd73MhD8xWAhgHsROXc5Bn6PUNpphasf8wy1VmIRkpjOotBEP8HkcyheM
         D7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4BViZmMHUNQYYu9VpJJKST4ly897JCfdbGhTeJJKpE=;
        b=FLsXl9io0DDCVd4rD8CLCwWpjBjxFoJsNIV/7OuK3/QruMtV60NrgFfFJfXyDLIwdN
         Oe7A167NENI9aG6zHsqBlxE0g84Pa6/AM1QOCs1y2rSw15lYMqgHrbXPlNE9tZGs/QI+
         tCLEMK1tIsRR62KvP/lTeTXfqfZ4O/y643QjkgvYOpk3D5eVo2y8k5zcc/KykDM3eGWa
         iY2crHpd9SpNwwa6Y9kNgr6IXKUtIQlj6XqHtJoJFcnVMpscymO90xzLK3tvxJ7gmXhI
         i+C97Q5sk6h8cgxTacZ0yKxLnpSZSzAfNNvZfzm6VFgRJJfD8RO8/kWh1mtzSFxcqoN0
         O3TA==
X-Gm-Message-State: AOAM530kDag6joYchICK2xOykyHiY4UfYWtgQJ+es4kTgzuFbhQwssTL
        xzhVt+7gS1++K0aTBMAUsmSmZEEtOSQx/Q==
X-Google-Smtp-Source: ABdhPJw7gaAXtBIKNQ9/gzv0zDWIcltELlQLThM40iQJ0Bswjyw4FanIBgMiEjXcVlfn4+s7tat9Vw==
X-Received: by 2002:a05:6214:522:: with SMTP id x2mr1604236qvw.13.1612475048876;
        Thu, 04 Feb 2021 13:44:08 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id h185sm6353858qkd.122.2021.02.04.13.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:44:08 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/11] crypto: qce: common: Set data unit size to message length for AES XTS transformation
Date:   Thu,  4 Feb 2021 16:43:57 -0500
Message-Id: <20210204214359.1993065-10-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204214359.1993065-1-thara.gopinath@linaro.org>
References: <20210204214359.1993065-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the register REG_ENCR_XTS_DU_SIZE to cryptlen for AES XTS
transformation. Anything else causes the engine to return back
wrong results.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index a73db2a5637f..f7bc701a4aa2 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -295,15 +295,15 @@ static void qce_xtskey(struct qce_device *qce, const u8 *enckey,
 {
 	u32 xtskey[QCE_MAX_CIPHER_KEY_SIZE / sizeof(u32)] = {0};
 	unsigned int xtsklen = enckeylen / (2 * sizeof(u32));
-	unsigned int xtsdusize;
 
 	qce_cpu_to_be32p_array((__be32 *)xtskey, enckey + enckeylen / 2,
 			       enckeylen / 2);
 	qce_write_array(qce, REG_ENCR_XTS_KEY0, xtskey, xtsklen);
 
-	/* xts du size 512B */
-	xtsdusize = min_t(u32, QCE_SECTOR_SIZE, cryptlen);
-	qce_write(qce, REG_ENCR_XTS_DU_SIZE, xtsdusize);
+	/* Set data unit size to cryptlen. Anything else causes
+	 * crypto engine to return back incorrect results.
+	 */
+	qce_write(qce, REG_ENCR_XTS_DU_SIZE, cryptlen);
 }
 
 static int qce_setup_regs_skcipher(struct crypto_async_request *async_req,
-- 
2.25.1

