Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C9338BD39
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 06:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbhEUEZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 00:25:34 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:52861 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbhEUEZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 00:25:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621571050; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=U5lBnv0BhH6sVkqljkunOjMLccN8yb0A8j9YRbLa+zc=; b=AY8CBijqDlUUckdhfUOQS+4HhH5hmEyQCBxjxfMtgvKiOE3W07cYz/3P+pBucHAa2Tih9pcz
 /tocPIafzMDH1TC4oqMIPiFrCgGr4y8HAz2k0sq54KZLHvbPuzP3FfksCTC5WGU9vzUH0wYb
 mW3hapwymKyWaL5LTStuiA119Xc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60a735e25f788b52a50cca62 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 May 2021 04:24:02
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4FB99C43460; Fri, 21 May 2021 04:24:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37C34C433F1;
        Fri, 21 May 2021 04:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37C34C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH] usb: dwc3: gadget: Disable gadget IRQ during pullup disable
Date:   Thu, 20 May 2021 21:23:57 -0700
Message-Id: <1621571037-1424-1-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current sequence utilizes dwc3_gadget_disable_irq() alongside
synchronize_irq() to ensure that no further DWC3 events are generated.
However, the dwc3_gadget_disable_irq() API only disables device
specific events.  Endpoint events can still be generated.  Briefly
disable the interrupt line, so that the cleanup code can run to
prevent device and endpoint events. (i.e. __dwc3_gadget_stop() and
dwc3_stop_active_transfers() respectively)

Without doing so, it can lead to both the interrupt handler and the
pullup disable routine both writing to the GEVNTCOUNT register, which
will cause an incorrect count being read from future interrupts.

Fixes: ae7e86108b12 ("usb: dwc3: Stop active transfers before halting the controller")
Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
---
 drivers/usb/dwc3/gadget.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 49ca5da..89aa9ac 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2260,13 +2260,10 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	}
 
 	/*
-	 * Synchronize any pending event handling before executing the controller
-	 * halt routine.
+	 * Synchronize and disable any further event handling while controller
+	 * is being enabled/disabled.
 	 */
-	if (!is_on) {
-		dwc3_gadget_disable_irq(dwc);
-		synchronize_irq(dwc->irq_gadget);
-	}
+	disable_irq(dwc->irq_gadget);
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
@@ -2304,6 +2301,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	ret = dwc3_gadget_run_stop(dwc, is_on, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
+	enable_irq(dwc->irq_gadget);
+
 	pm_runtime_put(dwc->dev);
 
 	return ret;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

