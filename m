Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BE73601AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhDOFkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:40:02 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56378 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230090AbhDOFj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:39:56 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B800A400CB;
        Thu, 15 Apr 2021 05:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618465172; bh=eeTrcspT2sKM4kBxXx1yy7IspbJ+ahCzuXCFIU1myxc=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=CPWsKl/ebdoyO5HuHXZZ0vfr2evf7Byx95N/fucD3eNCHZP5zm5z6UN8/9NYJtsBf
         882S8KsRqpkkq97xfdA8Ol58WPIInu7qIXfgC17J3c4J2d24W9bWWA6dgYqHmfVGBZ
         qqjtooHp2dh/Gn0iRL8E9H4l5yjGz3LqMbT9KJDIMMzHbhV7snzr08SfH+1M/S0I8P
         /hZhCsNREUznkLLlB0Lu4K2zVcZ1ZrJ9pUkSQrdKBPt9oe3FrUVbBGEbttD6KDvOo2
         kPQ/9ejCI9BCcuPUgt9fT0sHHgXuPUGowmgqBhBu7Kh1v/+ToEVeEtTluE2IAZsSy8
         ZYwTKJGBgYkag==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 3D074A005C;
        Thu, 15 Apr 2021 05:39:28 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 15 Apr 2021 09:39:26 +0400
Date:   Thu, 15 Apr 2021 09:39:26 +0400
Message-Id: <1d0e78a2c7da8706a065420302c8dacf2793738a.1618464534.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 01/15] usb: dwc2: Update exit hibernation when port reset is asserted
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to check for "DWC2_POWER_DOWN_PARAM_HIBERNATION" param
as "hsotg->hibernated" flag is already enough for exiting from
hibernation mode.

- Removes checking of "DWC2_POWER_DOWN_PARAM_HIBERNATION" param.

- For code readability Hibernation exit code moved after
debug message print.

- Added "dwc2_exit_hibernation()" function error checking.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 drivers/usb/dwc2/hcd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 04a1b53d65af..cda3f931195d 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -3668,9 +3668,17 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 			break;
 
 		case USB_PORT_FEAT_RESET:
-			if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_HIBERNATION &&
-			    hsotg->hibernated)
-				dwc2_exit_hibernation(hsotg, 0, 1, 1);
+			dev_dbg(hsotg->dev,
+				"SetPortFeature - USB_PORT_FEAT_RESET\n");
+
+			hprt0 = dwc2_read_hprt0(hsotg);
+
+			if (hsotg->hibernated) {
+				retval = dwc2_exit_hibernation(hsotg, 0, 1, 1);
+				if (retval)
+					dev_err(hsotg->dev,
+						"exit hibernation failed\n");
+			}
 
 			if (hsotg->in_ppd) {
 				retval = dwc2_exit_partial_power_down(hsotg, 1,
@@ -3684,9 +3692,6 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended)
 				dwc2_host_exit_clock_gating(hsotg, 0);
 
-			hprt0 = dwc2_read_hprt0(hsotg);
-			dev_dbg(hsotg->dev,
-				"SetPortFeature - USB_PORT_FEAT_RESET\n");
 			pcgctl = dwc2_readl(hsotg, PCGCTL);
 			pcgctl &= ~(PCGCTL_ENBL_SLEEP_GATING | PCGCTL_STOPPCLK);
 			dwc2_writel(hsotg, pcgctl, PCGCTL);
-- 
2.25.1

