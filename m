Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5FE3AF4AE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhFUSRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhFUSQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:16:50 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5519C08ED72
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:56:33 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id k5so2491890ilv.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e7K1tI1lYYipcc5AxyBMccBKPqQyHUZh+yTOba27WkI=;
        b=r+aFpl3Foyz72/gjSSAg+lldx+pun+eZ88u2hTBG+NLXfsOqggy8dK71eC8MfgMf6G
         hBynC3uTNpuXAQEcI6RVrZaLgRltLGcQcsXYcdAmWoOtjoQ/5th3+vI8CZNZnAl1EqTU
         j1dzgv9w64q99bRnBL0FxXXxgkZxjp4CjAANZYEoSipntJIZnZngXTFRet0MEX1+UGBY
         HEmMqRHc6j2DsVVne108UYkYySEeGn9tMjM46ytcPcFBq+Oy+jUnRMpXZamH/e5MvJRW
         pf+ntvwEzt4b5YuTeiEnyQksNTYCfWjuHWlU/JhF66f8RMBR3a6aunzaoKmMUVtjj32f
         9jEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7K1tI1lYYipcc5AxyBMccBKPqQyHUZh+yTOba27WkI=;
        b=Buav+isIMZh6fquXBS3x8mbgAtbiwXkl1PtUFGGNVLbh0NXUOSuxeeM+8wBjgeFgWE
         VkKWnZyNb7Xp8tEkNZZ4S7e03kRAX9rNpHME0RVlqJDkU0FnfiI3BspN9ZDc+B47rF7v
         UKZBFiFfa4ahrMPhYKFC8K5hyuW4n5iyUgvM2WnC2FUuvDp8fXetnZ/55+JYlBR7KSdP
         TC10fKi37+Ab6AjXe1PEjfIgXvyQWbpRrPuHW1b1HrXS3KzgLeYkgb2fvpdrqNpIBl8U
         ASvp8H62f6pf0mMlusma1cId0ARkEwbRik7tIRm2eShJNCDqtcaWYjSWfeyn4iOYQlmX
         yaYA==
X-Gm-Message-State: AOAM532V5642Yo7U2/TTCWyTJ+kol+R4E19S6MgW+Z7x/6IuSvF1Dhkx
        Wuk5D4SIhQj9P8a9NXE7VR+I5A==
X-Google-Smtp-Source: ABdhPJzEGV8fxJnVHIDdHh/kWNrQRPwXUvK6Q/THZvhVYfryfYnKcD/PgBCGPy2ASGLAuVwDgMRgOA==
X-Received: by 2002:a05:6e02:2183:: with SMTP id j3mr6219006ila.244.1624298193140;
        Mon, 21 Jun 2021 10:56:33 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id m13sm6259264iob.35.2021.06.21.10.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 10:56:32 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        jamipkettunen@gmail.com, bjorn.andersson@linaro.org,
        agross@kernel.org, elder@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/6] net: ipa: inter-EE interrupts aren't always available
Date:   Mon, 21 Jun 2021 12:56:23 -0500
Message-Id: <20210621175627.238474-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210621175627.238474-1-elder@linaro.org>
References: <20210621175627.238474-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GSI inter-EE interrupts are not supported prior to IPA v3.5.
Don't attempt to initialize them in gsi_irq_setup() for hardware
that does not support them.

Originally proposed by AngeloGioacchino Del Regno.

Link: https://lore.kernel.org/netdev/20210211175015.200772-4-angelogioacchino.delregno@somainline.org
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c     | 13 ++++++++++---
 drivers/net/ipa/gsi_reg.h |  3 ++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index e374079603cf7..efd826e508bce 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -210,9 +210,16 @@ static void gsi_irq_setup(struct gsi *gsi)
 	iowrite32(0, gsi->virt + GSI_CNTXT_GLOB_IRQ_EN_OFFSET);
 	iowrite32(0, gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET);
 
-	/* The inter-EE registers are in the non-adjusted address range */
-	iowrite32(0, gsi->virt_raw + GSI_INTER_EE_SRC_CH_IRQ_MSK_OFFSET);
-	iowrite32(0, gsi->virt_raw + GSI_INTER_EE_SRC_EV_CH_IRQ_MSK_OFFSET);
+	/* The inter-EE interrupts are not supported for IPA v3.0-v3.1 */
+	if (gsi->version > IPA_VERSION_3_1) {
+		u32 offset;
+
+		/* These registers are in the non-adjusted address range */
+		offset = GSI_INTER_EE_SRC_CH_IRQ_MSK_OFFSET;
+		iowrite32(0, gsi->virt_raw + offset);
+		offset = GSI_INTER_EE_SRC_EV_CH_IRQ_MSK_OFFSET;
+		iowrite32(0, gsi->virt_raw + offset);
+	}
 
 	iowrite32(0, gsi->virt + GSI_CNTXT_GSI_IRQ_EN_OFFSET);
 }
diff --git a/drivers/net/ipa/gsi_reg.h b/drivers/net/ipa/gsi_reg.h
index cb42c5ae86fa2..bf9593d9eaead 100644
--- a/drivers/net/ipa/gsi_reg.h
+++ b/drivers/net/ipa/gsi_reg.h
@@ -52,7 +52,8 @@
  */
 #define GSI_EE_REG_ADJUST			0x0000d000	/* IPA v4.5+ */
 
-/* The two inter-EE IRQ register offsets are relative to gsi->virt_raw */
+/* The inter-EE IRQ registers are relative to gsi->virt_raw (IPA v3.5+) */
+
 #define GSI_INTER_EE_SRC_CH_IRQ_MSK_OFFSET \
 			GSI_INTER_EE_N_SRC_CH_IRQ_MSK_OFFSET(GSI_EE_AP)
 #define GSI_INTER_EE_N_SRC_CH_IRQ_MSK_OFFSET(ee) \
-- 
2.27.0

