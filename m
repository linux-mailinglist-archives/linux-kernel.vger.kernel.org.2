Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDDF3B41DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhFYKrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:47:16 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:35539 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231239AbhFYKrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:47:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624617894; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=30tOO7LTxPTZ1XcUwe0x/AhKaRExethlXl2sly8VV4o=; b=H5UDC5YBKZknolxFDI/rrFrmvQzoutMT1kPPnVpx9rNuhMaB6mjz22WHIkt7gq5D0Gye6Zm+
 03zH5TTCBpZIVJNukTWO1KsUau3IqsLouTtHldDdyQCfw4LCWTFfrpJlgmWmqYluE4VJudw6
 GdjPmvoLk51Tu4/+aV2wOrDbm88=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60d5b3a23a8b6d0a4587e370 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Jun 2021 10:44:50
 GMT
Sender: linyyuan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5BB8CC4338A; Fri, 25 Jun 2021 10:44:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from localhost.localdomain (unknown [101.87.142.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: linyyuan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 21F45C433F1;
        Fri, 25 Jun 2021 10:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21F45C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=linyyuan@codeaurora.org
From:   Linyu Yuan <linyyuan@codeaurora.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>,
        Linyu Yuan <linyyuan@codeaurora.org>
Subject: [PATCH] usb: dwc3: fix race of usb_gadget_driver operation
Date:   Fri, 25 Jun 2021 18:44:15 +0800
Message-Id: <20210625104415.8072-1-linyyuan@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is following race condition,

      CPU1                         CPU2
dwc3_runtime_suspend()        dwc3_gadget_stop()
spin_lock(&dwc->lock)
dwc3_gadget_suspend()
dwc3_disconnect_gadget()
dwc->gadget_driver != NULL
spin_unlock(&dwc->lock)
                              spin_lock(&dwc->lock)
                              dwc->gadget_driver = NULL
                              spin_unlock(&dwc->lock)
dwc->gadget_driver->disconnect(dwc->gadget);

system will crash when access NULL gadget_driver.

7dc0c55e9f30 ('USB: UDC core: Add udc_async_callbacks gadget op')
suggest a common way to avoid such kind of race.

this change implment the callback in dwc3 and
change related functions which have callback to UDC core.

Signed-off-by: Linyu Yuan <linyyuan@codeaurora.org>
---
 drivers/usb/dwc3/core.h   |  1 +
 drivers/usb/dwc3/ep0.c    |  5 +++--
 drivers/usb/dwc3/gadget.c | 39 +++++++++++++++++++++++----------------
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index dccdf13b5f9e..5991766239ba 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1279,6 +1279,7 @@ struct dwc3 {
 	unsigned		dis_metastability_quirk:1;
 
 	unsigned		dis_split_quirk:1;
+	unsigned		async_callbacks:1;
 
 	u16			imod_interval;
 };
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 3cd294264372..26419077c7c9 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -597,10 +597,11 @@ static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 
 static int dwc3_ep0_delegate_req(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
-	int ret;
+	int ret = 0;
 
 	spin_unlock(&dwc->lock);
-	ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
+	if (dwc->async_callbacks)
+		ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
 	spin_lock(&dwc->lock);
 	return ret;
 }
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index af6d7f157989..d868f30007cc 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2585,6 +2585,16 @@ static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 	return ret;
 }
 
+static void dwc3_gadget_async_callbacks(struct usb_gadget *g, bool enable)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->async_callbacks = enable;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.get_frame		= dwc3_gadget_get_frame,
 	.wakeup			= dwc3_gadget_wakeup,
@@ -2596,6 +2606,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.udc_set_ssp_rate	= dwc3_gadget_set_ssp_rate,
 	.get_config_params	= dwc3_gadget_config_params,
 	.vbus_draw		= dwc3_gadget_vbus_draw,
+	.udc_async_callbacks	= dwc3_gadget_async_callbacks,
 };
 
 /* -------------------------------------------------------------------------- */
@@ -3231,29 +3242,26 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 
 static void dwc3_disconnect_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->disconnect) {
-		spin_unlock(&dwc->lock);
+	spin_unlock(&dwc->lock);
+	if (dwc->async_callbacks && dwc->gadget_driver->disconnect)
 		dwc->gadget_driver->disconnect(dwc->gadget);
-		spin_lock(&dwc->lock);
-	}
+	spin_lock(&dwc->lock);
 }
 
 static void dwc3_suspend_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->suspend) {
-		spin_unlock(&dwc->lock);
+	spin_unlock(&dwc->lock);
+	if (dwc->async_callbacks && dwc->gadget_driver->suspend)
 		dwc->gadget_driver->suspend(dwc->gadget);
-		spin_lock(&dwc->lock);
-	}
+	spin_lock(&dwc->lock);
 }
 
 static void dwc3_resume_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
-		spin_unlock(&dwc->lock);
+	spin_unlock(&dwc->lock);
+	if (dwc->async_callbacks && dwc->gadget_driver->resume)
 		dwc->gadget_driver->resume(dwc->gadget);
-		spin_lock(&dwc->lock);
-	}
+	spin_lock(&dwc->lock);
 }
 
 static void dwc3_reset_gadget(struct dwc3 *dwc)
@@ -3585,11 +3593,10 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
 	 * implemented.
 	 */
 
-	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
-		spin_unlock(&dwc->lock);
+	spin_unlock(&dwc->lock);
+	if (dwc->async_callbacks && dwc->gadget_driver->resume)
 		dwc->gadget_driver->resume(dwc->gadget);
-		spin_lock(&dwc->lock);
-	}
+	spin_lock(&dwc->lock);
 }
 
 static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
-- 
2.25.1

