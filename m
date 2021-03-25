Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF73349B98
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhCYV1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhCYV1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:27:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50157C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:27:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g9so7527149ybc.19
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rUphNMT0sm87MpzUiuuClzpcMsplrJctbX+7T7BgcBI=;
        b=Z31KaBaf0F337eZVWuVD1HT4Uu9KPoH0PgSCulKvd0aw1lTRFmeEoIvqKRdGQlpyJc
         SLuEh9pdLGtSpPxur46IC4+LS7M9Q7wee5WpMQRBGYkwc6nV9Q1GZsnByKYAabF+jL1/
         JLAj3p8JSxlCOcKbzqJdczpXcGH3dtgVD+waeRvSCaiKXMeapuNi/XaBwSLLSLJ5pzXb
         qF0hzvaRThCKTBQ5T51EPvZGzDjfrscM9URatMIoj3CPBmomNb63SniIDZLtzW3FHVTP
         mgtkrjGzTQ+B4PgLCPy3OlY81rzufDO8KFrcYyB9ZxWC6U4GyyzGj4UECEGmLtlSUm7T
         CC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rUphNMT0sm87MpzUiuuClzpcMsplrJctbX+7T7BgcBI=;
        b=XOUVxOMKL/SjjtndTFpmD1tuVPJ4BiCW4PIj8vepEbta51cYCW1Rbv6/reD+ucroan
         iTZGaSS4TmHcTcWv2LOZwVWQjsiNLRvhPnTtTDdOTCVfRb2WrKhOCFCGuaRGGfTE2K+9
         pOfeznPFYTfO/N6I1JPxE123dM1g+fZj467EqZZhXPShnMS4b57YJqRxVl52ecuE2UcD
         xSuMkhD4GPbBa8I+2gOoRW7mWbNPNQaZyqtVIxitQUZkmb3oMnKrNgRA+n69rBsjAHOO
         Eqe1fZDikSiXbolWhWBpeUIkRN+tfclUXDtQFH4zSPja+tIWSKiP9TWrQ3iUQvD8swwd
         Q5Cg==
X-Gm-Message-State: AOAM5312V4HYABhgFMLLVQpQJkIWOrVlm4PjGsgg5C1SMqhy6ikghoJi
        eh5WVC3QXjqMOS1HLvX1YwIZqkFqFcc=
X-Google-Smtp-Source: ABdhPJxSUh4OHNl49f7VKbtAYjTnF/4KPwbp5X+5mw42hAO4X6wZpuWATUzKmo0HV+mNi0+WWXp4fnPoamM=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:d451:: with SMTP id m78mr8877781ybf.105.1616707630557;
 Thu, 25 Mar 2021 14:27:10 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:26:02 +0000
In-Reply-To: <20210325212609.492188-1-satyat@google.com>
Message-Id: <20210325212609.492188-2-satyat@google.com>
Mime-Version: 1.0
References: <20210325212609.492188-1-satyat@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 1/8] block: introduce blk_ksm_is_empty()
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
 block/keyslot-manager.c         | 13 +++++++++++++
 drivers/md/dm-table.c           | 11 +----------
 include/linux/keyslot-manager.h |  2 ++
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 2c4a55bea6ca..2a2b1a9785d2 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -437,6 +437,19 @@ void blk_ksm_destroy(struct blk_keyslot_manager *ksm)
 }
 EXPORT_SYMBOL_GPL(blk_ksm_destroy);
 
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
index 95391f78b8d5..db18a58adad7 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1313,7 +1313,6 @@ static int dm_table_construct_keyslot_manager(struct dm_table *t)
 	struct blk_keyslot_manager *ksm;
 	struct dm_target *ti;
 	unsigned int i;
-	bool ksm_is_empty = true;
 
 	dksm = kmalloc(sizeof(*dksm), GFP_KERNEL);
 	if (!dksm)
@@ -1350,15 +1349,7 @@ static int dm_table_construct_keyslot_manager(struct dm_table *t)
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
index a27605e2f826..5bf0cea20c81 100644
--- a/include/linux/keyslot-manager.h
+++ b/include/linux/keyslot-manager.h
@@ -117,4 +117,6 @@ bool blk_ksm_is_superset(struct blk_keyslot_manager *ksm_superset,
 void blk_ksm_update_capabilities(struct blk_keyslot_manager *target_ksm,
 				 struct blk_keyslot_manager *reference_ksm);
 
+bool blk_ksm_is_empty(struct blk_keyslot_manager *ksm);
+
 #endif /* __LINUX_KEYSLOT_MANAGER_H */
-- 
2.31.0.291.g576ba9dcdaf-goog

