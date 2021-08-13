Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA3B3EAEAF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 04:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238470AbhHMCou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 22:44:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30302 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238357AbhHMCou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 22:44:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628822664; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=+sXnDd5NzLQp8aMTaouqrcnUqs/sQpYuHKr+B/RA/Ro=; b=w+mWhwsydM9D8zaeKyIB0/M3D70uXGIoMSVA3jc3rBcgdKP0p1ND6ouzMzebHNDFtbZDpcwa
 DTthHThH4WtdviKswzSeQTWMqaKbtb+a58uHFq3XX+qUBuRwWFheRB5qwEyLxPTcQFozMqnB
 5+q4OposM+ELKSPrW9hxRaypWfs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6115dc7191487ad5207df2fc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 13 Aug 2021 02:44:01
 GMT
Sender: wat=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A3BACC43217; Fri, 13 Aug 2021 02:44:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cbsp-sh-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wat)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F584C433F1;
        Fri, 13 Aug 2021 02:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F584C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wat@codeaurora.org
From:   Tao Wang <wat@codeaurora.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     Tao Wang <wat@codeaurora.org>
Subject: [PATCH] usb: xhci-ring: set all cancelled_td's cancel_status to TD_CLEARING_CACHE
Date:   Fri, 13 Aug 2021 10:43:23 +0800
Message-Id: <1628822604-29239-1-git-send-email-wat@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB SSD may fail to unmount if disconnect during data transferring.

it stuck in usb_kill_urb() due to urb use_count will not become zero,
this means urb giveback is not happen.
in xhci_handle_cmd_set_deq() will giveback urb if td's cancel_status
equal to TD_CLEARING_CACHE,
but in xhci_invalidate_cancelled_tds(), only last canceled td's
cancel_status change to TD_CLEARING_CACHE,
thus giveback only happen to last urb.

this change set all cancelled_td's cancel_status to TD_CLEARING_CACHE
rather than the last one, so all urb can giveback.

Signed-off-by: Tao Wang <wat@codeaurora.org>
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

