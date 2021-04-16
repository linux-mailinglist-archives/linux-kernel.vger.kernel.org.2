Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F4362026
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbhDPMrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:47:46 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:38428 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243085AbhDPMrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:47:43 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8D23A40E1C;
        Fri, 16 Apr 2021 12:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618577238; bh=hpok5kVHp0MfHWo/Afzmy8pDTmAO8J2XmKEyi0l2Cjk=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=mR0MrHzeam7RdMSEhNVL5QfbEjgPhtvUby9Sy4kyezNfZE4/8rA1txTp8e4ZOnmdK
         2Qsx3nP/aA1+8s73uBcLVIruSE9r/U98DKmXmBJxeigMxqRUkXiRPCuFVfxSf19uvP
         T53/Kdb1TwdJUHsqGoA68kUkwFUQl65TC6KU5qJt3OrZXwvRHc4PDC0INQ0ykdlaR9
         QJ+f/Inay2cFdZS3DFzch3DhX3933CvfT1Qi76g9hNGubAt5yJapwe2GxowxQU2O8J
         fSouaXV84Up8rRN1n18w3avR1UL1c6H33dO3EBufBBHiWdR9bzeFV9JpPhVtG0Bd6H
         q03OrDyYcSrtg==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 75355A005D;
        Fri, 16 Apr 2021 12:47:15 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Fri, 16 Apr 2021 16:47:14 +0400
Date:   Fri, 16 Apr 2021 16:47:14 +0400
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 04/15] usb: dwc2: Fix hibernation between host and device modes.
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Vardan Mikayelyan <Vardan.Mikayelyan@synopsys.com>,
        Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Message-Id: <20210416124715.75355A005D@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When core is in hibernation in host mode and a device cable
was connected then driver exited from device hibernation.
However, registers saved for host mode and when exited from
device hibernation register restore would be done for device
register which was wrong because there was no device registers
stored to restore.

- Added dwc_handle_gpwrdn_disc_det() function which handles
  gpwrdn disconnect detect flow and exits hibernation
  without restoring the registers.
- Updated exiting from hibernation in GPWRDN_STS_CHGINT with
  calling dwc_handle_gpwrdn_disc_det() function. Here no register
  is restored which is the solution described above.

Fixes: 65c9c4c6b01f ("usb: dwc2: Add dwc2_handle_gpwrdn_intr() handler")
Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Signed-off-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/core_intr.c | 154 +++++++++++++++++++----------------
 1 file changed, 83 insertions(+), 71 deletions(-)

diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index 550c52c1a0c7..27d729fad227 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -680,6 +680,71 @@ static u32 dwc2_read_common_intr(struct dwc2_hsotg *hsotg)
 		return 0;
 }
 
+/**
+ * dwc_handle_gpwrdn_disc_det() - Handles the gpwrdn disconnect detect.
+ * Exits hibernation without restoring registers.
+ *
+ * @hsotg: Programming view of DWC_otg controller
+ * @gpwrdn: GPWRDN register
+ */
+static inline void dwc_handle_gpwrdn_disc_det(struct dwc2_hsotg *hsotg,
+					      u32 gpwrdn)
+{
+	u32 gpwrdn_tmp;
+
+	/* Switch-on voltage to the core */
+	gpwrdn_tmp = dwc2_readl(hsotg, GPWRDN);
+	gpwrdn_tmp &= ~GPWRDN_PWRDNSWTCH;
+	dwc2_writel(hsotg, gpwrdn_tmp, GPWRDN);
+	udelay(5);
+
+	/* Reset core */
+	gpwrdn_tmp = dwc2_readl(hsotg, GPWRDN);
+	gpwrdn_tmp &= ~GPWRDN_PWRDNRSTN;
+	dwc2_writel(hsotg, gpwrdn_tmp, GPWRDN);
+	udelay(5);
+
+	/* Disable Power Down Clamp */
+	gpwrdn_tmp = dwc2_readl(hsotg, GPWRDN);
+	gpwrdn_tmp &= ~GPWRDN_PWRDNCLMP;
+	dwc2_writel(hsotg, gpwrdn_tmp, GPWRDN);
+	udelay(5);
+
+	/* Deassert reset core */
+	gpwrdn_tmp = dwc2_readl(hsotg, GPWRDN);
+	gpwrdn_tmp |= GPWRDN_PWRDNRSTN;
+	dwc2_writel(hsotg, gpwrdn_tmp, GPWRDN);
+	udelay(5);
+
+	/* Disable PMU interrupt */
+	gpwrdn_tmp = dwc2_readl(hsotg, GPWRDN);
+	gpwrdn_tmp &= ~GPWRDN_PMUINTSEL;
+	dwc2_writel(hsotg, gpwrdn_tmp, GPWRDN);
+
+	/* De-assert Wakeup Logic */
+	gpwrdn_tmp = dwc2_readl(hsotg, GPWRDN);
+	gpwrdn_tmp &= ~GPWRDN_PMUACTV;
+	dwc2_writel(hsotg, gpwrdn_tmp, GPWRDN);
+
+	hsotg->hibernated = 0;
+	hsotg->bus_suspended = 0;
+
+	if (gpwrdn & GPWRDN_IDSTS) {
+		hsotg->op_state = OTG_STATE_B_PERIPHERAL;
+		dwc2_core_init(hsotg, false);
+		dwc2_enable_global_interrupts(hsotg);
+		dwc2_hsotg_core_init_disconnected(hsotg, false);
+		dwc2_hsotg_core_connect(hsotg);
+	} else {
+		hsotg->op_state = OTG_STATE_A_HOST;
+
+		/* Initialize the Core for Host mode */
+		dwc2_core_init(hsotg, false);
+		dwc2_enable_global_interrupts(hsotg);
+		dwc2_hcd_start(hsotg);
+	}
+}
+
 /*
  * GPWRDN interrupt handler.
  *
@@ -701,64 +766,14 @@ static void dwc2_handle_gpwrdn_intr(struct dwc2_hsotg *hsotg)
 
 	if ((gpwrdn & GPWRDN_DISCONN_DET) &&
 	    (gpwrdn & GPWRDN_DISCONN_DET_MSK) && !linestate) {
-		u32 gpwrdn_tmp;
-
 		dev_dbg(hsotg->dev, "%s: GPWRDN_DISCONN_DET\n", __func__);
-
-		/* Switch-on voltage to the core */
-		gpwrdn_tmp = dwc2_readl(hsotg, GPWRDN);
-		gpwrdn_tmp &= ~GPWRDN_PWRDNSWTCH;
-		dwc2_writel(hsotg, gpwrdn_tmp, GPWRDN);
-		udelay(10);
-
-		/* Reset core */
-		gpwrdn_tmp = dwc2_readl(hsotg, GPWRDN);
-		gpwrdn_tmp &= ~GPWRDN_PWRDNRSTN;
-		dwc2_writel(hsotg, gpwrdn_tmp, GPWRDN);
-		udelay(10);
-
-		/* Disable Power Down Clamp */
-		gpwrdn_tmp = dwc2_readl(hsotg, GPWRDN);
-		gpwrdn_tmp &= ~GPWRDN_PWRDNCLMP;
-		dwc2_writel(hsotg, gpwrdn_tmp, GPWRDN);
-		udelay(10);
-
-		/* Deassert reset core */
-		gpwrdn_tmp = dwc2_readl(hsotg, GPWRDN);
-		gpwrdn_tmp |= GPWRDN_PWRDNRSTN;
-		dwc2_writel(hsotg, gpwrdn_tmp, GPWRDN);
-		udelay(10);
-
-		/* Disable PMU interrupt */
-		gpwrdn_tmp = dwc2_readl(hsotg, GPWRDN);
-		gpwrdn_tmp &= ~GPWRDN_PMUINTSEL;
-		dwc2_writel(hsotg, gpwrdn_tmp, GPWRDN);
-
-		/* De-assert Wakeup Logic */
-		gpwrdn_tmp = dwc2_readl(hsotg, GPWRDN);
-		gpwrdn_tmp &= ~GPWRDN_PMUACTV;
-		dwc2_writel(hsotg, gpwrdn_tmp, GPWRDN);
-
-		hsotg->hibernated = 0;
-
-		if (gpwrdn & GPWRDN_IDSTS) {
-			hsotg->op_state = OTG_STATE_B_PERIPHERAL;
-			dwc2_core_init(hsotg, false);
-			dwc2_enable_global_interrupts(hsotg);
-			dwc2_hsotg_core_init_disconnected(hsotg, false);
-			dwc2_hsotg_core_connect(hsotg);
-		} else {
-			hsotg->op_state = OTG_STATE_A_HOST;
-
-			/* Initialize the Core for Host mode */
-			dwc2_core_init(hsotg, false);
-			dwc2_enable_global_interrupts(hsotg);
-			dwc2_hcd_start(hsotg);
-		}
-	}
-
-	if ((gpwrdn & GPWRDN_LNSTSCHG) &&
-	    (gpwrdn & GPWRDN_LNSTSCHG_MSK) && linestate) {
+		/*
+		 * Call disconnect detect function to exit from
+		 * hibernation
+		 */
+		dwc_handle_gpwrdn_disc_det(hsotg, gpwrdn);
+	} else if ((gpwrdn & GPWRDN_LNSTSCHG) &&
+		   (gpwrdn & GPWRDN_LNSTSCHG_MSK) && linestate) {
 		dev_dbg(hsotg->dev, "%s: GPWRDN_LNSTSCHG\n", __func__);
 		if (hsotg->hw_params.hibernation &&
 		    hsotg->hibernated) {
@@ -769,24 +784,21 @@ static void dwc2_handle_gpwrdn_intr(struct dwc2_hsotg *hsotg)
 				dwc2_exit_hibernation(hsotg, 1, 0, 1);
 			}
 		}
-	}
-	if ((gpwrdn & GPWRDN_RST_DET) && (gpwrdn & GPWRDN_RST_DET_MSK)) {
+	} else if ((gpwrdn & GPWRDN_RST_DET) &&
+		   (gpwrdn & GPWRDN_RST_DET_MSK)) {
 		dev_dbg(hsotg->dev, "%s: GPWRDN_RST_DET\n", __func__);
 		if (!linestate && (gpwrdn & GPWRDN_BSESSVLD))
 			dwc2_exit_hibernation(hsotg, 0, 1, 0);
-	}
-	if ((gpwrdn & GPWRDN_STS_CHGINT) &&
-	    (gpwrdn & GPWRDN_STS_CHGINT_MSK) && linestate) {
+	} else if ((gpwrdn & GPWRDN_STS_CHGINT) &&
+		   (gpwrdn & GPWRDN_STS_CHGINT_MSK)) {
 		dev_dbg(hsotg->dev, "%s: GPWRDN_STS_CHGINT\n", __func__);
-		if (hsotg->hw_params.hibernation &&
-		    hsotg->hibernated) {
-			if (gpwrdn & GPWRDN_IDSTS) {
-				dwc2_exit_hibernation(hsotg, 0, 0, 0);
-				call_gadget(hsotg, resume);
-			} else {
-				dwc2_exit_hibernation(hsotg, 1, 0, 1);
-			}
-		}
+		/*
+		 * As GPWRDN_STS_CHGINT exit from hibernation flow is
+		 * the same as in GPWRDN_DISCONN_DET flow. Call
+		 * disconnect detect helper function to exit from
+		 * hibernation.
+		 */
+		dwc_handle_gpwrdn_disc_det(hsotg, gpwrdn);
 	}
 }
 
-- 
2.25.1

