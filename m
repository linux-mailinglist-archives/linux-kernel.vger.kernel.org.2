Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C588335D918
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242130AbhDMHiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:38:15 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:36534 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230251AbhDMHhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:37:54 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EC9B940162;
        Tue, 13 Apr 2021 07:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618299454; bh=Zci3Jp+duNOiR2nGDWG6DcZ1NoyuZrC26LkJVEHVtBE=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=NM9zqu63h7cPqAF/U78w/yqAuue9n+gAsgyIbxRVwK/6kxb+tIHPDG+VSq6n9JTKu
         lFxxi8dTDtUmuUjSuTcHxQKSinIqYKCj0Plsc5BM1o3iI+na32OwPO/wRndiLhfOt9
         uJoFRTynErKnWhYsSZJkPk7wHBW85R6LbYI3zeqLeMfd0LEn/hAdhXlClR2APOHWN6
         abiZI1Kt7tVYFsmn7Upv1rj+LQwXdn3YpBsF5QX9i0EdqR4BOAQiOYerWGbfesHRSk
         7PZEcz6jQxoFiQrAXb+A98b/ha5PnRFH7+LTPoMTQQ52Wqbf8w0HejNnWgxBxvOHDO
         AFtiTsTsEvThA==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 3C81BA022E;
        Tue, 13 Apr 2021 07:37:31 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:37:30 +0400
Date:   Tue, 13 Apr 2021 11:37:30 +0400
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 12/12] usb: dwc2: Add exit clock gating before removing driver
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210413073731.3C81BA022E@mailhost.synopsys.com>
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
 Changes in v2:
 - None

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

