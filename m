Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABD935D8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbhDMHRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:17:04 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59700 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237810AbhDMHQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:16:54 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8DE52C00F4;
        Tue, 13 Apr 2021 07:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618298195; bh=nj1BeKTbsJpmOWsKzyw4Q4Ak3JprmbRdIDgrwfON3Og=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=AQc4n6WTE0XgPFcAK3CyJW0lI1tkkEFiWAoJj4tdW5xTIvMp4EPZ3FlKAE4iOrw4U
         fo1ISl6pCHWj6GuC24dMriXWgLl87QR3NaStL3V4EgbFeiukB7Zxanxp4UX8iJYrAR
         MziL9opYZWXdPNaYokkE891RsmIT10JPoQAAYuoJua0wHZ5Ms4z+SmDJn1mSVvVf0L
         DXRDvamukJplXZURGFjMFKOYmZFDeig1AC0Q+KZJBganYwsRE7VsBf4Jn1JLw30nMw
         XTKleAf9GY49JQeRGW95Kwax04l07YCiaXkzCGNp0e7aiMaRg/caMg2BJyj2IxrDAl
         OryDdj9NY/nQQ==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 9F77EA0094;
        Tue, 13 Apr 2021 07:16:32 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:16:31 +0400
Date:   Tue, 13 Apr 2021 11:16:31 +0400
Message-Id: <58dc1c1805b583fa87f9615e9d17e9ff88644718.1618297800.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 03/12] usb: dwc2: Allow entering clock gating from USB_SUSPEND interrupt
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If core doesn't support hibernation or partial power
down power saving options, power can still be saved
using clock gating on all the clocks.

- Added entering clock gating state from USB_SUSPEND
  interrupt.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/core_intr.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index 8c0152b514be..ab7fe303c0f9 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -529,14 +529,18 @@ static void dwc2_handle_usb_suspend_intr(struct dwc2_hsotg *hsotg)
 				/* Ask phy to be suspended */
 				if (!IS_ERR_OR_NULL(hsotg->uphy))
 					usb_phy_set_suspend(hsotg->uphy, true);
-			}
-
-			if (hsotg->hw_params.hibernation) {
+			} else if (hsotg->hw_params.hibernation) {
 				ret = dwc2_enter_hibernation(hsotg, 0);
 				if (ret && ret != -ENOTSUPP)
 					dev_err(hsotg->dev,
 						"%s: enter hibernation failed\n",
 						__func__);
+			} else {
+				/*
+				 * If not hibernation nor partial power down are supported,
+				 * clock gating is used to save power.
+				 */
+				dwc2_gadget_enter_clock_gating(hsotg);
 			}
 skip_power_saving:
 			/*
-- 
2.25.1

