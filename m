Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D337D3AB3C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhFQMk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:40:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47819 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhFQMkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:40:35 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1ltrHu-0000mh-Fr; Thu, 17 Jun 2021 12:38:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: host: u132-hcd: remove redundant continue statements
Date:   Thu, 17 Jun 2021 13:38:26 +0100
Message-Id: <20210617123826.13764-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are continue statements at the end of loops that have
no effect and are redundant. Remove them.

Addresses-Coverity: ("Continue has no effect")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/host/u132-hcd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index 5a783c423d8e..ae882d76612b 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -2392,8 +2392,7 @@ static int dequeue_from_overflow_chain(struct u132 *u132,
 			urb->error_count = 0;
 			usb_hcd_giveback_urb(hcd, urb, 0);
 			return 0;
-		} else
-			continue;
+		}
 	}
 	dev_err(&u132->platform_dev->dev, "urb=%p not found in endp[%d]=%p ring"
 		"[%d] %c%c usb_endp=%d usb_addr=%d size=%d next=%04X last=%04X"
@@ -2448,8 +2447,7 @@ static int u132_endp_urb_dequeue(struct u132 *u132, struct u132_endp *endp,
 				urb_slot = &endp->urb_list[ENDP_QUEUE_MASK &
 					queue_scan];
 				break;
-			} else
-				continue;
+			}
 		}
 		while (++queue_list < ENDP_QUEUE_SIZE && --queue_size > 0) {
 			*urb_slot = endp->urb_list[ENDP_QUEUE_MASK &
-- 
2.31.1

