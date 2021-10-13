Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE0942BE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 13:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhJMLBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhJMLB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:01:28 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B040C06139D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:57:09 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y7so2095820pfg.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MT9l55bItKwW4zbHDysvvnWQI2UpXg0GRXR7AA0D6+o=;
        b=Hy2WLbWTgOpyChziGWJlhfOCbotX2DDfa5kzMQ5n6qYKet4py0CRZu1NhbxYnM7EkY
         0b6Hk7h0+GL9McCDXiPm82b6yveXBn+uE1fUPYfb91MlcEKoNuj2XG+0Yfk5gQS1xcH7
         NlANVKMJF7eHtBfZaLGwER+EPMvZmFInxy10FQElVZ/DT1UEAv4vnQS/kr3tU67QVj7+
         eCYsAXk7YNwIkgIqcSoc2+J4Yxo2lrfmIkyWSTzr7dHqp/a/+MH/Q/bGaJ5ZXnPDbO2k
         ggcP+iyXvwav4A1eMPl+hikrhhf9vFts7RIJ8uuS1ivYHWrOk4ZRvlU22SOw8xHi4Iev
         jnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MT9l55bItKwW4zbHDysvvnWQI2UpXg0GRXR7AA0D6+o=;
        b=d55CdTJlSLjd/BYwbFM+lAXV2zaVhsEDZK0Aasvm/drSFTsduFW+FUNIeuxCLepZcD
         DVj1uE6PZ7TiRQ7XtAimBgcLUbyeEbDxOy7DRy/grocAQcMrVfPsdrHQvwdHERgYN66P
         8doPjQzGaHWOvV4bu1u+dbRqqm5JEqlCo8C6z9hNM4IKuoP5TPSQMHuK1UGSgXAuM4Je
         U/spMXch3OI4KgW15wimht3rS0VBGHYnHsxNo18X4adKm3Qalnc+QXwW28bNXdWIIQ/2
         U8pqavEa7w3YjNkKav0P6bTYqlGYFyVgNdiQZW21nTVYeyvuo7AKTlkOLca1kphHkmST
         LJEA==
X-Gm-Message-State: AOAM5309msaoarsa+p+3rcVgX1hbSwSGVs7bJDS6/ia4Bwj8HrakEfBR
        LbD4oU/4Op6TK+gVnRpi1swppA==
X-Google-Smtp-Source: ABdhPJxGPNE1Rn2FeiHga0quikOJnmZU+UBnn7ejHiZqtRROQ/ynCxTBRbppnJCacUDIkwaXGM+cFg==
X-Received: by 2002:a63:5453:: with SMTP id e19mr27288018pgm.178.1634122628771;
        Wed, 13 Oct 2021 03:57:08 -0700 (PDT)
Received: from localhost.name ([122.161.48.68])
        by smtp.gmail.com with ESMTPSA id b13sm6155351pjl.15.2021.10.13.03.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:57:08 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH v4 16/20] crypto: qce: core: Make clocks optional
Date:   Wed, 13 Oct 2021 16:25:37 +0530
Message-Id: <20211013105541.68045-17-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
References: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thara Gopinath <thara.gopinath@linaro.org>

On certain Snapdragon processors, the crypto engine clocks are enabled by
default by security firmware and the driver need not/ should not handle the
clocks. Make acquiring of all the clocks optional in crypto enginer driver
so that the driver intializes properly even if no clocks are specified in
the dt.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 2ab0b97d718c..576c416461f9 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -213,19 +213,19 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (IS_ERR(qce->mem_path))
 		return PTR_ERR(qce->mem_path);
 
-	qce->core = devm_clk_get(qce->dev, "core");
+	qce->core = devm_clk_get_optional(qce->dev, "core");
 	if (IS_ERR(qce->core)) {
 		ret = PTR_ERR(qce->core);
 		goto err_mem_path_put;
 	}
 
-	qce->iface = devm_clk_get(qce->dev, "iface");
+	qce->iface = devm_clk_get_optional(qce->dev, "iface");
 	if (IS_ERR(qce->iface)) {
 		ret = PTR_ERR(qce->iface);
 		goto err_mem_path_put;
 	}
 
-	qce->bus = devm_clk_get(qce->dev, "bus");
+	qce->bus = devm_clk_get_optional(qce->dev, "bus");
 	if (IS_ERR(qce->bus)) {
 		ret = PTR_ERR(qce->bus);
 		goto err_mem_path_put;
-- 
2.31.1

