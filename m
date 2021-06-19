Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC5D3ADAAF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 17:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbhFSPqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 11:46:37 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:16091 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhFSPqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 11:46:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624117464; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=LW8UY91ifGqJSXV13wNYa6bjhwTWZjZP9sgy2LvBNwg=; b=gBNZtTue93Fhl5wFu03tL181nsJo9ELXUHgQr+46LcMl87sUFBt4jRgvMMAzFRFFIWL8fKCO
 slyGpxv96FJB3lE+bbE8nQtlcIpBz3Diq51Z+FRZLU/8Rl9uit3SXLlqxQreVj23I8gbAAn6
 vy6dUcdSzPe+rDlIsX4jDfvrKVc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60ce10bc6ddc3305c418dd19 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 19 Jun 2021 15:43:56
 GMT
Sender: linyyuan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F205EC43460; Sat, 19 Jun 2021 15:43:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from localhost.localdomain (unknown [101.87.142.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: linyyuan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D8B7C433F1;
        Sat, 19 Jun 2021 15:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D8B7C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=linyyuan@codeaurora.org
From:   Linyu Yuan <linyyuan@codeaurora.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>,
        Linyu Yuan <linyyuan@codeaurora.org>
Subject: [PATCH v3 1/2] usb: udc: core: hide struct usb_gadget_driver to gadget driver
Date:   Sat, 19 Jun 2021 23:43:08 +0800
Message-Id: <20210619154309.52127-2-linyyuan@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210619154309.52127-1-linyyuan@codeaurora.org>
References: <20210619154309.52127-1-linyyuan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently most gadget driver have a pointer to save
struct usb_gadget_driver from upper layer,
it allow upper layer set and unset of the pointer.

there is race that upper layer unset the pointer first,
but gadget driver use the pointer later,
and it cause system crash due to NULL pointer access.

Signed-off-by: Linyu Yuan <linyyuan@codeaurora.org>
---

v3: no change
v2: no change

 drivers/usb/gadget/udc/core.c | 47 ++++++++++++++++++++++++++++++++++-
 include/linux/usb/gadget.h    |  6 +++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index b7f0b1ebaaa8..44af6ff281d3 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1052,6 +1052,45 @@ void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
 }
 EXPORT_SYMBOL_GPL(usb_udc_vbus_handler);
 
+void usb_gadget_udc_disconnect(struct usb_gadget *gadget)
+{
+	struct usb_udc *udc = gadget->udc;
+
+	if (udc && udc->driver && udc->driver->disconnect)
+		udc->driver->disconnect(gadget);
+}
+EXPORT_SYMBOL_GPL(usb_gadget_udc_disconnect);
+
+void usb_gadget_udc_suspend(struct usb_gadget *gadget)
+{
+	struct usb_udc *udc = gadget->udc;
+
+	if (udc && udc->driver && udc->driver->suspend)
+		udc->driver->suspend(gadget);
+}
+EXPORT_SYMBOL_GPL(usb_gadget_udc_suspend);
+
+void usb_gadget_udc_resume(struct usb_gadget *gadget)
+{
+	struct usb_udc *udc = gadget->udc;
+
+	if (udc && udc->driver && udc->driver->resume)
+		udc->driver->resume(gadget);
+}
+EXPORT_SYMBOL_GPL(usb_gadget_udc_resume);
+
+int usb_gadget_udc_setup(struct usb_gadget *gadget,
+			const struct usb_ctrlrequest *ctrl)
+{
+	struct usb_udc *udc = gadget->udc;
+
+	if (udc && udc->driver)
+		return udc->driver->setup(gadget, ctrl);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_udc_setup);
+
 /**
  * usb_gadget_udc_reset - notifies the udc core that bus reset occurs
  * @gadget: The gadget which bus reset occurs
@@ -1064,7 +1103,13 @@ EXPORT_SYMBOL_GPL(usb_udc_vbus_handler);
 void usb_gadget_udc_reset(struct usb_gadget *gadget,
 		struct usb_gadget_driver *driver)
 {
-	driver->reset(gadget);
+	struct usb_udc *udc = gadget->udc;
+
+	if (driver)
+		driver->reset(gadget);
+	else if (udc && udc->driver)
+		udc->driver->reset(gadget);
+
 	usb_gadget_set_state(gadget, USB_STATE_DEFAULT);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 75c7538e350a..85f4c87ba5b3 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -881,6 +881,12 @@ extern void usb_gadget_set_state(struct usb_gadget *gadget,
 
 /*-------------------------------------------------------------------------*/
 
+extern void usb_gadget_udc_disconnect(struct usb_gadget *gadget);
+extern void usb_gadget_udc_suspend(struct usb_gadget *gadget);
+extern void usb_gadget_udc_resume(struct usb_gadget *gadget);
+extern int usb_gadget_udc_setup(struct usb_gadget *gadget,
+			const struct usb_ctrlrequest *ctrl);
+
 /* utility to tell udc core that the bus reset occurs */
 extern void usb_gadget_udc_reset(struct usb_gadget *gadget,
 		struct usb_gadget_driver *driver);
-- 
2.25.1

