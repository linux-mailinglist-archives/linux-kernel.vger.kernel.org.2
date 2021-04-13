Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD8935D90C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbhDMHha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:37:30 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:60542 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241062AbhDMHhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:37:23 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E2AB8C00BB;
        Tue, 13 Apr 2021 07:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618299424; bh=Fv4JPmOHiaU4u68YH3Yw/jD1CUMtHBOo8gxdJsn8nWo=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=TcYxkvvwr7HkzAphbjs0V12oF7qWdG3YglgiG987jfU0ojRBfknOgue0oYnySEWNl
         uATZge9GWMy+SrMw6RuKqNRJ7va8oCV/5pPGeBx58bYPhqsJR0BUo+WCBMJe/4vONW
         mxXHMfEWSKECErDrCK4w4gJaUnMadKiitaEoCjGcDFBejYITh/c1zI8mAcJnjapK0/
         bUjpbCYe0su6hE2x6lw9F19qElFOWc4KmrFKXeIvGv5bMm86TwLi8BJnTM9dHanrEl
         0iVEmvivOv34/N8++uRTrMDruNRStQc17zhPvEDgNmsor04hu32aiTIl+dH81IbKTj
         dPIqmY5iWj2aw==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 367E0A022E;
        Tue, 13 Apr 2021 07:37:01 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:37:00 +0400
Date:   Tue, 13 Apr 2021 11:37:00 +0400
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 08/12] usb: dwc2: Update exit clock gating when port is resumed
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210413073701.367E0A022E@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the implementation of exiting clock gating mode
when core receives port resume.
Instead of setting the required bit fields of the registers
inline, called the "dwc2_host_exit_clock_gating()" function.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/dwc2/hcd.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index e1225fe6c61a..8a42675ab94e 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -3359,8 +3359,6 @@ int dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
 int dwc2_port_resume(struct dwc2_hsotg *hsotg)
 {
 	unsigned long flags;
-	u32 hprt0;
-	u32 pcgctl;
 	int ret = 0;
 
 	spin_lock_irqsave(&hsotg->lock, flags);
@@ -3374,33 +3372,14 @@ int dwc2_port_resume(struct dwc2_hsotg *hsotg)
 		break;
 	case DWC2_POWER_DOWN_PARAM_HIBERNATION:
 	case DWC2_POWER_DOWN_PARAM_NONE:
-	default:
 		/*
-		 * If power_down is supported, Phy clock is already resumed
-		 * after registers restore.
+		 * If not hibernation nor partial power down are supported,
+		 * port resume is done using the clock gating programming flow.
 		 */
-		if (!hsotg->params.power_down) {
-			pcgctl = dwc2_readl(hsotg, PCGCTL);
-			pcgctl &= ~PCGCTL_STOPPCLK;
-			dwc2_writel(hsotg, pcgctl, PCGCTL);
-			spin_unlock_irqrestore(&hsotg->lock, flags);
-			msleep(20);
-			spin_lock_irqsave(&hsotg->lock, flags);
-		}
-
-		hprt0 = dwc2_read_hprt0(hsotg);
-		hprt0 |= HPRT0_RES;
-		hprt0 &= ~HPRT0_SUSP;
-		dwc2_writel(hsotg, hprt0, HPRT0);
 		spin_unlock_irqrestore(&hsotg->lock, flags);
-
-		msleep(USB_RESUME_TIMEOUT);
-
+		dwc2_host_exit_clock_gating(hsotg, 0);
 		spin_lock_irqsave(&hsotg->lock, flags);
-		hprt0 = dwc2_read_hprt0(hsotg);
-		hprt0 &= ~(HPRT0_RES | HPRT0_SUSP);
-		dwc2_writel(hsotg, hprt0, HPRT0);
-		hsotg->bus_suspended = false;
+		break;
 	}
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
-- 
2.25.1

