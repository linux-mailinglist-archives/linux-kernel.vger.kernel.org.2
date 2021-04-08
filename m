Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67349357F91
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhDHJoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:44:46 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37524 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231210AbhDHJoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:44:44 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 219394051F;
        Thu,  8 Apr 2021 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617875073; bh=0PxDWJIpQtC257oJRHAJSE2XYl24PZfxWI+JLKX2I+E=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=cZE0rCwJNL9sxQeLKmKJYe1NAqziJUH9ofwQ/PK97xzCDHykIqW5sX6sSR0rR0ftb
         pSb9Wn2pyZ2Px7nlvnsIykNbZd9kTWGUpgryn7zpbyw8x6ZKikuu5j5LyBeV+xUR4/
         zZ4wXqVy1POatUr2dTBoZYf+cTBo+lBcvEi1UgmJNpV+m1Hvz22UnSXvqVusCQzqJO
         zO0EBDRVAQzYmOnY2Rx7C/RItst6e0NV2fE533shgvDaek6iB556Am7OsVrdZGtTjj
         wN0d+MdbE76MY1I9bx9KgeIuA+xlVpGG1LZTHjFME5BAmHA9UAvYlbejAfOyiN/1z/
         ODXW/KXKejZQA==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 383B9A0094;
        Thu,  8 Apr 2021 09:44:30 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 08 Apr 2021 13:44:29 +0400
Date:   Thu, 08 Apr 2021 13:44:29 +0400
In-Reply-To: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v3 01/14] usb: dwc2: Add device partial power down functions
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Message-Id: <20210408094430.383B9A0094@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For device mode Partial Power Down entering and exiting
separate functions are needed to implement the logic.
Earlier the logic was implemented in one function. Which was
confusing the readability. Also both host and device implementations
were in the same function.

- Added device partial power down functions which must be called
by dwc2_enter_partial_power_down()/dwc2_exit_partial_power_down()
functions.

- Added "in_ppd" flag in "dwc2_hsotg" struct to indicate the
core state after entering into partial power down mode.

Added function names:
dwc2_gadget_enter_partial_power_down()
dwc2_gadget_exit_partial_power_down()

NOTE: There is a checkpatch "CHECK" warning on "udelay(100)".
The delay is needed to properly exit gadget Partial Power Down
A delay less than 100 doesn't work.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/core.h   |  10 +++
 drivers/usb/dwc2/gadget.c | 128 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index d0ebe721fb98..ed54d834138d 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -865,6 +865,7 @@ struct dwc2_hregs_backup {
  * @gadget_enabled:	Peripheral mode sub-driver initialization indicator.
  * @ll_hw_enabled:	Status of low-level hardware resources.
  * @hibernated:		True if core is hibernated
+ * @in_ppd:		True if core is partial power down mode.
  * @reset_phy_on_wake:	Quirk saying that we should assert PHY reset on a
  *			remote wakeup.
  * @phy_off_for_suspend: Status of whether we turned the PHY off at suspend.
@@ -1060,6 +1061,7 @@ struct dwc2_hsotg {
 	unsigned int gadget_enabled:1;
 	unsigned int ll_hw_enabled:1;
 	unsigned int hibernated:1;
+	unsigned int in_ppd:1;
 	unsigned int reset_phy_on_wake:1;
 	unsigned int need_phy_for_wake:1;
 	unsigned int phy_off_for_suspend:1;
@@ -1409,6 +1411,9 @@ int dwc2_restore_device_registers(struct dwc2_hsotg *hsotg, int remote_wakeup);
 int dwc2_gadget_enter_hibernation(struct dwc2_hsotg *hsotg);
 int dwc2_gadget_exit_hibernation(struct dwc2_hsotg *hsotg,
 				 int rem_wakeup, int reset);
+int dwc2_gadget_enter_partial_power_down(struct dwc2_hsotg *hsotg);
+int dwc2_gadget_exit_partial_power_down(struct dwc2_hsotg *hsotg,
+					bool restore);
 int dwc2_hsotg_tx_fifo_count(struct dwc2_hsotg *hsotg);
 int dwc2_hsotg_tx_fifo_total_depth(struct dwc2_hsotg *hsotg);
 int dwc2_hsotg_tx_fifo_average_depth(struct dwc2_hsotg *hsotg);
@@ -1442,6 +1447,11 @@ static inline int dwc2_gadget_enter_hibernation(struct dwc2_hsotg *hsotg)
 static inline int dwc2_gadget_exit_hibernation(struct dwc2_hsotg *hsotg,
 					       int rem_wakeup, int reset)
 { return 0; }
+static inline int dwc2_gadget_enter_partial_power_down(struct dwc2_hsotg *hsotg)
+{ return 0; }
+static inline int dwc2_gadget_exit_partial_power_down(struct dwc2_hsotg *hsotg,
+						      bool restore)
+{ return 0; }
 static inline int dwc2_hsotg_tx_fifo_count(struct dwc2_hsotg *hsotg)
 { return 0; }
 static inline int dwc2_hsotg_tx_fifo_total_depth(struct dwc2_hsotg *hsotg)
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index ad4c94366dad..98a2a63c67ae 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5351,3 +5351,131 @@ int dwc2_gadget_exit_hibernation(struct dwc2_hsotg *hsotg,
 
 	return ret;
 }
+
+/**
+ * dwc2_gadget_enter_partial_power_down() - Put controller in partial
+ * power down.
+ *
+ * @hsotg: Programming view of the DWC_otg controller
+ *
+ * Return: non-zero if failed to enter device partial power down.
+ *
+ * This function is for entering device mode partial power down.
+ */
+int dwc2_gadget_enter_partial_power_down(struct dwc2_hsotg *hsotg)
+{
+	u32 pcgcctl;
+	int ret = 0;
+
+	dev_dbg(hsotg->dev, "Entering device partial power down started.\n");
+
+	/* Backup all registers */
+	ret = dwc2_backup_global_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
+			__func__);
+		return ret;
+	}
+
+	ret = dwc2_backup_device_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to backup device registers\n",
+			__func__);
+		return ret;
+	}
+
+	/*
+	 * Clear any pending interrupts since dwc2 will not be able to
+	 * clear them after entering partial_power_down.
+	 */
+	dwc2_writel(hsotg, 0xffffffff, GINTSTS);
+
+	/* Put the controller in low power state */
+	pcgcctl = dwc2_readl(hsotg, PCGCTL);
+
+	pcgcctl |= PCGCTL_PWRCLMP;
+	dwc2_writel(hsotg, pcgcctl, PCGCTL);
+	udelay(5);
+
+	pcgcctl |= PCGCTL_RSTPDWNMODULE;
+	dwc2_writel(hsotg, pcgcctl, PCGCTL);
+	udelay(5);
+
+	pcgcctl |= PCGCTL_STOPPCLK;
+	dwc2_writel(hsotg, pcgcctl, PCGCTL);
+
+	/* Set in_ppd flag to 1 as here core enters suspend. */
+	hsotg->in_ppd = 1;
+	hsotg->lx_state = DWC2_L2;
+
+	dev_dbg(hsotg->dev, "Entering device partial power down completed.\n");
+
+	return ret;
+}
+
+/*
+ * dwc2_gadget_exit_partial_power_down() - Exit controller from device partial
+ * power down.
+ *
+ * @hsotg: Programming view of the DWC_otg controller
+ * @restore: indicates whether need to restore the registers or not.
+ *
+ * Return: non-zero if failed to exit device partial power down.
+ *
+ * This function is for exiting from device mode partial power down.
+ */
+int dwc2_gadget_exit_partial_power_down(struct dwc2_hsotg *hsotg,
+					bool restore)
+{
+	u32 pcgcctl;
+	u32 dctl;
+	struct dwc2_dregs_backup *dr;
+	int ret = 0;
+
+	dr = &hsotg->dr_backup;
+
+	dev_dbg(hsotg->dev, "Exiting device partial Power Down started.\n");
+
+	pcgcctl = dwc2_readl(hsotg, PCGCTL);
+	pcgcctl &= ~PCGCTL_STOPPCLK;
+	dwc2_writel(hsotg, pcgcctl, PCGCTL);
+
+	pcgcctl = dwc2_readl(hsotg, PCGCTL);
+	pcgcctl &= ~PCGCTL_PWRCLMP;
+	dwc2_writel(hsotg, pcgcctl, PCGCTL);
+
+	pcgcctl = dwc2_readl(hsotg, PCGCTL);
+	pcgcctl &= ~PCGCTL_RSTPDWNMODULE;
+	dwc2_writel(hsotg, pcgcctl, PCGCTL);
+
+	udelay(100);
+	if (restore) {
+		ret = dwc2_restore_global_registers(hsotg);
+		if (ret) {
+			dev_err(hsotg->dev, "%s: failed to restore registers\n",
+				__func__);
+			return ret;
+		}
+		/* Restore DCFG */
+		dwc2_writel(hsotg, dr->dcfg, DCFG);
+
+		ret = dwc2_restore_device_registers(hsotg, 0);
+		if (ret) {
+			dev_err(hsotg->dev, "%s: failed to restore device registers\n",
+				__func__);
+			return ret;
+		}
+	}
+
+	/* Set the Power-On Programming done bit */
+	dctl = dwc2_readl(hsotg, DCTL);
+	dctl |= DCTL_PWRONPRGDONE;
+	dwc2_writel(hsotg, dctl, DCTL);
+
+	/* Set in_ppd flag to 0 as here core exits from suspend. */
+	hsotg->in_ppd = 0;
+	hsotg->lx_state = DWC2_L0;
+
+	dev_dbg(hsotg->dev, "Exiting device partial Power Down completed.\n");
+	return ret;
+}
-- 
2.25.1

