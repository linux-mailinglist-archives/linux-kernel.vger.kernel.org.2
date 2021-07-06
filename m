Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BFC3BD2F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 13:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbhGFLqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 07:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236602AbhGFLfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 07:35:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20BC761E35;
        Tue,  6 Jul 2021 11:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625570628;
        bh=gQvJRFM6NdQV4GzQ2npWN1NIBM9y32kxi3ccaS/EeTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbHTpCgR8+xvn1jOMO05Hk6NechPhQE9dHdghJFj6O53JrpTorayJK4fY7ws5xGvq
         kfavetgcsenLdAUS0xSj42GE0wLu9cxpr2wIgJXXgmrGyiBG4BUrtjagubdQOE5oxO
         ZfJaJjkahFIyccTQp2KNm/687v1nH6aNk8k8zoUjihK3m7C04riB9a+/rmljHGTw2q
         9vzVWKjhl9cJwiEVFf2hugceR+R77vVskKSJaMQaQ+8t2JJ2WW3xW97qmT0kv2VMm1
         aaXrgGcW+alcf/CXxVTCJVXuviwrF+fqbx4t+V+9zHEbYsUp1aQfjq1VUVTDtzD+8t
         vjvYhlHpDTFxg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>, dm-devel@redhat.com
Subject: [PATCH AUTOSEL 5.10 081/137] dm writecache: commit just one block, not a full page
Date:   Tue,  6 Jul 2021 07:21:07 -0400
Message-Id: <20210706112203.2062605-81-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706112203.2062605-1-sashal@kernel.org>
References: <20210706112203.2062605-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 991bd8d7bc78966b4dc427b53a144f276bffcd52 ]

Some architectures have pages larger than 4k and committing a full
page causes needless overhead.

Fix this by writing a single block when committing the superblock.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-writecache.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 64c2980aaa54..894b58bbe56e 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -532,11 +532,7 @@ static void ssd_commit_superblock(struct dm_writecache *wc)
 
 	region.bdev = wc->ssd_dev->bdev;
 	region.sector = 0;
-	region.count = PAGE_SIZE >> SECTOR_SHIFT;
-
-	if (unlikely(region.sector + region.count > wc->metadata_sectors))
-		region.count = wc->metadata_sectors - region.sector;
-
+	region.count = wc->block_size >> SECTOR_SHIFT;
 	region.sector += wc->start_sector;
 
 	req.bi_op = REQ_OP_WRITE;
-- 
2.30.2

