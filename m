Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477A7362030
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243711AbhDPMsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:48:25 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42280 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243684AbhDPMsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:48:23 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BC6FEC06B9;
        Fri, 16 Apr 2021 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618577278; bh=QzqNN1TpnnJZcO/RBKPeEftrEV02egBMMrN3BOE/mQM=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=BFoO2BfrenU3EDAhdv53IFPveQpjJbnsaZgUvc+ZN540gFIPtVFeDUontVj+zmtHI
         g66VtL86UPNbAO9PRTqBsQwnsNXI1MIf0FQG7qU3Vpn6Vy8HgbwR6dNp3vujLajeaX
         lSe9a91S+LUan7FFtWQEwnhB2pXwXN7Zu0dnHvn1s9+6teq6G4CUZlEqJ5DD8S2OIA
         q58XRZ2GLXx6FQ6YBYucMThfnkWq5dZy4u4nAdge9e0o9r25RKBi09vLJEK8J71jiX
         wCjtMYVyYfVmwR+wUew6eG3tPVRJJ8p+bRAh7KO37TCXdmHKA/EU5rgQ6jUVi1CbBC
         Oh2Lm5uEfZ3AQ==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id E47F3A005D;
        Fri, 16 Apr 2021 12:47:55 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Fri, 16 Apr 2021 16:47:54 +0400
Date:   Fri, 16 Apr 2021 16:47:54 +0400
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 09/15] usb: dwc2: Move exit hibernation to dwc2_port_resume() function
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210416124755.E47F3A005D@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This move is done to call hibernation exit handler in
"dwc2_port_resume()" function when core receives port resume.
Otherwise it could be confusing to exit hibernation in
"dwc2_hcd_hub_control()" function but other power saving modes
in "dwc2_port_resume()" function.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/dwc2/hcd.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 43a2298b7d42..cc9ad6cf02d9 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -3383,6 +3383,11 @@ int dwc2_port_resume(struct dwc2_hsotg *hsotg)
 				"exit partial_power_down failed.\n");
 		break;
 	case DWC2_POWER_DOWN_PARAM_HIBERNATION:
+		/* Exit host hibernation. */
+		ret = dwc2_exit_hibernation(hsotg, 0, 0, 1);
+		if (ret)
+			dev_err(hsotg->dev, "exit hibernation failed.\n");
+		break;
 	case DWC2_POWER_DOWN_PARAM_NONE:
 		/*
 		 * If not hibernation nor partial power down are supported,
@@ -3446,12 +3451,8 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 			dev_dbg(hsotg->dev,
 				"ClearPortFeature USB_PORT_FEAT_SUSPEND\n");
 
-			if (hsotg->bus_suspended) {
-				if (hsotg->hibernated)
-					dwc2_exit_hibernation(hsotg, 0, 0, 1);
-				else
-					dwc2_port_resume(hsotg);
-			}
+			if (hsotg->bus_suspended)
+				retval = dwc2_port_resume(hsotg);
 			break;
 
 		case USB_PORT_FEAT_POWER:
-- 
2.25.1

