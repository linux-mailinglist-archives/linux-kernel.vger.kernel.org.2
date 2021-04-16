Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5D0362036
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243766AbhDPMsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:48:50 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42306 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233213AbhDPMsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:48:47 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7D67FC06BA;
        Fri, 16 Apr 2021 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618577302; bh=DfKZaFnqWjb1E0PW3+rHjyT9X2LosU0QtR64jeE+J3o=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=JpWYEfgVldf2ldMG/fzhwX0+5ckQQqwTKHaQ/d6okNKxEQmYYCfCevknrJtEWO6Ek
         1qqG6hHQqnCaePeTXrVCmrmbgloUP5JNiyg2f4zLZxST/4bmV5yUbB3iZmEPDhT2W7
         TDS8JQXr1XNJdJ5ubOYc73OPqyMXZm/qC/8eiXoqlEb8u6ji5q3QQ7+NVuvTuYJ8Ro
         9NF/WW4+Lhc95f6q/6UZPYHen8suw4z81Soiy8AUHYpO9FZubQUpq6IHiq/PlnL3sq
         yiR89F3yYgId563FMN2Adk4056OVMRZylTMbz6FKt2iamhMhN5J05RTp7uq9ec8f5x
         unHYmYe2vv/3Q==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id A3B26A005C;
        Fri, 16 Apr 2021 12:48:19 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Fri, 16 Apr 2021 16:48:18 +0400
Date:   Fri, 16 Apr 2021 16:48:18 +0400
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 12/15] usb: dwc2: Add hibernation exiting flow by system resume
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210416124819.A3B26A005C@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new flow of exiting hibernation when PC is resumed
from suspend state.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/dwc2/hcd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 92848629cc61..035d4911a3c3 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4470,6 +4470,16 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)
 		set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 		break;
 	case DWC2_POWER_DOWN_PARAM_HIBERNATION:
+		ret = dwc2_exit_hibernation(hsotg, 0, 0, 1);
+		if (ret)
+			dev_err(hsotg->dev, "exit hibernation failed.\n");
+
+		/*
+		 * Set HW accessible bit before powering on the controller
+		 * since an interrupt may rise.
+		 */
+		set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+		break;
 	case DWC2_POWER_DOWN_PARAM_NONE:
 		/*
 		 * If not hibernation nor partial power down are supported,
-- 
2.25.1

