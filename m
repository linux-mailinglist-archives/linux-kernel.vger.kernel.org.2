Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2A6398F83
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhFBQFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFBQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:05:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0DBC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 09:03:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h16so1927075pjv.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpuA/7oLq4UEnVc4i14SbU6FY6IGX2Ds0P5xLrnP6MQ=;
        b=b1zwPRNHAckpnbPEFF1zZ5XnE4ONYVpzSlgziJzblDRIHeKZDJAZYMj0XZf+SLMKfI
         GsLNTwTgcPio9fAtA8qnLtAcqYPlx6yNu0LmYnne6v98zhXXGQkYTnPGHTHPplJeL5Hp
         1gTmbGc9xv39z2Xpw1AV3pWrhDzNQ5G4mDH5mI63ANhItu14JGvpeWcb3LuhOLyz0C8R
         CCg41pVQMvyj//sHkqlmJE4sScrvNW3tdf4b1gBsdmi0NOLDXanRIjPvpUvfYeqIm9E4
         j/PS0FlrA5zGwggZKco5F8KCfFIqRm1sPjaGTS2Y84da7W8v6jAIpmMu3ER8wJYrVXBY
         yDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpuA/7oLq4UEnVc4i14SbU6FY6IGX2Ds0P5xLrnP6MQ=;
        b=kQ20e/ypLwuMiL/qHoLMkCJKkAsOTXYzgs51KdHLDiB7Pp7yeQwwAmX2FZtluHsEZ1
         1NbWOn/p4UG9YTbLRZH0MSFFOOD9/b8nmCD2ENWaBJjunVcxDrjag3n430rdt4wiAkNH
         h3aVrCwj7mxBmRI89jFKsNP+ZUcmIgtBz9U1qzXrMK2b/tELZTXvMpGV6DqpxqsBhGrJ
         hXWmEcKd/Bplc8JVz9mojdX8twH2ZK9nNmeRuKNtFOCg50qn1e7d0dzvAHm+/9Vw8Q+n
         zDudW1V/pIU3UP3UchXRz0bLbufi1e36cYk+sZ7rI/mcCi7wCEDhkRHTYIB3e6ggWj54
         NEhw==
X-Gm-Message-State: AOAM5333JZ/KXMm3OORzMIV+9zdYpnGOr7eKVkpj669FA2AMdu/oBHcP
        rQIOIW1SYWb9AgN/U+WyUr0=
X-Google-Smtp-Source: ABdhPJzKNynNhIu8RHjcCvOwPltTdjpU5YPsnVZkvT9iXrAralrXzbFoUXEn1KuYyZLgQsDSTmhx0Q==
X-Received: by 2002:a17:90b:4d82:: with SMTP id oj2mr31057179pjb.61.1622649819956;
        Wed, 02 Jun 2021 09:03:39 -0700 (PDT)
Received: from localhost.localdomain ([183.82.156.71])
        by smtp.googlemail.com with ESMTPSA id h20sm105332pfq.83.2021.06.02.09.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 09:03:39 -0700 (PDT)
From:   Manikishan Ghantasala <manikishanghantasala@gmail.com>
Cc:     manikishanghantasala@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: fix coding-style issues in r8192U_hw.h
Date:   Wed,  2 Jun 2021 21:33:31 +0530
Message-Id: <20210602160333.62163-1-manikishanghantasala@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

staging: rtl8192u: r8192U_hw.h: Clear the coding-style issue

"Macros with complex values should be enclosed in parentheses"
by enclosing values in parantheses.
Modified spacing around "|" and removed a space before tab.

Signed-off-by: Manikishan Ghantasala <manikishanghantasala@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_hw.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index 8d3a592f1c35..27c96493006a 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -88,7 +88,7 @@ enum _RTL8192Usb_HW {
 #define RX_FIFO_THRESHOLD_MASK (BIT(13) | BIT(14) | BIT(15))
 #define RX_FIFO_THRESHOLD_SHIFT 13
 #define RX_FIFO_THRESHOLD_NONE 7
-#define MAX_RX_DMA_MASK 	(BIT(8) | BIT(9) | BIT(10))
+#define MAX_RX_DMA_MASK	(BIT(8) | BIT(9) | BIT(10))
 #define RCR_MXDMA_OFFSET	8
 #define RCR_FIFO_OFFSET		13
 #define RCR_ONLYERLPKT		BIT(31)			// Early Receiving based on Packet Size.
@@ -221,14 +221,13 @@ enum _RTL8192Usb_HW {
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
-
+#define RATE_ALL_CCK		(RATR_1M | RATR_2M | RATR_55M | RATR_11M)
+#define RATE_ALL_OFDM_AG	(RATR_6M | RATR_9M | RATR_12M | RATR_18M |\
+				 RATR_24M | RATR_36M | RATR_48M | RATR_54M)
+#define RATE_ALL_OFDM_1SS	(RATR_MCS0 | RATR_MCS1 | RATR_MCS2 | RATR_MCS3 |\
+				 RATR_MCS4 | RATR_MCS5 | RATR_MCS6 | RATR_MCS7)
+#define RATE_ALL_OFDM_2SS	(RATR_MCS8 | RATR_MCS9 | RATR_MCS10 | RATR_MCS11 |\
+				 RATR_MCS12 | RATR_MCS13 | RATR_MCS14 | RATR_MCS15)
 	EPROM_CMD		= 0xfe58,
 #define Cmd9346CR_9356SEL	BIT(4)
 #define EPROM_CMD_OPERATING_MODE_SHIFT 6
-- 
2.25.1

