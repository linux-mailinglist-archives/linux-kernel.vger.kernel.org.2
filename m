Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302A835D8A8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbhDMHRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:17:11 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:35704 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238136AbhDMHRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:17:10 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E8D0440162;
        Tue, 13 Apr 2021 07:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618298211; bh=R6Ygbep4bPgdkk7o8eJrmZO+pnbepHJPMR0aZsJk8jw=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=adfHB69AL64gmDVgrBmR5srl27ChrTCA7E0urNnXZXF3bJlH4W+q8i2iN5dyCeHfS
         sV2cr9e6ulul9MPGND70ENnUW9JqoI66HDH0JRONcv3Y6sXGb1ItjfcLGkUF1qEnS0
         dFWu6/uh7dkMVDFCKF6Yz4GpOomqSDTjsCI9d7m9FFpo52moB/8VUw5yK5C7Nl5Go3
         9r2DK0r6oJph3c9QjAKbl40oi3qmShZNcvLUJu0wll84xmudVUDbsCUX9mCBc3lMux
         qmjvfZZKJzLj6Ea2oXJ+7gUhyXGxZql658jlTSKdJ/WZ2vdQJ+6OPJFyTnBe5Y3WRA
         x1rIR69NHC1fw==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 1F1DCA022E;
        Tue, 13 Apr 2021 07:16:48 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:16:47 +0400
Date:   Tue, 13 Apr 2021 11:16:47 +0400
Message-Id: <f561d634ba934ebb668374c3b017a62aa1593d17.1618297800.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 05/12] usb: dwc2: Add exit clock gating from session request interrupt
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added clock gating exit flow from session
request interrupt handler according programming guide.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
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

