Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B5A350F83
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhDAGx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:53:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15425 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhDAGx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:53:26 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F9v3s44KnzjXhh;
        Thu,  1 Apr 2021 14:51:37 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 14:53:13 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <yumeng18@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] Bluetooth: Remove 'return' in void function
Date:   Thu, 1 Apr 2021 14:50:38 +0800
Message-ID: <1617259839-31383-2-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617259839-31383-1-git-send-email-yumeng18@huawei.com>
References: <1617259839-31383-1-git-send-email-yumeng18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

void function return statements are not generally useful.

Signed-off-by: Meng Yu <yumeng18@huawei.com>
---
 net/bluetooth/6lowpan.c    | 2 --
 net/bluetooth/l2cap_core.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index cff4944..19f7e42 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -841,8 +841,6 @@ static void chan_close_cb(struct l2cap_chan *chan)
 	} else {
 		spin_unlock(&devices_lock);
 	}
-
-	return;
 }
 
 static void chan_state_change_cb(struct l2cap_chan *chan, int state, int err)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 56e1975..ccfe8ad 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -676,8 +676,6 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		skb_queue_purge(&chan->tx_q);
 		break;
 	}
-
-	return;
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_del);
 
-- 
2.8.1

