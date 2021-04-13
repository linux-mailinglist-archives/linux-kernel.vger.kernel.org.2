Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2212935D89B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbhDMHQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:16:42 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59684 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237481AbhDMHQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:16:39 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 48A79C00BB;
        Tue, 13 Apr 2021 07:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618298180; bh=mTMgLw0i3qjR66MH6B8kFrVdfGg0tmxHpkjak79KE64=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=OzMVIUnoHdTjcxASC+roNIbXfn5j2wSSkrblfS23CvraYuEOR/FpHqkpQ325WUmHE
         1nAuJW4aZNuV9vNN1moJFdl1yDZDiR8wstOThJJT6OmaU3COvDGVwZWDol8R3FDIOE
         LAXCZIpDorEUw5FKXsZ5k50dxw9l/DfXGu5Dr4ty7kZKE9ddOofMAxIgfR0nLVfH1w
         SiFhJPyr1HwfkLrktFScQa7WpPyBQWZKMwOhouJM3rjo5NvE0aLkUozGY6pZ4AO5XO
         IZQ6MM0tpzMaBnlS/6K6lMKfcce0W7cJ9ANmnmTWRbxdCBJ8lLKLZLFIwsc19n6jJG
         MwOnzVtmGBekA==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 8365CA0094;
        Tue, 13 Apr 2021 07:16:17 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:16:16 +0400
Date:   Tue, 13 Apr 2021 11:16:16 +0400
Message-Id: <da98de3e0e68f24348a9bc846c0dc09ff466b8a8.1618297800.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 01/12] usb: dwc2: Add device clock gating support functions
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device clock gating support functions according
programming guide.

Moved "bus_suspended" flag to "dwc2_hsotg" struct because
we need to set that flag while entering to clock gating
in case when the driver is built in peripheral mode.

Added function names:
dwc2_gadget_enter_clock_gating()
dwc2_gadget_exit_clock_gating()

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/core.h   | 10 ++++--
 drivers/usb/dwc2/gadget.c | 71 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 5a7850482e57..e5597796dca4 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -866,6 +866,7 @@ struct dwc2_hregs_backup {
  * @ll_hw_enabled:	Status of low-level hardware resources.
  * @hibernated:		True if core is hibernated
  * @in_ppd:		True if core is partial power down mode.
+ * @bus_suspended:	True if bus is suspended
  * @reset_phy_on_wake:	Quirk saying that we should assert PHY reset on a
  *			remote wakeup.
  * @phy_off_for_suspend: Status of whether we turned the PHY off at suspend.
@@ -1023,7 +1024,6 @@ struct dwc2_hregs_backup {
  *			a pointer to an array of register definitions, the
  *			array size and the base address where the register bank
  *			is to be found.
- * @bus_suspended:	True if bus is suspended
  * @last_frame_num:	Number of last frame. Range from 0 to  32768
  * @frame_num_array:    Used only  if CONFIG_USB_DWC2_TRACK_MISSED_SOFS is
  *			defined, for missed SOFs tracking. Array holds that
@@ -1062,6 +1062,7 @@ struct dwc2_hsotg {
 	unsigned int ll_hw_enabled:1;
 	unsigned int hibernated:1;
 	unsigned int in_ppd:1;
+	bool bus_suspended;
 	unsigned int reset_phy_on_wake:1;
 	unsigned int need_phy_for_wake:1;
 	unsigned int phy_off_for_suspend:1;
@@ -1145,7 +1146,6 @@ struct dwc2_hsotg {
 	unsigned long hs_periodic_bitmap[
 		DIV_ROUND_UP(DWC2_HS_SCHEDULE_US, BITS_PER_LONG)];
 	u16 periodic_qh_count;
-	bool bus_suspended;
 	bool new_connection;
 
 	u16 last_frame_num;
@@ -1415,6 +1415,9 @@ int dwc2_gadget_exit_hibernation(struct dwc2_hsotg *hsotg,
 int dwc2_gadget_enter_partial_power_down(struct dwc2_hsotg *hsotg);
 int dwc2_gadget_exit_partial_power_down(struct dwc2_hsotg *hsotg,
 					bool restore);
+void dwc2_gadget_enter_clock_gating(struct dwc2_hsotg *hsotg);
+void dwc2_gadget_exit_clock_gating(struct dwc2_hsotg *hsotg,
+				   int rem_wakeup);
 int dwc2_hsotg_tx_fifo_count(struct dwc2_hsotg *hsotg);
 int dwc2_hsotg_tx_fifo_total_depth(struct dwc2_hsotg *hsotg);
 int dwc2_hsotg_tx_fifo_average_depth(struct dwc2_hsotg *hsotg);
@@ -1453,6 +1456,9 @@ static inline int dwc2_gadget_enter_partial_power_down(struct dwc2_hsotg *hsotg)
 static inline int dwc2_gadget_exit_partial_power_down(struct dwc2_hsotg *hsotg,
 						      bool restore)
 { return 0; }
+static inline void dwc2_gadget_enter_clock_gating(struct dwc2_hsotg *hsotg) {}
+static inline void dwc2_gadget_exit_clock_gating(struct dwc2_hsotg *hsotg,
+						 int rem_wakeup) {}
 static inline int dwc2_hsotg_tx_fifo_count(struct dwc2_hsotg *hsotg)
 { return 0; }
 static inline int dwc2_hsotg_tx_fifo_total_depth(struct dwc2_hsotg *hsotg)
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index e08baee4987b..2f50f3e62caa 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5483,3 +5483,74 @@ int dwc2_gadget_exit_partial_power_down(struct dwc2_hsotg *hsotg,
 	dev_dbg(hsotg->dev, "Exiting device partial Power Down completed.\n");
 	return ret;
 }
+
+/**
+ * dwc2_gadget_enter_clock_gating() - Put controller in clock gating.
+ *
+ * @hsotg: Programming view of the DWC_otg controller
+ *
+ * Return: non-zero if failed to enter device partial power down.
+ *
+ * This function is for entering device mode clock gating.
+ */
+void dwc2_gadget_enter_clock_gating(struct dwc2_hsotg *hsotg)
+{
+	u32 pcgctl;
+
+	dev_dbg(hsotg->dev, "Entering device clock gating.\n");
+
+	/* Set the Phy Clock bit as suspend is received. */
+	pcgctl = dwc2_readl(hsotg, PCGCTL);
+	pcgctl |= PCGCTL_STOPPCLK;
+	dwc2_writel(hsotg, pcgctl, PCGCTL);
+	udelay(5);
+
+	/* Set the Gate hclk as suspend is received. */
+	pcgctl = dwc2_readl(hsotg, PCGCTL);
+	pcgctl |= PCGCTL_GATEHCLK;
+	dwc2_writel(hsotg, pcgctl, PCGCTL);
+	udelay(5);
+
+	hsotg->lx_state = DWC2_L2;
+	hsotg->bus_suspended = true;
+}
+
+/*
+ * dwc2_gadget_exit_clock_gating() - Exit controller from device clock gating.
+ *
+ * @hsotg: Programming view of the DWC_otg controller
+ * @rem_wakeup: indicates whether remote wake up is enabled.
+ *
+ * This function is for exiting from device mode clock gating.
+ */
+void dwc2_gadget_exit_clock_gating(struct dwc2_hsotg *hsotg, int rem_wakeup)
+{
+	u32 pcgctl;
+	u32 dctl;
+
+	dev_dbg(hsotg->dev, "Exiting device clock gating.\n");
+
+	/* Clear the Gate hclk. */
+	pcgctl = dwc2_readl(hsotg, PCGCTL);
+	pcgctl &= ~PCGCTL_GATEHCLK;
+	dwc2_writel(hsotg, pcgctl, PCGCTL);
+	udelay(5);
+
+	/* Phy Clock bit. */
+	pcgctl = dwc2_readl(hsotg, PCGCTL);
+	pcgctl &= ~PCGCTL_STOPPCLK;
+	dwc2_writel(hsotg, pcgctl, PCGCTL);
+	udelay(5);
+
+	if (rem_wakeup) {
+		/* Set Remote Wakeup Signaling */
+		dctl = dwc2_readl(hsotg, DCTL);
+		dctl |= DCTL_RMTWKUPSIG;
+		dwc2_writel(hsotg, dctl, DCTL);
+	}
+
+	/* Change to L0 state */
+	call_gadget(hsotg, resume);
+	hsotg->lx_state = DWC2_L0;
+	hsotg->bus_suspended = false;
+}
-- 
2.25.1

