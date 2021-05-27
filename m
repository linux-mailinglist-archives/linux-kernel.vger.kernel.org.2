Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158A0392C93
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhE0LYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:24:03 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2371 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhE0LXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:23:52 -0400
Received: from dggeml765-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FrQL62R6Kz663t;
        Thu, 27 May 2021 19:18:38 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggeml765-chm.china.huawei.com (10.1.199.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 19:22:16 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 19:22:15 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <stefanr@s5r6.in-berlin.de>, <yoshfuji@linux-ipv6.org>,
        <davem@davemloft.net>
CC:     <linux1394-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH] firewire: net: Remove unused variable 'dev' and 'guid'
Date:   Thu, 27 May 2021 19:31:40 +0800
Message-ID: <20210527113140.304008-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/firewire/net.c:491:23: warning: variable ‘dev’ set but not used
[-Wunused-but-set-variable]

Fixes: 6752c8db8e0cf ("firewire net, ipv4 arp: Extend hardware ...")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
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
2.25.4

