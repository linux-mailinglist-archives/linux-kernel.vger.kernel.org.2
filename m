Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2740C357FC3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhDHJqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:46:34 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37664 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231210AbhDHJq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:46:29 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 50BA140806;
        Thu,  8 Apr 2021 09:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617875178; bh=3WPQXRrxUY4EWlLwQjuK0lXjFiPQbgHDqifXJNP6F0o=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=M0SCpTSJ4QgfnFQigvbi+j9b03RQ6A+jt7LexTrU0v3FiQ/q75mF+7LZiGQ5Dzpnf
         9DgzQyQN5FRMYugx7JPjbs23XTb8IhQzoe6Ife8oBOp7+rXzLUXq6gQZ5VSpKLgTeo
         Oo5mtekph74JeeEauE3dqFuKm+aUHGMg8EjEfBlTye0tcXMPbqxfgEJ4EKVwBEZBom
         /bpn1dUYVmv4gfQa52dot6WTH23c2uuxRu8Mqv02/1KN2vVE348jVYnSrDDuedYjsj
         5RSAimBu+bdc6giszu8InO5TCIU1RB9IaNVM0jSxLMk/MI4cd8wBWi55TT70jIrHhA
         wvtD++u+u2B0A==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 8AE35A0094;
        Thu,  8 Apr 2021 09:46:15 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 08 Apr 2021 13:46:14 +0400
Date:   Thu, 08 Apr 2021 13:46:14 +0400
In-Reply-To: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v3 14/14] usb: dwc2: Add exit partial power down before removing driver
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210408094615.8AE35A0094@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dwc2 core is in partial power down mode
loading driver again causes driver fail. Because in
that mode registers are not accessible.

Added a flow of exiting the partial power down mode
to avoid the driver reload failure.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 Changes in v3:
 - None
 Changes in v2:
 - None

 drivers/usb/dwc2/platform.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 5f18acac7406..b28b8cd45799 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -316,6 +316,15 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 static int dwc2_driver_remove(struct platform_device *dev)
 {
 	struct dwc2_hsotg *hsotg = platform_get_drvdata(dev);
+	int ret = 0;
+
+	/* Exit Partial Power Down when driver is removed. */
+	if (hsotg->in_ppd) {
+		ret = dwc2_exit_partial_power_down(hsotg, 0, true);
+		if (ret)
+			dev_err(hsotg->dev,
+				"exit partial_power_down failed\n");
+	}
 
 	dwc2_debugfs_exit(hsotg);
 	if (hsotg->hcd_enabled)
@@ -334,7 +343,7 @@ static int dwc2_driver_remove(struct platform_device *dev)
 	reset_control_assert(hsotg->reset);
 	reset_control_assert(hsotg->reset_ecc);
 
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.25.1

