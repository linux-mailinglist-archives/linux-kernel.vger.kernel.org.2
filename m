Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD4D35D8AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbhDMHRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:17:30 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59724 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238490AbhDMHRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:17:25 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DE60FC00BB;
        Tue, 13 Apr 2021 07:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618298226; bh=IwAP0/YVaEAhW8arUzRytGobOyp3Q8lPqT3ibl+yzug=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=hHpJuYdSJrw5j8IGRgpKPbHTKdFwGadYAqKo9pRRcVDiGpYKhbSFbgpElRy9UdrV3
         97jPhTEX4miRVIH0eX6F4dQvWn+nOCkMMrddxRoDqnOvl+oyhxwJa9ZH/zZG/KVNV5
         xnjaeIh6hTiy0stMsouhQjftJqaf89+n9iRif0oxAjRXX49dYiJDCURrO0mG69mtnX
         xSmxoGYU5v8ZCtwpSydKr1nespPxdTAm649QMEjIBPXl3VLYJ+jvnN9ko1BQUkWf5V
         RkpYcToLi//Wi7Xy+FQ1PD4PddqNjRmjWOV6J4DSIU7RUkKD7g4a+w0R8/gbkvb+Ap
         ThuRAmGzw27uQ==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 2D057A0094;
        Tue, 13 Apr 2021 07:17:03 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:17:02 +0400
Date:   Tue, 13 Apr 2021 11:17:02 +0400
Message-Id: <9ed1da9780cddf995841cc5867f195024f5a16d9.1618297800.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 07/12] usb: dwc2: Update enter clock gating when port is suspended
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the implementation of entering clock gating mode
when core receives port suspend.
Instead of setting the required bit fields of the registers
inline, called the "dwc2_host_enter_clock_gating()" function.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 drivers/usb/dwc2/hcd.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 27f030d5de54..e1225fe6c61a 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -3298,7 +3298,6 @@ static int dwc2_host_is_b_hnp_enabled(struct dwc2_hsotg *hsotg)
 int dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
 {
 	unsigned long flags;
-	u32 hprt0;
 	u32 pcgctl;
 	u32 gotgctl;
 	int ret = 0;
@@ -3323,22 +3322,12 @@ int dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
 		break;
 	case DWC2_POWER_DOWN_PARAM_HIBERNATION:
 	case DWC2_POWER_DOWN_PARAM_NONE:
-	default:
-		hprt0 = dwc2_read_hprt0(hsotg);
-		hprt0 |= HPRT0_SUSP;
-		dwc2_writel(hsotg, hprt0, HPRT0);
-		hsotg->bus_suspended = true;
 		/*
-		 * If power_down is supported, Phy clock will be suspended
-		 * after registers are backuped.
+		 * If not hibernation nor partial power down are supported,
+		 * clock gating is used to save power.
 		 */
-		if (!hsotg->params.power_down) {
-			/* Suspend the Phy Clock */
-			pcgctl = dwc2_readl(hsotg, PCGCTL);
-			pcgctl |= PCGCTL_STOPPCLK;
-			dwc2_writel(hsotg, pcgctl, PCGCTL);
-			udelay(10);
-		}
+		dwc2_host_enter_clock_gating(hsotg);
+		break;
 	}
 
 	/* For HNP the bus must be suspended for at least 200ms */
-- 
2.25.1

