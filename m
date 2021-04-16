Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DABB36202E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbhDPMsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:48:19 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42270 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243684AbhDPMsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:48:15 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CD889C06BA;
        Fri, 16 Apr 2021 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618577271; bh=AsB4pzMO9T/Ifbq2nL27yKkTwDu2eMWyNVeZjwbDJWQ=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=FlSUbb+QQ8QiOnjXEVFvPREY7ezPE+YF+HjB60jnQSIu7IfLHIZ7nZfHbmufWA/IE
         Qdkmc9FCihPxUdpeXNUy7uY9cFAqMhaPgXwPv+yKo/aQSAE5ywpn55LHEnmNsaFBdH
         I7L4OuZpyrJ60LUuD+JreEX5v3ZqZvrJQQQXLTtBJSuVyBGafqiQLsMx9R/d+pB0Ft
         P+wf20bZNFMyD4OChNSFy1CcEmnF8pzHW4KPj2ffTBS7wP0Kc7QoffpUGawhcMsPhR
         6W56iHgFUxHVLSFcFmPjoVjAps3II4xNRMb3QbONUcHflKQYx5YqmseT776NDfN8w4
         os1gvLezLHp+w==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id EE79EA005C;
        Fri, 16 Apr 2021 12:47:47 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Fri, 16 Apr 2021 16:47:46 +0400
Date:   Fri, 16 Apr 2021 16:47:46 +0400
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 08/15] usb: dwc2: Move enter hibernation to dwc2_port_suspend() function
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210416124747.EE79EA005C@mailhost.synopsys.com>
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
 Changes in v2:
 - None

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

