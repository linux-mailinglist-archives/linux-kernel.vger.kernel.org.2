Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F23357FAF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhDHJpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:45:55 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:36612 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231474AbhDHJps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:45:48 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3C4D8C09B6;
        Thu,  8 Apr 2021 09:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617875137; bh=udgwLz5bv1zt3AIAh0DMinAYsayGC48qOFuI+SZpOFc=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=UFNLpXAmFuMqmveQ8H0v2eG63jRuXzIINr6qcZLqAVm/2a3mHw3xBtprv0PU7oWkp
         slphKZ9JpchQijcE/uTHXL/uhHAjrjVBK7R3KExHv9bSzTec4+5jNfAZ4foSuihRgx
         LcyIzVmoKWm/KrchvkM3vY0cp1ymtdKwiPEafWr90dFL4IPmzMWkaCFK9f/gOoWWBy
         ZPy6rfj+TL5TVUATdOmbWzpgZV/EBjcAPkMsY+2TzXOFcofsd2Omb3Z4nBJPBq0bsk
         hYtcb+oSs06TROxx2TAEPHpZNbIEuGw81mVPup+quUt1x9Q/82rGzCblxbRkBh6lxP
         2GobwtxQfOEVw==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 4AA7AA022E;
        Thu,  8 Apr 2021 09:45:34 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 08 Apr 2021 13:45:33 +0400
Date:   Thu, 08 Apr 2021 13:45:33 +0400
In-Reply-To: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v3 09/14] usb: dwc2: Add part. power down exit from dwc2_conn_id_status_change().
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Message-Id: <20210408094534.4AA7AA022E@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before changing to connector B exiting from Partial
Power Down is required.

- Added exiting from Partial Power Down mode when
  connector ID status changes to "connId B".
  Because if connector ID status changed to B connector
  while core was in partial power down mode, HANG would
  accrue from a soft reset.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/hcd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 7c7496719152..9529e9839961 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -3206,6 +3206,15 @@ static void dwc2_conn_id_status_change(struct work_struct *work)
 		if (count > 250)
 			dev_err(hsotg->dev,
 				"Connection id status change timed out\n");
+
+		/*
+		 * Exit Partial Power Down without restoring registers.
+		 * No need to check the return value as registers
+		 * are not being restored.
+		 */
+		if (hsotg->in_ppd && hsotg->lx_state == DWC2_L2)
+			dwc2_exit_partial_power_down(hsotg, 0, false);
+
 		hsotg->op_state = OTG_STATE_B_PERIPHERAL;
 		dwc2_core_init(hsotg, false);
 		dwc2_enable_global_interrupts(hsotg);
-- 
2.25.1

