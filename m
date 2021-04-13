Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8594535D907
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbhDMHhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:37:11 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:60532 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240704AbhDMHhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:37:08 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D51F8C00BB;
        Tue, 13 Apr 2021 07:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618299409; bh=XAJeQ3isMefcorjlMacgdrKXwWNcmGQIZ19CdFiIwZ8=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=ir4rBRhmC9dMOwUTyy13BvdphH3LGQHh3Fa8QIFaDqOGwnHjZf9DyMI66sNQio562
         rqLCHEWNGa7eEEaIC8cgO+cYbDfy03NwbmSNh9xJ8/BWNVEIRNXuCuidllqZXIilak
         38v4YwuqevqEe3/oOmH0yLrgUfufCToDc+oHsVsnei9ykAHunJY+1jSaVJU3RyTWoO
         jplKoCaVq7UZgovAM6ITz+9+u9xTYEZXMJCKnC/d9vep1u2oOK5EbmWPuNmyLrSMvV
         h16QhxdEPT+LzOtAMzNv38evF40IVW/KXXqzHzbU2oU38NMfiSO3+Oo7f0+SPvjypi
         9UCLWzkB5n5FQ==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 27217A0094;
        Tue, 13 Apr 2021 07:36:46 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:36:45 +0400
Date:   Tue, 13 Apr 2021 11:36:45 +0400
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 06/12] usb: dwc2: Add exit clock gating when port reset is asserted
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210413073646.27217A0094@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds clock gating exit flow when set port feature
reset is received in suspended state.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 Changes in v2:
 - None

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

