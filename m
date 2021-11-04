Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FAC444DE1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 05:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhKDEJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 00:09:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14713 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhKDEJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 00:09:07 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hl94h1yzqzZckp;
        Thu,  4 Nov 2021 12:04:20 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 12:06:16 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 12:06:16 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>,
        <wubo40@huawei.com>
Subject: [PATCH RESEND] nbd: code clean for nbd_genl_status()
Date:   Thu, 4 Nov 2021 12:38:23 +0800
Message-ID: <1636000703-13217-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A simple code clean for nbd_genl_status()

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/block/nbd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b47b2a8..175ea97 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2375,7 +2375,6 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	reply_head = genlmsg_put_reply(reply, info, &nbd_genl_family, 0,
 				       NBD_CMD_STATUS);
 	if (!reply_head) {
-		nlmsg_free(reply);
 		goto out;
 	}
 
@@ -2383,7 +2382,6 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	if (index == -1) {
 		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
 		if (ret) {
-			nlmsg_free(reply);
 			goto out;
 		}
 	} else {
@@ -2392,7 +2390,6 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 		if (nbd) {
 			ret = populate_nbd_status(nbd, reply);
 			if (ret) {
-				nlmsg_free(reply);
 				goto out;
 			}
 		}
@@ -2401,6 +2398,8 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	genlmsg_end(reply, reply_head);
 	ret = genlmsg_reply(reply, info);
 out:
+	if (reply)
+		nlmsg_free(reply);
 	mutex_unlock(&nbd_index_mutex);
 	return ret;
 }
-- 
1.8.3.1

