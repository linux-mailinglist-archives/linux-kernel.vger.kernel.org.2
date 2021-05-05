Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E492A374AB4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhEEVlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhEEVk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:40:58 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41031C06135D
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 14:39:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cl24-20020a17090af698b0290157efd14899so1744208pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 14:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gqMsEIhJm5EqUOgNeJCrpzezZPASaD0w7LK6NRTqosc=;
        b=pzbOscr85X4EFeeMDqwg9QrjOk6I1RQdc7g7pzKkYlY3dH0iLlhi72s1X2XWWMpM2s
         QvGZNRQjdPZvog/lGq4VdeZwsy30G1ovMEGiKDjmnF3dpiEVc4VY5vkv6HYQJFCfUfTf
         i2bPSmolUuj9lE2IcWYgkJhuddwgjd4LvHe7l2qploh7CB3JM4FVgmVE1glQAwOS5XQq
         wXIuEO7FDs7Fxr281q7alYvVu70/98vHSffE3Mt3lSJZom2aMOIdBTKI+W/EJDYnSKVP
         +3vhZCJfnYs76p4pTF/qWbBBv+Gnqoqrb8c0v7bdxxb6M0wFGRWsHruT524pi7sgCoQC
         nisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gqMsEIhJm5EqUOgNeJCrpzezZPASaD0w7LK6NRTqosc=;
        b=hQrinjIpYavzObzEJRWzCGmo8yPk1oaxc6B0rLngwlpA4qakUSrE812qFB8Mn7RYf1
         0lYSUO6UaSDHZIbq0RDPBKl/cSrn2X6uH/goHS0S1XOW++h+TWJNM+JQ1yiLNI2efRnL
         3HswbNA6H8F4aoewAf8imAnb90j0uoa9l1tBMb33ibFqA7MIhpzxBWxvXfcyFD1B2ose
         VFaExIBsGIJ6YotQKM76E9wDkpWH18HXh+KC9GMcEv6nFXRRD/VXuF1SVvfNnOVgrf4s
         ODyjIkPmTtv7T9hHjDdc2MTpnOlkYBFfUVghfVyCvyM0ubZ4xLys/T/SRO2/wozLZQHT
         uarQ==
X-Gm-Message-State: AOAM533JbNFyBmAHySI+xCqPV0zHzhMArRi/hqhwouFFy/3hZdT19III
        SUQbESrVxDNneMccn+Ye/kWxZQ==
X-Google-Smtp-Source: ABdhPJyf8nn6KA3HWAacIkBqf+Zbuzkl16c37vrDWzE9zSrrG100mjqBC57zNCVbO7cuI0BgF0fwNw==
X-Received: by 2002:a17:902:b609:b029:ec:e80d:7ebd with SMTP id b9-20020a170902b609b02900ece80d7ebdmr771721pls.75.1620250782828;
        Wed, 05 May 2021 14:39:42 -0700 (PDT)
Received: from localhost.localdomain.name ([223.235.141.68])
        by smtp.gmail.com with ESMTPSA id z26sm167031pfq.86.2021.05.05.14.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 14:39:42 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: [PATCH v2 16/17] crypto: qce: Defer probe in case interconnect is not yet initialized
Date:   Thu,  6 May 2021 03:07:30 +0530
Message-Id: <20210505213731.538612-17-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Qualcomm parts the qce crypto driver needs the interconnect between
the crypto block and main memory to be initialized first before the crypto
registers can be accessed. So it makes sense to defer the qce crypto driver
probing in case the interconnect driver is not yet probed.

This fixes the qce probe failure issues when both qce and
interconnect drivers are compiled as static part of the kernel.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bhupesh.linux@gmail.com
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/crypto/qce/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 3e742e9911fa..9915b184f780 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -222,6 +222,20 @@ static int qce_crypto_probe(struct platform_device *pdev)
 		return ret;
 
 	qce->mem_path = of_icc_get(qce->dev, "memory");
+
+	/* Check for NULL return path, which indicates
+	 * interconnect API is disabled or the "interconnects"
+	 * DT property is missing.
+	 */
+	if (!qce->mem_path)
+		/* On some qcom parts, the qce crypto block needs interconnect
+		 * paths to be configured before the registers can be accessed.
+		 * Check here for the same.
+		 */
+		if (!strcmp(of_id->compatible, "qcom,ipq6018-qce") ||
+		    !strcmp(of_id->compatible, "qcom,sdm845-qce"))
+			return -EPROBE_DEFER;
+
 	if (IS_ERR(qce->mem_path))
 		return PTR_ERR(qce->mem_path);
 
-- 
2.30.2

