Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC9238C686
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbhEUMbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:31:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5657 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhEUMbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:31:36 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fmm8D1NYGz1BPTy;
        Fri, 21 May 2021 20:27:24 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 20:30:11 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 20:30:11 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <agk@redhat.com>, <snitzer@redhat.com>, <dm-devel@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] dm btree: make symbol 'shadow_child' static
Date:   Fri, 21 May 2021 20:48:56 +0800
Message-ID: <1621601336-11279-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

drivers/md/persistent-data/dm-btree.c:696:5: warning:
 symbol 'shadow_child' was not declared. Should it be static?

This symbol is not used outside of dm-btree.c, so marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/md/persistent-data/dm-btree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/persistent-data/dm-btree.c b/drivers/md/persistent-data/dm-btree.c
index b8d21b6..a29bcb8 100644
--- a/drivers/md/persistent-data/dm-btree.c
+++ b/drivers/md/persistent-data/dm-btree.c
@@ -693,8 +693,10 @@ static int split_one_into_two(struct shadow_spine *s, unsigned parent_index,
  * child of the given parent node.  Making sure to update the parent to point
  * to the new shadow.
  */
-int shadow_child(struct dm_btree_info *info, struct dm_btree_value_type *vt,
-		 struct btree_node *parent, unsigned index, struct dm_block **result)
+static int shadow_child(struct dm_btree_info *info,
+			struct dm_btree_value_type *vt,
+			struct btree_node *parent,
+			unsigned index, struct dm_block **result)
 {
 	int r, inc;
 	dm_block_t root;
-- 
2.6.2

