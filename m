Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FC936D42D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbhD1IpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:45:08 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:41878 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbhD1IpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:45:06 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d23 with ME
        id y8kL2400621Fzsu038kLjb; Wed, 28 Apr 2021 10:44:20 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 28 Apr 2021 10:44:20 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] quota: Use 'hlist_for_each_entry' to simplify code
Date:   Wed, 28 Apr 2021 10:44:19 +0200
Message-Id: <f82d3e33964dcbd2aac19866735e0a8381c8a735.1619599407.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'hlist_for_each_entry' instead of hand writing it.
This saves a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 fs/quota/dquot.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 4f1373463766..22d904bde6ab 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -288,14 +288,12 @@ static inline void remove_dquot_hash(struct dquot *dquot)
 static struct dquot *find_dquot(unsigned int hashent, struct super_block *sb,
 				struct kqid qid)
 {
-	struct hlist_node *node;
 	struct dquot *dquot;
 
-	hlist_for_each (node, dquot_hash+hashent) {
-		dquot = hlist_entry(node, struct dquot, dq_hash);
+	hlist_for_each_entry(dquot, dquot_hash+hashent, dq_hash)
 		if (dquot->dq_sb == sb && qid_eq(dquot->dq_id, qid))
 			return dquot;
-	}
+
 	return NULL;
 }
 
-- 
2.30.2

