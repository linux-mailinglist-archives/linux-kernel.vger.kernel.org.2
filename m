Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7906736201B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243590AbhDPMrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:47:23 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:38398 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243574AbhDPMrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:47:20 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F006540E26;
        Fri, 16 Apr 2021 12:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618577215; bh=WUBBsSAYHVfxuO7w6qNhvJEptUq9PTeKv5MPqi859dc=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Efz2XXcyy1+DicB0b/lFZPo9n6sx4fsPieQGwXrK6lENXwi4Y8/ffCZqiB/q8Y4ph
         zUHWHOSS+trpv0BYXysJbKN1C7fXEIu0IPrd4m32SLtBwqBIoSJ3u0cJ0ggphJpPDM
         1JOOywmWB2FapKisBg7G4zWqg3LzCJALzWMwuq6J0VAkAfQMMKqRr2AjWSMCW+r0qq
         BgYYoxYmJr9THXS/ygDz8Zv0cPfadhgdgJ6j8A7nk9pnoo8b97L1pbH0Nhmh2wnRGG
         lI61fsHmc0M6iSf5p3aYVj02BTyJol7pPDym0UaoEcqcHTjNE+23GK5bxImgt9jqqJ
         PTIQgHNuTZsVQ==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 51C8DA005C;
        Fri, 16 Apr 2021 12:46:51 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Fri, 16 Apr 2021 16:46:50 +0400
Date:   Fri, 16 Apr 2021 16:46:50 +0400
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 01/15] usb: dwc2: Update exit hibernation when port reset is asserted
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210416124651.51C8DA005C@mailhost.synopsys.com>
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
 Changes in v2:
 - None

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

