Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD72374A91
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbhEEVki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbhEEVkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:40:17 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E97C06138D
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 14:39:16 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m37so2802507pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 14:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1sSf0qLJyLVYx1RDRkbOVw7ymMGOYYyNpXZ6BpinJ5I=;
        b=vEajL1EbcQ06XtvJ1SFAVyQg9rt87G7DnGNRmGmmwhV05ov7JKp/MGTvqT92eSrLdM
         qyberW4utabHgRDGWO631F6nZ0SEZKv7KF3Yd/QDYIeMEVBNJ01qpFMKdr8ENCT7BJWr
         r+5X6hyAWC3tDk+GZHLuNRyuo95TBxi3QboWSx0F0XEkUkjd7tRG0g1L0H+kJRobhi/B
         G5pxnV3loZcfLVGecyrCAHU2Aapi0lIXPzxZhPpSLlGuQJRI5k0jOviph5WhWjhsQpGu
         oQIU+a3l32fuiVZwwSZUZUEK7d8ib6vZcCQFqV5LgmwDcOwF+iOBpQ9NNdPH4Ocx3ojK
         rF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1sSf0qLJyLVYx1RDRkbOVw7ymMGOYYyNpXZ6BpinJ5I=;
        b=uZf6G/oD+0RDjOKzEM24b/4+Y/PUtDtsRUbXEG56NYmPqj98vL8tHL/pEaj/4WqztX
         eu3ZWexM1XtA7u8lwhqhtqCv1dLV8RrlJh4G26L0LiuYGPTYQuAVWXnP5Sm5W19dTgGR
         mLU2EbK+Q82Iqh2HhWZEiwRgb7scH6+gPlCZ91kMTr38sRmGys3JN3X+xx8C5qhPxSc/
         hDe9slFHeKwMpBPTw6/Q8I7ikYXTBwtRO6nYDo1X/ZytX/mdis4LxkFImESID6ZlmrWo
         6LlZ1N5cZtSIq2CbUT1h74Q2C2tKZ6vAv+1YxGtvoaloXlC6/0Z9BGB2wUtcJm+9mXl4
         +fvQ==
X-Gm-Message-State: AOAM532LHLKmtK/Zs7vE/tak9fmHUCQSwFNj5PWSVQkMj0ClN7FTLPYg
        GWFRZhwAhyisRnhH4+pmVqGJlw==
X-Google-Smtp-Source: ABdhPJw9/Qn/hjK7cYMjvGVZbkNf5lDvmamHWH1NqGTZaV28vRdoj48SBaVMt5+w6bIgqBIAxHT33g==
X-Received: by 2002:a63:e405:: with SMTP id a5mr891379pgi.89.1620250756407;
        Wed, 05 May 2021 14:39:16 -0700 (PDT)
Received: from localhost.localdomain.name ([223.235.141.68])
        by smtp.gmail.com with ESMTPSA id z26sm167031pfq.86.2021.05.05.14.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 14:39:16 -0700 (PDT)
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
Subject: [PATCH v2 12/17] crypto: qce: Print a failure msg in case probe() fails
Date:   Thu,  6 May 2021 03:07:26 +0530
Message-Id: <20210505213731.538612-13-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print a failure message (dev_err) in case the qcom qce crypto
driver probe() fails.

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
 drivers/crypto/qce/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 293d0bfe3aab..bae08fdfc44f 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -301,6 +301,8 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	icc_set_bw(qce->mem_path, 0, 0);
 err_mem_path_put:
 	icc_put(qce->mem_path);
+
+	dev_err(dev, "%s failed : %d\n", __func__, ret);
 	return ret;
 }
 
-- 
2.30.2

