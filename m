Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B16333399
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhCJDHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:07:12 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:51270 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhCJDGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:06:53 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id BBA8E4000A4;
        Wed, 10 Mar 2021 11:06:51 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] net: ethernet: chelsiofix: spelling typo of 'rewriteing'
Date:   Wed, 10 Mar 2021 11:06:46 +0800
Message-Id: <1615345606-1799-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSk1ITUtCQ0kaS0MeVkpNSk5IT05NSklLTkhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NQg6Pgw4HT8TPQ0WDy1WLxEC
        Nx4KCxhVSlVKTUpOSE9OTUpJT0lKVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTUxLNwY+
X-HM-Tid: 0a781a19f4bdd991kuwsbba8e4000a4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rewriteing -> rewriting

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
index 83b4644..b1cae5a
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
@@ -979,7 +979,7 @@ void clear_filter(struct adapter *adap, struct filter_entry *f)
 {
 	struct port_info *pi = netdev_priv(f->dev);
 
-	/* If the new or old filter have loopback rewriteing rules then we'll
+	/* If the new or old filter have loopback rewriting rules then we'll
 	 * need to free any existing L2T, SMT, CLIP entries of filter
 	 * rule.
 	 */
-- 
2.7.4

