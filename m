Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25DB35D905
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbhDMHhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:37:10 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:60522 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240497AbhDMHhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:37:01 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4FA91C00BB;
        Tue, 13 Apr 2021 07:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618299401; bh=dKhq2iqRjrY0N9i7U4VKo0N5zELnYfh/gudC2BsyoPY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=CwL/0OSU1z55QZ4bJIcb7kdUWokwGxr7dS43AXvMlfCC2lW3S00PyGjHFGVkBcadH
         GJBqz3V24hvCnYUkw2HnoC/Wt5XdH4NhfpMCZMrQc5IrfaFuyORI4zod4KT7/HsHMD
         Es2jPpwepXwsFp1XFNDJSzSktMgd4TqWaBaeFuDtcxSZQsV1500Z0HEMR2hvVqHfxU
         9I5UICyWkkWTZOt+JYjiV70fHP/OSDSqw/4NXj9+Yxo6vBAYQXkzTqzqzSubnUUkJo
         /dledWB2x4+Py9gBJeBjgpSmcAR6GczyOQmLZ23+phhvNuntOHN7y7/pYe1lbvRnM9
         6WZX7vcCcW7iA==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 921E8A0099;
        Tue, 13 Apr 2021 07:36:38 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:36:37 +0400
Date:   Tue, 13 Apr 2021 11:36:37 +0400
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 05/12] usb: dwc2: Add exit clock gating from session request interrupt
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210413073638.921E8A0099@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added clock gating exit flow from session
request interrupt handler according programming guide.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/dwc2/core_intr.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index c764407e7633..550c52c1a0c7 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -316,12 +316,19 @@ static void dwc2_handle_session_req_intr(struct dwc2_hsotg *hsotg)
 		hsotg->lx_state);
 
 	if (dwc2_is_device_mode(hsotg)) {
-		if (hsotg->lx_state == DWC2_L2 && hsotg->in_ppd) {
-			ret = dwc2_exit_partial_power_down(hsotg, 0,
-							   true);
-			if (ret)
-				dev_err(hsotg->dev,
-					"exit power_down failed\n");
+		if (hsotg->lx_state == DWC2_L2) {
+			if (hsotg->in_ppd) {
+				ret = dwc2_exit_partial_power_down(hsotg, 0,
+								   true);
+				if (ret)
+					dev_err(hsotg->dev,
+						"exit power_down failed\n");
+			}
+
+			/* Exit gadget mode clock gating. */
+			if (hsotg->params.power_down ==
+			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended)
+				dwc2_gadget_exit_clock_gating(hsotg, 0);
 		}
 
 		/*
-- 
2.25.1

