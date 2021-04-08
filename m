Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBD2357F96
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhDHJox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:44:53 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:36552 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231269AbhDHJow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:44:52 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7DBC8C09BA;
        Thu,  8 Apr 2021 09:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617875081; bh=u6F+fXW2qz+tbASMRsPqsckjpuRhyQDO1KmGr9q5n0M=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Z3oES2lMqcLJpVaMIb37jCZmSx2FT12Zr1DNgxixE5PUaDHqq8UT3d90TTaB3kOnh
         rBSk30Z4dUycVv9oh5mJ4aj8BC50FwWUwKOKKe3Xw6xoQ63hKDACOxFKgGlwr8bzzU
         KRb95Wr3Vis7kRXxvf97Dy3u6KYjH6mf51DQpp4wAlthoO+Lt8ED3/UT3oZdgR2xxf
         aOxSHLfi080bXACQv2WHrJVJREOsuO3vQRuOFOTn+5E7mJJfocywiTOA+x+NRUc9vz
         DWrIk0DZ32+6gXexcWHYNvwIyJVEnQFkAlmtlFX6hF6tU8UtRbaU3v1pDVU/80LRMb
         EuxLZX5AbMqbQ==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 56CFBA022E;
        Thu,  8 Apr 2021 09:44:38 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 08 Apr 2021 13:44:37 +0400
Date:   Thu, 08 Apr 2021 13:44:37 +0400
In-Reply-To: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v3 02/14] usb: dwc2: Add host partial power down functions
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Message-Id: <20210408094438.56CFBA022E@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For host mode Partial Power Down entering and exiting
separate functions are needed to implement the logic.
Earlier the logic was implemented in one function. Which was
confusing the readability. Also both host and device implementations
were in the same function.

- Added host partial power down functions which must be called
by dwc2_enter_partial_power_down()/dwc2_exit_partial_power_down()
functions.

Added function names:
dwc2_host_enter_partial_power_down()
dwc2_host_exit_partial_power_down()

NOTE: There is a checkpatch "CHECK" warning on "udelay(100)".
The delay is needed to properly exit gadget Partial Power Down
A delay less than 100 doesn't work.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/core.h |   8 ++
 drivers/usb/dwc2/hcd.c  | 160 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index ed54d834138d..1a97df8bf5cb 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1474,6 +1474,9 @@ int dwc2_restore_host_registers(struct dwc2_hsotg *hsotg);
 int dwc2_host_enter_hibernation(struct dwc2_hsotg *hsotg);
 int dwc2_host_exit_hibernation(struct dwc2_hsotg *hsotg,
 			       int rem_wakeup, int reset);
+int dwc2_host_enter_partial_power_down(struct dwc2_hsotg *hsotg);
+int dwc2_host_exit_partial_power_down(struct dwc2_hsotg *hsotg,
+				      int rem_wakeup, bool restore);
 bool dwc2_host_can_poweroff_phy(struct dwc2_hsotg *dwc2);
 static inline void dwc2_host_schedule_phy_reset(struct dwc2_hsotg *hsotg)
 { schedule_work(&hsotg->phy_reset_work); }
@@ -1500,6 +1503,11 @@ static inline int dwc2_host_enter_hibernation(struct dwc2_hsotg *hsotg)
 static inline int dwc2_host_exit_hibernation(struct dwc2_hsotg *hsotg,
 					     int rem_wakeup, int reset)
 { return 0; }
+static inline int dwc2_host_enter_partial_power_down(struct dwc2_hsotg *hsotg)
+{ return 0; }
+static inline int dwc2_host_exit_partial_power_down(struct dwc2_hsotg *hsotg,
+						    int rem_wakeup, bool restore)
+{ return 0; }
 static inline bool dwc2_host_can_poweroff_phy(struct dwc2_hsotg *dwc2)
 { return false; }
 static inline void dwc2_host_schedule_phy_reset(struct dwc2_hsotg *hsotg) {}
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 1a9789ec5847..35e617be4bc3 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5607,3 +5607,163 @@ bool dwc2_host_can_poweroff_phy(struct dwc2_hsotg *dwc2)
 	/* No reason to keep the PHY powered, so allow poweroff */
 	return true;
 }
+
+/**
+ * dwc2_host_enter_partial_power_down() - Put controller in partial
+ * power down.
+ *
+ * @hsotg: Programming view of the DWC_otg controller
+ *
+ * Return: non-zero if failed to enter host partial power down.
+ *
+ * This function is for entering Host mode partial power down.
+ */
+int dwc2_host_enter_partial_power_down(struct dwc2_hsotg *hsotg)
+{
+	u32 pcgcctl;
+	u32 hprt0;
+	int ret = 0;
+
+	dev_dbg(hsotg->dev, "Entering host partial power down started.\n");
+
+	/* Put this port in suspend mode. */
+	hprt0 = dwc2_read_hprt0(hsotg);
+	hprt0 |= HPRT0_SUSP;
+	dwc2_writel(hsotg, hprt0, HPRT0);
+	udelay(5);
+
+	/* Wait for the HPRT0.PrtSusp register field to be set */
+	if (dwc2_hsotg_wait_bit_set(hsotg, HPRT0, HPRT0_SUSP, 3000))
+		dev_warn(hsotg->dev, "Suspend wasn't generated\n");
+
+	/* Backup all registers */
+	ret = dwc2_backup_global_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
+			__func__);
+		return ret;
+	}
+
+	ret = dwc2_backup_host_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to backup host registers\n",
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
+	hsotg->bus_suspended = true;
+
+	dev_dbg(hsotg->dev, "Entering host partial power down completed.\n");
+
+	return ret;
+}
+
+/*
+ * dwc2_host_exit_partial_power_down() - Exit controller from host partial
+ * power down.
+ *
+ * @hsotg: Programming view of the DWC_otg controller
+ * @rem_wakeup: indicates whether resume is initiated by Reset.
+ * @restore: indicates whether need to restore the registers or not.
+ *
+ * Return: non-zero if failed to exit host partial power down.
+ *
+ * This function is for exiting from Host mode partial power down.
+ */
+int dwc2_host_exit_partial_power_down(struct dwc2_hsotg *hsotg,
+				      int rem_wakeup, bool restore)
+{
+	u32 pcgcctl;
+	int ret = 0;
+	u32 hprt0;
+
+	dev_dbg(hsotg->dev, "Exiting host partial power down started.\n");
+
+	pcgcctl = dwc2_readl(hsotg, PCGCTL);
+	pcgcctl &= ~PCGCTL_STOPPCLK;
+	dwc2_writel(hsotg, pcgcctl, PCGCTL);
+	udelay(5);
+
+	pcgcctl = dwc2_readl(hsotg, PCGCTL);
+	pcgcctl &= ~PCGCTL_PWRCLMP;
+	dwc2_writel(hsotg, pcgcctl, PCGCTL);
+	udelay(5);
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
+
+		ret = dwc2_restore_host_registers(hsotg);
+		if (ret) {
+			dev_err(hsotg->dev, "%s: failed to restore host registers\n",
+				__func__);
+			return ret;
+		}
+	}
+
+	/* Drive resume signaling and exit suspend mode on the port. */
+	hprt0 = dwc2_read_hprt0(hsotg);
+	hprt0 |= HPRT0_RES;
+	hprt0 &= ~HPRT0_SUSP;
+	dwc2_writel(hsotg, hprt0, HPRT0);
+	udelay(5);
+
+	if (!rem_wakeup) {
+		/* Stop driveing resume signaling on the port. */
+		hprt0 = dwc2_read_hprt0(hsotg);
+		hprt0 &= ~HPRT0_RES;
+		dwc2_writel(hsotg, hprt0, HPRT0);
+
+		hsotg->bus_suspended = false;
+	} else {
+		/* Turn on the port power bit. */
+		hprt0 = dwc2_read_hprt0(hsotg);
+		hprt0 |= HPRT0_PWR;
+		dwc2_writel(hsotg, hprt0, HPRT0);
+
+		/* Connect hcd. */
+		dwc2_hcd_connect(hsotg);
+
+		mod_timer(&hsotg->wkp_timer,
+			  jiffies + msecs_to_jiffies(71));
+	}
+
+	/* Set lx_state to and in_ppd to 0 as here core exits from suspend. */
+	hsotg->in_ppd = 0;
+	hsotg->lx_state = DWC2_L0;
+
+	dev_dbg(hsotg->dev, "Exiting host partial power down completed.\n");
+	return ret;
+}
-- 
2.25.1

