Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9063A9999
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhFPLyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:54:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45357 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229713AbhFPLyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:54:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623844331; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=x8YM41tIK2n4ialB5PxG4YvrBi5avZ4s6tNfI+y5Hf0=; b=UKfmjV20MYuMBRBRBQJQjPMPLKkf7h+z+BL/fjkizaPODOH+7TnLKk3YJT6Tls9hDiijaLga
 vvIT9XcrX+J3TPN7sQAMC0fnoXIeQ45Fr1lh7rWUqcGrDYItQAoVZvGMIXlLzE7XRfkvxxPy
 rTVJKoyiP6QSBJCfwqUM8LPFaPA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60c9e5e7f726fa4188cae76f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Jun 2021 11:52:07
 GMT
Sender: linyyuan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 24C4EC4338A; Wed, 16 Jun 2021 11:52:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost.localdomain (unknown [101.87.142.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: linyyuan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C961CC433F1;
        Wed, 16 Jun 2021 11:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C961CC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=linyyuan@codeaurora.org
From:   Linyu Yuan <linyyuan@codeaurora.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Linyu Yuan <linyyuan@codeaurora.com>
Subject: [PATCH v3] usb: gadget: eem: fix echo command packet response issue
Date:   Wed, 16 Jun 2021 19:51:42 +0800
Message-Id: <20210616115142.34075-1-linyyuan@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linyu Yuan <linyyuan@codeaurora.com>

when receive eem echo command, it will send a response,
but queue this response to the usb request which allocate
from gadget device endpoint zero,
and transmit the request to IN endpoint of eem interface.

on dwc3 gadget, it will trigger following warning in function
__dwc3_gadget_ep_queue(),

	if (WARN(req->dep != dep, "request %pK belongs to '%s'\n",
				&req->request, req->dep->name))
		return -EINVAL;

fix it by allocating a usb request from IN endpoint of eem interface,
and transmit the usb request to same IN endpoint of eem interface.

Signed-off-by: Linyu Yuan <linyyuan@codeaurora.com>
---

v3: use exist goto label 'next'
v2: fix mail format and expand commit message

 drivers/usb/gadget/function/f_eem.c | 43 ++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/f_eem.c b/drivers/usb/gadget/function/f_eem.c
index 2cd9942707b4..5d38f29bda72 100644
--- a/drivers/usb/gadget/function/f_eem.c
+++ b/drivers/usb/gadget/function/f_eem.c
@@ -30,6 +30,11 @@ struct f_eem {
 	u8				ctrl_id;
 };
 
+struct in_context {
+	struct sk_buff	*skb;
+	struct usb_ep	*ep;
+};
+
 static inline struct f_eem *func_to_eem(struct usb_function *f)
 {
 	return container_of(f, struct f_eem, port.func);
@@ -320,9 +325,12 @@ static int eem_bind(struct usb_configuration *c, struct usb_function *f)
 
 static void eem_cmd_complete(struct usb_ep *ep, struct usb_request *req)
 {
-	struct sk_buff *skb = (struct sk_buff *)req->context;
+	struct in_context *ctx = req->context;
 
-	dev_kfree_skb_any(skb);
+	dev_kfree_skb_any(ctx->skb);
+	kfree(req->buf);
+	usb_ep_free_request(ctx->ep, req);
+	kfree(ctx);
 }
 
 /*
@@ -410,7 +418,9 @@ static int eem_unwrap(struct gether *port,
 		 * b15:		bmType (0 == data, 1 == command)
 		 */
 		if (header & BIT(15)) {
-			struct usb_request	*req = cdev->req;
+			struct usb_request	*req;
+			struct in_context	*ctx;
+			struct usb_ep		*ep;
 			u16			bmEEMCmd;
 
 			/* EEM command packet format:
@@ -439,11 +449,36 @@ static int eem_unwrap(struct gether *port,
 				skb_trim(skb2, len);
 				put_unaligned_le16(BIT(15) | BIT(11) | len,
 							skb_push(skb2, 2));
+
+				ep = port->in_ep;
+				req = usb_ep_alloc_request(ep, GFP_ATOMIC);
+				if (!req) {
+					dev_kfree_skb_any(skb2);
+					goto next;
+				}
+
+				req->buf = kmalloc(skb2->len, GFP_KERNEL);
+				if (!req->buf) {
+					usb_ep_free_request(ep, req);
+					dev_kfree_skb_any(skb2);
+					goto next;
+				}
+
+				ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+				if (!ctx) {
+					kfree(req->buf);
+					usb_ep_free_request(ep, req);
+					dev_kfree_skb_any(skb2);
+					goto next;
+				}
+				ctx->skb = skb2;
+				ctx->ep = ep;
+
 				skb_copy_bits(skb2, 0, req->buf, skb2->len);
 				req->length = skb2->len;
 				req->complete = eem_cmd_complete;
 				req->zero = 1;
-				req->context = skb2;
+				req->context = ctx;
 				if (usb_ep_queue(port->in_ep, req, GFP_ATOMIC))
 					DBG(cdev, "echo response queue fail\n");
 				break;
-- 
2.25.1

