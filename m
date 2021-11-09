Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C3144A604
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 06:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhKIFOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 00:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhKIFOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 00:14:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DD3C061766
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 21:11:32 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r67-20020a252b46000000b005bea12c4befso28392885ybr.19
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 21:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uvIwbGx+u6q+kJKMl/5AYRSz/lq9tfFJ54Vg+Sbhq2Q=;
        b=H4SadlQEIDFGn/n58RPTZa8Y0fSNRFGPsRuP/lwPlG0tbLpyllkiz8843jOd3crEfm
         8v6Me4t3eJIhsqwE5qBZxAuh5VK/seDdbk9zoXfFHnYY6lwC4x29KNc9kCmrp1U6QRb5
         9RxxBTlR1InBsUnXd1iQalevatNLTftNYWOqWgHYjgEwJCWtArkU3gnvh462VlLgD6Pb
         i87hNJSqI6c+lSnMwhFIpNC3YP4zbB4GbQ8pxR3S3cMmvMhdm3xGMEdrBonQDJ9kRsmG
         nNrRNFf1f0svFDw0IvMG2odsuK8cy9g2CrsumF5bhwJbxOYbczADa1kzWY9Il1EZydLo
         RYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uvIwbGx+u6q+kJKMl/5AYRSz/lq9tfFJ54Vg+Sbhq2Q=;
        b=vgRQ0FheADqy7dhflMtAAvV+FqfV3+0077OKZzntx2rQd/9ZS0dv0rq8tiOPMD3ub1
         FGQsQq7Cmw7AUJtywGr6g/AD+8r6cJV+LSAVBG1JxD92od9ViB2e/od9CmVlc/mhAWnL
         H/qHOzc/KBadEqBuOk816P6OMGIuDbzk2rBlfv1RSI9aklaygfLtu7LpweaSCI2pedGc
         Ky/mvmeXQYErVVVQ+BZgRZeBht8x3/CUQ7ftWVCziKLQasFdI2bn3gS4vrBlBl771d6G
         Q9CKb7YW1iyCl+UeYPcmS83qyS5QUq1l3kTGPfbJURLl9Q8acysXwKMWuQ3JMF6QHUAM
         wjWQ==
X-Gm-Message-State: AOAM530oT/L4s09UTpVEv0cdnVZ8j+L8VFVUKD6AYllBkrWqWhBjMU9V
        qIzv2qWb3+atr7G+UyDLmh7KnT+zkbXFzLpl648=
X-Google-Smtp-Source: ABdhPJxs79jF1Ic27F9OPFZoZUHFyOjgSk3kRcJ0YwKb6sXA4LXk302zqaWiHZCLnfyAQMt9OyyqSx2W8myqdg6aaW0=
X-Received: from albertccwang.ntc.corp.google.com ([2401:fa00:fc:202:a18f:cf64:97e0:fceb])
 (user=albertccwang job=sendgmr) by 2002:a25:4055:: with SMTP id
 n82mr5617104yba.168.1636434691444; Mon, 08 Nov 2021 21:11:31 -0800 (PST)
Date:   Tue,  9 Nov 2021 13:11:23 +0800
Message-Id: <20211109051123.3458088-1-albertccwang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2] usb: dwc3: gadget: Fix null pointer exception
From:   Albert Wang <albertccwang@google.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, wcheng@codeaurora.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Albert Wang <albertccwang@google.com>,
        Jack Pham <quic_jackp@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the endpoint interrupt functions
dwc3_gadget_endpoint_transfer_in_progress() and
dwc3_gadget_endpoint_trbs_complete() will dereference the endpoint
descriptor. But it could be cleared in __dwc3_gadget_ep_disable()
when accessory disconnected. So we need to check whether it is null
or not before dereferencing it.

Fixes: f09ddcfcb8c5 ("usb: dwc3: gadget: Prevent EP queuing while stopping transfers")
Signed-off-by: Albert Wang <albertccwang@google.com>
Reviewed-by: Jack Pham <quic_jackp@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 23de2a5a40d6..83c7344888fd 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3252,6 +3252,9 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 	struct dwc3		*dwc = dep->dwc;
 	bool			no_started_trb = true;
 
+	if (!dep->endpoint.desc)
+		return no_started_trb;
+
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
 	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
@@ -3299,6 +3302,9 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 {
 	int status = 0;
 
+	if (!dep->endpoint.desc)
+		return;
+
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
 		dwc3_gadget_endpoint_frame_from_event(dep, event);
 
-- 
2.34.0.rc0.344.g81b53c2807-goog

