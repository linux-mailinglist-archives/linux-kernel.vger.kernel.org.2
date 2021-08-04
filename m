Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D9D3DFB6B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 08:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbhHDGYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 02:24:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53278 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234831AbhHDGYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 02:24:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628058276; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ms4w2nOLpyvnWav4AUaTVOElpOLGquasTh0H33YDf+8=; b=HItqekPhj6O3sqbJTXWiqk9ysTUrF6QUw1PBnfLWifqJIjWwn9k7OP57w2w/mG0yACIFWI5Z
 5kAPMqO+O2+bekYaS1dOye1Val13w836TmHGOP5JUqln9ZqELFMFvnWP0P/EMKC7vWsw2Ojj
 ZVkYky3D1uUYi4uU67s1IdyZHFM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 610a3294041a739c46fbf70a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Aug 2021 06:24:20
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9B39CC433D3; Wed,  4 Aug 2021 06:24:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E23C1C433F1;
        Wed,  4 Aug 2021 06:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E23C1C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v2] usb: dwc3: gadget: Avoid runtime resume if disabling pullup
Date:   Tue,  3 Aug 2021 23:24:05 -0700
Message-Id: <1628058245-30692-1-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device is already in the runtime suspended state, any call to
the pullup routine will issue a runtime resume on the DWC3 core
device.  If the USB gadget is disabling the pullup, then avoid having
to issue a runtime resume, as DWC3 gadget has already been
halted/stopped.

This fixes an issue where the following condition occurs:

usb_gadget_remove_driver()
-->usb_gadget_disconnect()
 -->dwc3_gadget_pullup(0)
  -->pm_runtime_get_sync() -> ret = 0
  -->pm_runtime_put() [async]
-->usb_gadget_udc_stop()
 -->dwc3_gadget_stop()
  -->dwc->gadget_driver = NULL
...

dwc3_suspend_common()
-->dwc3_gadget_suspend()
 -->DWC3 halt/stop routine skipped, driver_data == NULL

This leads to a situation where the DWC3 gadget is not properly
stopped, as the runtime resume would have re-enabled EP0 and event
interrupts, and since we avoided the DWC3 gadget suspend, these
resources were never disabled.

Fixes: 77adb8bdf422 ("usb: dwc3: gadget: Allow runtime suspend if UDC unbinded")
Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
---
Changes in v2:
- Added fixes tag with the problem commit.

 drivers/usb/dwc3/gadget.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a29a4ca..5d08454 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2435,6 +2435,17 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	}
 
 	/*
+	 * Avoid issuing a runtime resume if the device is already in the
+	 * suspended state during gadget disconnect.  DWC3 gadget was already
+	 * halted/stopped during runtime suspend.
+	 */
+	if (!is_on) {
+		pm_runtime_barrier(dwc->dev);
+		if (pm_runtime_suspended(dwc->dev))
+			return 0;
+	}
+
+	/*
 	 * Check the return value for successful resume, or error.  For a
 	 * successful resume, the DWC3 runtime PM resume routine will handle
 	 * the run stop sequence, so avoid duplicate operations here.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

