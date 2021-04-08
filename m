Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F14357FB1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhDHJp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:45:58 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37622 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231478AbhDHJp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:45:56 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4202F4051F;
        Thu,  8 Apr 2021 09:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617875145; bh=ftbyk00YEvJSEIL+T7rY2QGF6NNFxPT9bL5QU6rM9KI=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=ZwB5fZoQXN6MqbC41fLhmdMBGryeaK+0k4qwYxWJMrVGe44bRPRveVjBBkSo+Aj2T
         USDLD6ZSK+3Ngh5XXQMXSdCl2MpMLK3Fdirnl78zaU2ZbjOMShTApQOQvXR6cX14CJ
         FQBeWrs3Xg6GflteSmvDqKcJbBYSdXNVIMrhDJ46MG8f7DK4XCkt2c1atN8GXNzTUB
         u+3nmIH3CJUocPxnlLll4pWQn+foYjisyyDugLVNv+CSxE3LoaVZi7xH87ApAxfa9r
         sg7tAzZUgNk2icqdrKpSMhiFqXgaCxBdDRkHww/rLkrwlGIKeh/7IDjwajYMWHxab/
         3DsXVB9EvBZKg==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 685BAA0094;
        Thu,  8 Apr 2021 09:45:42 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 08 Apr 2021 13:45:41 +0400
Date:   Thu, 08 Apr 2021 13:45:41 +0400
In-Reply-To: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v3 10/14] usb: dwc2: Allow exit partial power down in urb enqueue
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210408094542.685BAA0094@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When core is in partial power down state and an external
hub is connected, upper layer sends URB enqueue request,
which results in port reset issue.

Added exit from partial power down state to avoid port
reset issue and process upper layer request correctly.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 Changes in v3:
 - None
 Changes in v2:
 - None

 drivers/usb/dwc2/hcd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 9529e9839961..cb52bc41bfb8 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4633,6 +4633,13 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 		dwc2_dump_urb_info(hcd, urb, "urb_enqueue");
 	}
 
+	if (hsotg->in_ppd) {
+		retval = dwc2_exit_partial_power_down(hsotg, 0, true);
+		if (retval)
+			dev_err(hsotg->dev,
+				"exit partial_power_down failed\n");
+	}
+
 	if (!ep)
 		return -EINVAL;
 
-- 
2.25.1

