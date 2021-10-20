Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343F243469D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhJTIRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:17:31 -0400
Received: from giacobini.uberspace.de ([185.26.156.129]:52614 "EHLO
        giacobini.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhJTIRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:17:22 -0400
Received: (qmail 18277 invoked from network); 20 Oct 2021 08:15:01 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by giacobini.uberspace.de with SMTP; 20 Oct 2021 08:15:01 -0000
From:   Soenke Huster <soenke.huster@eknoes.de>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Soenke Huster <soenke.huster@eknoes.de>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: virtio_bt: fix memory leak in virtbt_rx_handle()
Date:   Wed, 20 Oct 2021 10:14:44 +0200
Message-Id: <20211020081444.37324-1-soenke.huster@eknoes.de>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the reception of packets with an invalid packet type, the memory of
the allocated socket buffers is never freed. Add a default case that frees
these to avoid a memory leak.

Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
---
Changes in v2:
  - Add break; to default case

 drivers/bluetooth/virtio_bt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 57908ce4fae8..076e4942a3f0 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -202,6 +202,9 @@ static void virtbt_rx_handle(struct virtio_bluetooth *vbt, struct sk_buff *skb)
 		hci_skb_pkt_type(skb) = pkt_type;
 		hci_recv_frame(vbt->hdev, skb);
 		break;
+	default:
+		kfree_skb(skb);
+		break;
 	}
 }
 
-- 
2.33.1

