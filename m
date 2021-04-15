Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D142D3601C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhDOFlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:41:15 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56494 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230442AbhDOFlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:41:07 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 19C25400CB;
        Thu, 15 Apr 2021 05:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618465245; bh=RxiBBUBDNJeCPKVTcE/c2kcOM6ahrlbWIsZdYFTZEpw=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=cd42AV5DkcZas4dLhQ6VXTrlXG/v1z9yl3WWbPeIqtEqwlFSlN9LX8Qy0FelV9bj3
         H+a49mQN/kSM5dilth0dIEtlqZ9SCICobzImal2QDOHMffvUI3HKpWE377GSpOusgm
         XJKRutOfRroZSWqLEbrErIvrJ0EwlB/sqYwg/BxO+MLvZYjt/VLtFBaTQNolIqVeH+
         xu902MjNn1cXhVA178i+NopUWba0Hauw3RC5eZeGYFHJZklYzUuFu0LK+emISbZvt7
         cKB7i+2/v7Brlj7sctf8pF8CL/zVjqdzER6eHRoCN1Sq/jad1LAy8bdIlD7je3vRgn
         rkuc5PqaNBsfg==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 1CDB1A005C;
        Thu, 15 Apr 2021 05:40:42 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 15 Apr 2021 09:40:40 +0400
Date:   Thu, 15 Apr 2021 09:40:40 +0400
Message-Id: <65daa916b29e0009083702cb4584c8274e58ddac.1618464534.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 10/15] usb: dwc2: Allow exit hibernation in urb enqueue
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When core is in hibernation state and an external
hub is connected, upper layer sends URB enqueue request,
which results in port reset issue.

- Added exit from hibernation state to avoid port
reset issue and process upper layer request properly.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 drivers/usb/dwc2/hcd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index cc9ad6cf02d9..3b03b2d73aaa 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4631,12 +4631,29 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 	struct dwc2_qh *qh;
 	bool qh_allocated = false;
 	struct dwc2_qtd *qtd;
+	struct dwc2_gregs_backup *gr;
+
+	gr = &hsotg->gr_backup;
 
 	if (dbg_urb(urb)) {
 		dev_vdbg(hsotg->dev, "DWC OTG HCD URB Enqueue\n");
 		dwc2_dump_urb_info(hcd, urb, "urb_enqueue");
 	}
 
+	if (hsotg->hibernated) {
+		if (gr->gotgctl & GOTGCTL_CURMODE_HOST) {
+			retval = dwc2_exit_hibernation(hsotg, 0, 0, 1);
+			if (retval)
+				dev_err(hsotg->dev,
+					"exit hibernation failed.\n");
+		} else {
+			retval = dwc2_exit_hibernation(hsotg, 0, 0, 0);
+			if (retval)
+				dev_err(hsotg->dev,
+					"exit hibernation failed.\n");
+		}
+	}
+
 	if (hsotg->in_ppd) {
 		retval = dwc2_exit_partial_power_down(hsotg, 0, true);
 		if (retval)
-- 
2.25.1

