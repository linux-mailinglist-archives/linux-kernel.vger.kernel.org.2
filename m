Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7DB398E06
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhFBPMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhFBPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:12:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76756C061756
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 08:10:48 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q15so2453504pgg.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a9mH2b19KKqcLod1ABGLq+gY5WhpO9fgbJf5zaTl/ZU=;
        b=SWB4USm1zFIH5OjqBrJAoP27QMcDTsfRuq51kSBU12BhXk7MIikDkT1Qob+iS9bQ5J
         mUIXkMaYhHFutnSIpxKFMiwRBsPAF08Et3QPtq5IIJlkqyQiOJ8bZlkT573nL0C+oiWi
         /BCuBgShuO92aN3ziUV6tAdWs+viSNQNgVSkv+clcO7Ey+f/6u9QocxI8BMRMREMO4mO
         kW1VKG0KwvS5yyMDFC/KLAbLXQ597ZBolXnrjo8cBLwWYb0EI+VFam/fZTb7Jj8ywSWj
         nF31CYQFRiXcViYYH8Y1CDSi+hAC0V6rOzCpfSsPAsgL0xCMC2KCrMFKWYnRAev4gB8k
         c5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a9mH2b19KKqcLod1ABGLq+gY5WhpO9fgbJf5zaTl/ZU=;
        b=GaIHIympyN5qIcdUofKKeYLo8RuREa10S0hCXSdbCWKyxOuUtJNe4F4ZkKJkqWZ5Vh
         UtE6ySGqPzU5/k64iP84YnqiabfNffxrGmzZ2i8w21jpblu5R3EjrDZuHExfUPl6g2kJ
         zsEeXSTYBKr6RJej1Ygbv04QJHIE7hs5sOVUj4zWh5X4dYmYhFRc/sCL7/GqLRyrbkfw
         SWBTzcwr+VYOzwlsL1CDTjAKYw2cbLEF1gCwvio7NNSSs3ZdfL6vDB8dKxjGPXtdXrdJ
         NPOUv8HHFFSHyyPVbDGHGKQqroU3XrfKETY9bMqlQZU5O5OpWSIB3l/UKwYxOM9UrfIh
         71cg==
X-Gm-Message-State: AOAM533I/yW94ZXXGfPd1Y5KdSnAu4RW9IYXwOjicCvQbwIxTof2923T
        /f3mwU1nVeHHAxGgNeMSnfNr3JxedxhdCZHL
X-Google-Smtp-Source: ABdhPJzxrjUCgP7MagHPiv6h0YrSPlVHO8REd2vSRfBzLYEVCF2h13gPIdFuKT145JajrVXjzyqYlA==
X-Received: by 2002:a63:164f:: with SMTP id 15mr34464289pgw.175.1622646648000;
        Wed, 02 Jun 2021 08:10:48 -0700 (PDT)
Received: from localhost.localdomain ([183.82.156.71])
        by smtp.googlemail.com with ESMTPSA id j2sm4812536pji.34.2021.06.02.08.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 08:10:47 -0700 (PDT)
From:   sh4nnu <manikishanghantasala@gmail.com>
Cc:     manikishanghantasala@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: fix coding-style issues in r8192U_hw.h
Date:   Wed,  2 Jun 2021 20:40:33 +0530
Message-Id: <20210602151038.53794-1-manikishanghantasala@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

staging: rtl8192u: r8192U_hw.h: Clear the coding-style issue

"Macros with complex values should be enclosed in parantheses"
by enclosing values in parantheses.
Modified spacing around "|" and removed a space before tab.

Signed-off-by: sh4nnu <manikishanghantasala@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_hw.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index 8d3a592f1c35..aabe03721d99 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -88,7 +88,7 @@ enum _RTL8192Usb_HW {
 #define RX_FIFO_THRESHOLD_MASK (BIT(13) | BIT(14) | BIT(15))
 #define RX_FIFO_THRESHOLD_SHIFT 13
 #define RX_FIFO_THRESHOLD_NONE 7
-#define MAX_RX_DMA_MASK 	(BIT(8) | BIT(9) | BIT(10))
+#define MAX_RX_DMA_MASK		(BIT(8) | BIT(9) | BIT(10))
 #define RCR_MXDMA_OFFSET	8
 #define RCR_FIFO_OFFSET		13
 #define RCR_ONLYERLPKT		BIT(31)			// Early Receiving based on Packet Size.
@@ -221,13 +221,13 @@ enum _RTL8192Usb_HW {
 #define	RATR_MCS14		0x04000000
 #define	RATR_MCS15		0x08000000
 // ALL CCK Rate
-#define RATE_ALL_CCK		RATR_1M|RATR_2M|RATR_55M|RATR_11M
-#define RATE_ALL_OFDM_AG	RATR_6M|RATR_9M|RATR_12M|RATR_18M|RATR_24M\
-							|RATR_36M|RATR_48M|RATR_54M
-#define RATE_ALL_OFDM_1SS	RATR_MCS0|RATR_MCS1|RATR_MCS2|RATR_MCS3 | \
-							RATR_MCS4|RATR_MCS5|RATR_MCS6|RATR_MCS7
-#define RATE_ALL_OFDM_2SS	RATR_MCS8|RATR_MCS9	|RATR_MCS10|RATR_MCS11| \
-							RATR_MCS12|RATR_MCS13|RATR_MCS14|RATR_MCS15
+#define RATE_ALL_CCK		(RATR_1M | RATR_2M | RATR_55M | RATR_11M)
+#define RATE_ALL_OFDM_AG	(RATR_6M | RATR_9M | RATR_12M | RATR_18M |\
+				 RATR_24M | RATR_36M | RATR_48M | RATR_54M)
+#define RATE_ALL_OFDM_1SS	(RATR_MCS0 | RATR_MCS1 | RATR_MCS2 | RATR_MCS3 |\
+				 RATR_MCS4 | RATR_MCS5 | RATR_MCS6 | RATR_MCS7)
+#define RATE_ALL_OFDM_2SS	(RATR_MCS8 | RATR_MCS9 | RATR_MCS10 | RATR_MCS11 |\
+				 RATR_MCS12 | RATR_MCS13 | RATR_MCS14 | RATR_MCS15)
 
 	EPROM_CMD		= 0xfe58,
 #define Cmd9346CR_9356SEL	BIT(4)
-- 
2.25.1

