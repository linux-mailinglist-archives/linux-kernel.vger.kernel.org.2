Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82453EA43B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 14:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbhHLMDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 08:03:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62831 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234110AbhHLMDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:03:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628769788; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=6QsmkNZbQwVsN9LnELcdMHAkKo6gl/13f9/auIf990s=; b=fozKaMzIdJgBk+pZ2yeJAz+LFvekS0+DBz/+76M6qWMDvosWJ7UGSH8ZWPgSuoNmNe141PgW
 qUBqPKK8ysVg7TTVTQ28KXD10x5OQFbhQUIiNbXiKHp4khDTe53FMxvGriW4bHftk0CVe5xv
 PPXSdW4VJg4iWqX7JBPcKIGKqb4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61150dceb14e7e2ecbf32183 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 12 Aug 2021 12:02:22
 GMT
Sender: wat=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B6EC2C43217; Thu, 12 Aug 2021 12:02:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cbsp-sh-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wat)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17E84C433D3;
        Thu, 12 Aug 2021 12:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17E84C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wat@codeaurora.org
From:   Tao Wang <wat@codeaurora.org>
To:     quic_wat@quicinc.com, linyyuan@qti.qualcomm.com,
        hongwus@qti.qualcomm.com, zhijunw@qti.qualcomm.com,
        wat@codeaurora.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] usb: xhci-ring: USB SSD may fail to unmount if disconnect during data transferring.
Date:   Thu, 12 Aug 2021 20:02:07 +0800
Message-Id: <1628769727-45046-1-git-send-email-wat@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Wang <quic_wat@quicinc.com>

it stuck in usb_kill_urb() due to urb use_count will not become zero,
this means urb giveback is not happen.
in xhci_handle_cmd_set_deq() will giveback urb if td's cancel_status
equal to TD_CLEARING_CACHE,
but in xhci_invalidate_cancelled_tds(), only last canceled td's
cancel_status change to TD_CLEARING_CACHE,
thus giveback only happen to last urb.

this change set all cancelled_td's cancel_status to TD_CLEARING_CACHE
rather than the last one, so all urb can giveback.

Signed-off-by: Tao Wang <quic_wat@quicinc.com>
---
 drivers/usb/host/xhci-ring.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 8fea44b..c7dd7c0 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -960,19 +960,19 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 			td_to_noop(xhci, ring, td, false);
 			td->cancel_status = TD_CLEARED;
 		}
-	}
-	if (cached_td) {
-		cached_td->cancel_status = TD_CLEARING_CACHE;
-
-		err = xhci_move_dequeue_past_td(xhci, slot_id, ep->ep_index,
-						cached_td->urb->stream_id,
-						cached_td);
-		/* Failed to move past cached td, try just setting it noop */
-		if (err) {
-			td_to_noop(xhci, ring, cached_td, false);
-			cached_td->cancel_status = TD_CLEARED;
+		if (cached_td) {
+			cached_td->cancel_status = TD_CLEARING_CACHE;
+
+			err = xhci_move_dequeue_past_td(xhci, slot_id, ep->ep_index,
+							cached_td->urb->stream_id,
+							cached_td);
+			/* Failed to move past cached td, try just setting it noop */
+			if (err) {
+				td_to_noop(xhci, ring, cached_td, false);
+				cached_td->cancel_status = TD_CLEARED;
+			}
+			cached_td = NULL;
 		}
-		cached_td = NULL;
 	}
 	return 0;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

