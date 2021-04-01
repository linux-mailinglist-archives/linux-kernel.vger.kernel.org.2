Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A96C351278
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhDAJhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbhDAJhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:37:11 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A8EC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:37:11 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m11so1014548pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mcgJPI+OLnXKS6f2jEHdXibOScXid3UD2wHpcMZsYC8=;
        b=XXHnwjtjUIXHglDE8sYs3uix5dsEwoiOr126fLR+uD3MRWnDxS5mXundRMl6oyKp8G
         0BLCnAd0wZdUTDQv56WayLebeE+LCDZkat3P2QE/0k4sHmu8NBn0RGQRL6DskgayhEpO
         f7OYOJq4cZf1cTx/cZ9d26eS+5jXRdj/j6OunAYDgBQsW3YFdnLcJadkiiuoPIQepTQz
         SejeuXsZq8aFLT/CMxOee3LtDWYILC+Tl5e/mZ9gSpTzd8IItpg22a7lTIMUfH+6YlmD
         ZyTzP9SIX/AQO1VFFJHw8ibEa1T0YPK9AzIhi9n+n+HwhvxGAX+4pSKt25A/Ehm2YWml
         n8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mcgJPI+OLnXKS6f2jEHdXibOScXid3UD2wHpcMZsYC8=;
        b=NKFWWW+tZ/d5+oKzpCAL6qHJbKa74R8kc+C3SOtaTYA2nOkfH/xTHmY2hpe5Xaj1cq
         UOehs/4nm6aJy/7dy7M/EC+QbknBJwB+R0t7/Dosjwzl5IOflkZw/SSXguR9fi28YjQU
         jKDiAXFieFGtIF63ieAAq2niKNXO1lOJAZyh1v6xIxiIKZMQIvxJZFx1pPL5wc21jqQB
         Iul8PSBMawpoyuckQBC+I1CReMAQfu7UnB7omwQryjC0uf3islIyp1Sa27oDO0C4gNCK
         d6vcYROlB+Qw4+E3RVzQF7qdu6S7A8EK4XAs38/rW+9fB+brI0EdSZyqerfhW1POW40k
         Dknw==
X-Gm-Message-State: AOAM5336W3IZUf94u3wn56eCfd5XEhedI+89RTwIyGUYNjmPc4KJnstn
        8cIUZGa1MNzPRWNK7uuRhH/4Iw==
X-Google-Smtp-Source: ABdhPJxkfP7QA7T16arIV78STn7cljX0N93gxkGF9gMmDTfxUDZogi1r5p1jZl2QT4ir2ZVOhGGaSQ==
X-Received: by 2002:a65:4c43:: with SMTP id l3mr6637800pgr.327.1617269831183;
        Thu, 01 Apr 2021 02:37:11 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id h13sm4710189pjv.52.2021.04.01.02.37.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Apr 2021 02:37:10 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     viro@zeniv.linux.org.uk, tj@kernel.org, axboe@fb.com,
        willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] writeback: fix obtain a reference to a freeing memcg css
Date:   Thu,  1 Apr 2021 17:33:43 +0800
Message-Id: <20210401093343.51299-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The caller of wb_get_create() should pin the memcg, because
wb_get_create() relies on this guarantee. The rcu read lock
only can guarantee that the memcg css returned by css_from_id()
cannot be released, but the reference of the memcg can be zero.
Fix it by holding a reference to the css before calling
wb_get_create(). This is not a problem I encountered in the
real world. Just the result of a code review.

And it is unnecessary to use GFP_ATOMIC, so replace it with
GFP_NOIO.

Fixes: 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb transaction and use it for stat updates")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
Changelog in v2:
 1. Replace GFP_ATOMIC with GFP_NOIO suggested by Matthew.

 fs/fs-writeback.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e91980f49388..df7f89f8f771 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -501,16 +501,21 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	if (atomic_read(&isw_nr_in_flight) > WB_FRN_MAX_IN_FLIGHT)
 		return;
 
-	isw = kzalloc(sizeof(*isw), GFP_ATOMIC);
+	isw = kzalloc(sizeof(*isw), GFP_NOIO);
 	if (!isw)
 		return;
 
 	/* find and pin the new wb */
 	rcu_read_lock();
 	memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
-	if (memcg_css)
-		isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+	if (memcg_css && !css_tryget(memcg_css))
+		memcg_css = NULL;
 	rcu_read_unlock();
+	if (!memcg_css)
+		goto out_free;
+
+	isw->new_wb = wb_get_create(bdi, memcg_css, GFP_NOIO);
+	css_put(memcg_css);
 	if (!isw->new_wb)
 		goto out_free;
 
-- 
2.11.0

