Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB375374B4D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 00:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhEEWhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 18:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhEEWhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 18:37:37 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7430DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 15:36:40 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id v123so3099593ioe.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 15:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5yTMFAu5PQsqsLYoETACnPdjv/EWrNXFjZpRnoGVc4=;
        b=lVsrHbFc0939vNdUid2cZ2fr99h4kHZIfKGRJDOgCrIhNh9XofgTSyIuGJZg0d7o3H
         mCQGXtgFKGJQ46r8aMAOX7EECWZ0lKfBfO4LmEtak8E38ZTgFbxYAJoLYBE130akWGMM
         6VNF6AYaIRu+fHtEVfOPQUGJqPRfWM2/9waq+topQUC1s2pByK1hYvUp6Qfn5HLT/w30
         uMrXeJSxYnduuMLQHn6gRAsYu+Dhb5mbxA90gsqzMT7pVK/FRheiJ8UJoyHB0hbCsoP1
         Vy2JyM3Qe5NNH0TO5ckUyzDTaalXcOX649iiVoae4XX0lUBtYsmutEOQOY7lmfds0lxu
         55Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5yTMFAu5PQsqsLYoETACnPdjv/EWrNXFjZpRnoGVc4=;
        b=DPCzqEdMlvuyv187DNmSQsEs33CaYuTIDRyXkhUr2owcbTG/zu0iOnJ6gd67Lecj79
         seZcgyYejedXKXNqjXyr2ZQlr93q5KLulx/6T+1oc1tTFLJCFlCInSmSzLtmR0w/+v7A
         UQOjbwKIzZb+BqurNktinFVH4XFniovkX8YbSFOMxZOw5691hhht7v72RJR7fz6R/QY7
         oK/g4jorfBq8esS4PhhbdPYBPOiYZXkidRhbHCVEltLIcs63RZMOLz09aulBo/MFjHOr
         P4hZd0WyFatAjBbRG6vh1xkmqYpD9CeBr585wv2/9scT8LId/mR/89d1W9Qc2XK99gJP
         SR1Q==
X-Gm-Message-State: AOAM533aDYqu7PUpI+PI3fW+KESGKH44/FT0usKGxRc+qjeh3Ss+dRFk
        iu6FiUi9NHa+3Ch7q7V6ZrDNIg==
X-Google-Smtp-Source: ABdhPJzc8yQhQ6tcpCvw7VnovW6xB/ySmSY4y/2nRFN3KI/fUs6X02O+SPFSCzdSbC/4a1e7e1Lbfg==
X-Received: by 2002:a6b:d918:: with SMTP id r24mr665545ioc.25.1620254199959;
        Wed, 05 May 2021 15:36:39 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id n23sm248957ion.53.2021.05.05.15.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 15:36:39 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ipa: fix inter-EE IRQ register definitions
Date:   Wed,  5 May 2021 17:36:36 -0500
Message-Id: <20210505223636.232527-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gsi_irq_setup(), two registers are written with the intention of
disabling inter-EE channel and event IRQs.

But the wrong registers are used (and defined); the ones used are
read-only registers that indicate whether the interrupt condition is
present.

Define the mask registers instead of the status registers, and use
them to disable the inter-EE interrupt types.

Fixes: 46f748ccaf01 ("net: ipa: explicitly disallow inter-EE interrupts")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c     |  4 ++--
 drivers/net/ipa/gsi_reg.h | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 9f06663cef263..e374079603cf7 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -211,8 +211,8 @@ static void gsi_irq_setup(struct gsi *gsi)
 	iowrite32(0, gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET);
 
 	/* The inter-EE registers are in the non-adjusted address range */
-	iowrite32(0, gsi->virt_raw + GSI_INTER_EE_SRC_CH_IRQ_OFFSET);
-	iowrite32(0, gsi->virt_raw + GSI_INTER_EE_SRC_EV_CH_IRQ_OFFSET);
+	iowrite32(0, gsi->virt_raw + GSI_INTER_EE_SRC_CH_IRQ_MSK_OFFSET);
+	iowrite32(0, gsi->virt_raw + GSI_INTER_EE_SRC_EV_CH_IRQ_MSK_OFFSET);
 
 	iowrite32(0, gsi->virt + GSI_CNTXT_GSI_IRQ_EN_OFFSET);
 }
diff --git a/drivers/net/ipa/gsi_reg.h b/drivers/net/ipa/gsi_reg.h
index b4ac0258d6e10..cb42c5ae86fa2 100644
--- a/drivers/net/ipa/gsi_reg.h
+++ b/drivers/net/ipa/gsi_reg.h
@@ -53,15 +53,15 @@
 #define GSI_EE_REG_ADJUST			0x0000d000	/* IPA v4.5+ */
 
 /* The two inter-EE IRQ register offsets are relative to gsi->virt_raw */
-#define GSI_INTER_EE_SRC_CH_IRQ_OFFSET \
-			GSI_INTER_EE_N_SRC_CH_IRQ_OFFSET(GSI_EE_AP)
-#define GSI_INTER_EE_N_SRC_CH_IRQ_OFFSET(ee) \
-			(0x0000c018 + 0x1000 * (ee))
+#define GSI_INTER_EE_SRC_CH_IRQ_MSK_OFFSET \
+			GSI_INTER_EE_N_SRC_CH_IRQ_MSK_OFFSET(GSI_EE_AP)
+#define GSI_INTER_EE_N_SRC_CH_IRQ_MSK_OFFSET(ee) \
+			(0x0000c020 + 0x1000 * (ee))
 
-#define GSI_INTER_EE_SRC_EV_CH_IRQ_OFFSET \
-			GSI_INTER_EE_N_SRC_EV_CH_IRQ_OFFSET(GSI_EE_AP)
-#define GSI_INTER_EE_N_SRC_EV_CH_IRQ_OFFSET(ee) \
-			(0x0000c01c + 0x1000 * (ee))
+#define GSI_INTER_EE_SRC_EV_CH_IRQ_MSK_OFFSET \
+			GSI_INTER_EE_N_SRC_EV_CH_IRQ_MSK_OFFSET(GSI_EE_AP)
+#define GSI_INTER_EE_N_SRC_EV_CH_IRQ_MSK_OFFSET(ee) \
+			(0x0000c024 + 0x1000 * (ee))
 
 /* All other register offsets are relative to gsi->virt */
 
-- 
2.27.0

