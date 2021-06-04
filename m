Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C74239C0F0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhFDUB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:01:59 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:57062 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhFDUB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:01:57 -0400
Received: by mail-yb1-f202.google.com with SMTP id m205-20020a25d4d60000b029052a8de1fe41so13098186ybf.23
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 13:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wt2qxnxy/b8IZ2QO+GAswkwuO0WmiwjICqpUWuqeT7k=;
        b=BfgL5Q+yv1Gzkf9o/f8X1rtUSSA6murv+6sH8j0ykCJia1piKw55urpOJDjgFIA3d/
         w5f5IcTOuWS+JBGTk+bguWV5C12rMZXZtB0xm7lZDCQUJOpo3W/o3HhYzRCz+j3nd4Na
         2MG4BJwFIlnlVeOPF1RTCXrVb+lxsdrYUGneWMEAB5qYNO9WJg90ztm3pH6jIb1q9pRB
         y8gfQ8jdWPSXMskZmMcnFpdu5RwSp207haB+zUlq0h3mhcegzHaqlHMHliNz9P6/0j9b
         nH0IJycwD2kbfSUwzBN/MhBwvwxPBtL6vmgkKmEvT4RMFHgdXsacye8S76Y6+Yqvmgn/
         14Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wt2qxnxy/b8IZ2QO+GAswkwuO0WmiwjICqpUWuqeT7k=;
        b=Ahc7J8/1jXOmDy8nnu9/tFULMfJl9FHTL5MUZAtgZFgcrGEaje249pYWED5icRQVHh
         bCTX8mvbMhrVMf1lswaySH6KR0+U6ZJfvHH/ZwTp3GZB0FLeEK1DJioCqDybw+5RDBEN
         4T/8q6bU4RiNHoXRPnFf6CzqnJxIxTuSAzAxhsvYrFRS/JoAz1l85mq6v0ikqevT+m6c
         Bn5DAGtTt0LoBCAPyFHEvBGv823A3oJ//fskwoPnz/8q+Ljg3M/0Cq7u86OUUjpucusk
         xp0TdJJctP2Js4QiosnBaFT/fN0IYYGUo52qeqUilUzI34FEpSBCtZIPLFfg8cNxgvGI
         2J9g==
X-Gm-Message-State: AOAM533KcHeWdhh7YkYGU5iLQC/TeCiqLftu+i6KMaFf/8tEOgXwb8pM
        +9m0D5xPQr3RZOW/S1MsvdLevLCv03g=
X-Google-Smtp-Source: ABdhPJyLk0AvyZyFGRqqG2Cq3AZd0VBGrOlLaB7qb3b7G+q4lx5yzm3JQXDwZUkv/saaoV5YgDjx1rjc46E=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a05:6902:1343:: with SMTP id
 g3mr7100296ybu.283.1622836750940; Fri, 04 Jun 2021 12:59:10 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:58:51 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-2-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 01/10] block: introduce blk_ksm_is_empty()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function checks if a given keyslot manager supports any encryption
mode/data unit size combination (and returns true if there is no such
supported combination). Helps clean up code a little.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/keyslot-manager.c         | 21 +++++++++++++++++++++
 drivers/md/dm-table.c           | 11 +----------
 include/linux/keyslot-manager.h |  2 ++
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 2c4a55bea6ca..88211581141a 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -437,6 +437,27 @@ void blk_ksm_destroy(struct blk_keyslot_manager *ksm)
 }
 EXPORT_SYMBOL_GPL(blk_ksm_destroy);
 
+/**
+ * blk_ksm_is_empty() - Checks if the keyslot manager has any crypto
+ *			capabilities at all.
+ * @ksm: The input keyslot manager to check
+ *
+ * Return: true if @ksm doesn't have any crypto capabilities at all, and
+ *	   false otherwise.
+ */
+bool blk_ksm_is_empty(struct blk_keyslot_manager *ksm)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ksm->crypto_modes_supported); i++) {
+		if (ksm->crypto_modes_supported[i])
+			return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_ksm_is_empty);
+
 bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q)
 {
 	if (blk_integrity_queue_supports_integrity(q)) {
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index ee47a332b462..29cbfc3e3c4b 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1295,7 +1295,6 @@ static int dm_table_construct_keyslot_manager(struct dm_table *t)
 	struct blk_keyslot_manager *ksm;
 	struct dm_target *ti;
 	unsigned int i;
-	bool ksm_is_empty = true;
 
 	dksm = kmalloc(sizeof(*dksm), GFP_KERNEL);
 	if (!dksm)
@@ -1332,15 +1331,7 @@ static int dm_table_construct_keyslot_manager(struct dm_table *t)
 	 * If the new KSM doesn't actually support any crypto modes, we may as
 	 * well represent it with a NULL ksm.
 	 */
-	ksm_is_empty = true;
-	for (i = 0; i < ARRAY_SIZE(ksm->crypto_modes_supported); i++) {
-		if (ksm->crypto_modes_supported[i]) {
-			ksm_is_empty = false;
-			break;
-		}
-	}
-
-	if (ksm_is_empty) {
+	if (blk_ksm_is_empty(ksm)) {
 		dm_destroy_keyslot_manager(ksm);
 		ksm = NULL;
 	}
diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
index a27605e2f826..0f09b4f310f7 100644
--- a/include/linux/keyslot-manager.h
+++ b/include/linux/keyslot-manager.h
@@ -106,6 +106,8 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm);
 
 void blk_ksm_destroy(struct blk_keyslot_manager *ksm);
 
+bool blk_ksm_is_empty(struct blk_keyslot_manager *ksm);
+
 void blk_ksm_intersect_modes(struct blk_keyslot_manager *parent,
 			     const struct blk_keyslot_manager *child);
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

