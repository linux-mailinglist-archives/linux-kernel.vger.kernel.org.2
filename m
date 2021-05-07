Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BC537606F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhEGGfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:35:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:14810 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhEGGfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:35:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620369294; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=r8Izzb0AxTyu35PXx43nBPtJjj5UDakJZVnGgFYktPY=; b=GXJAHBYF8tVC5yOnsLlutTD46qrXNfZ7+nIUjMAFjX2/zrfEzFIB3ig1viNvVo5WCkIOUG03
 CgxQ/WZS6UmaGhGrTyLWwzvFQHzVJkHvD1KGo3iaFbg73/eeE4hhbzg0kFEkHnZJvI1LKBXw
 ZFpb7Y32sLMXGPRMw8vcrSWspo0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6094df8b03cfff345240e6bb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 07 May 2021 06:34:51
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4032C43143; Fri,  7 May 2021 06:34:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03685C4338A;
        Fri,  7 May 2021 06:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03685C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thinh.Nguyen@synopsys.com, jackp@codeaurora.org,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH] usb: dwc3: gadget: Return success always for kick transfer in ep queue
Date:   Thu,  6 May 2021 23:34:47 -0700
Message-Id: <1620369287-27492-1-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error is received when issuing a start or update transfer
command, the error handler will stop all active requests (including
the current USB request), and call dwc3_gadget_giveback() to notify
function drivers of the requests which have been stopped.  Avoid
returning an error for kick transfer during EP queue, to remove
duplicate cleanup operations on the request being queued.

Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
---
Changes in v1:
 - Renamed commit title due to new implementation
 - Return success always for kick transfer during ep queue

Previous patchset:
https://lore.kernel.org/linux-usb/875yzxibur.fsf@kernel.org/T/#t

 drivers/usb/dwc3/gadget.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index dd80e5c..a5b7fd9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1684,7 +1684,9 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 		}
 	}
 
-	return __dwc3_gadget_kick_transfer(dep);
+	__dwc3_gadget_kick_transfer(dep);
+
+	return 0;
 }
 
 static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

