Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53D535D8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbhDMHSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:18:07 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:35762 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238878AbhDMHSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:18:02 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A9DBB4023B;
        Tue, 13 Apr 2021 07:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618298263; bh=hI4GIsvcFvWGvoLwblHdg89O+IAB/oAS89dwlgZ0jo0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=PuXnXPx7Z12++C9IYrjEfGSoSUB7xVcjeuuqWhYKXEznCG9PPUqblRArbKJsoubla
         1sGDbmRYnteGLTkIXIWxTGUOcR+zXkcMVEEdCXeaD20oEPBWgxFwmxy5dMgnHu/0fr
         FzBFMqnU3LiTGdzbtE2Y93IBFZM3MBlhkHUgGJ/qHx9u/7H5OpjrXcn3doYwYwolDh
         zo2yc+ER+PZ/7hyLemuFRNbvPLlEcUzjYCrX9ZdccSaVsnRRVx6h42/CJcfd3/1h3k
         X9nSRpSseRarrYfkQkmUkSk+b94KLLdH5MSWFu5+T6muyMwV1JvvI/2DEkeBi4EryD
         mdfUqirBpe0Bw==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id D3124A0094;
        Tue, 13 Apr 2021 07:17:40 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:17:39 +0400
Date:   Tue, 13 Apr 2021 11:17:39 +0400
Message-Id: <6df5d98c33407fca971d4318b1f48730130101a7.1618297800.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 12/12] usb: dwc2: Add exit clock gating before removing driver
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dwc2 core is in clock gating mode loading driver
again causes driver fail. Because in that mode
registers are not accessible.

Added a flow of exiting clock gating mode
to avoid the driver reload failure.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 drivers/usb/dwc2/platform.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index b28b8cd45799..f8b819cfa80e 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -326,6 +326,15 @@ static int dwc2_driver_remove(struct platform_device *dev)
 				"exit partial_power_down failed\n");
 	}
 
+	/* Exit clock gating when driver is removed. */
+	if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_NONE &&
+	    hsotg->bus_suspended) {
+		if (dwc2_is_device_mode(hsotg))
+			dwc2_gadget_exit_clock_gating(hsotg, 0);
+		else
+			dwc2_host_exit_clock_gating(hsotg, 0);
+	}
+
 	dwc2_debugfs_exit(hsotg);
 	if (hsotg->hcd_enabled)
 		dwc2_hcd_remove(hsotg);
-- 
2.25.1

