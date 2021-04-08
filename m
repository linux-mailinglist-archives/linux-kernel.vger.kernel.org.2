Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523DB357F98
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhDHJpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:45:02 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:36564 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231269AbhDHJpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:45:00 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 55C23C09B1;
        Thu,  8 Apr 2021 09:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617875089; bh=WzuyIoK/ht3m7Z4eAuhGfdS7mckRrxq8N1eY7NCgEtM=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=hDhxJ6PmsUNjyMz4KW/RHcagl8a82HSTNRuzU2dNr9h1B7qcFP4WTgggpTIF12GKh
         NS0UraeU2nTVcnaJMTaaVsl7gtcpXvF1z4Wq3mu+CidUEdjtYFRQb5RH8SVUxipC0b
         W0zg6vvmuGWSYizXsfOnWINRIt/XaHTVgz2eEdEGHX3M90dAf2y6Sqa/jWUKeuBguH
         CkRv+tmSRu561mooT4ECeeaSd7HG2eXHO1SF4Sg+SrpU51ZkPG+qhB9EfTtFe1aQKt
         whruheuRYkGUjvdr385RvEkpNWv8dOeuvGaNG3CSbgyJnJs5SAJuPtwi140ojM0AWB
         nWqMciEmeSemQ==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 6491BA022E;
        Thu,  8 Apr 2021 09:44:46 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 08 Apr 2021 13:44:45 +0400
Date:   Thu, 08 Apr 2021 13:44:45 +0400
In-Reply-To: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v3 03/14] usb: dwc2: Update enter and exit partial power down functions
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Message-Id: <20210408094446.6491BA022E@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are wrapper functions which are calling device or host
enter/exit partial power down functions.

This change is done because we need to separate device and
host partial power down functions as the programming flow
has a lot of difference between host and device. With this
update during partial power down exit driver relies on
backup value of "GOTGCTL_CURMODE_HOST" to determine the
mode of core before entering to PPD.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/core.c      | 113 ++++++-----------------------------
 drivers/usb/dwc2/core.h      |   3 +-
 drivers/usb/dwc2/core_intr.c |  21 ++++---
 drivers/usb/dwc2/gadget.c    |  20 ++++---
 drivers/usb/dwc2/hcd.c       |   2 +-
 drivers/usb/dwc2/hw.h        |   1 +
 6 files changed, 45 insertions(+), 115 deletions(-)

diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index fec17a2d2447..cb65f7f60573 100644
--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -131,54 +131,26 @@ int dwc2_restore_global_registers(struct dwc2_hsotg *hsotg)
  * dwc2_exit_partial_power_down() - Exit controller from Partial Power Down.
  *
  * @hsotg: Programming view of the DWC_otg controller
+ * @rem_wakeup: indicates whether resume is initiated by Reset.
  * @restore: Controller registers need to be restored
  */
-int dwc2_exit_partial_power_down(struct dwc2_hsotg *hsotg, bool restore)
+int dwc2_exit_partial_power_down(struct dwc2_hsotg *hsotg, int rem_wakeup,
+				 bool restore)
 {
-	u32 pcgcctl;
-	int ret = 0;
-
-	if (hsotg->params.power_down != DWC2_POWER_DOWN_PARAM_PARTIAL)
-		return -ENOTSUPP;
-
-	pcgcctl = dwc2_readl(hsotg, PCGCTL);
-	pcgcctl &= ~PCGCTL_STOPPCLK;
-	dwc2_writel(hsotg, pcgcctl, PCGCTL);
-
-	pcgcctl = dwc2_readl(hsotg, PCGCTL);
-	pcgcctl &= ~PCGCTL_PWRCLMP;
-	dwc2_writel(hsotg, pcgcctl, PCGCTL);
-
-	pcgcctl = dwc2_readl(hsotg, PCGCTL);
-	pcgcctl &= ~PCGCTL_RSTPDWNMODULE;
-	dwc2_writel(hsotg, pcgcctl, PCGCTL);
+	struct dwc2_gregs_backup *gr;
 
-	udelay(100);
-	if (restore) {
-		ret = dwc2_restore_global_registers(hsotg);
-		if (ret) {
-			dev_err(hsotg->dev, "%s: failed to restore registers\n",
-				__func__);
-			return ret;
-		}
-		if (dwc2_is_host_mode(hsotg)) {
-			ret = dwc2_restore_host_registers(hsotg);
-			if (ret) {
-				dev_err(hsotg->dev, "%s: failed to restore host registers\n",
-					__func__);
-				return ret;
-			}
-		} else {
-			ret = dwc2_restore_device_registers(hsotg, 0);
-			if (ret) {
-				dev_err(hsotg->dev, "%s: failed to restore device registers\n",
-					__func__);
-				return ret;
-			}
-		}
-	}
+	gr = &hsotg->gr_backup;
 
-	return ret;
+	/*
+	 * Restore host or device regisers with the same mode core enterted
+	 * to partial power down by checking "GOTGCTL_CURMODE_HOST" backup
+	 * value of the "gotgctl" register.
+	 */
+	if (gr->gotgctl & GOTGCTL_CURMODE_HOST)
+		return dwc2_host_exit_partial_power_down(hsotg, rem_wakeup,
+							 restore);
+	else
+		return dwc2_gadget_exit_partial_power_down(hsotg, restore);
 }
 
 /**
@@ -188,57 +160,10 @@ int dwc2_exit_partial_power_down(struct dwc2_hsotg *hsotg, bool restore)
  */
 int dwc2_enter_partial_power_down(struct dwc2_hsotg *hsotg)
 {
-	u32 pcgcctl;
-	int ret = 0;
-
-	if (!hsotg->params.power_down)
-		return -ENOTSUPP;
-
-	/* Backup all registers */
-	ret = dwc2_backup_global_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
-			__func__);
-		return ret;
-	}
-
-	if (dwc2_is_host_mode(hsotg)) {
-		ret = dwc2_backup_host_registers(hsotg);
-		if (ret) {
-			dev_err(hsotg->dev, "%s: failed to backup host registers\n",
-				__func__);
-			return ret;
-		}
-	} else {
-		ret = dwc2_backup_device_registers(hsotg);
-		if (ret) {
-			dev_err(hsotg->dev, "%s: failed to backup device registers\n",
-				__func__);
-			return ret;
-		}
-	}
-
-	/*
-	 * Clear any pending interrupts since dwc2 will not be able to
-	 * clear them after entering partial_power_down.
-	 */
-	dwc2_writel(hsotg, 0xffffffff, GINTSTS);
-
-	/* Put the controller in low power state */
-	pcgcctl = dwc2_readl(hsotg, PCGCTL);
-
-	pcgcctl |= PCGCTL_PWRCLMP;
-	dwc2_writel(hsotg, pcgcctl, PCGCTL);
-	ndelay(20);
-
-	pcgcctl |= PCGCTL_RSTPDWNMODULE;
-	dwc2_writel(hsotg, pcgcctl, PCGCTL);
-	ndelay(20);
-
-	pcgcctl |= PCGCTL_STOPPCLK;
-	dwc2_writel(hsotg, pcgcctl, PCGCTL);
-
-	return ret;
+	if (dwc2_is_host_mode(hsotg))
+		return dwc2_host_enter_partial_power_down(hsotg);
+	else
+		return dwc2_gadget_enter_partial_power_down(hsotg);
 }
 
 /**
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 1a97df8bf5cb..39037709a2ad 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1303,7 +1303,8 @@ static inline bool dwc2_is_hs_iot(struct dwc2_hsotg *hsotg)
  */
 int dwc2_core_reset(struct dwc2_hsotg *hsotg, bool skip_wait);
 int dwc2_enter_partial_power_down(struct dwc2_hsotg *hsotg);
-int dwc2_exit_partial_power_down(struct dwc2_hsotg *hsotg, bool restore);
+int dwc2_exit_partial_power_down(struct dwc2_hsotg *hsotg, int rem_wakeup,
+				 bool restore);
 int dwc2_enter_hibernation(struct dwc2_hsotg *hsotg, int is_host);
 int dwc2_exit_hibernation(struct dwc2_hsotg *hsotg, int rem_wakeup,
 		int reset, int is_host);
diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index 55f1d14fc414..1fb957ce6c25 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -315,9 +315,10 @@ static void dwc2_handle_session_req_intr(struct dwc2_hsotg *hsotg)
 		hsotg->lx_state);
 
 	if (dwc2_is_device_mode(hsotg)) {
-		if (hsotg->lx_state == DWC2_L2) {
-			ret = dwc2_exit_partial_power_down(hsotg, true);
-			if (ret && (ret != -ENOTSUPP))
+		if (hsotg->lx_state == DWC2_L2 && hsotg->in_ppd) {
+			ret = dwc2_exit_partial_power_down(hsotg, 0,
+							   true);
+			if (ret)
 				dev_err(hsotg->dev,
 					"exit power_down failed\n");
 		}
@@ -406,18 +407,16 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 	if (dwc2_is_device_mode(hsotg)) {
 		dev_dbg(hsotg->dev, "DSTS=0x%0x\n",
 			dwc2_readl(hsotg, DSTS));
-		if (hsotg->lx_state == DWC2_L2) {
+		if (hsotg->lx_state == DWC2_L2 && hsotg->in_ppd) {
 			u32 dctl = dwc2_readl(hsotg, DCTL);
-
 			/* Clear Remote Wakeup Signaling */
 			dctl &= ~DCTL_RMTWKUPSIG;
 			dwc2_writel(hsotg, dctl, DCTL);
-			ret = dwc2_exit_partial_power_down(hsotg, true);
-			if (ret && (ret != -ENOTSUPP))
-				dev_err(hsotg->dev, "exit power_down failed\n");
-
-			/* Change to L0 state */
-			hsotg->lx_state = DWC2_L0;
+			ret = dwc2_exit_partial_power_down(hsotg, 1,
+							   true);
+			if (ret)
+				dev_err(hsotg->dev,
+					"exit partial_power_down failed\n");
 			call_gadget(hsotg, resume);
 		} else {
 			/* Change to L0 state */
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 98a2a63c67ae..e08baee4987b 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3689,10 +3689,10 @@ static irqreturn_t dwc2_hsotg_irq(int irq, void *pw)
 		dwc2_writel(hsotg, GINTSTS_RESETDET, GINTSTS);
 
 		/* This event must be used only if controller is suspended */
-		if (hsotg->lx_state == DWC2_L2) {
-			dwc2_exit_partial_power_down(hsotg, true);
-			hsotg->lx_state = DWC2_L0;
-		}
+		if (hsotg->in_ppd && hsotg->lx_state == DWC2_L2)
+			dwc2_exit_partial_power_down(hsotg, 0, true);
+
+		hsotg->lx_state = DWC2_L0;
 	}
 
 	if (gintsts & (GINTSTS_USBRST | GINTSTS_RESETDET)) {
@@ -4615,11 +4615,15 @@ static int dwc2_hsotg_vbus_session(struct usb_gadget *gadget, int is_active)
 	spin_lock_irqsave(&hsotg->lock, flags);
 
 	/*
-	 * If controller is hibernated, it must exit from power_down
-	 * before being initialized / de-initialized
+	 * If controller is in partial power down state, it must exit from
+	 * that state before being initialized / de-initialized
 	 */
-	if (hsotg->lx_state == DWC2_L2)
-		dwc2_exit_partial_power_down(hsotg, false);
+	if (hsotg->lx_state == DWC2_L2 && hsotg->in_ppd)
+		/*
+		 * No need to check the return value as
+		 * registers are not being restored.
+		 */
+		dwc2_exit_partial_power_down(hsotg, 0, false);
 
 	if (is_active) {
 		hsotg->op_state = OTG_STATE_B_PERIPHERAL;
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 35e617be4bc3..dd0362e07444 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4418,7 +4418,7 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)
 
 
 		/* Exit partial_power_down */
-		ret = dwc2_exit_partial_power_down(hsotg, true);
+		ret = dwc2_exit_partial_power_down(hsotg, 0, true);
 		if (ret && (ret != -ENOTSUPP))
 			dev_err(hsotg->dev, "exit partial_power_down failed\n");
 	} else {
diff --git a/drivers/usb/dwc2/hw.h b/drivers/usb/dwc2/hw.h
index c3d6dde2aca4..6b16fbf98bc6 100644
--- a/drivers/usb/dwc2/hw.h
+++ b/drivers/usb/dwc2/hw.h
@@ -44,6 +44,7 @@
 #define GOTGCTL_CHIRPEN			BIT(27)
 #define GOTGCTL_MULT_VALID_BC_MASK	(0x1f << 22)
 #define GOTGCTL_MULT_VALID_BC_SHIFT	22
+#define GOTGCTL_CURMODE_HOST		BIT(21)
 #define GOTGCTL_OTGVER			BIT(20)
 #define GOTGCTL_BSESVLD			BIT(19)
 #define GOTGCTL_ASESVLD			BIT(18)
-- 
2.25.1

