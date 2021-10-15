Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1B542FE77
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243436AbhJOXA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 19:00:28 -0400
Received: from giacobini.uberspace.de ([185.26.156.129]:48180 "EHLO
        giacobini.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243422AbhJOXA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 19:00:27 -0400
Received: (qmail 988 invoked from network); 15 Oct 2021 22:51:36 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by giacobini.uberspace.de with SMTP; 15 Oct 2021 22:51:36 -0000
From:   Soenke Huster <soenke.huster@eknoes.de>
To:     soenke.huster@eknoes.de
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: virtio_bt: fix memory leak in virtbt_rx_handle()
Date:   Sat, 16 Oct 2021 00:50:48 +0200
Message-Id: <20211015225048.342949-1-soenke.huster@eknoes.de>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the reception of packets with a packet type that is not processed by
the virtbt driver, the memory of the allocated socket buffers is never
freed. Add a default case that frees these to avoid a memory leak.

Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
---
 drivers/bluetooth/virtio_bt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 57908ce4fae8..2de0f54ada73 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -202,6 +202,8 @@ static void virtbt_rx_handle(struct virtio_bluetooth *vbt, struct sk_buff *skb)
 		hci_skb_pkt_type(skb) = pkt_type;
 		hci_recv_frame(vbt->hdev, skb);
 		break;
+	default:
+		kfree_skb(skb);
 	}
 }
 
-- 
2.33.1

