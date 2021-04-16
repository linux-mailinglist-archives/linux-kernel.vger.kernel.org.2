Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36800362032
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243315AbhDPMsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:48:33 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:38460 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243264AbhDPMsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:48:31 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C544440E1C;
        Fri, 16 Apr 2021 12:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618577287; bh=VKvv7dpBu3/bQP8SJp7mAnHTwS9nd0ZI6IQSnKfwHEI=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=iUcJP97kDJ2VV6qTwOK47VqSL5Qkj8Q3vnaNRPVAf2+pF9++4xD4fkY/pdZLBXrPZ
         pdjyTtQxPl4caRJD7LO0zz9oLshuWJwmw3CTxJ1hvG7+aZtnH1h/2zcko2kQFtoKFJ
         iML8omcCqw64sXe7HazajMiwAlHZ0BH98rvwZyZLP16e+fMqsGUO3vz82qP0f1XTjS
         cLPcBXuStAI2+t9aVljXlStD5kesxhISbrEFueKPcW4weA+XYfpms0EKBV2+L8ZT5L
         imtlTfwlx9k0B3LECYxTE3W0DD7M5IMrrcYhlzzm4keLMbcta4GWJbo8KEmjAZG2BF
         zFDeXvWu8mHOg==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id D1C1FA005F;
        Fri, 16 Apr 2021 12:48:03 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Fri, 16 Apr 2021 16:48:02 +0400
Date:   Fri, 16 Apr 2021 16:48:02 +0400
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 10/15] usb: dwc2: Allow exit hibernation in urb enqueue
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210416124803.D1C1FA005F@mailhost.synopsys.com>
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
 Changes in v2:
 - Moved duplicated error checking *if* conditions from innermost to outside if.

 drivers/usb/dwc2/hcd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index cc9ad6cf02d9..093b1717df01 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4631,12 +4631,26 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
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
+		if (gr->gotgctl & GOTGCTL_CURMODE_HOST)
+			retval = dwc2_exit_hibernation(hsotg, 0, 0, 1);
+		else
+			retval = dwc2_exit_hibernation(hsotg, 0, 0, 0);
+
+		if (retval)
+			dev_err(hsotg->dev,
+				"exit hibernation failed.\n");
+	}
+
 	if (hsotg->in_ppd) {
 		retval = dwc2_exit_partial_power_down(hsotg, 0, true);
 		if (retval)
-- 
2.25.1

