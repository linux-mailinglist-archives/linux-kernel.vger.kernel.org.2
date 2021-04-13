Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9BD35D903
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbhDMHhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:37:04 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:36484 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240511AbhDMHgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:36:54 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B925B4019F;
        Tue, 13 Apr 2021 07:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618299393; bh=VCsfoeGdYNwNfiUJzuIJGTNPJtdO1Pi+it1NAEsAZQw=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=asyFKQh0snLnZDW6FTI6+w8MRcs7m78d7CqFo22W/yZ9Wb6rS6E4BT2/ZG+2kzKg2
         x3ni4m5LRvMBoTh4adU1zwlJ6yYwPFHmAYerPaxjqHkpG+3R1+QptYWDfAdkJ2OQG+
         tYSzPt1S0wf0e7v7n+fIr4n9Aye/Bht27QZngQL/09iuZwH0Ha7gtbVOya1IhOZliY
         h2ws0FVtW60Mueafn7EDpEUGkJzmgvNQNdTtZM2fmNaZLWYrx27tXEn3GB4APxuhPn
         OXjph4pZGmY9odpQjH+z/q0CCxIm29TbSBKWB70TZLDYNwds4zWOpxN0mB7a/18U7w
         KShM7jkQ/weKQ==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id EF2CEA0094;
        Tue, 13 Apr 2021 07:36:30 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:36:30 +0400
Date:   Tue, 13 Apr 2021 11:36:30 +0400
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 04/12] usb: dwc2: Add exit clock gating from wakeup interrupt
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Message-Id: <20210413073630.EF2CEA0094@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added exit from clock gating mode when wakeup interrupt
is detected. To exit from the clock gating
in device mode "dwc2_gadget_exit_clock_gating()"
function is used with rem_wakeup parameter 0. To exit
clock gating in host mode "dwc2_host_exit_clock_gating()"
with rem_wakeup parameter 1.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/core_intr.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index ab7fe303c0f9..c764407e7633 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -415,17 +415,24 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 	if (dwc2_is_device_mode(hsotg)) {
 		dev_dbg(hsotg->dev, "DSTS=0x%0x\n",
 			dwc2_readl(hsotg, DSTS));
-		if (hsotg->lx_state == DWC2_L2 && hsotg->in_ppd) {
-			u32 dctl = dwc2_readl(hsotg, DCTL);
-			/* Clear Remote Wakeup Signaling */
-			dctl &= ~DCTL_RMTWKUPSIG;
-			dwc2_writel(hsotg, dctl, DCTL);
-			ret = dwc2_exit_partial_power_down(hsotg, 1,
-							   true);
-			if (ret)
-				dev_err(hsotg->dev,
-					"exit partial_power_down failed\n");
-			call_gadget(hsotg, resume);
+		if (hsotg->lx_state == DWC2_L2) {
+			if (hsotg->in_ppd) {
+				u32 dctl = dwc2_readl(hsotg, DCTL);
+				/* Clear Remote Wakeup Signaling */
+				dctl &= ~DCTL_RMTWKUPSIG;
+				dwc2_writel(hsotg, dctl, DCTL);
+				ret = dwc2_exit_partial_power_down(hsotg, 1,
+								   true);
+				if (ret)
+					dev_err(hsotg->dev,
+						"exit partial_power_down failed\n");
+				call_gadget(hsotg, resume);
+			}
+
+			/* Exit gadget mode clock gating. */
+			if (hsotg->params.power_down ==
+			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended)
+				dwc2_gadget_exit_clock_gating(hsotg, 0);
 		} else {
 			/* Change to L0 state */
 			hsotg->lx_state = DWC2_L0;
@@ -440,6 +447,10 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 						"exit partial_power_down failed\n");
 			}
 
+			if (hsotg->params.power_down ==
+			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended)
+				dwc2_host_exit_clock_gating(hsotg, 1);
+
 			/*
 			 * If we've got this quirk then the PHY is stuck upon
 			 * wakeup.  Assert reset.  This will propagate out and
-- 
2.25.1

