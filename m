Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F9E36201F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbhDPMrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:47:42 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:38416 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243085AbhDPMrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:47:35 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AABBD40E1C;
        Fri, 16 Apr 2021 12:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618577230; bh=mLQKQ2urvcg7b5By6P/zbYGY78aG0gF+7Bqi25FQfyA=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=YiSGuLRVDUzQLKxoMIZxdcSn+jHSr/I7YvuCjf5LhRyBPii6jIaRdgLf8xnitc6MZ
         LXVySq8eW17WOaYli5qvPIXE7XadYblMIKrYUF3G1VGUixnnJlX2kYZx489DQyAHrZ
         YhcnQcylcsqnc+gsxwGKhWthoUDXYVV7V3GtwIxAhu/Nkm229lIpUA3XN6z0f8HcjM
         +98y6tJEEKANcONzsgXkvqupaK291e1hBISgdtDRM3HxxT4k0yvhCDMA546JBBUs+X
         BArx27MI2CY4ms77xi5cyKrwzJTpwBRMtdYm3yuaMoOjoxa9geJngHvsnL+qIH2IUR
         TOJAZ01vSHMNA==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 5EEC2A005D;
        Fri, 16 Apr 2021 12:47:07 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Fri, 16 Apr 2021 16:47:06 +0400
Date:   Fri, 16 Apr 2021 16:47:06 +0400
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 03/15] usb: dwc2: Fix host mode hibernation exit with remote wakeup flow.
To:     John Youn <John.Youn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Vardan Mikayelyan <Vardan.Mikayelyan@synopsys.com>,
        Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210416124707.5EEC2A005D@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added setting "port_connect_status_change" flag to "1" in order
to re-enumerate, because after exit from hibernation port
connection status is not detected.

Fixes: c5c403dc4336 ("usb: dwc2: Add host/device hibernation functions")
Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/dwc2/hcd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index cda3f931195d..ff945c40ef8a 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5650,7 +5650,15 @@ int dwc2_host_exit_hibernation(struct dwc2_hsotg *hsotg, int rem_wakeup,
 		return ret;
 	}
 
-	dwc2_hcd_rem_wakeup(hsotg);
+	if (rem_wakeup) {
+		dwc2_hcd_rem_wakeup(hsotg);
+		/*
+		 * Change "port_connect_status_change" flag to re-enumerate,
+		 * because after exit from hibernation port connection status
+		 * is not detected.
+		 */
+		hsotg->flags.b.port_connect_status_change = 1;
+	}
 
 	hsotg->hibernated = 0;
 	hsotg->bus_suspended = 0;
-- 
2.25.1

