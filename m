Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1612B357FA7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhDHJpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:45:36 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37576 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231341AbhDHJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:45:24 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 675344051F;
        Thu,  8 Apr 2021 09:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617875113; bh=2ECs4iyrkEFhuwCrAjvTGLneI7YBEwV7A8GEtnwY84M=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=MhSR6MjnZutKtP/6AnC+2zFeZFsU5Yp0uLsDdJGhTrlxg5vXuvVMP9UofhEbA6Y30
         sB9oJQHBlgl4hyZj6U1U7PvFexDGl4zHc0Lcu2ZsmtS3V7V7NrX2OXEUnV8T+73WLH
         Thp9n7oi8Sf9+qZx0q3Rl6MbnPdLI+aPhDMeKANUh3E1KwoElXOtCshYERDQzjaTpw
         //fZJZj8fZMQOeQc52YGwVGiyJEQ0x3pfJTkOw7xwCd7kEcDWEbqVIQ2oAEDRz94wA
         QOI+rd3z6aGXUyH3ckPkMNzIiMJgOcfkdSlB7+7F0xvLyn+UWHsEaDz6RvRpobe3kv
         lq73JdlBE7+Dg==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 6C4E9A022E;
        Thu,  8 Apr 2021 09:45:10 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 08 Apr 2021 13:45:09 +0400
Date:   Thu, 08 Apr 2021 13:45:09 +0400
In-Reply-To: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v3 06/14] usb: dwc2: Add enter partial power down when port is suspended
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210408094510.6C4E9A022E@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds flow of entering Partial Power Down in
"dwc2_port_suspend()" function when core receives suspend.

NOTE: Switch case statement is used for hibernation partial
power down and clock gating mode determination. In this patch
only Partial Power Down is implemented the Hibernation and
clock gating implementations are planned to be added.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 Changes in v3:
 - None
 Changes in v2:
 - None

 drivers/usb/dwc2/core.h |  5 +++--
 drivers/usb/dwc2/hcd.c  | 48 ++++++++++++++++++++++++++---------------
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index b7d99cf9e84c..76807abd753b 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1470,7 +1470,7 @@ void dwc2_hcd_connect(struct dwc2_hsotg *hsotg);
 void dwc2_hcd_disconnect(struct dwc2_hsotg *hsotg, bool force);
 void dwc2_hcd_start(struct dwc2_hsotg *hsotg);
 int dwc2_core_init(struct dwc2_hsotg *hsotg, bool initial_setup);
-void dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex);
+int dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex);
 void dwc2_port_resume(struct dwc2_hsotg *hsotg);
 int dwc2_backup_host_registers(struct dwc2_hsotg *hsotg);
 int dwc2_restore_host_registers(struct dwc2_hsotg *hsotg);
@@ -1495,7 +1495,8 @@ static inline void dwc2_hcd_start(struct dwc2_hsotg *hsotg) {}
 static inline void dwc2_hcd_remove(struct dwc2_hsotg *hsotg) {}
 static inline int dwc2_core_init(struct dwc2_hsotg *hsotg, bool initial_setup)
 { return 0; }
-static inline void dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex) {}
+static inline int dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
+{ return 0; }
 static inline void dwc2_port_resume(struct dwc2_hsotg *hsotg) {}
 static inline int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
 { return 0; }
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index f4247a66c2b2..e7fb0d5940bc 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -3281,15 +3281,18 @@ static int dwc2_host_is_b_hnp_enabled(struct dwc2_hsotg *hsotg)
  * @hsotg: Programming view of the DWC_otg controller
  * @windex: The control request wIndex field
  *
+ * Return: non-zero if failed to enter suspend mode for host.
+ *
  * This function is for entering Host mode suspend.
  * Must NOT be called with interrupt disabled or spinlock held.
  */
-void dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
+int dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
 {
 	unsigned long flags;
 	u32 hprt0;
 	u32 pcgctl;
 	u32 gotgctl;
+	int ret = 0;
 
 	dev_dbg(hsotg->dev, "%s()\n", __func__);
 
@@ -3302,22 +3305,31 @@ void dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
 		hsotg->op_state = OTG_STATE_A_SUSPEND;
 	}
 
-	hprt0 = dwc2_read_hprt0(hsotg);
-	hprt0 |= HPRT0_SUSP;
-	dwc2_writel(hsotg, hprt0, HPRT0);
-
-	hsotg->bus_suspended = true;
-
-	/*
-	 * If power_down is supported, Phy clock will be suspended
-	 * after registers are backuped.
-	 */
-	if (!hsotg->params.power_down) {
-		/* Suspend the Phy Clock */
-		pcgctl = dwc2_readl(hsotg, PCGCTL);
-		pcgctl |= PCGCTL_STOPPCLK;
-		dwc2_writel(hsotg, pcgctl, PCGCTL);
-		udelay(10);
+	switch (hsotg->params.power_down) {
+	case DWC2_POWER_DOWN_PARAM_PARTIAL:
+		ret = dwc2_enter_partial_power_down(hsotg);
+		if (ret)
+			dev_err(hsotg->dev,
+				"enter partial_power_down failed.\n");
+		break;
+	case DWC2_POWER_DOWN_PARAM_HIBERNATION:
+	case DWC2_POWER_DOWN_PARAM_NONE:
+	default:
+		hprt0 = dwc2_read_hprt0(hsotg);
+		hprt0 |= HPRT0_SUSP;
+		dwc2_writel(hsotg, hprt0, HPRT0);
+		hsotg->bus_suspended = true;
+		/*
+		 * If power_down is supported, Phy clock will be suspended
+		 * after registers are backuped.
+		 */
+		if (!hsotg->params.power_down) {
+			/* Suspend the Phy Clock */
+			pcgctl = dwc2_readl(hsotg, PCGCTL);
+			pcgctl |= PCGCTL_STOPPCLK;
+			dwc2_writel(hsotg, pcgctl, PCGCTL);
+			udelay(10);
+		}
 	}
 
 	/* For HNP the bus must be suspended for at least 200ms */
@@ -3332,6 +3344,8 @@ void dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
 	} else {
 		spin_unlock_irqrestore(&hsotg->lock, flags);
 	}
+
+	return ret;
 }
 
 /**
-- 
2.25.1

