Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92777362038
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243788AbhDPMtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:49:01 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:38478 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242267AbhDPMsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:48:55 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 709EC40E1C;
        Fri, 16 Apr 2021 12:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618577310; bh=Kr2xNeU4OXF1sHy3UEwMqt5On5AMSUd5JRZZcuAfDNk=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=btBDN3YdtgxaC9rwpE+4voT8g5XzmlTc+kCzduaa307x2Lbi8FE/54EqPfI/PDPDw
         6CpKJFhD8Vzo1aALfpTpHUotiluGaP4LlKSglq1Iz6gEcfbmrN3ttZnUBTU7nNe1Bo
         ga0A/8E7+ioc23U4SXgIwFCEzLZ1U6XtPzfhwt1YWpfbPgWd+wpX0P8mMEfzCF/Mt6
         WVjuQpWwF+CM1huPuyj4oi6LJufXCgsb7J3cJt6GW4QYDVLeKBVRfcuvbDXA4MzR1b
         5H54JGZIKfrm8YEhHodpXr6vEYCBrG382GveaZd+jXFLXsnacc1pUx4v5nlLMIH4qr
         uixtv27y6MqjQ==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 9BB59A005D;
        Fri, 16 Apr 2021 12:48:27 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Fri, 16 Apr 2021 16:48:26 +0400
Date:   Fri, 16 Apr 2021 16:48:26 +0400
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 13/15] usb: dwc2: Add exit hibernation mode before removing drive
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210416124827.9BB59A005D@mailhost.synopsys.com>
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
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/usb/dwc2/platform.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index f8b819cfa80e..8ad33e042a14 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -316,8 +316,23 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 static int dwc2_driver_remove(struct platform_device *dev)
 {
 	struct dwc2_hsotg *hsotg = platform_get_drvdata(dev);
+	struct dwc2_gregs_backup *gr;
 	int ret = 0;
 
+	gr = &hsotg->gr_backup;
+
+	/* Exit Hibernation when driver is removed. */
+	if (hsotg->hibernated) {
+		if (gr->gotgctl & GOTGCTL_CURMODE_HOST)
+			ret = dwc2_exit_hibernation(hsotg, 0, 0, 1);
+		else
+			ret = dwc2_exit_hibernation(hsotg, 0, 0, 0);
+
+		if (ret)
+			dev_err(hsotg->dev,
+				"exit hibernation failed.\n");
+	}
+
 	/* Exit Partial Power Down when driver is removed. */
 	if (hsotg->in_ppd) {
 		ret = dwc2_exit_partial_power_down(hsotg, 0, true);
-- 
2.25.1

