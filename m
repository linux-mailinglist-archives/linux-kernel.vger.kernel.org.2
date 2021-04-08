Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF36357F9E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhDHJpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:45:18 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37546 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231358AbhDHJpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:45:09 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3D02540829;
        Thu,  8 Apr 2021 09:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617875097; bh=Gd6RpJYfHcJtTprhTBHDNtSWQfOmDM4ekWqCTpUJyiw=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=MVI+lX+aeluFNiHFgHK+ZIfFPaUReoDY9IO//B7JPIcG4o7awS7DNmWuB4g4rp38a
         b5t2zjxex9k1fy3GPFGADwZCMB5CBDGBEME8Mh/pFHVh40VUZywCon0xtyiNdAHKMd
         okYyY6u0u6+lAX8FPzwGAnHQjplYH3oq9/dOEQBWwKBI4p2Nly0W1K0Q32F5Rgedwb
         XwcZrCTOJSpLuv9noTRkyKF0+yUTzOz+nX2ygoD7gY8c+o8CQ6hph4xYn3teq9EjfD
         ++q4vssFHh8Lq7MmEGJVPuD4yyMhVOGkMoQ34wWYdli5Z0J1m5IFvfyPlQwCqZ7dr8
         GE/OocWAvHAeQ==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 5BBCBA0094;
        Thu,  8 Apr 2021 09:44:54 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 08 Apr 2021 13:44:53 +0400
Date:   Thu, 08 Apr 2021 13:44:53 +0400
In-Reply-To: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v3 04/14] usb: dwc2: Add partial power down exit flow in wakeup intr.
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Message-Id: <20210408094454.5BBCBA0094@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to programming guide added host partial power
down exit flow in wakeup detected interrupt handler.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/core_intr.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index 1fb957ce6c25..0a7f9330907f 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -423,15 +423,14 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 			hsotg->lx_state = DWC2_L0;
 		}
 	} else {
-		if (hsotg->params.power_down)
-			return;
-
-		if (hsotg->lx_state != DWC2_L1) {
-			u32 pcgcctl = dwc2_readl(hsotg, PCGCTL);
-
-			/* Restart the Phy Clock */
-			pcgcctl &= ~PCGCTL_STOPPCLK;
-			dwc2_writel(hsotg, pcgcctl, PCGCTL);
+		if (hsotg->lx_state == DWC2_L2) {
+			if (hsotg->in_ppd) {
+				ret = dwc2_exit_partial_power_down(hsotg, 1,
+								   true);
+				if (ret)
+					dev_err(hsotg->dev,
+						"exit partial_power_down failed\n");
+			}
 
 			/*
 			 * If we've got this quirk then the PHY is stuck upon
-- 
2.25.1

