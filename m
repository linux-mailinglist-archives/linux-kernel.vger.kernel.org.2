Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A533601BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhDOFk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:40:58 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:53752 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230398AbhDOFkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:40:51 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1CB90C0619;
        Thu, 15 Apr 2021 05:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618465229; bh=/CKEqrmCTBvX8BljUE8RmnqFNiwNonJFnQwnpVeK+DM=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=VnxjUhjZVHUmcCINdCPyosW4z0tvlCRYp3WLdKLyKc7nKEz/Wrpii2od5LTutSh+u
         Ou9+FcY+46uxIOcjKi+YsV7SNvBN2ifyS8VZjFK93Y87j4VOTrb+IlKcBbsEYX6PVL
         A4IKTVQ3pJjHON85Vam7oxMOrHxhp/BkpmnW8uRiKFOS9B+yRzFiwDn+Wmo0BnGvYd
         mP7ycSx3Dht157qFO1DRAe9fFkKju/6XvgD5tY8prvpwAOCS4z45BfFCRi9EoOsHxv
         ixIsP+/yrpAMy7lNqPLa45VgZJYoxetPqGd72VOdZBNU0GqPtnYXC99RiNqHXaRlnj
         JuDlHZFXbi/bg==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 1ECD8A005C;
        Thu, 15 Apr 2021 05:40:26 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 15 Apr 2021 09:40:24 +0400
Date:   Thu, 15 Apr 2021 09:40:24 +0400
Message-Id: <a2ac2540a3d6858d3a7b04cd466caead1b6bb0a8.1618464534.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 08/15] usb: dwc2: Move enter hibernation to dwc2_port_suspend() function
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This move is done to call enter hibernation handler in
"dwc2_port_suspend()" function when core receives port suspend.
Otherwise it could be confusing to enter to hibernation in
"dwc2_hcd_hub_control()" function but other power saving modes
in "dwc2_port_suspend()" function.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 drivers/usb/dwc2/hcd.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index ff945c40ef8a..43a2298b7d42 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -3321,6 +3321,18 @@ int dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
 				"enter partial_power_down failed.\n");
 		break;
 	case DWC2_POWER_DOWN_PARAM_HIBERNATION:
+		/*
+		 * Perform spin unlock and lock because in
+		 * "dwc2_host_enter_hibernation()" function there is a spinlock
+		 * logic which prevents servicing of any IRQ during entering
+		 * hibernation.
+		 */
+		spin_unlock_irqrestore(&hsotg->lock, flags);
+		ret = dwc2_enter_hibernation(hsotg, 1);
+		if (ret)
+			dev_err(hsotg->dev, "enter hibernation failed.\n");
+		spin_lock_irqsave(&hsotg->lock, flags);
+		break;
 	case DWC2_POWER_DOWN_PARAM_NONE:
 		/*
 		 * If not hibernation nor partial power down are supported,
@@ -3650,10 +3662,8 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 				"SetPortFeature - USB_PORT_FEAT_SUSPEND\n");
 			if (windex != hsotg->otg_port)
 				goto error;
-			if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_HIBERNATION)
-				dwc2_enter_hibernation(hsotg, 1);
-			else
-				dwc2_port_suspend(hsotg, windex);
+			if (!hsotg->bus_suspended)
+				retval = dwc2_port_suspend(hsotg, windex);
 			break;
 
 		case USB_PORT_FEAT_POWER:
-- 
2.25.1

