Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9B537095A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 01:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhEAXyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 19:54:52 -0400
Received: from h04.kommunity.net ([138.201.86.160]:56829 "EHLO
        h04.kommunity.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhEAXyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 19:54:51 -0400
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 May 2021 19:54:51 EDT
Received: from notebook.fritz.box (p4fc26c70.dip0.t-ipconnect.de [79.194.108.112])
        by h04.kommunity.net (Postfix) with ESMTPSA id 894F3F840C0;
        Sun,  2 May 2021 01:45:39 +0200 (CEST)
Authentication-Results: h04.kommunity.net;
        spf=pass (sender IP is 79.194.108.112) smtp.mailfrom=alec@vc-celle.de smtp.helo=notebook.fritz.box
Received-SPF: pass (h04.kommunity.net: connection is authenticated)
From:   Alexander Vorwerk <alec@vc-celle.de>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexander Vorwerk <alec@vc-celle.de>
Subject: [PATCH] staging: rtl8712: remove multiple multiple assignments
Date:   Sun,  2 May 2021 01:45:01 +0200
Message-Id: <20210501234501.5411-1-alec@vc-celle.de>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/process/coding-style.rst says (in line 88)
"Don't put multiple assignments on a single line either."

This patch fixes the coding style issue reported by checkpatch.pl.

Signed-off-by: Alexander Vorwerk <alec@vc-celle.de>
---
 drivers/staging/rtl8712/rtl8712_recv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index db5c7a487ab3..0ffb30f1af7e 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -1039,8 +1039,9 @@ static void recvbuf2recvframe(struct _adapter *padapter, struct sk_buff *pskb)
 		skb_reserve(pkt_copy, 4 - ((addr_t)(pkt_copy->data) % 4));
 		skb_reserve(pkt_copy, shift_sz);
 		memcpy(pkt_copy->data, pbuf, tmp_len);
-		precvframe->u.hdr.rx_head = precvframe->u.hdr.rx_data =
-			precvframe->u.hdr.rx_tail = pkt_copy->data;
+		precvframe->u.hdr.rx_head = pkt_copy->data;
+		precvframe->u.hdr.rx_data = pkt_copy->data;
+		precvframe->u.hdr.rx_tail = pkt_copy->data;
 		precvframe->u.hdr.rx_end = pkt_copy->data + alloc_sz;
 
 		recvframe_put(precvframe, tmp_len);
-- 
2.17.1

