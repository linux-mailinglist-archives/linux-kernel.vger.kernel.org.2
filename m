Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F923601CB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhDOFll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:41:41 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:53796 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230497AbhDOFlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:41:39 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 48047C0619;
        Thu, 15 Apr 2021 05:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618465277; bh=FHLZ7VgZo7/0nBxiPZCw24PQ1RTUO894+7mdEeSmKgk=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=UJ1XYB2br4FVKpQ2ryc6PGE/CYNJy9maZSF2jJJYupI489tfTtNMUJINuAKZQ9B6U
         Madx7fb4t7rmdxnyB66ghhr97pUvq1JM9jqU5vh2yqQoGZy55GFskEmB788Y0ao6ln
         vuWVGL/lUhd3wrHPrZdRfKAbT/ijtUxQ65oZHVaBK1M5HnPO7+LwBqRY1KSlFUSI8j
         Z0tgwhwQw7d7lT50dhN8SwsbZNl43icy2MGZH7b5fBhwEiscIEkCAbM8fkrQi/0ydh
         tB4JPL2PC/jaduzjaH2oDn8Au7BJ7Y19jhq7q8oDgtIpXJ28GROZMiSdIJtExPFTLN
         vk9PFWs5YacLA==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 38732A005C;
        Thu, 15 Apr 2021 05:41:14 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 15 Apr 2021 09:41:13 +0400
Date:   Thu, 15 Apr 2021 09:41:13 +0400
Message-Id: <24b3783a4e78d0500b0a3f1f06d9d2f72cfbb9f7.1618464534.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 14/15] usb: dwc2: Update dwc2_handle_usb_suspend_intr function.
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

To avoid working in two modes (partial power down
and hibernation) changed conditions for entering
partial power down or hibernation.

Instead of checking hw_params.power_optimized and
hw_params.hibernation now checking power_down
param which already set to one of the options
(Hibernation or Partial Power Down) based on
OTG_EN_PWROPT.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Signed-off-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/core_intr.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index f8963c0cf6af..470458ac664b 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -532,7 +532,8 @@ static void dwc2_handle_usb_suspend_intr(struct dwc2_hsotg *hsotg)
 			return;
 		}
 		if (dsts & DSTS_SUSPSTS) {
-			if (hsotg->hw_params.power_optimized) {
+			switch (hsotg->params.power_down) {
+			case DWC2_POWER_DOWN_PARAM_PARTIAL:
 				ret = dwc2_enter_partial_power_down(hsotg);
 				if (ret) {
 					if (ret != -ENOTSUPP)
@@ -541,21 +542,22 @@ static void dwc2_handle_usb_suspend_intr(struct dwc2_hsotg *hsotg)
 							__func__);
 					goto skip_power_saving;
 				}
-
 				udelay(100);
 
 				/* Ask phy to be suspended */
 				if (!IS_ERR_OR_NULL(hsotg->uphy))
 					usb_phy_set_suspend(hsotg->uphy, true);
-			} else if (hsotg->hw_params.hibernation) {
+				break;
+			case DWC2_POWER_DOWN_PARAM_HIBERNATION:
 				ret = dwc2_enter_hibernation(hsotg, 0);
 				if (ret && ret != -ENOTSUPP)
 					dev_err(hsotg->dev,
 						"%s: enter hibernation failed\n",
 						__func__);
-			} else {
+				break;
+			case DWC2_POWER_DOWN_PARAM_NONE:
 				/*
-				 * If not hibernation nor partial power down are supported,
+				 * If neither hibernation nor partial power down are supported,
 				 * clock gating is used to save power.
 				 */
 				dwc2_gadget_enter_clock_gating(hsotg);
-- 
2.25.1

