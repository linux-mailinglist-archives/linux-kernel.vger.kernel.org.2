Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEF736203C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243792AbhDPMtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:49:16 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:38488 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243825AbhDPMtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:49:11 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BFA1940E26;
        Fri, 16 Apr 2021 12:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618577327; bh=vjUFWtJSLOzPAUTyN17ZQL8vgGSaKnLTTSgQqYHWaCo=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=ilIg1rjlOMa0y+ZHnyNgwmRpeaDonwR0CW/ybKtpuQVQQVcZ3F4nFuq6406iXqcp6
         jDWV9s48X72TnfPKDwU7l6Jn4MTqXJOII341dlAAyF9O8PWwXS1UBelOijGH9WP4rJ
         JF4cuqkt1yRReICisdo2ddl74pZJJ4HEaNpak3uU9AvHAyQlEQkWi7/Q2FaCExn68/
         BydKHlcm571Pz8aR6DNMbPkjvpyJbIbQH+b9YOg96bI/T4I2mcI8724g0zzmtkOuuY
         +9wAxFLvvvCOP4CSmU1fyaMDAeeiPqYdvSGbYGFY6o8inzVZHKTxMs9BMQN96ViqgH
         5wCZrEdshsOvg==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 9EDCDA005D;
        Fri, 16 Apr 2021 12:48:43 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Fri, 16 Apr 2021 16:48:42 +0400
Date:   Fri, 16 Apr 2021 16:48:42 +0400
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 15/15] usb: dwc2: Get rid of useless error checks in suspend interrupt
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>
Message-Id: <20210416124843.9EDCDA005D@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Squashed from Douglas Anderson's suggested commit
"usb: dwc2: Get rid of useless error checks for
hibernation/partial power down"

 - After this commit there should never be any
case where dwc2_enter_partial_power_down() and
dwc2_enter_hibernation() are called when
'params.power_down' is not correct.  Get rid of
the pile of error checking.

- As part of this cleanup some of the error messages
not to have __func__ in them.  That's not needed
for dev_err() calls since they already have the
device name as part of the message.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 Changes in v2:
 - None

 drivers/usb/dwc2/core.c      |  3 ---
 drivers/usb/dwc2/core_intr.c | 18 +++++++-----------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index 576c262dba55..6f70ab9577b4 100644
--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -391,9 +391,6 @@ static bool dwc2_iddig_filter_enabled(struct dwc2_hsotg *hsotg)
  */
 int dwc2_enter_hibernation(struct dwc2_hsotg *hsotg, int is_host)
 {
-	if (hsotg->params.power_down != DWC2_POWER_DOWN_PARAM_HIBERNATION)
-		return -ENOTSUPP;
-
 	if (is_host)
 		return dwc2_host_enter_hibernation(hsotg);
 	else
diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index 470458ac664b..a5ab03808da6 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -535,13 +535,10 @@ static void dwc2_handle_usb_suspend_intr(struct dwc2_hsotg *hsotg)
 			switch (hsotg->params.power_down) {
 			case DWC2_POWER_DOWN_PARAM_PARTIAL:
 				ret = dwc2_enter_partial_power_down(hsotg);
-				if (ret) {
-					if (ret != -ENOTSUPP)
-						dev_err(hsotg->dev,
-							"%s: enter partial_power_down failed\n",
-							__func__);
-					goto skip_power_saving;
-				}
+				if (ret)
+					dev_err(hsotg->dev,
+						"enter partial_power_down failed\n");
+
 				udelay(100);
 
 				/* Ask phy to be suspended */
@@ -550,10 +547,9 @@ static void dwc2_handle_usb_suspend_intr(struct dwc2_hsotg *hsotg)
 				break;
 			case DWC2_POWER_DOWN_PARAM_HIBERNATION:
 				ret = dwc2_enter_hibernation(hsotg, 0);
-				if (ret && ret != -ENOTSUPP)
+				if (ret)
 					dev_err(hsotg->dev,
-						"%s: enter hibernation failed\n",
-						__func__);
+						"enter hibernation failed\n");
 				break;
 			case DWC2_POWER_DOWN_PARAM_NONE:
 				/*
@@ -562,7 +558,7 @@ static void dwc2_handle_usb_suspend_intr(struct dwc2_hsotg *hsotg)
 				 */
 				dwc2_gadget_enter_clock_gating(hsotg);
 			}
-skip_power_saving:
+
 			/*
 			 * Change to L2 (suspend) state before releasing
 			 * spinlock
-- 
2.25.1

