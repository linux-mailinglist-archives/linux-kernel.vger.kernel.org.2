Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6907E44A479
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 03:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbhKICQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 21:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbhKICP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 21:15:58 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23910C061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 18:13:13 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y1so18068238plk.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 18:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluerivertech.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/KmtMbfeaXHuTAh4g4GRV6pvDUPLEEqbIUrWqrzrkr4=;
        b=VWNXSJ7c9oewp5zwmjgYyTofl8MWUpyO6jYRfVKQMpradF2g0kPx/a5xHL6KxsQ9wK
         MXAl9nBCktRejGnb+EpaTJXIlrbc/dLc3sDMzl7c8vOh9q9HJphZbsg/jkzuL5Lz1Fd3
         Eq8fEQ3T25FrYfXgtaWA5RBiCgHctFnk6ZWeEJoSawDdsHUVsr7MklNomCPrQ9pzQKLS
         2Or11Fc21Yzl/NwWgPDPxsseqlQkDKkYlnFK6PrBTUYnwE3FZqTfS4zzkANKXzgh1xvz
         bQ8/1spX5YWKdjvj26yB2zQATsbg4l5hceLCKGGYoAhmlFH/F66eFFK5KGsr3/0xmRcz
         agDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/KmtMbfeaXHuTAh4g4GRV6pvDUPLEEqbIUrWqrzrkr4=;
        b=TFCTstX8MzW3J+pWsuB5aOBE6l+btAQY45rL7CJBm6/XUAW9EKT6t1SyV9roBvCEpZ
         t9dxRNvcpmSksx8TxsgzDLpGWW1elN61cGGZjfP9tordrUhhh5jdn/GL9GfvxOhQvgf2
         3v9jTnrENVnxkGV8hxtC3B4DAmbaaHvydxnZlHlNDhOQl/2woDprMlAktVcSrkK7xxGW
         vDJv6lSG0FLuFOB/5ypl8n160A+uF69rjCozMrTToSUhks5adi08WBp0C8ATxzvCpbdZ
         UHB1zS13C2nSgYtka4mDEfBrls+EWEut/ukaHOfyQkgy1huBSbPbESnQbbCwCYErQsuh
         +WgA==
X-Gm-Message-State: AOAM530dhZK9dp2kTD/HE5qzAHyR3qcxkZzOrRX8iBmEPGM9MgM6hduF
        HmcOoElAG0CTHY6NzVRVgZqJkQ==
X-Google-Smtp-Source: ABdhPJyC/JZiHHGHtloHvx9nkuJ5gCvVSNoZw24JRS5IbnnnyMuqzg92vMXzIxZE9pBARpLr2NKFRw==
X-Received: by 2002:a17:902:c412:b0:141:f710:2a94 with SMTP id k18-20020a170902c41200b00141f7102a94mr3465223plk.1.1636423992630;
        Mon, 08 Nov 2021 18:13:12 -0800 (PST)
Received: from localhost.localdomain (c-73-231-33-37.hsd1.ca.comcast.net. [73.231.33.37])
        by smtp.gmail.com with ESMTPSA id 95sm576982pjo.2.2021.11.08.18.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 18:13:12 -0800 (PST)
From:   Brian Silverman <brian.silverman@bluerivertech.com>
Cc:     Brian Silverman <brian.silverman@bluerivertech.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Varka Bhadram <varkabhadram@gmail.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Dong Aisheng <b29396@freescale.com>,
        linux-can@vger.kernel.org (open list:MCAN MMIO DEVICE DRIVER),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] can: m_can: Disable and ignore ELO interrupt
Date:   Mon,  8 Nov 2021 18:12:40 -0800
Message-Id: <20211109021240.3013-1-brian.silverman@bluerivertech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the design of this driver, this condition is often triggered.
However, the counter that this interrupt indicates an overflow is never
read either, so overflowing is harmless.

On my system, when a CAN bus starts flapping up and down, this locks up
the whole system with lots of interrupts and printks.

Specifically, this interrupt indicates the CEL field of ECR has
overflowed. All reads of ECR mask out CEL.

Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Signed-off-by: Brian Silverman <brian.silverman@bluerivertech.com>
---
 drivers/net/can/m_can/m_can.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2470c47b2e31..91be87c4f4d3 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -204,16 +204,16 @@ enum m_can_reg {
 
 /* Interrupts for version 3.0.x */
 #define IR_ERR_LEC_30X	(IR_STE	| IR_FOE | IR_ACKE | IR_BE | IR_CRCE)
-#define IR_ERR_BUS_30X	(IR_ERR_LEC_30X | IR_WDI | IR_ELO | IR_BEU | \
-			 IR_BEC | IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | \
-			 IR_RF1L | IR_RF0L)
+#define IR_ERR_BUS_30X	(IR_ERR_LEC_30X | IR_WDI | IR_BEU | IR_BEC | \
+			 IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | IR_RF1L | \
+			 IR_RF0L)
 #define IR_ERR_ALL_30X	(IR_ERR_STATE | IR_ERR_BUS_30X)
 
 /* Interrupts for version >= 3.1.x */
 #define IR_ERR_LEC_31X	(IR_PED | IR_PEA)
-#define IR_ERR_BUS_31X      (IR_ERR_LEC_31X | IR_WDI | IR_ELO | IR_BEU | \
-			 IR_BEC | IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | \
-			 IR_RF1L | IR_RF0L)
+#define IR_ERR_BUS_31X      (IR_ERR_LEC_31X | IR_WDI | IR_BEU | IR_BEC | \
+			 IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | IR_RF1L | \
+			 IR_RF0L)
 #define IR_ERR_ALL_31X	(IR_ERR_STATE | IR_ERR_BUS_31X)
 
 /* Interrupt Line Select (ILS) */
@@ -810,8 +810,6 @@ static void m_can_handle_other_err(struct net_device *dev, u32 irqstatus)
 {
 	if (irqstatus & IR_WDI)
 		netdev_err(dev, "Message RAM Watchdog event due to missing READY\n");
-	if (irqstatus & IR_ELO)
-		netdev_err(dev, "Error Logging Overflow\n");
 	if (irqstatus & IR_BEU)
 		netdev_err(dev, "Bit Error Uncorrected\n");
 	if (irqstatus & IR_BEC)

base-commit: d2f38a3c6507b2520101f9a3807ed98f1bdc545a
-- 
2.20.1

