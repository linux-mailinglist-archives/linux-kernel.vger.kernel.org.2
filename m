Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550F435D8FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbhDMHgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:36:38 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:36470 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239448AbhDMHgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:36:37 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 969204019F;
        Tue, 13 Apr 2021 07:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618299378; bh=hST1iATIE6CPXmJo944SfVT7CgV9Q11nuNGznF/0Gs8=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=GC77akFH6cTf0MjnKw8XtWJfxb68sEVZwW5wtIEwm+o0bSJm2MkCgV6O5HRovjre9
         U8xa4DB32veNltmjpw+Gbmp9o4uAY9BnU9eT7JuUkbvoNfK+98UA75TQVn1T1uVuD6
         bxkxB05QJopdbtznOol5is6wU9ildz9EzPvWwNoocX6w4Czal29jT5DNWTfRUbf4KJ
         Ynb9jSOpVTsceB7RDqOlPXNChxltWBCNoS73EwZRYkjLgZyaXw9IgofNzBhm9y5XDB
         hAlJ1y+ipjcyHKGtjXqwMtKTcFelt5Ksxejge9LSDBdziQ4EGej7pACvMyJ3KPhxwG
         gFSWekT4LFxKw==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id B3E84A022E;
        Tue, 13 Apr 2021 07:36:15 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:36:14 +0400
Date:   Tue, 13 Apr 2021 11:36:14 +0400
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 02/12] usb: dwc2: Add host clock gating support functions
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Message-Id: <20210413073615.B3E84A022E@mailhost.synopsys.com>
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

