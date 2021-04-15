Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E3A3601B7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhDOFkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:40:41 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56478 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230296AbhDOFkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:40:35 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A94EA40876;
        Thu, 15 Apr 2021 05:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618465213; bh=uQ2IGh1zNa806XuJ0Ij3ORBvTUnpJ5SKdAn2kXmH6mU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=a/pJHXmyy26cQyoTRLYAGT168XxQrTxJ89z7f+81V/Fn2Gsp2qBJ2BdNBXuldDtv4
         Jq9qBGeII87PtEHsOsnHhimN309sicoUT/k37ZuyA3SI7cg3mP9n/MXmw2vkVR6wbU
         JsJwkhh6mUK2muLXbCdUZ6KGbRhYcKo5WDP+us+TfZb0uPZdqVHGzfLYlHpoUilU7f
         PlCN/PYnwfplYlm4GKw2rSjJ0JwUoCQH45Mi4Hcmz0XgGYjMc5ltqT9obUwJGAlkMS
         Yr/ADsDvQ3IeJr1SXs5iXZTLo86M4uhwCpdWgioRMVOTwu6aJxu0CBMMnvIc0HR5mI
         /LJ9kDVa1VlnA==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id BA5F4A005D;
        Thu, 15 Apr 2021 05:40:09 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 15 Apr 2021 09:40:08 +0400
Date:   Thu, 15 Apr 2021 09:40:08 +0400
Message-Id: <7ec6eaf787d37c39595d92ad2fc656812b5d0457.1618464534.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 06/15] usb: dwc2: Clear fifo_map when resetting core.
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

Switching from device mode to host mode by disconnecting
device cable core enters and exits form hibernation.
However, the fifo map remains not cleared. It results
to a WARNING (WARNING: CPU: 5 PID: 0 at drivers/usb/dwc2/
gadget.c:307 dwc2_hsotg_init_fifo+0x12/0x152 [dwc2])
if in host mode we disconnect the micro a to b host
cable. Because core reset occurs.

To avoid the WARNING, fifo_map should be cleared
in dwc2_core_reset() function by taking into account configs.
fifo_map must be cleared only if driver is configured in
"CONFIG_USB_DWC2_PERIPHERAL" or "CONFIG_USB_DWC2_DUAL_ROLE"
mode.

- Added "static inline void dwc2_clear_fifo_map()" helper
function to clear fifo_map with peripheral or dual role mode.

- Added a dummy version of "dwc2_clear_fifo_map()" helper
for host-only mode.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/core.c | 16 ++++++++++++++++
 drivers/usb/dwc2/core.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index cb65f7f60573..eccd96fa164e 100644
--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -470,6 +470,22 @@ int dwc2_core_reset(struct dwc2_hsotg *hsotg, bool skip_wait)
 		dwc2_writel(hsotg, greset, GRSTCTL);
 	}
 
+	/*
+	 * Switching from device mode to host mode by disconnecting
+	 * device cable core enters and exits form hibernation.
+	 * However, the fifo map remains not cleared. It results
+	 * to a WARNING (WARNING: CPU: 5 PID: 0 at drivers/usb/dwc2/
+	 * gadget.c:307 dwc2_hsotg_init_fifo+0x12/0x152 [dwc2])
+	 * if in host mode we disconnect the micro a to b host
+	 * cable. Because core reset occurs.
+	 * To avoid the WARNING, fifo_map should be cleared
+	 * in dwc2_core_reset() function by taking into account configs.
+	 * fifo_map must be cleared only if driver is configured in
+	 * "CONFIG_USB_DWC2_PERIPHERAL" or "CONFIG_USB_DWC2_DUAL_ROLE"
+	 * mode.
+	 */
+	dwc2_clear_fifo_map(hsotg);
+
 	/* Wait for AHB master IDLE state */
 	if (dwc2_hsotg_wait_bit_set(hsotg, GRSTCTL, GRSTCTL_AHBIDLE, 10000)) {
 		dev_warn(hsotg->dev, "%s: HANG! AHB Idle timeout GRSTCTL GRSTCTL_AHBIDLE\n",
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 8c12b3061f7f..e1f432095565 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1423,6 +1423,8 @@ int dwc2_hsotg_tx_fifo_total_depth(struct dwc2_hsotg *hsotg);
 int dwc2_hsotg_tx_fifo_average_depth(struct dwc2_hsotg *hsotg);
 void dwc2_gadget_init_lpm(struct dwc2_hsotg *hsotg);
 void dwc2_gadget_program_ref_clk(struct dwc2_hsotg *hsotg);
+static inline void dwc2_clear_fifo_map(struct dwc2_hsotg *hsotg)
+{ hsotg->fifo_map = 0; }
 #else
 static inline int dwc2_hsotg_remove(struct dwc2_hsotg *dwc2)
 { return 0; }
@@ -1467,6 +1469,7 @@ static inline int dwc2_hsotg_tx_fifo_average_depth(struct dwc2_hsotg *hsotg)
 { return 0; }
 static inline void dwc2_gadget_init_lpm(struct dwc2_hsotg *hsotg) {}
 static inline void dwc2_gadget_program_ref_clk(struct dwc2_hsotg *hsotg) {}
+static inline void dwc2_clear_fifo_map(struct dwc2_hsotg *hsotg) {}
 #endif
 
 #if IS_ENABLED(CONFIG_USB_DWC2_HOST) || IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
-- 
2.25.1

