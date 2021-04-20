Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DD93650F9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 05:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhDTDgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 23:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhDTDgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 23:36:37 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA7CC06138D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:36:05 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id y12so27800972qtx.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T6+zvlvsLjNp5pODzoq20iFMKbJBEBGuZQctRXwxLzk=;
        b=pNVEqhlK3G5r1t9ZbVhVyTsSkjWwpKmkaqqnPdEt574Q98uODBUM4eRh28yHIOpMx3
         HKg/paiyZUU3nLBhWYWlTJM014w1Bjg9dWLaPUBgtQaJHsgcE4mi78omwnMvohX704Nf
         OpFbtAgbJiXYcL9GUOgpmoyWKrxtNN1IX0iB3voK8Bml9IDTHiJnweP4XddOSRXZMvuH
         OvQhA+h5NRmrYdLOBWAmxnXPh/aZ7a2/5tqGqJm3r7DwVO9zyaiR7Tm86iKliuDTcRC5
         fbO0K9r3neWTl7X+DsyYChdvxr8S3YL9UJTX1+lrjD/crPGq5xP1I9l+YGUNq3PCqcJ1
         /+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T6+zvlvsLjNp5pODzoq20iFMKbJBEBGuZQctRXwxLzk=;
        b=bvmuDGs/MPK1ALTrTeAoHGaicQllqKEsJJbO7eVJIo9W8kbfdEjU8c3fUsuTsaaAi2
         r211VzoWw+r1HIbjnyDCTExteY/mhggYYW5Td9bjCg7AWaJHST06mMSzwv20lyP2U9Rk
         h2qxDUdP8xl7IyuqMTFgMOLKTDXm+EE4nghyrKImvRulSCSc9X59EQAwxWYzLkFG3ZRs
         Oh8Fr7koscJrWG4Ov8+ygHy/8ilKSg0wAW8UMd5+W3PEHVv69nNOYwJIrQhshsZnlxu+
         IT82D+G4GlkRLVpaXS5A9H+QztCZ7/diET98IRi8mB60leEEbd9Zpk81iGRHghJwivP4
         pRIg==
X-Gm-Message-State: AOAM530BSzu10KqCZ8t2bbPppl2igc/9q9473xKV9J4OgCs0G3jUHrul
        Wu2cZQF2bkAiav85BOk/jDuY4w==
X-Google-Smtp-Source: ABdhPJxACoL4owQfv4aGWhhvZ7IAcpyiFm2fO3Q8fhVoOgfqwFjc7aCJ5+pqr6BzfLxpJmvMqCZXsg==
X-Received: by 2002:ac8:5ad5:: with SMTP id d21mr15067440qtd.198.1618889765198;
        Mon, 19 Apr 2021 20:36:05 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id b8sm3562643qka.117.2021.04.19.20.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 20:36:04 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [Patch v3 2/7] crypto: qce: common: Make result dump optional
Date:   Mon, 19 Apr 2021 23:35:57 -0400
Message-Id: <20210420033602.1729947-3-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420033602.1729947-1-thara.gopinath@linaro.org>
References: <20210420033602.1729947-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm crypto engine allows for IV registers and status register
to be concatenated to the output. This option is enabled by setting the
RESULTS_DUMP field in GOPROC  register. This is useful for most of the
algorithms to either retrieve status of operation or in case of
authentication algorithms to retrieve the mac. But for ccm
algorithms, the mac is part of the output stream and not retrieved
from the IV registers, thus needing a separate buffer to retrieve it.
Make enabling RESULTS_DUMP field optional so that algorithms can choose
whether or not to enable the option.
Note that in this patch, the enabled algorithms always choose
RESULTS_DUMP to be enabled. But later with the introduction of ccm
algorithms, this changes.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/common.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index dd76175d5c62..7b5bc5a6ae81 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -88,9 +88,12 @@ static void qce_setup_config(struct qce_device *qce)
 	qce_write(qce, REG_CONFIG, config);
 }
 
-static inline void qce_crypto_go(struct qce_device *qce)
+static inline void qce_crypto_go(struct qce_device *qce, bool result_dump)
 {
-	qce_write(qce, REG_GOPROC, BIT(GO_SHIFT) | BIT(RESULTS_DUMP_SHIFT));
+	if (result_dump)
+		qce_write(qce, REG_GOPROC, BIT(GO_SHIFT) | BIT(RESULTS_DUMP_SHIFT));
+	else
+		qce_write(qce, REG_GOPROC, BIT(GO_SHIFT));
 }
 
 #ifdef CONFIG_CRYPTO_DEV_QCE_SHA
@@ -219,7 +222,7 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 	config = qce_config_reg(qce, 1);
 	qce_write(qce, REG_CONFIG, config);
 
-	qce_crypto_go(qce);
+	qce_crypto_go(qce, true);
 
 	return 0;
 }
@@ -380,7 +383,7 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 	config = qce_config_reg(qce, 1);
 	qce_write(qce, REG_CONFIG, config);
 
-	qce_crypto_go(qce);
+	qce_crypto_go(qce, true);
 
 	return 0;
 }
-- 
2.25.1

