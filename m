Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007CA35D8AA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbhDMHRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:17:21 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:35716 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238338AbhDMHRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:17:17 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7F6554023B;
        Tue, 13 Apr 2021 07:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618298218; bh=zf5Cqf60UGZVZhLQtjCB2JLjnqM9Qw3EKME53CBI2EE=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=kD5FjXJ0bLQKMJOf3AaJlZBEkYdH4foP2DJhZNS4zGvOuTwaq2B+OSAacnkCqmbui
         o+xZpgDDOTThlOk6sRzsM+IefIl3SYogq8KJjfdZ7CaU2XirvIZw116JtmRaA9xzzH
         LJm4T85KdVe3eABoU2DUn8v9lcQoL+Zn77zzr7c9X77Yom+HgpeYKnMZW4HDWWMVlo
         wWzJtMtvqtveFbKJ7Rf/boM2NEMefkX0kGBq8KKvfQnzGvWdEedbFLoVJ7duOBg3bh
         ZphXbFjnHeyQrLoW2ykoW0PdR4AtxIyyNdrp8VHNSJ+/un2rx6jMwftSOrPKu2Ycg0
         1Sv+rUE+E0K3A==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id A61F8A022E;
        Tue, 13 Apr 2021 07:16:55 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:16:54 +0400
Date:   Tue, 13 Apr 2021 11:16:54 +0400
Message-Id: <f705e273c8d398130039452da93f4be8abd4e7ed.1618297800.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 06/12] usb: dwc2: Add exit clock gating when port reset is asserted
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds clock gating exit flow when set port feature
reset is received in suspended state.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 drivers/usb/dwc2/hcd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index f1c24c15d185..27f030d5de54 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -3712,6 +3712,10 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 						"exit partial_power_down failed\n");
 			}
 
+			if (hsotg->params.power_down ==
+			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended)
+				dwc2_host_exit_clock_gating(hsotg, 0);
+
 			hprt0 = dwc2_read_hprt0(hsotg);
 			dev_dbg(hsotg->dev,
 				"SetPortFeature - USB_PORT_FEAT_RESET\n");
-- 
2.25.1

