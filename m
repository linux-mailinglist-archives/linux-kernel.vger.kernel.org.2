Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E069D3970AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhFAJyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:54:44 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3317 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhFAJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:54:41 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FvS5Z0zdKz1BGV9;
        Tue,  1 Jun 2021 17:48:18 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 17:52:58 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 17:52:58 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, <dm-devel@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next] dm btree: shadow_child leaves unchecked in split_two_into_three
Date:   Tue, 1 Jun 2021 18:02:18 +0800
Message-ID: <20210601100218.69842-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function shadow_child() leaves variable 'r' unchecked in
split_two_into_three when parent_index not equals to 0.
It's also not coordinate with above relative codes.

Fixes: dee29bf9192b ("dm btree: improve btree residency")
Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 drivers/md/persistent-data/dm-btree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/persistent-data/dm-btree.c b/drivers/md/persistent-data/dm-btree.c
index 3e5a90580427..0703ca7a7d9a 100644
--- a/drivers/md/persistent-data/dm-btree.c
+++ b/drivers/md/persistent-data/dm-btree.c
@@ -743,8 +743,10 @@ static int split_two_into_three(struct shadow_spine *s, unsigned parent_index,
 			return r;
 	} else {
 		middle_index = parent_index;
-		r = shadow_child(s->info, vt, pn, parent_index - 1, &left);
 		right = shadow_current(s);
+		r = shadow_child(s->info, vt, pn, parent_index - 1, &left);
+		if (r)
+			return r;
 	}
 
 	r = new_block(s->info, &middle);
-- 
2.18.0.huawei.25

