Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BE9319400
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhBKUJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhBKUDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:03:11 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CE1C06121E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:01:39 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id c5so5117506qth.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H4BViZmMHUNQYYu9VpJJKST4ly897JCfdbGhTeJJKpE=;
        b=d8ymdmwFXCwez4mLOrfhKf5mFT0mnFj75aMOO4K6woC6nV8wCoQmGV1QYH3VAl3Uoq
         YgUVNwD6VcAu2MtRViHxmnA/sG2aJN2lKQsaKyZE3nas3C/Rxn32TDXlYHJYU8mj19zb
         U8eT3V9ICgvWeem//Hbl/x66G2nQXDXcvsgdjYbh8z7pH2gKpoiYzc+dqc9mUSH2A1zN
         6GqMDkGXeRidVvXqN8aa1dGIzSSa+kdDA4s8Ifz68XrFZhqZ/Xb8/V/GB6eTnnVFiw9S
         0Xl6Zy1hGthmd3iI1871kouJz4sFS5GbOaXXuiP6HwVdu1WvW5/tZCDjxvsXbp2sfDm+
         TpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4BViZmMHUNQYYu9VpJJKST4ly897JCfdbGhTeJJKpE=;
        b=Z88Ny5rppLqWaUAVNIyXCtkM2YcQLtagwPfH/1UYr0f00gyZuNXRyAVSktPwmiwglt
         Rrlpznbz52Upbg0ujpIgA1KT4X7+lmTUiH8j9q1AGAdkLHOQJ8hwMOgnrsES9mvQG9jN
         m1lJLDEaBEdfadiBf5GDkDZbJeshqhud/p3HwEOdiWLRFGHKhi+0R2OgIdndi6EAPzTI
         CZ9j1ACapasXsMm+Xm6S7L1c0IjWmWk32AUWul2i1kCx4dkP59uze57nJchgfnB4LU/c
         3Uxdk1EStgn43M6yGnzKULMgHmKc2vx/TT/8C9K4kHvgL4rZ3CHCRvv8bxCExy76mx0G
         b6sg==
X-Gm-Message-State: AOAM532Csrzp3F74BESe0uB0Q9ww1OhNXxo/roGloUWM3EI7ZtfoxoqE
        CfOevYI3Xd3HHV0mjBAn/ZH8Eg==
X-Google-Smtp-Source: ABdhPJwIoe4FnuMOqW/b3lz3GUJCoLf6gkWdWYGsr9A4a/o9PsOHB4lIcd2kDNU8FFABJdNkrtaB8w==
X-Received: by 2002:ac8:5992:: with SMTP id e18mr9063133qte.177.1613073698273;
        Thu, 11 Feb 2021 12:01:38 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id 17sm4496243qtu.23.2021.02.11.12.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 12:01:37 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 09/11] crypto: qce: common: Set data unit size to message length for AES XTS transformation
Date:   Thu, 11 Feb 2021 15:01:26 -0500
Message-Id: <20210211200128.2886388-10-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211200128.2886388-1-thara.gopinath@linaro.org>
References: <20210211200128.2886388-1-thara.gopinath@linaro.org>
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

