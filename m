Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48242449A88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbhKHRMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:12:53 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40757 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236413AbhKHRMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:12:51 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B20ED5C01A8;
        Mon,  8 Nov 2021 12:10:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 08 Nov 2021 12:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=MU0pudiomOBk1
        BhCOEiNgrv+VzG0+79jlfAXlUbLYZo=; b=bBkFbRDq4FysP7uICMfwI0w0c6EIO
        +WnwaUzkQtM6ie6YRZMqS1lPGfYD5dORjkqYXOcMTQ89Ih/jSDDbQOQb2RzUUZR9
        ol06DJLLpmExm76gfNBRYWvchFZ1QFfLDpNwlyNChZ3O7sowQR316Jx0/GNKOyNH
        /wLEHun4CdhPaV0WUCTJgsUAYqXvEGLO5exW45JrJ11+Pz1OjTq/DmFY1nfK2Pk7
        9ALYTlIuG3Faa9oXfyMocU5pEhdoQ0QHF1ZqmhjdkrCYM9JjUBvZhnKOCU+Uba+p
        T6W3pj2Z9NLj8gKHjmg8b15lq7A+MUd74Xs23mnXtOGyAPUgmKxogw6cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=MU0pudiomOBk1BhCOEiNgrv+VzG0+79jlfAXlUbLYZo=; b=fDRtFySg
        t9CONshaSQzNUsOm/tixzxcHwGCBepagPWJJ+urs9YwbbMaMsBHB1kN4NxYBYDKw
        DaxBXxfql0uPyXaTTZxTLXP7WEg4oXEbtIRRGRKmu1nFG90hNgUSFKl2fDAQZNV+
        nRNJ2fX/UwtSCElg3zJuPLEAV/T/oJO5fyO98z7ftCEM9+A8tgftkBp5zaALFsUU
        N25Um3WoZs8pgWQ2xXOI/TzhtVIVNdL0IF6GR+FxH9AbwLUmfpPgDttjqO14naOo
        KtVT1vTh+ng2uNbdH1J7mogWpstKwMNlfk8PQbrZAqJ2ztG5ivtRR4xxsn3xBNXN
        crD3+mZaAvd3IA==
X-ME-Sender: <xms:6FmJYR5Y2l8vAlehQkMTYkDOyepCepHtQWAtzeD996Oi6mW_vo86zw>
    <xme:6FmJYe6UwIIIRdOPHEvk8rHQxgE_MKlCU6GwjLhUJYcNpi7YfdkB1KH9lb_1d1tVe
    IqaqQBcYpNzow0AT94>
X-ME-Received: <xmr:6FmJYYeVlVi1qgBip-I74jk7H68lw_c-YXDDkUPyeicxSfi7uZ5jwd1ztg8rAwEbaxVBopvlYFzCNMgtymmXm25OkB5N09mifrQSMdHdgWekQSAwE_y48OvFU-eB3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddvgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfefjeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
    esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:6FmJYaJgX0t-JhhMsVs_elX4zPIVmMNjZum9DljcdiJGsD5YOGcOCA>
    <xmx:6FmJYVJ1CZaWrUjuQXaSIZvvQIr-p5XPaZcE5OmELAl0j8RsD5HFeA>
    <xmx:6FmJYTw87SW41JgEDonHAhN6C2lDs0ycwg9JJqiurnPQje5706h8VA>
    <xmx:6FmJYc_tAEIUbfWoYqEGnbloK2_faLPw4PL1Q56tEyzgfptdhIWmlA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Nov 2021 12:09:58 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] usb: dwc3: Add role switch reset quirk for Apple DWC3
Date:   Mon,  8 Nov 2021 18:09:46 +0100
Message-Id: <20211108170946.49689-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211108170946.49689-1-sven@svenpeter.dev>
References: <20211108170946.49689-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mad as it sounds, the dwc3 controller present on Apple SoCs must be
reset and reinitialized whenever a device is unplugged from the root port
and triggers a role switch notification from the USB PD controller.

This is required for at least two reasons:

  - The USB2 D+/D- lines are connected through a stateful eUSB2 repeater
    which in turn is controlled by a variant of the TI TPS6598x USB PD
    chip. When the USB PD controller detects a hotplug event it resets
    the eUSB2 repeater. Afterwards, no new device is recognized before
    the DWC3 core and PHY are reset as well.

  - It's possible to completely break the dwc3 controller by switching
    it to device mode and unplugging the cable at just the wrong time.
    Even a CORESOFTRESET is not enough to allow new devices again.
    The only workaround is to trigger a hard reset of the entire
    dwc3 core. This also happens when running macOS on these
    machines.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
v1 -> v2:
 - enable the quirk based on the compatible instead of a property
   as requested by robh

 drivers/usb/dwc3/core.c | 39 ++++++++++++++++++++++++++++++++++++---
 drivers/usb/dwc3/core.h |  6 ++++++
 drivers/usb/dwc3/drd.c  |  7 +++++++
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 0104a80b185e..b76d7536eafe 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -115,6 +115,8 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 }
 
 static int dwc3_core_soft_reset(struct dwc3 *dwc);
+static void dwc3_core_exit(struct dwc3 *dwc);
+static int dwc3_core_init_for_resume(struct dwc3 *dwc);
 
 static void __dwc3_set_mode(struct work_struct *work)
 {
@@ -130,10 +132,11 @@ static void __dwc3_set_mode(struct work_struct *work)
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
 		dwc3_otg_update(dwc, 0);
 
-	if (!dwc->desired_dr_role)
+	if (!dwc->desired_dr_role && !dwc->role_switch_reset_quirk)
 		goto out;
 
-	if (dwc->desired_dr_role == dwc->current_dr_role)
+	if (dwc->desired_dr_role == dwc->current_dr_role &&
+			!dwc->role_switch_reset_quirk)
 		goto out;
 
 	if (dwc->desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
@@ -158,6 +161,34 @@ static void __dwc3_set_mode(struct work_struct *work)
 		break;
 	}
 
+	if (dwc->role_switch_reset_quirk) {
+		if (dwc->current_dr_role) {
+			dwc->current_dr_role = 0;
+			dwc3_core_exit(dwc);
+		}
+
+		if (dwc->desired_dr_role) {
+			/*
+			 * the first call to __dwc3_set_mode comes from
+			 * dwc3_drd_init. In that case dwc3_core_init has been
+			 * called but dwc->current_dr_role is zero such that
+			 * we must not reinitialize the core again here.
+			 */
+			if (dwc->role_switch_reset_quirk_initialized) {
+				ret = dwc3_core_init_for_resume(dwc);
+				if (ret) {
+					dev_err(dwc->dev,
+					    "failed to reinitialize core\n");
+					goto out;
+				}
+			}
+
+			dwc->role_switch_reset_quirk_initialized = 1;
+		} else {
+			goto out;
+		}
+	}
+
 	/* For DRD host or device mode only */
 	if (dwc->desired_dr_role != DWC3_GCTL_PRTCAP_OTG) {
 		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
@@ -1586,6 +1617,8 @@ static int dwc3_probe(struct platform_device *pdev)
 		else
 			dwc->num_clks = ret;
 
+		if (of_device_is_compatible(dev->of_node, "apple,dwc3"))
+			dwc->role_switch_reset_quirk = true;
 	}
 
 	ret = reset_control_deassert(dwc->reset);
@@ -1715,7 +1748,6 @@ static int dwc3_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 {
 	int ret;
@@ -1742,6 +1774,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	return ret;
 }
 
+#ifdef CONFIG_PM
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5612bfdf37da..3fc5c5bc4c57 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1080,6 +1080,9 @@ struct dwc3_scratchpad_array {
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
+ * @role_switch_reset_quirk: set to force reinitialization after any role switch
+ * @role_switch_reset_quirk_initialized: set to true after the first role switch
+ *			which is triggered from dwc3_drd_init directly
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
  * @max_cfg_eps: current max number of IN eps used across all USB configs.
@@ -1291,6 +1294,9 @@ struct dwc3 {
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
 
+	unsigned		role_switch_reset_quirk:1;
+	unsigned		role_switch_reset_quirk_initialized:1;
+
 	u16			imod_interval;
 
 	int			max_cfg_eps;
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index d7f76835137f..403e88a72f0e 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -506,6 +506,9 @@ static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
 		break;
 	}
 
+	if (dwc->role_switch_reset_quirk && role == USB_ROLE_NONE)
+		mode = 0;
+
 	dwc3_set_mode(dwc, mode);
 	return 0;
 }
@@ -534,6 +537,10 @@ static enum usb_role dwc3_usb_role_switch_get(struct usb_role_switch *sw)
 			role = USB_ROLE_DEVICE;
 		break;
 	}
+
+	if (dwc->role_switch_reset_quirk && !dwc->current_dr_role)
+		role = USB_ROLE_NONE;
+
 	spin_unlock_irqrestore(&dwc->lock, flags);
 	return role;
 }
-- 
2.25.1

