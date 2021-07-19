Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028473CD7F7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 17:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242489AbhGSOT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 10:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241833AbhGSOSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:18:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F0F561165;
        Mon, 19 Jul 2021 14:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626706759;
        bh=J0NENgAt31gVwc0onkPzAQ0JzvYd/SejmqA2j+3YpVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iXIPgiiRPYXKX5jtqJD6e2R1TsSWwnH92jS8skj7Xw56EJmYv8aKoHKdHdxYW5L9q
         BEeyUxfnYeu4Tzn+gvayTh7s15KUaQEW/ed5oPEVZlBVJek4GR7vlbW4a6Qe2FzSpT
         QrxPE/mfbUenRTJbQ7YW6tQhO2k7iel6vuJS4tK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 087/188] staging: gdm724x: check for overflow in gdm_lte_netif_rx()
Date:   Mon, 19 Jul 2021 16:51:11 +0200
Message-Id: <20210719144933.359140752@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719144913.076563739@linuxfoundation.org>
References: <20210719144913.076563739@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7002b526f4ff1f6da34356e67085caafa6be383a ]

This code assumes that "len" is at least 62 bytes, but we need a check
to prevent a read overflow.

Fixes: 61e121047645 ("staging: gdm7240: adding LTE USB driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/YMcoTPsCYlhh2TQo@mwanda
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/gdm724x/gdm_lte.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_lte.c b/drivers/staging/gdm724x/gdm_lte.c
index 1eacf82d1bd0..8561f7fb53e9 100644
--- a/drivers/staging/gdm724x/gdm_lte.c
+++ b/drivers/staging/gdm724x/gdm_lte.c
@@ -624,10 +624,12 @@ static void gdm_lte_netif_rx(struct net_device *dev, char *buf,
 						  * bytes (99,130,83,99 dec)
 						  */
 			} __packed;
-			void *addr = buf + sizeof(struct iphdr) +
-				sizeof(struct udphdr) +
-				offsetof(struct dhcp_packet, chaddr);
-			ether_addr_copy(nic->dest_mac_addr, addr);
+			int offset = sizeof(struct iphdr) +
+				     sizeof(struct udphdr) +
+				     offsetof(struct dhcp_packet, chaddr);
+			if (offset + ETH_ALEN > len)
+				return;
+			ether_addr_copy(nic->dest_mac_addr, buf + offset);
 		}
 	}
 
-- 
2.30.2



