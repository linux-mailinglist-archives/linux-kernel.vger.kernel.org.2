Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC6435D8A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbhDMHRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:17:03 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59690 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237714AbhDMHQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:16:47 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0053BC00BB;
        Tue, 13 Apr 2021 07:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618298188; bh=hST1iATIE6CPXmJo944SfVT7CgV9Q11nuNGznF/0Gs8=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=azKRm5/pDk4QsefQEgnbE6yNnOdTjxhc+4NAwlJuqJkcFrnOacfaRknkkh+8vZ1uX
         lvuSndAOaq79Ctp/FU5nWiRANY48PzSGBX03k0NF/8NWJtPnCQAx86ffFuYv6oawTZ
         4q5MR7gn2BBeMYFgtpE5tCSMFp6kRN7yRFQxl29fHIB8+s7tyCHLLGWZITZqcvaPCi
         Lkv5XXrAoAmlXyrHEQ+dLtkKr6+byjOba/Tp+GI0TnIZSpNHGCAKasbI4+PpB35p/R
         fvUitlGL/kmDbn8y/v5FEd6sYkjuPWbY3CehNJ2N+BS0KoRYNQDOArKJEJeb9mj0SZ
         QEspg0nJmrYHA==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 170A7A0099;
        Tue, 13 Apr 2021 07:16:25 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:16:24 +0400
Date:   Tue, 13 Apr 2021 11:16:24 +0400
Message-Id: <4f4d90dd4f2156915eea45ac4b1316446b40632b.1618297800.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 02/12] usb: dwc2: Add host clock gating support functions
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

Added host clock gating support functions according
programming guide.

Added function names:
dwc2_host_enter_clock_gating()
dwc2_host_exit_clock_gating()

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/core.h |  5 +++
 drivers/usb/dwc2/hcd.c  | 86 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index e5597796dca4..8c12b3061f7f 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1486,6 +1486,8 @@ int dwc2_host_exit_hibernation(struct dwc2_hsotg *hsotg,
 int dwc2_host_enter_partial_power_down(struct dwc2_hsotg *hsotg);
 int dwc2_host_exit_partial_power_down(struct dwc2_hsotg *hsotg,
 				      int rem_wakeup, bool restore);
+void dwc2_host_enter_clock_gating(struct dwc2_hsotg *hsotg);
+void dwc2_host_exit_clock_gating(struct dwc2_hsotg *hsotg, int rem_wakeup);
 bool dwc2_host_can_poweroff_phy(struct dwc2_hsotg *dwc2);
 static inline void dwc2_host_schedule_phy_reset(struct dwc2_hsotg *hsotg)
 { schedule_work(&hsotg->phy_reset_work); }
@@ -1521,6 +1523,9 @@ static inline int dwc2_host_enter_partial_power_down(struct dwc2_hsotg *hsotg)
 static inline int dwc2_host_exit_partial_power_down(struct dwc2_hsotg *hsotg,
 						    int rem_wakeup, bool restore)
 { return 0; }
+static inline void dwc2_host_enter_clock_gating(struct dwc2_hsotg *hsotg) {}
+static inline void dwc2_host_exit_clock_gating(struct dwc2_hsotg *hsotg,
+					       int rem_wakeup) {}
 static inline bool dwc2_host_can_poweroff_phy(struct dwc2_hsotg *dwc2)
 { return false; }
 static inline void dwc2_host_schedule_phy_reset(struct dwc2_hsotg *hsotg) {}
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index f096006df96f..f1c24c15d185 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5821,3 +5821,89 @@ int dwc2_host_exit_partial_power_down(struct dwc2_hsotg *hsotg,
 	dev_dbg(hsotg->dev, "Exiting host partial power down completed.\n");
 	return ret;
 }
+
+/**
+ * dwc2_host_enter_clock_gating() - Put controller in clock gating.
+ *
+ * @hsotg: Programming view of the DWC_otg controller
+ *
+ * This function is for entering Host mode clock gating.
+ */
+void dwc2_host_enter_clock_gating(struct dwc2_hsotg *hsotg)
+{
+	u32 hprt0;
+	u32 pcgctl;
+
+	dev_dbg(hsotg->dev, "Entering host clock gating.\n");
+
+	/* Put this port in suspend mode. */
+	hprt0 = dwc2_read_hprt0(hsotg);
+	hprt0 |= HPRT0_SUSP;
+	dwc2_writel(hsotg, hprt0, HPRT0);
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
+	hsotg->bus_suspended = true;
+	hsotg->lx_state = DWC2_L2;
+}
+
+/**
+ * dwc2_host_exit_clock_gating() - Exit controller from clock gating.
+ *
+ * @hsotg: Programming view of the DWC_otg controller
+ * @rem_wakeup: indicates whether resume is initiated by remote wakeup
+ *
+ * This function is for exiting Host mode clock gating.
+ */
+void dwc2_host_exit_clock_gating(struct dwc2_hsotg *hsotg, int rem_wakeup)
+{
+	u32 hprt0;
+	u32 pcgctl;
+
+	dev_dbg(hsotg->dev, "Exiting host clock gating.\n");
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
+	/* Drive resume signaling and exit suspend mode on the port. */
+	hprt0 = dwc2_read_hprt0(hsotg);
+	hprt0 |= HPRT0_RES;
+	hprt0 &= ~HPRT0_SUSP;
+	dwc2_writel(hsotg, hprt0, HPRT0);
+	udelay(5);
+
+	if (!rem_wakeup) {
+		/* In case of port resume need to wait for 40 ms */
+		msleep(USB_RESUME_TIMEOUT);
+
+		/* Stop driveing resume signaling on the port. */
+		hprt0 = dwc2_read_hprt0(hsotg);
+		hprt0 &= ~HPRT0_RES;
+		dwc2_writel(hsotg, hprt0, HPRT0);
+
+		hsotg->bus_suspended = false;
+		hsotg->lx_state = DWC2_L0;
+	} else {
+		mod_timer(&hsotg->wkp_timer,
+			  jiffies + msecs_to_jiffies(71));
+	}
+}
-- 
2.25.1

