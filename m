Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7C53193F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhBKUHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhBKUCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:02:53 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB9EC0617AB
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:01:37 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id m144so6499559qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QVxt07NhH8i9s6gtmli+U/sos51ULXBrf5Wyl507Yss=;
        b=VpBxqcUzxTQuw+QYAmzO4hctY0VmJspmo6/IK/9FR6aVlrjGAJGeIxkEzHKiNBkGFP
         ByDXFmIKqkDmKiOCN6tslPbHpuitSWg/mkXhyS9G7cK+AIQtliCkrQl26BZETz4kWxWZ
         SmQeMhN+G1Ond83VwI3HEn/gx72dnkCp+B5ppeup4rY0CBAe5pgP6nAsXyv+Mzoi88Kp
         0dpgb/sc2TIfSun2TY47DZ+mWujQHHUB1xRG5CI7/NnpueQNOinA5l+DKnI4ftTcxNKW
         1tQF+yP3VXen3hJVKLNmZw7wPlS02sN7ID2Enj4xS3hcAE/Tvbzj0jUFk3pSNOwqrQOA
         SMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QVxt07NhH8i9s6gtmli+U/sos51ULXBrf5Wyl507Yss=;
        b=VTUGLnZiaDf42pTR+OronCt3ZDbwKtS6fmCbLjf0zBaZwc2hzNBEZODXN/KScDetGh
         YeFhFdkGG++4JPhMtfdke5N4H1xh7PNIFbjfNHLRpFtu99ZA4V9tCAf01ElZvRhZrhXg
         J2KOoztqrFuHwotFpwzzs9e+5n1prJu2HWKV5EvUgWwZUasnUS57F9ze7g6uZYIGbXOe
         EUrKA2+AYkJUYy9z2jM7mHwZKe72FRVd9pggQ5qrkO6S3ZYRYGaEtawsaEj1FI2lQiM5
         2Mhb4zqF9DViVLoPFVp/j/PeEm1mxXQrCKfqcE4PAAbHCWSn2DhJsYPwvsEEdWY4gTFf
         V+PA==
X-Gm-Message-State: AOAM533rSV31i2WeHEdOFc8YrZEluJmm9erVlMMo7xrwPtB4Mdj1tVPk
        8JEGgkXEtUzRmrNLytBCvq3WPtHvo3dH4A==
X-Google-Smtp-Source: ABdhPJxZmh8ro83WJhIR6p/rpciurw+BoKtlVT7oeK/pOCjeXKNk9PnPb350PyhBDMx5lgllk9cslA==
X-Received: by 2002:a05:620a:80e:: with SMTP id s14mr4872595qks.20.1613073696594;
        Thu, 11 Feb 2021 12:01:36 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id 17sm4496243qtu.23.2021.02.11.12.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 12:01:36 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 07/11] crypto: qce: skcipher: Set ivsize to 0 for ecb(aes)
Date:   Thu, 11 Feb 2021 15:01:24 -0500
Message-Id: <20210211200128.2886388-8-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211200128.2886388-1-thara.gopinath@linaro.org>
References: <20210211200128.2886388-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ECB transformations do not have an IV and hence set the ivsize to 0 for
ecb(aes).

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/skcipher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index c2f0469ffb22..11a2a30631af 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -353,7 +353,7 @@ static const struct qce_skcipher_def skcipher_def[] = {
 		.name		= "ecb(aes)",
 		.drv_name	= "ecb-aes-qce",
 		.blocksize	= AES_BLOCK_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
+		.ivsize		= 0,
 		.min_keysize	= AES_MIN_KEY_SIZE,
 		.max_keysize	= AES_MAX_KEY_SIZE,
 	},
-- 
2.25.1

