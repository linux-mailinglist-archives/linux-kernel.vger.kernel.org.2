Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0C53601C9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhDOFlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:41:35 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56518 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230090AbhDOFlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:41:31 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 39637404B4;
        Thu, 15 Apr 2021 05:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618465269; bh=sMYUcJjmu6mpKPzTc6LOGrbWk7P4Y2uZaj8qYVP7Nzo=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=ZupbC7992yJg9PJjU9XWNfboBKnb6zFoFvYOPIFlJB3Sg/TRMcmt5z6e4ArYn/2cf
         MN9WtATVDGXx6FWaZTn19CFlxS8D96IdZQlEI7E2YNONs/I68u5eyYmLO/IJh6RgGr
         qH6OMhI2hR1fohXpsxAiEda7yZIcWjcoeN1iyNRlfXaEeU6076t6kyrjqyseKUfSYx
         lCUWO/lrvVofS6JYWBSY90V13t01wFG+/mL43J4wvMjb6a2+IJ5XsIDw2CEO/Jynti
         IDbpRoK/0XhLy/7MuU+eYjXNPRGkYjDZYT3LqNOUF+4OLaPE0I6WjOruK73ZMUeMmo
         APnQXzJpPYGXA==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 3654DA005C;
        Thu, 15 Apr 2021 05:41:06 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 15 Apr 2021 09:41:04 +0400
Date:   Thu, 15 Apr 2021 09:41:04 +0400
Message-Id: <d01d23e2473407af37c42acb6ca4815ae5fd256e.1618464534.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 13/15] usb: dwc2: Add exit hibernation mode before removing drive
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dwc2 core is in hibernation mode loading
driver again causes driver fail. Because in
that mode registers are not accessible.

In order to exit from hibernation checking
dwc2 core power saving state in "dwc2_driver_remove()"
function. If core is in hibernation, then checking the
operational mode of the driver. To check whether dwc2 core
is operating in host mode or device mode there is one way
which is retrieving the backup value of "gotgctl" and compare
the "CurMod" value. If previously core entered hibernation
in host mode then the exit is performed for host if not then
exit is performed for device mode. The introduced checking
is because in hibernation state all registers are not
accessible.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 drivers/usb/dwc2/platform.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index f8b819cfa80e..2ae4748ed5ec 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -316,8 +316,24 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 static int dwc2_driver_remove(struct platform_device *dev)
 {
 	struct dwc2_hsotg *hsotg = platform_get_drvdata(dev);
+	struct dwc2_gregs_backup *gr;
 	int ret = 0;
 
+	/* Exit Hibernation when driver is removed. */
+	if (hsotg->hibernated) {
+		if (gr->gotgctl & GOTGCTL_CURMODE_HOST) {
+			ret = dwc2_exit_hibernation(hsotg, 0, 0, 1);
+			if (ret)
+				dev_err(hsotg->dev,
+					"exit hibernation failed.\n");
+		} else {
+			ret = dwc2_exit_hibernation(hsotg, 0, 0, 0);
+			if (ret)
+				dev_err(hsotg->dev,
+					"exit hibernation failed.\n");
+		}
+	}
+
 	/* Exit Partial Power Down when driver is removed. */
 	if (hsotg->in_ppd) {
 		ret = dwc2_exit_partial_power_down(hsotg, 0, true);
-- 
2.25.1

