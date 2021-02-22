Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CE0321AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhBVO6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:58:19 -0500
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:25208 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhBVO6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 09:58:18 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea6033c64cc72-ebc28; Mon, 22 Feb 2021 22:57:16 +0800 (CST)
X-RM-TRANSID: 2eea6033c64cc72-ebc28
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.144.162])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16033c6477e4-d7395;
        Mon, 22 Feb 2021 22:57:16 +0800 (CST)
X-RM-TRANSID: 2ee16033c6477e4-d7395
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] net: tap: remove redundant assignments
Date:   Mon, 22 Feb 2021 22:57:48 +0800
Message-Id: <20210222145748.10496-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function tap_get_user, the assignment of 'err' at both places
is redundant, so remove one.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/net/tap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 1f4bdd944..3e9c72738 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -625,7 +625,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	struct tap_dev *tap;
 	unsigned long total_len = iov_iter_count(from);
 	unsigned long len = total_len;
-	int err;
+	int err = -EINVAL;
 	struct virtio_net_hdr vnet_hdr = { 0 };
 	int vnet_hdr_len = 0;
 	int copylen = 0;
@@ -636,7 +636,6 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	if (q->flags & IFF_VNET_HDR) {
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
-		err = -EINVAL;
 		if (len < vnet_hdr_len)
 			goto err;
 		len -= vnet_hdr_len;
@@ -657,7 +656,6 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 			goto err;
 	}
 
-	err = -EINVAL;
 	if (unlikely(len < ETH_HLEN))
 		goto err;
 
-- 
2.20.1.windows.1



