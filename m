Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1AC3803FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhENHHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:07:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2918 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhENHHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:07:11 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FhKHT2njszBsGN;
        Fri, 14 May 2021 15:03:17 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.98) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Fri, 14 May 2021 15:05:54 +0800
From:   Pu Lehui <pulehui@huawei.com>
To:     <stefanr@s5r6.in-berlin.de>
CC:     <linux1394-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <pulehui@huawei.com>
Subject: [PATCH -next] firewire: net: remove unused variable 'guid'
Date:   Fri, 14 May 2021 15:06:21 +0800
Message-ID: <20210514070621.73356-1-pulehui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.98]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC reports the following warning with W=1:

drivers/firewire/net.c:493:9: warning:
 variable ‘guid’ set but not used [-Wunused-but-set-variable]
  493 |  __be64 guid;
      |         ^~~~

This variable is not used in function , this commit
remove it to fix the warning.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 drivers/firewire/net.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index 715e491dfbc3..4c3fd2eed1da 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -488,9 +488,7 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 					struct sk_buff *skb, u16 source_node_id,
 					bool is_broadcast, u16 ether_type)
 {
-	struct fwnet_device *dev;
 	int status;
-	__be64 guid;
 
 	switch (ether_type) {
 	case ETH_P_ARP:
@@ -503,7 +501,6 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 		goto err;
 	}
 
-	dev = netdev_priv(net);
 	/* Write metadata, and then pass to the receive level */
 	skb->dev = net;
 	skb->ip_summed = CHECKSUM_NONE;
@@ -512,7 +509,6 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 	 * Parse the encapsulation header. This actually does the job of
 	 * converting to an ethernet-like pseudo frame header.
 	 */
-	guid = cpu_to_be64(dev->card->guid);
 	if (dev_hard_header(skb, net, ether_type,
 			   is_broadcast ? net->broadcast : net->dev_addr,
 			   NULL, skb->len) >= 0) {
-- 
2.17.1

