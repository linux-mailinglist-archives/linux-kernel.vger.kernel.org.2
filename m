Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA480388AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345699AbhESJev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345517AbhESJek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:34:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EC39613B6;
        Wed, 19 May 2021 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621416801;
        bh=G2bnh5nE7hbat+QYz2Xh6rd4kVjoC2IxjGFfgdqYVVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CX4Jh/C4SOqNtMp/Aa2Naavlg0W1EbXl5QRxrsq4g5GM4Dch2iBhaFEdJ1OFQbHjB
         bMOyQD4BBUknEGUVTXZNtkQBkBPZEqzuIMIZP9HPh2rLrtykFgkKyQhXTzAopUoueM
         5jNwNV3G3mxGyMMCQOIkX3u431O0Z+FNheUYG188rxtjvOyyoEJ4ebhDOpwIlOt2Dl
         5+we6MNxrkC+LlUPJKr6ocoTz4vMf9vYOyr2GccQfm1JNIPv8W/lfCJ39z6Zz5aZ9Z
         QqhwbvI+VGopHG3ARM4HGBacdt/wCC0PqqUgriJ3dv5ZHMZFsxcmIaHzgnDmXGH11M
         FyrL0EeP3g+uA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ljIZs-0002pS-Uc; Wed, 19 May 2021 11:33:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 1/3] USB: cdnsp: drop irq-flags initialisations
Date:   Wed, 19 May 2021 11:33:01 +0200
Message-Id: <20210519093303.10789-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210519093303.10789-1-johan@kernel.org>
References: <20210519093303.10789-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to initialise irq-flags variables before saving the
interrupt state.

Cc: Pawel Laszczak <pawell@cadence.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/cdns3/cdnsp-gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 56707b6b0f57..4fddc78f732f 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1151,7 +1151,7 @@ static int cdnsp_gadget_ep_set_halt(struct usb_ep *ep, int value)
 	struct cdnsp_ep *pep = to_cdnsp_ep(ep);
 	struct cdnsp_device *pdev = pep->pdev;
 	struct cdnsp_request *preq;
-	unsigned long flags = 0;
+	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&pdev->lock, flags);
@@ -1176,7 +1176,7 @@ static int cdnsp_gadget_ep_set_wedge(struct usb_ep *ep)
 {
 	struct cdnsp_ep *pep = to_cdnsp_ep(ep);
 	struct cdnsp_device *pdev = pep->pdev;
-	unsigned long flags = 0;
+	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&pdev->lock, flags);
-- 
2.26.3

