Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE85B30DCEC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhBCOfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhBCOes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:34:48 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5E5C061354
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:33:19 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z32so234398qtd.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H4BViZmMHUNQYYu9VpJJKST4ly897JCfdbGhTeJJKpE=;
        b=Fn9CA4YwyxlXYNEjYdibrpe1DxpcKeD8/v0w0LcbTQArYbUr1mqMEehOF8wsJYUpv6
         FBMdrK0DQQVx8JrH+CY1ihpqsT+/ma+PyoAw+0CYQLXmYM6LvFDUZph1/wYQF/7rIF4t
         7HcEwqOEQW4AK4YiGOY1bNGUp41ctQael1o+fRjNzz2bQZLh3LoKstrw7TXBVBCjB3v9
         ls3zCZM/mMcb2ZKtVXW0GDHzAgSgStI1WO6IIVsBAkTy15kfge32Qm8E9iTu4UdMzxyv
         8OXAYTjeRdSKw4tUV0PsGlWcRFz+aBXnJq3WwMul7NyeJKyKgHBruIpa2SEzl7+7QZZl
         xETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4BViZmMHUNQYYu9VpJJKST4ly897JCfdbGhTeJJKpE=;
        b=pm+b8WKK2O3rgfJQapdjFT6j6L04P7B9cHIMyTzegJ+eptaKLUnrnOO8UWWTXdlXEi
         wvQ3F6hf/GZVsxuJVMJ6w+kvCERhvsNtjSnWL6iP8f/h214HsBHND4Gpx4PNfUjbHTyA
         CjkMPBjjndZjafL6yEBsk7HbyyJu533hamt2JkfUXul/OJnhAaIybKMuH6N10ddOooUV
         VExSNEI2TWiYMmf0r4strv8di3L77qlnSCRSNp+PxZFmeBVbJzRiwkzGojAVZSLzhgc9
         xwXRKD2zRml/QGk7uHrihq+dGwmPaw3dmgo0mobKL/FdD/GqJRroRT/bZ4C5rzdwoQxH
         l7/g==
X-Gm-Message-State: AOAM5315aMjehmw6WWW+kQHEVrHH4nYsc/SYT3ZOsEFEsTcxQxPcYNde
        wbhzNrMVTmhmCijKHIx/uucJ76OJ4L1OFA==
X-Google-Smtp-Source: ABdhPJwh7/mykZlq/TuNp0sNl6eKd27+UNFUfFdP00kXLjF/61T/Y9e8QvsIx7ZhAdQ8tInlk+j2gA==
X-Received: by 2002:aed:2f86:: with SMTP id m6mr2580104qtd.253.1612362798885;
        Wed, 03 Feb 2021 06:33:18 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id v15sm1775433qkv.36.2021.02.03.06.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:33:18 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/11] crypto: qce: common: Set data unit size to message length for AES XTS transformation
Date:   Wed,  3 Feb 2021 09:33:05 -0500
Message-Id: <20210203143307.1351563-10-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210203143307.1351563-1-thara.gopinath@linaro.org>
References: <20210203143307.1351563-1-thara.gopinath@linaro.org>
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

