Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A8E35D915
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241578AbhDMHiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:38:04 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:60574 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241950AbhDMHhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:37:45 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6FCA7C0114;
        Tue, 13 Apr 2021 07:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618299446; bh=AZ/oQOAeGT0gsqZk0VXwMupD/Fhho98Hy6eZwRCpkz0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Iyx+kiIBne9EeIjR6YIIHTDTIzTwoRI3PSH7rvBliaVc1H3lUlVBYYgvgKoSGmDf+
         si8D2RRxrUHtPd2AR/jdNWBw7ieO8Nc7sJZM+FWWmFxNu7w9YOHq44M/x9jvHV47YZ
         oq/LegX19fAHFOR65pVwR6MAd0YlhOrc5Thyho/oCQzG+2Xu4SEjFpgT3ALjRE81Qf
         8uKOA2SNDNA8NALgRSPW0g8zofQfRcHNGrnbZqNU3UwRahj5rqOhV8sl8hhyi+A/EF
         7DZeJRhRNvEiqcZMyONFXYtQFnyJwg9U6MgyZ1AyAz/XWzynUI1FcSsC/LgrBGad8E
         W2eLadOsxakMQ==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id BA0FEA022E;
        Tue, 13 Apr 2021 07:37:23 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:37:22 +0400
Date:   Tue, 13 Apr 2021 11:37:22 +0400
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 11/12] usb: dwc2: Add clock gating exiting flow by system resume
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210413073723.BA0FEA022E@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If not hibernation nor partial power down are supported,
port resume is done using the clock gating programming flow.

Adds a new flow of exiting clock gating when PC is
resumed.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/dwc2/hcd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 09dcd37b9ef8..04a1b53d65af 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4445,6 +4445,28 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)
 		break;
 	case DWC2_POWER_DOWN_PARAM_HIBERNATION:
 	case DWC2_POWER_DOWN_PARAM_NONE:
+		/*
+		 * If not hibernation nor partial power down are supported,
+		 * port resume is done using the clock gating programming flow.
+		 */
+		spin_unlock_irqrestore(&hsotg->lock, flags);
+		dwc2_host_exit_clock_gating(hsotg, 0);
+
+		/*
+		 * Initialize the Core for Host mode, as after system resume
+		 * the global interrupts are disabled.
+		 */
+		dwc2_core_init(hsotg, false);
+		dwc2_enable_global_interrupts(hsotg);
+		dwc2_hcd_reinit(hsotg);
+		spin_lock_irqsave(&hsotg->lock, flags);
+
+		/*
+		 * Set HW accessible bit before powering on the controller
+		 * since an interrupt may rise.
+		 */
+		set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+		break;
 	default:
 		hsotg->lx_state = DWC2_L0;
 		goto unlock;
-- 
2.25.1

