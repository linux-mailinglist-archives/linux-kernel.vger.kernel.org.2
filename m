Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F51C362034
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243747AbhDPMsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:48:40 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:38468 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243151AbhDPMsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:48:39 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 86D4440E26;
        Fri, 16 Apr 2021 12:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618577294; bh=VM6f/TKO94y/jjzBT0toOLZNAI6CdN6rLQAX3zNLiTM=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=BwfsjsE536QRgW7jeA7iOpsIj0schyplT8aFh/uyazKMy5Kj/RIWtQqpj/zpVhsff
         OBTT3DliIuEQLnDcqgH10eP+y/wzS05LvZ0TpRGZviWuMOLjZXZwKefFqL1hb04Mew
         oJin0vYxIpFTMvrP196m0XnLgFwrwLss6w0OjyLo30/R3LhMSh25cetbrNeUMkw0Br
         zgdTeR2uVn/sAVzSxjQyRRfKYnjHydJfrBbcNoJUzDwgtaHJu5wTlJmKeeGqNbg+Vy
         JN0vCIH/4EEuCSeUl1gOYWPQBflK1Vt8akUsXX543xf7RmMW/gb81QI6/UxwM7jkWl
         CGemvYS1eXaRg==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id BBFDBA005C;
        Fri, 16 Apr 2021 12:48:11 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Fri, 16 Apr 2021 16:48:10 +0400
Date:   Fri, 16 Apr 2021 16:48:10 +0400
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 11/15] usb: dwc2: Add hibernation entering flow by system suspend
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210416124811.BBFDBA005C@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new flow of entering hibernation when PC is
hibernated or suspended.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/dwc2/hcd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 093b1717df01..92848629cc61 100644
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

