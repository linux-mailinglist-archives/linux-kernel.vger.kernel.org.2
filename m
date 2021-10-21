Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AB9435E10
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhJUJjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:39:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhJUJjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:39:07 -0400
From:   viraj.shah@linutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634809011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=crfFFhCWTs/q+CgKcRUkyHn/11/dfdg8XTredYKuW8Y=;
        b=oeaNaW7Y4EE63FEAKANjcRTyQJtHb1adSlPV0uQp9eMCIEhtt0OxZAhUXWw5FutD/aRld+
        deoupsW8uc/Rmx/7WdkGrK+Iro4lPS2FNbpelnViBC6CAXLdkwRhu5PFjSsg4xcoja1poc
        z9IFA38Sr68KclUn5VLwlf9+8TVZQUEGg7cEPMAaktxA6692VM7okg2y/OwQeTI4sPhyeD
        96JtY4Ku288sDoikTvX+O1zOx6kxoo9EcQgk7031z8y3HEDPISAjgWzGV5ncPEKSpmmq/K
        /+qozWre2sOKd2GhEf7mhL2XUG+NKn89Lcoq9IAOePut9qXAGzA4CcUp6lLEJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634809011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=crfFFhCWTs/q+CgKcRUkyHn/11/dfdg8XTredYKuW8Y=;
        b=Y3sRIlBu/eT4MTNay/GLiZ5mXgf1GuRVH2c92Ol2O9WkkOXaQY/aFxQr2o2p1ySDSbBzz3
        t9uBCBMoUNReIHCg==
To:     b-liu@ti.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] usb: musb: Balance list entry in musb_gadget_queue
Date:   Thu, 21 Oct 2021 11:36:44 +0200
Message-Id: <20211021093644.4734-1-viraj.shah@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viraj Shah <viraj.shah@linutronix.de>

musb_gadget_queue() adds the passed request to musb_ep::req_list. If the
endpoint is idle and it is the first request then it invokes
musb_queue_resume_work(). If the function returns an error then the
error is passed to the caller without any clean-up and the request
remains enqueued on the list. If the caller enqueues the request again
then the list corrupts.

Remove the request from the list on error.

Fixes: ea2f35c01d5ea ("usb: musb: Fix sleeping function called from invalid context for hdrc glue")
Signed-off-by: Viraj Shah <viraj.shah@linutronix.de>
---
 drivers/usb/musb/musb_gadget.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 98c0f4c1bffd..51274b87f46c 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1247,9 +1247,11 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 		status = musb_queue_resume_work(musb,
 						musb_ep_restart_resume_work,
 						request);
-		if (status < 0)
+		if (status < 0) {
 			dev_err(musb->controller, "%s resume work: %i\n",
 				__func__, status);
+			list_del(&request->list);
+		}
 	}
 
 unlock:
-- 
2.30.2

