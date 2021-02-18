Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC4C31EB64
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 16:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhBRPQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 10:16:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12980 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhBRMXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:23:49 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DhDL91Km1zjNbT;
        Thu, 18 Feb 2021 20:20:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 18 Feb 2021
 20:21:23 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <Markus.Elfring@web.de>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <sunke32@huawei.com>
Subject: [PATCH v6 2/2] nbd: share nbd_put and return by goto put_nbd
Date:   Thu, 18 Feb 2021 07:26:20 -0500
Message-ID: <20210218122620.228375-3-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210218122620.228375-1-sunke32@huawei.com>
References: <20210218122620.228375-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the following two statements by the statement “goto put_nbd;”

	nbd_put(nbd);
	return 0;

Suggested-by: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 drivers/block/nbd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 403c1e1fe748..10cbb5caad07 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2027,12 +2027,11 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 	mutex_unlock(&nbd_index_mutex);
-	if (!refcount_inc_not_zero(&nbd->config_refs)) {
-		nbd_put(nbd);
-		return 0;
-	}
+	if (!refcount_inc_not_zero(&nbd->config_refs))
+		goto put_nbd;
 	nbd_disconnect_and_put(nbd);
 	nbd_config_put(nbd);
+put_nbd:
 	nbd_put(nbd);
 	return 0;
 }
-- 
2.25.4

