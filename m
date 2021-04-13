Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DFF35D8B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbhDMHSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:18:03 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59754 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238676AbhDMHRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:17:55 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 178C3C00E6;
        Tue, 13 Apr 2021 07:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618298256; bh=Aq7sYQKiih3aGixqOw8/h3Bi7Ry2yotivKMTMAHf/lo=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=mBh6MUwnFffM1WY7WV6ZqBndeoj1wcGol05uxP4pvqE1fZM9g7xzSa9C/RoI4yN73
         zLn+kPbVmw408NTKS3hjvyWMUjCkzyWCYFECdiLNrTBs3Rz6DLxIakx8R1euQ78+CM
         BBUAlFH9Jf1PnK9hukwcAt3B5fOfJLTLcFp3cJ8kJzPTheKQct2dsgEtBIxGVXjkjA
         iLWETchq8UeVKjTOcBqxTuT8u7koqFh9USfOcCkyKnmQhubMcCVQmIZIxwCxUx8Yqs
         JgFCMZTlL3H1yy8F0Ox/jCElIncfb5grLup83ZQO7Jlj+zj+M7NVc4Oph/Ij5dEnP0
         5ukhTr8c9FtsQ==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 5B1C9A022E;
        Tue, 13 Apr 2021 07:17:33 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:17:32 +0400
Date:   Tue, 13 Apr 2021 11:17:32 +0400
Message-Id: <149265dd7416633cbfed33f2d61a996cb1947f4c.1618297800.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 11/12] usb: dwc2: Add clock gating exiting flow by system resume
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If not hibernation nor partial power down are supported,
port resume is done using the clock gating programming flow.

Adds a new flow of exiting clock gating when PC is
resumed.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
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

