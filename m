Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DF43601C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhDOFlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:41:24 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:53780 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230264AbhDOFlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:41:23 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 248AAC0619;
        Thu, 15 Apr 2021 05:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618465261; bh=d87QjhQf/cs9tD6ioQrtQbqw59Z9zhbJBKqLhxDVfus=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=mGQpHIWrv83OyuZKlCGghm8+EYtOoh/04NVLNzYbtNCdwxZ5zZ24b5b3VJ9cTS0js
         eGa1PRIL1ebm2Q5EwMpQI/ru8oHK1M/LHR9XEiF1QzRLi7h2r4H+dlnEGbX1EI1oJY
         3AuwiZApHzlQY2uUyijl7GT6ExEjykVovNuNQBd0+QU0erAf6qjDA2hI8NVbREtgJ7
         B+T4ttpVvLO5Pk6INQ+TjuXE3pxCDAgPqLh8Siz7PBoOGKZfi5K8jG41RFy/0Rd3bS
         kskUmBuxLO0xekKDHbAJ9zQTOAoqoB0AnKhqbs3Iq6qiKEDKMgP0nBqFqhM4OS22No
         2TLYoLIaZy3Qw==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 2DC7EA005C;
        Thu, 15 Apr 2021 05:40:58 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 15 Apr 2021 09:40:56 +0400
Date:   Thu, 15 Apr 2021 09:40:56 +0400
Message-Id: <59963c145b78ce9677ae66c33f84720480bf6882.1618464534.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 12/15] usb: dwc2: Add hibernation exiting flow by system resume
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new flow of exiting hibernation when PC is resumed
from suspend state.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 drivers/usb/dwc2/hcd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index db8eb1940d17..c92307775863 100644
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

