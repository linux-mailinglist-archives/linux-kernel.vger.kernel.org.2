Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6A03601BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhDOFlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:41:03 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:53758 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230118AbhDOFk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:40:59 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DDED3C0619;
        Thu, 15 Apr 2021 05:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618465237; bh=+x+O2x776IR77O4BNxgrElMeHHKOSZeGKNYnzVXdQKE=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=V/z7D1i+yZTjYZc9fQawJ4HHxQ+JoUYfQ/PTiBp04O/nHVCdxRz0I2k4Ej50XCSAv
         En846RBwGNLLmNHj2UpFqoNp8YqR+QsMpTUpyIqGatvsHTcwzcFQYqoHhsKveorpd8
         2ImUTirQXAasmXVcbtLcY62s4iA6GCxbyIsnO45Xt7fyn/2yH1Dt+sNJdtiCev2Pu8
         zTgiPfy6ayrd0XnilwwAFlUIDE7p50FwOW4sL/Tess5MPjrSOvZNqfP0ouOxHBeuml
         4BxOIGPgrX5qzcMhphZcEFArAoJ3uNrpnWB54zwZv1Xe3owvNjut0/+PSEePf/Jfza
         g5OtiEjvn0evA==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 1708BA005D;
        Thu, 15 Apr 2021 05:40:34 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 15 Apr 2021 09:40:32 +0400
Date:   Thu, 15 Apr 2021 09:40:32 +0400
Message-Id: <ce0293bcc36b0857262a9a46e61b3f4e1d9e757c.1618464534.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 09/15] usb: dwc2: Move exit hibernation to dwc2_port_resume() function
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
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

