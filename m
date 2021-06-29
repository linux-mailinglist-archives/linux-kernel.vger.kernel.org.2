Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C733B6BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 02:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhF2AXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 20:23:46 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38089 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231996AbhF2AXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 20:23:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624926072; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=iQMYetUye9xqOFpBrvrgWZrNKB88y6EU2wd7YeKk3/4=; b=k1LLX6fQzQOHfsynKmwz8+8uyZ6JJrQiW9FHmvIDyZvkwsVWepf9Bp6UHNUgpTmSJ7DnbkTE
 g407mEjbT22ntryehbrINjPCHOr2PfIMMI2PlpI97pKxAy7uVFfkdcjtKvAb1vw9DYavv+bN
 NA+9PUhHT8gG0n9XBAanp2D9zJI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60da676cc4cc5436029ea20f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Jun 2021 00:21:00
 GMT
Sender: linyyuan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 40662C4360C; Tue, 29 Jun 2021 00:21:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost.localdomain (unknown [101.87.142.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: linyyuan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E582C433F1;
        Tue, 29 Jun 2021 00:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E582C433F1
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
Subject: [PATCH] usb: dwc3: avoid NULL access of usb_gadget_driver
Date:   Tue, 29 Jun 2021 08:20:28 +0800
Message-Id: <20210629002029.6295-1-linyyuan@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we found crash in dwc3_disconnect_gadget(),
it is because dwc->gadget_driver become NULL before async access.
7dc0c55e9f30 ('USB: UDC core: Add udc_async_callbacks gadget op')
suggest a common way to avoid such kind of issue.

this change implment the callback in dwc3 and
change related functions which have callback to UDC core.

Signed-off-by: Linyu Yuan <linyyuan@codeaurora.org>
---
 drivers/usb/dwc3/core.h   |  1 +
 drivers/usb/dwc3/ep0.c    | 10 ++++++----
 drivers/usb/dwc3/gadget.c | 19 +++++++++++++++----
 3 files changed, 22 insertions(+), 8 deletions(-)

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
index 3cd294264372..2f9e45eed228 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -597,11 +597,13 @@ static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 
 static int dwc3_ep0_delegate_req(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
-	int ret;
+	int ret = -EINVAL;
 
-	spin_unlock(&dwc->lock);
-	ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
-	spin_lock(&dwc->lock);
+	if (dwc->async_callbacks) {
+		spin_unlock(&dwc->lock);
+		ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
+		spin_lock(&dwc->lock);
+	}
 	return ret;
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index af6d7f157989..a815ba96b502 100644
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
@@ -3231,7 +3242,7 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 
 static void dwc3_disconnect_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->disconnect) {
+	if (dwc->async_callbacks && dwc->gadget_driver->disconnect) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->disconnect(dwc->gadget);
 		spin_lock(&dwc->lock);
@@ -3240,7 +3251,7 @@ static void dwc3_disconnect_gadget(struct dwc3 *dwc)
 
 static void dwc3_suspend_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->suspend) {
+	if (dwc->async_callbacks && dwc->gadget_driver->suspend) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->suspend(dwc->gadget);
 		spin_lock(&dwc->lock);
@@ -3249,7 +3260,7 @@ static void dwc3_suspend_gadget(struct dwc3 *dwc)
 
 static void dwc3_resume_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
+	if (dwc->async_callbacks && dwc->gadget_driver->resume) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->resume(dwc->gadget);
 		spin_lock(&dwc->lock);
@@ -3585,7 +3596,7 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
 	 * implemented.
 	 */
 
-	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
+	if (dwc->async_callbacks && dwc->gadget_driver->resume) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->resume(dwc->gadget);
 		spin_lock(&dwc->lock);
-- 
2.25.1

