Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83892406FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhIJQcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:32:46 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:54002
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229466AbhIJQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:32:44 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 976383F101;
        Fri, 10 Sep 2021 16:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631291491;
        bh=SR/L81JLSKAhEZz9JdeEM0yZ2Mf/QE9vSWMfGM29XLU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=SCAutQJgieEvjtpMnChcEbzq7MCNQYwawe3bHLU86u34K3QWQToGNILjcW0q0HM4A
         kBZSpBolesjniZxMv1WCys0siNARFQcgvtp4MYWp6aeTWDVe3PK7uiQ5Uq+5lQ9yfE
         4ERsHH0g0knm5eq6mN6vW5wG6kq40AVqPdQb14ch87iESJrWMkDu/p/KsHezRiCW8j
         IYC3GMV0BCZt/f5LJAIyw7QaY3COYHN2ZEpH4Z9IKmdOZLYq8bPyPQK/LeUYKT5saE
         D5L3x9ZqPVqs9ZY2X+TqzZu/gm592nSeXqxo7c6LHW6lmwuY5od1U2FZLDSVYvhKoQ
         ggMQWkxrebxzQ==
From:   Colin King <colin.king@canonical.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Evgeny Novikov <novikov@ispras.ru>, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: goku_udc: Fix mask and set operation on variable master
Date:   Fri, 10 Sep 2021 17:31:31 +0100
Message-Id: <20210910163131.94796-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable master is being masked with ~MST_R_BITS however this
masked value is never used, the following updates to master are
assignments. I suspect the original intention was to mask out the
MST_R_BITS and then bit-wise or in the appropriate read bits rather
than perform an assignment. Fix this by using the |= operator rather
than a straight assignment.

Note that this code is pre-git history, so I can't find a sha for
it.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/gadget/udc/goku_udc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
index 3e1267d38774..3757a772a55e 100644
--- a/drivers/usb/gadget/udc/goku_udc.c
+++ b/drivers/usb/gadget/udc/goku_udc.c
@@ -553,12 +553,12 @@ static int start_dma(struct goku_ep *ep, struct goku_request *req)
 
 		master &= ~MST_R_BITS;
 		if (unlikely(req->req.length == 0))
-			master = MST_RD_ENA | MST_RD_EOPB;
+			master |= MST_RD_ENA | MST_RD_EOPB;
 		else if ((req->req.length % ep->ep.maxpacket) != 0
 					|| req->req.zero)
-			master = MST_RD_ENA | MST_EOPB_ENA;
+			master |= MST_RD_ENA | MST_EOPB_ENA;
 		else
-			master = MST_RD_ENA | MST_EOPB_DIS;
+			master |= MST_RD_ENA | MST_EOPB_DIS;
 
 		ep->dev->int_enable |= INT_MSTRDEND;
 
-- 
2.32.0

