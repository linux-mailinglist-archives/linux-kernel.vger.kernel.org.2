Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEF833C988
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 23:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhCOWzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 18:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhCOWzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 18:55:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5999EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:55:06 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lLw70-00Gf7T-3L; Mon, 15 Mar 2021 23:54:58 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] gcov: use kvmalloc()
Date:   Mon, 15 Mar 2021 23:54:55 +0100
Message-Id: <20210315235453.799e7a9d627d.I741d0db096c6f312910f7f1bcdfde0fda20801a4@changeid>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315235453.e3fbb86e99a0.I08a3ee6dbe47ea3e8024956083f162884a958e40@changeid>
References: <20210315235453.e3fbb86e99a0.I08a3ee6dbe47ea3e8024956083f162884a958e40@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Using vmalloc() in gcov is really quite wasteful, many of the
objects allocated are really small (e.g. I've seen 24 bytes.)
Use kvmalloc() to automatically pick the better of kmalloc()
or vmalloc() depending on the size.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 kernel/gcov/clang.c   | 6 +++---
 kernel/gcov/fs.c      | 6 +++---
 kernel/gcov/gcc_4_7.c | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
index e59c290527b2..89be9ab2d909 100644
--- a/kernel/gcov/clang.c
+++ b/kernel/gcov/clang.c
@@ -49,7 +49,7 @@
 #include <linux/printk.h>
 #include <linux/ratelimit.h>
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
+#include <linux/mm.h>
 #include "gcov.h"
 
 typedef void (*llvm_gcov_callback)(void);
@@ -308,7 +308,7 @@ static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
 		goto err_name;
 
 	cv_size = fn->num_counters * sizeof(fn->counters[0]);
-	fn_dup->counters = vmalloc(cv_size);
+	fn_dup->counters = kvmalloc(cv_size, GFP_KERNEL);
 	if (!fn_dup->counters)
 		goto err_counters;
 	memcpy(fn_dup->counters, fn->counters, cv_size);
@@ -367,7 +367,7 @@ void gcov_info_free(struct gcov_info *info)
 
 	list_for_each_entry_safe(fn, tmp, &info->functions, head) {
 		kfree(fn->function_name);
-		vfree(fn->counters);
+		kvfree(fn->counters);
 		list_del(&fn->head);
 		kfree(fn);
 	}
diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index 40ea81c0475b..5c3086cad8f9 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -26,7 +26,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/seq_file.h>
-#include <linux/vmalloc.h>
+#include <linux/mm.h>
 #include "gcov.h"
 
 /**
@@ -116,7 +116,7 @@ static struct gcov_iterator *gcov_iter_new(struct gcov_info *info)
 	/* Dry-run to get the actual buffer size. */
 	size = convert_to_gcda(NULL, info);
 
-	iter = vmalloc(struct_size(iter, buffer, size));
+	iter = kvmalloc(struct_size(iter, buffer, size), GFP_KERNEL);
 	if (!iter)
 		return NULL;
 
@@ -134,7 +134,7 @@ static struct gcov_iterator *gcov_iter_new(struct gcov_info *info)
  */
 static void gcov_iter_free(struct gcov_iterator *iter)
 {
-	vfree(iter);
+	kvfree(iter);
 }
 
 /**
diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index 1251f2434e90..460c12b7dfea 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -15,7 +15,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/vmalloc.h>
+#include <linux/mm.h>
 #include "gcov.h"
 
 #if (__GNUC__ >= 10)
@@ -309,7 +309,7 @@ struct gcov_info *gcov_info_dup(struct gcov_info *info)
 
 			cv_size = sizeof(gcov_type) * sci_ptr->num;
 
-			dci_ptr->values = vmalloc(cv_size);
+			dci_ptr->values = kvmalloc(cv_size, GFP_KERNEL);
 
 			if (!dci_ptr->values)
 				goto err_free;
@@ -351,7 +351,7 @@ void gcov_info_free(struct gcov_info *info)
 		ci_ptr = info->functions[fi_idx]->ctrs;
 
 		for (ct_idx = 0; ct_idx < active; ct_idx++, ci_ptr++)
-			vfree(ci_ptr->values);
+			kvfree(ci_ptr->values);
 
 		kfree(info->functions[fi_idx]);
 	}
-- 
2.30.2

