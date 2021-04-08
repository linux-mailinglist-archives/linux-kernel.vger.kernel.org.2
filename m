Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53C8357FBC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhDHJqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:46:14 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37640 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231500AbhDHJqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:46:13 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1019340806;
        Thu,  8 Apr 2021 09:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617875162; bh=QpZJUwqksrvxljluCFgrIzDH+wfZNuUqYSwN0TUMTt4=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=a0PXgEseuoQiz6ZPg8EGxIO9MhezCJYyGHBwrHisw4i9TNx7E5Oe7p+8VydakBrkx
         S70LmGGXJdV3So4CPw2Lwd5tGZPPVfmVRjTxsgHFZmD8FPQL6JQ2HDZOq4vXS8GWXW
         Es7TfT5u5V0j71XZwlB88qw776Ekue4Yw6IUz5aehlfAXqEKIMp1tTrBKnMdM0ICFc
         G+EjnLxTQm8RFu/cvEYBIMcZUDO5qUmFU9DF22uuCr6aOEU1nz1ZtoSCX370jnr8Ve
         BO1dqdKcPOgMzfq0dv1WUz/CxxNHAElv2qhrcOgr3CeZ8MfVDJz/NrKXqwyFAs6n+n
         zQSbrj7XOyz4g==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 33541A022E;
        Thu,  8 Apr 2021 09:45:59 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 08 Apr 2021 13:45:58 +0400
Date:   Thu, 08 Apr 2021 13:45:58 +0400
In-Reply-To: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v3 12/14] usb: dwc2: Update partial power down entering by system suspend
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210408094559.33541A022E@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With current implementation the port power is being disabled,
which is not required by the programming guide. Also, if there
is a system which works only in "DWC2_POWER_DOWN_PARAM_NONE"
(clock gating) mode the current implementation does not set
Gate hclk bit in pcgctl register.

Rearranges and updates the implementation of entering to partial
power down power saving mode when PC is suspended to get
rid of many "if" statements and removes disabling of port power.

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

 drivers/usb/dwc2/hcd.c | 53 ++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index cb52bc41bfb8..34030bafdff4 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4367,8 +4367,6 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)
 	struct dwc2_hsotg *hsotg = dwc2_hcd_to_hsotg(hcd);
 	unsigned long flags;
 	int ret = 0;
-	u32 hprt0;
-	u32 pcgctl;
 
 	spin_lock_irqsave(&hsotg->lock, flags);
 
@@ -4384,47 +4382,32 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)
 	if (hsotg->op_state == OTG_STATE_B_PERIPHERAL)
 		goto unlock;
 
-	if (hsotg->params.power_down != DWC2_POWER_DOWN_PARAM_PARTIAL ||
-	    hsotg->flags.b.port_connect_status == 0)
+	if (hsotg->bus_suspended)
 		goto skip_power_saving;
 
-	/*
-	 * Drive USB suspend and disable port Power
-	 * if usb bus is not suspended.
-	 */
-	if (!hsotg->bus_suspended) {
-		hprt0 = dwc2_read_hprt0(hsotg);
-		if (hprt0 & HPRT0_CONNSTS) {
-			hprt0 |= HPRT0_SUSP;
-			if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_PARTIAL)
-				hprt0 &= ~HPRT0_PWR;
-			dwc2_writel(hsotg, hprt0, HPRT0);
-		}
-		if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_PARTIAL) {
-			spin_unlock_irqrestore(&hsotg->lock, flags);
-			dwc2_vbus_supply_exit(hsotg);
-			spin_lock_irqsave(&hsotg->lock, flags);
-		} else {
-			pcgctl = readl(hsotg->regs + PCGCTL);
-			pcgctl |= PCGCTL_STOPPCLK;
-			writel(pcgctl, hsotg->regs + PCGCTL);
-		}
-	}
+	if (hsotg->flags.b.port_connect_status == 0)
+		goto skip_power_saving;
 
-	if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_PARTIAL) {
+	switch (hsotg->params.power_down) {
+	case DWC2_POWER_DOWN_PARAM_PARTIAL:
 		/* Enter partial_power_down */
 		ret = dwc2_enter_partial_power_down(hsotg);
-		if (ret) {
-			if (ret != -ENOTSUPP)
-				dev_err(hsotg->dev,
-					"enter partial_power_down failed\n");
-			goto skip_power_saving;
-		}
-
-		/* After entering partial_power_down, hardware is no more accessible */
+		if (ret)
+			dev_err(hsotg->dev,
+				"enter partial_power_down failed\n");
+		/* After entering suspend, hardware is not accessible */
 		clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+		break;
+	case DWC2_POWER_DOWN_PARAM_HIBERNATION:
+	case DWC2_POWER_DOWN_PARAM_NONE:
+	default:
+		goto skip_power_saving;
 	}
 
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+	dwc2_vbus_supply_exit(hsotg);
+	spin_lock_irqsave(&hsotg->lock, flags);
+
 	/* Ask phy to be suspended */
 	if (!IS_ERR_OR_NULL(hsotg->uphy)) {
 		spin_unlock_irqrestore(&hsotg->lock, flags);
-- 
2.25.1

