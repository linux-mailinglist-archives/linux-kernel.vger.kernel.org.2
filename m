Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265CA30DCE2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbhBCOfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhBCOec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:34:32 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3519CC0617AB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:33:17 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id n8so9286652qtp.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjZ2FfLW1/QZmo1tCtVZh16jkU5d2sBI2rN7J1hvIYw=;
        b=qAx/D5BiFOnHn97BwkyayC1pEdlp7lg77Shm0+zyftyMKEovfrABt1m7MxpP79jjje
         KPXkPgBjt/8U0iwg8lE/T2xE+Dg8QuAhVg/y4pkK0tCUVLamzZLRd578KdhzBlr2Pr4C
         puSlgFZfFMwbRyCF1ztVHI3blsfqH458We9sol4zp2Pca+ijbrZnCwHk8+aFJU/F5P2p
         TnJ2MDQ46kEpZdpwD/w+1a1uQ5gvXNE8GYISkqXswP7YbMJ2PW4jfj8dvV1mU4UyjyDb
         GlqLh0AK8LZpLGV+at6AesnQWxLCw1ZQRZRlpkRdZ3w7JigOo01gOLhl8IXEgyPm6uTC
         1cWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjZ2FfLW1/QZmo1tCtVZh16jkU5d2sBI2rN7J1hvIYw=;
        b=EqrOt+oBlytiIxasDeA697p9HfkLhl3cD8FMQUQCGiRVgWTQcvjughfOmSl1jvaXzJ
         qvAW1oRP1twekyjwD925WMUSDePnEP1+7BUvrOrFMOu8NtI/rhnI+97wwqH31asx87PX
         b+7cYePco+MVdw4WquxsiGiIAs+Gl59nclCpb5AGSPIBM7Xg9hYbdJJqQ4M6NJiIM15G
         MN+qwloJFELPnpBtvfOR3GNOj55jenGogZ+P35nMR0XDuuf9PcoZMI4EX0EVYG4t8lsY
         jTusjKn6kx9AZDndbZe/NkdLEj8wXGT375n+RgyrA43nhHNRQhNpFfcnHr41J5SqgB5S
         XJiA==
X-Gm-Message-State: AOAM532lvghFoTvX8tKANLEoellXgMB/D03U6sLH+/1+T4haKdew+TFl
        ixvBkOMDyI2cMobPhc6NRRwwXQ==
X-Google-Smtp-Source: ABdhPJyGTyzCp2GcprImfbxOpOGqHMbDBWnrcqGGWqNA2JyY99Gwid+Drcm45EP97wXKbPmXMgvkIA==
X-Received: by 2002:ac8:5ac9:: with SMTP id d9mr2534250qtd.123.1612362796444;
        Wed, 03 Feb 2021 06:33:16 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id v15sm1775433qkv.36.2021.02.03.06.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:33:15 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/11] crypto: qce: skcipher: Set ivsize to 0 for ecb(aes)
Date:   Wed,  3 Feb 2021 09:33:03 -0500
Message-Id: <20210203143307.1351563-8-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210203143307.1351563-1-thara.gopinath@linaro.org>
References: <20210203143307.1351563-1-thara.gopinath@linaro.org>
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
index 28bea9584c33..10e85b1fc0fd 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -356,7 +356,7 @@ static const struct qce_skcipher_def skcipher_def[] = {
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

