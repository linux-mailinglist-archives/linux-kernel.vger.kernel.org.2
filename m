Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72348357FA9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhDHJpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:45:39 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37584 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231461AbhDHJpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:45:32 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 40749407FC;
        Thu,  8 Apr 2021 09:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617875121; bh=su60XZzjEqTjvgGpWeRzNnkBW31xb/VNaoOv/jEIpE0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=DiaUzR5Hpm9TGBHVVYFW5boeNGD9fcQXlBV7Q9ECvkqVHHBqzQJ4aWdr6H0QB/tWv
         FAkPAKsYLVR0AXHnAE4J+uAr3RiLGhvoRYFG6Y/bbG1Bo/2g8euKWAmMD0hQwuDwVn
         +XIUuxiW+fVBJ3Z6UMXo3MaaX0DQGGyVJm8/84cn47wehipcd6rTAl9uQHu0ZsCyou
         17rGn4qOkWsItM6DiARG/F8zSNyzg30FvVwXdwSk5sB/L4mGmX7PMskTKwxubV+Y4x
         HlAL8Zh1ARFUMdEoNH3Pl+JdLAgffnDJoMTQsO4gS5WX5QlembtXKz7eST9yojrTT7
         WST4H0E3F3BRw==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 6DA1DA022E;
        Thu,  8 Apr 2021 09:45:18 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 08 Apr 2021 13:45:17 +0400
Date:   Thu, 08 Apr 2021 13:45:17 +0400
In-Reply-To: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v3 07/14] usb: dwc2: Add exit partial power down when port is resumed
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210408094518.6DA1DA022E@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added flow of exiting Partial Power Down in
"dwc2_port_resume()" function when core receives resume.

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

 drivers/usb/dwc2/core.h |  5 ++--
 drivers/usb/dwc2/hcd.c  | 61 ++++++++++++++++++++++++++---------------
 2 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 76807abd753b..5a7850482e57 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1471,7 +1471,7 @@ void dwc2_hcd_disconnect(struct dwc2_hsotg *hsotg, bool force);
 void dwc2_hcd_start(struct dwc2_hsotg *hsotg);
 int dwc2_core_init(struct dwc2_hsotg *hsotg, bool initial_setup);
 int dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex);
-void dwc2_port_resume(struct dwc2_hsotg *hsotg);
+int dwc2_port_resume(struct dwc2_hsotg *hsotg);
 int dwc2_backup_host_registers(struct dwc2_hsotg *hsotg);
 int dwc2_restore_host_registers(struct dwc2_hsotg *hsotg);
 int dwc2_host_enter_hibernation(struct dwc2_hsotg *hsotg);
@@ -1497,7 +1497,8 @@ static inline int dwc2_core_init(struct dwc2_hsotg *hsotg, bool initial_setup)
 { return 0; }
 static inline int dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
 { return 0; }
-static inline void dwc2_port_resume(struct dwc2_hsotg *hsotg) {}
+static inline int dwc2_port_resume(struct dwc2_hsotg *hsotg)
+{ return 0; }
 static inline int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
 { return 0; }
 static inline int dwc2_backup_host_registers(struct dwc2_hsotg *hsotg)
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index e7fb0d5940bc..720354df014b 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -3353,44 +3353,61 @@ int dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
  *
  * @hsotg: Programming view of the DWC_otg controller
  *
+ * Return: non-zero if failed to exit suspend mode for host.
+ *
  * This function is for exiting Host mode suspend.
  * Must NOT be called with interrupt disabled or spinlock held.
  */
-void dwc2_port_resume(struct dwc2_hsotg *hsotg)
+int dwc2_port_resume(struct dwc2_hsotg *hsotg)
 {
 	unsigned long flags;
 	u32 hprt0;
 	u32 pcgctl;
+	int ret = 0;
 
 	spin_lock_irqsave(&hsotg->lock, flags);
 
-	/*
-	 * If power_down is supported, Phy clock is already resumed
-	 * after registers restore.
-	 */
-	if (!hsotg->params.power_down) {
-		pcgctl = dwc2_readl(hsotg, PCGCTL);
-		pcgctl &= ~PCGCTL_STOPPCLK;
-		dwc2_writel(hsotg, pcgctl, PCGCTL);
+	switch (hsotg->params.power_down) {
+	case DWC2_POWER_DOWN_PARAM_PARTIAL:
+		ret = dwc2_exit_partial_power_down(hsotg, 0, true);
+		if (ret)
+			dev_err(hsotg->dev,
+				"exit partial_power_down failed.\n");
+		break;
+	case DWC2_POWER_DOWN_PARAM_HIBERNATION:
+	case DWC2_POWER_DOWN_PARAM_NONE:
+	default:
+		/*
+		 * If power_down is supported, Phy clock is already resumed
+		 * after registers restore.
+		 */
+		if (!hsotg->params.power_down) {
+			pcgctl = dwc2_readl(hsotg, PCGCTL);
+			pcgctl &= ~PCGCTL_STOPPCLK;
+			dwc2_writel(hsotg, pcgctl, PCGCTL);
+			spin_unlock_irqrestore(&hsotg->lock, flags);
+			msleep(20);
+			spin_lock_irqsave(&hsotg->lock, flags);
+		}
+
+		hprt0 = dwc2_read_hprt0(hsotg);
+		hprt0 |= HPRT0_RES;
+		hprt0 &= ~HPRT0_SUSP;
+		dwc2_writel(hsotg, hprt0, HPRT0);
 		spin_unlock_irqrestore(&hsotg->lock, flags);
-		msleep(20);
+
+		msleep(USB_RESUME_TIMEOUT);
+
 		spin_lock_irqsave(&hsotg->lock, flags);
+		hprt0 = dwc2_read_hprt0(hsotg);
+		hprt0 &= ~(HPRT0_RES | HPRT0_SUSP);
+		dwc2_writel(hsotg, hprt0, HPRT0);
+		hsotg->bus_suspended = false;
 	}
 
-	hprt0 = dwc2_read_hprt0(hsotg);
-	hprt0 |= HPRT0_RES;
-	hprt0 &= ~HPRT0_SUSP;
-	dwc2_writel(hsotg, hprt0, HPRT0);
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-	msleep(USB_RESUME_TIMEOUT);
-
-	spin_lock_irqsave(&hsotg->lock, flags);
-	hprt0 = dwc2_read_hprt0(hsotg);
-	hprt0 &= ~(HPRT0_RES | HPRT0_SUSP);
-	dwc2_writel(hsotg, hprt0, HPRT0);
-	hsotg->bus_suspended = false;
-	spin_unlock_irqrestore(&hsotg->lock, flags);
+	return ret;
 }
 
 /* Handles hub class-specific requests */
-- 
2.25.1

