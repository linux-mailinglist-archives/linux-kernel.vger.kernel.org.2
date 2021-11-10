Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA2B44BFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhKJLFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhKJLEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:04:47 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67697C061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:01:18 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u17so2645027plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9azdKo5F+J5uwMC2ixM7Nsm7TiPQrz8paNWTMvpMYA=;
        b=oNmlJcKTe+eh2ZMyJqUZSrBrxw3liLRa0hprYwa+Cm2Ozm2SklXmhxnFotZsVrY62P
         +NL2+fMEpyfJ7bf5n5WaKlhIl1RauVCwadSI6Gi0pWSSnIItlBz6tb9/l4XEIet2J8ph
         fAfLWuJKmLENDHZ/hJVxKkvNveTAZdiyRe68Qj7H0LXCs+ZTYqdb4gkCr1YANkLk8Ysq
         PTOnuzQ+sgfMQbr1bFUpWx56ZJ0gQ2tSvCgU0jDXjty6E81wt5TqMBuAi/o+UQLPb9TF
         U16W/c9jnyM/sXRwIfMkh2KbpK13lwIL+H4GtAgs58Rm9lL7YmsFIPy4Uz6mAJOXZyKp
         FV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9azdKo5F+J5uwMC2ixM7Nsm7TiPQrz8paNWTMvpMYA=;
        b=U+rCaJZfT00sEmNIyKH1Jh2RBh2tCQTvaeTRrrcpWWR5W2tpE+Jl5JiXCa3eJ3r9eH
         qLsep5KLKOwMjz7wWtuygZfLULJjEd++FjF/SkhM2y1LfTWNdFf9Bb32XlMsmgq+wSzQ
         tnjPqdKz9YMldEpDtIcujXKb8NQBqsSaF24DeAvAFc+G51UtkYRGICgBMAlpqDxUByR8
         BQf5eyd4NmMMlpC9j3gRuTTh0QpTGca0Awjg+CTV+7qcQY+WNyI4sejkJ8GDi14riyXl
         USCsaI1kfZnw3M96LMf+ourGN1OqtqHlJ8PRX/82iYOvZMxLUyvGt/+3RexeP+mt3Sw4
         Zn5A==
X-Gm-Message-State: AOAM531mhknsOPpMciAh6gKKIVeQ4m30t4ezaHGq5uxvd6JmgKA/1adW
        rbxOKASxQe6zCHT/JhlKTdP/CYYQm9M26Q==
X-Google-Smtp-Source: ABdhPJy1IzEHqoNEaVIXA5NY0xAM6hTfadLNA2yjnX+KMkFg3QyIHjQuAInkClC6LpQVBZsa+iKiHA==
X-Received: by 2002:a17:90b:4a47:: with SMTP id lb7mr15822360pjb.243.1636542077802;
        Wed, 10 Nov 2021 03:01:17 -0800 (PST)
Received: from localhost.name ([122.161.52.143])
        by smtp.gmail.com with ESMTPSA id e11sm5585282pjl.20.2021.11.10.03.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:01:17 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, stephan@gerhold.net,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH v5 19/22] crypto: qce: Add 'sm8250-qce' compatible string check
Date:   Wed, 10 Nov 2021 16:29:19 +0530
Message-Id: <20211110105922.217895-20-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'sm8250-qce' compatible string check in qce crypto
driver as we add support for sm8250 crypto device in the
device-tree in the subsequent patch.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/crypto/qce/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 84ed9e253d5d..a7d7d7d5d02f 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -309,6 +309,7 @@ static const struct of_device_id qce_crypto_of_match[] = {
 	/* Add compatible strings as per updated dt-bindings, here: */
 	{ .compatible = "qcom,ipq6018-qce", },
 	{ .compatible = "qcom,sdm845-qce", },
+	{ .compatible = "qcom,sm8250-qce", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qce_crypto_of_match);
-- 
2.31.1

