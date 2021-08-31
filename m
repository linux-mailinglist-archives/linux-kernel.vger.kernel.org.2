Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B6A3FCB2B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbhHaQEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239594AbhHaQEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:04:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EF4C061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:03:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u16so28578870wrn.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7XBdzsYcfbAFFqMK3EvyshaLCCtQzDoAHeCo4vRDzBk=;
        b=U2NQZcE9sbylaQm7A212jXABQnE6zq4llRL9giQ1oSim9XnSoDaIrUdZQtmDAYCef2
         qH+mKL6Un4oR1eqL8k3tdcC6Vdr7eYdTy9SvNOUWe9r1KQ/PDMPq6CW56bU3kKBJE0Eb
         +Gc4BnDz90lUEOlibsPH0yOkbzNNzZlz04c4Y8SdtYx3z9yBsNQXXjUKYQPURhG78V0T
         r4qXFpBl9x5cSrC+8ynWc0zbfqBX6GaRtEc/04tH8geF2KbipdZXuo460UN7fu6MvRD4
         cdqcwwPE14SetlEYksVcIm6X1WX2LTj8xPvRBe9r759WIVYSAZ/EAovnjF19RxczbX2/
         9bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7XBdzsYcfbAFFqMK3EvyshaLCCtQzDoAHeCo4vRDzBk=;
        b=mJJGWD15fY0evRQKwowID00oHnKOhpQjSxJYEVLNJXzaNWzBVRnJ3gROSArjCHDwZ2
         tyFGt8p95OA09BLmBWz/IuRUnQ6I80teyC/o1ZjCsC5KjpdLB/gkWaRCQXqXqiv+jmF3
         sB9Zf+UjYI8E4A406ekeTdQQo7FsUStCSiXgSIPoWAANNf51K5DN27CYxHXJpKTo95OT
         nH+FbJpY5uoSWst9BY5LLP2+MKl2UUFcZOxg5aEFlt60lWXPpPsoh7AJAJA3IrTu96Ah
         TZ5mG3FmMGekTl81tanTXg4mvgXTxXHuXJuBj0Y02gzCNMDPmSDPwR/VQB6DvdUvoOgS
         NUQQ==
X-Gm-Message-State: AOAM530ULs+OR4CTtEWMGTQ5FfgEpgJW51rLMjgfccUv6Axe6RrHwCHN
        aoTMfOe3FbcZozgmGjxY3lBX3A==
X-Google-Smtp-Source: ABdhPJxEYWLoI/kN0++wwJOdGNvSlwCszZpaaIv4lwVhp82x2hX4zEmr5fFlmRI1HIg4LFVmoWaogg==
X-Received: by 2002:adf:db07:: with SMTP id s7mr33301533wri.106.1630425789457;
        Tue, 31 Aug 2021 09:03:09 -0700 (PDT)
Received: from buildbot.pitowers.org ([2a00:1098:3142:14:ae1f:6bff:fedd:de54])
        by smtp.gmail.com with ESMTPSA id v13sm19245579wrf.55.2021.08.31.09.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 09:03:08 -0700 (PDT)
From:   Phil Elwell <phil@raspberrypi.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Bell <jonathan@raspberrypi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xhci: guard accesses to ep_state in xhci_endpoint_reset()
Date:   Tue, 31 Aug 2021 17:02:59 +0100
Message-Id: <20210831160259.2392459-1-phil@raspberrypi.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bell <jonathan@raspberrypi.com>

See https://github.com/raspberrypi/linux/issues/3981

Two read-modify-write cycles on ep->ep_state are not guarded by
xhci->lock. Fix these.

Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
---
 drivers/usb/host/xhci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index f3dabd02382c2..902f410874e8e 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3213,10 +3213,13 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 		return;
 
 	/* Bail out if toggle is already being cleared by a endpoint reset */
+	spin_lock_irqsave(&xhci->lock, flags);
 	if (ep->ep_state & EP_HARD_CLEAR_TOGGLE) {
 		ep->ep_state &= ~EP_HARD_CLEAR_TOGGLE;
+		spin_unlock_irqrestore(&xhci->lock, flags);
 		return;
 	}
+	spin_unlock_irqrestore(&xhci->lock, flags);
 	/* Only interrupt and bulk ep's use data toggle, USB2 spec 5.5.4-> */
 	if (usb_endpoint_xfer_control(&host_ep->desc) ||
 	    usb_endpoint_xfer_isoc(&host_ep->desc))
@@ -3302,8 +3305,10 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 	xhci_free_command(xhci, cfg_cmd);
 cleanup:
 	xhci_free_command(xhci, stop_cmd);
+	spin_lock_irqsave(&xhci->lock, flags);
 	if (ep->ep_state & EP_SOFT_CLEAR_TOGGLE)
 		ep->ep_state &= ~EP_SOFT_CLEAR_TOGGLE;
+	spin_unlock_irqrestore(&xhci->lock, flags);
 }
 
 static int xhci_check_streams_endpoint(struct xhci_hcd *xhci,
-- 
2.25.1

