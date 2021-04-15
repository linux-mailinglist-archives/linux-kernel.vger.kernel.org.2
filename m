Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1406F3601C5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhDOFlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:41:19 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:53772 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230398AbhDOFlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:41:15 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 29252C0619;
        Thu, 15 Apr 2021 05:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618465253; bh=WsRBVEJLa7c4h7kcd/DCuxjUXCUW4yaS2ksCYcyHu1E=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=gDAqvYylx9HsFbMlK7g8I0yJ0HObay2XGt74RnTl7Wx5WfVr89hgeHeezXsRG6363
         Pl8+gXK0ZoHZqw5AlCpxTMGytGntg47xvNHMrIwTJjAOYrr4PWkUAKA9mbi2//+aJR
         PMN4sbi9Ki19BAkeHpXwdWgIhuu6dq0+0pPskn1uGqmgl3vrw21E+1b4JQfiXEoDXG
         S579v4xzvguBd4GP9x7JRpISDMuxpLDiIxi+VjXCzrRE7Vm3amCwQIEsLuHkuUljwk
         csPZTgKxznL5dGmirCp4nE+kuFPWRSHO7h1DtKEBVasPi+Gzx4K+7I/odsPi5PvdiU
         e4FrdvDLfYS0w==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 2A4C3A005C;
        Thu, 15 Apr 2021 05:40:50 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 15 Apr 2021 09:40:48 +0400
Date:   Thu, 15 Apr 2021 09:40:48 +0400
Message-Id: <7ad62c0aa1831d810a8fefdfe0d417f52c4d8421.1618464534.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 11/15] usb: dwc2: Add hibernation entering flow by system suspend
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new flow of entering hibernation when PC is
hibernated or suspended.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 drivers/usb/dwc2/hcd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 3b03b2d73aaa..db8eb1940d17 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4387,6 +4387,16 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)
 		clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 		break;
 	case DWC2_POWER_DOWN_PARAM_HIBERNATION:
+		/* Enter hibernation */
+		spin_unlock_irqrestore(&hsotg->lock, flags);
+		ret = dwc2_enter_hibernation(hsotg, 1);
+		if (ret)
+			dev_err(hsotg->dev, "enter hibernation failed\n");
+		spin_lock_irqsave(&hsotg->lock, flags);
+
+		/* After entering suspend, hardware is not accessible */
+		clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+		break;
 	case DWC2_POWER_DOWN_PARAM_NONE:
 		/*
 		 * If not hibernation nor partial power down are supported,
-- 
2.25.1

