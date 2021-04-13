Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B0335D8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbhDMHRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:17:52 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:35742 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238648AbhDMHRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:17:40 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4EA7A4023B;
        Tue, 13 Apr 2021 07:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618298241; bh=678scCQb11lHtQjpRYGZ0SV7DaNPzjmb63PZ6Rk/X0s=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=ev95DDkesC5+df+JGfg+g/3AvMYsEPRwAF1WHu9qq2itUCrVEJ+eZiIvVCYI/zik/
         DFchbL2K2NTWYl9iK/3YBu1x52SVnwiRiFGb4n3wzg+Jd5YHeHUAS90sHos9cJapJU
         N8r5wxkxhcqgLahKqUTujxtTm+3/GvhztEuCtQojSGZqKH8yAGvZjDXYSs4Msq77Q/
         Fa4ydzR3RKiFWs+wf3xyCX8X5HLJuntSEDQr/weTHvO+ij2SkKT10MirehSUxtUWRC
         8JTZ8m9e2NDJKYqRXDv2sn+ImdVhpsfXFFBhIjRo9XgqQUWc3DJbyV7ZoxPl7UndSS
         Guy7ckEYJd3SQ==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 499EBA0094;
        Tue, 13 Apr 2021 07:17:18 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:17:17 +0400
Date:   Tue, 13 Apr 2021 11:17:17 +0400
Message-Id: <67524c4a0034d9ea21fc75edcb6704161ca81801.1618297800.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 09/12] usb: dwc2: Allow exit clock gating in urb enqueue
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When core is in clock gating state and an external
hub is connected, upper layer sends URB enqueue request,
which results in port reset issue.

Added exit from clock gating state to avoid port
reset issue and process upper layer request properly.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 drivers/usb/dwc2/hcd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 8a42675ab94e..31d6a1b87228 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4597,6 +4597,14 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 				"exit partial_power_down failed\n");
 	}
 
+	if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_NONE &&
+	    hsotg->bus_suspended) {
+		if (dwc2_is_device_mode(hsotg))
+			dwc2_gadget_exit_clock_gating(hsotg, 0);
+		else
+			dwc2_host_exit_clock_gating(hsotg, 0);
+	}
+
 	if (!ep)
 		return -EINVAL;
 
-- 
2.25.1

