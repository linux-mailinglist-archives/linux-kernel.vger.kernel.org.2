Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1011833C987
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 23:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhCOWzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 18:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhCOWzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 18:55:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CB6C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:55:06 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lLw6z-00Gf7T-Qu; Mon, 15 Mar 2021 23:54:57 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] gcov: simplify buffer allocation
Date:   Mon, 15 Mar 2021 23:54:54 +0100
Message-Id: <20210315235453.b6de4a92096e.Iac40a5166589cefbff8449e466bd1b38ea7a17af@changeid>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315235453.e3fbb86e99a0.I08a3ee6dbe47ea3e8024956083f162884a958e40@changeid>
References: <20210315235453.e3fbb86e99a0.I08a3ee6dbe47ea3e8024956083f162884a958e40@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Use just a single vmalloc() with struct_size() instead of
a separate kmalloc() for the iter struct.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 kernel/gcov/fs.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index 2d29e1d1225d..40ea81c0475b 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -97,9 +97,9 @@ __setup("gcov_persist=", gcov_persist_setup);
  */
 struct gcov_iterator {
 	struct gcov_info *info;
-	void *buffer;
 	size_t size;
 	loff_t pos;
+	char buffer[];
 };
 
 /**
@@ -111,25 +111,20 @@ struct gcov_iterator {
 static struct gcov_iterator *gcov_iter_new(struct gcov_info *info)
 {
 	struct gcov_iterator *iter;
+	size_t size;
+
+	/* Dry-run to get the actual buffer size. */
+	size = convert_to_gcda(NULL, info);
 
-	iter = kzalloc(sizeof(struct gcov_iterator), GFP_KERNEL);
+	iter = vmalloc(struct_size(iter, buffer, size));
 	if (!iter)
-		goto err_free;
+		return NULL;
 
 	iter->info = info;
-	/* Dry-run to get the actual buffer size. */
-	iter->size = convert_to_gcda(NULL, info);
-	iter->buffer = vmalloc(iter->size);
-	if (!iter->buffer)
-		goto err_free;
-
+	iter->size = size;
 	convert_to_gcda(iter->buffer, info);
 
 	return iter;
-
-err_free:
-	kfree(iter);
-	return NULL;
 }
 
 
@@ -139,8 +134,7 @@ static struct gcov_iterator *gcov_iter_new(struct gcov_info *info)
  */
 static void gcov_iter_free(struct gcov_iterator *iter)
 {
-	vfree(iter->buffer);
-	kfree(iter);
+	vfree(iter);
 }
 
 /**
-- 
2.30.2

