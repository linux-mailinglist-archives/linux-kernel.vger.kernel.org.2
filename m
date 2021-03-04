Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93FB32D591
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhCDOkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhCDOkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:40:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD80C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 06:40:04 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q77so30963060ybq.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 06:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=J0Eb4BeQ/LcK1uQlkM6nbhOgm0bqw0Va6B9G5XeIs/c=;
        b=D2kCIfqNz4T3Pf5QpozgmfIA0Gn/1MaYiwym/ex4zld+AS0SPu2SjFN3UEP9t8D9s5
         USZd9TrrVq2Bid2LbDADm1dDvc2LqE81EZY1Uj5f8L8f5Dum/W7ju1DJY66yhy6KrSPp
         OJokL+5ZgpBBLa3igAv3TTRQpAErd+FZGKIrD4HiYID02h5xMFIz5IsL2ljaNU7172Q5
         goAHFCUM9OYPoxEh0LStPmuetTUedeOqtI1/3gvY/kdQ0+dYwTWLD/nY8qhdWWWoc3uo
         s1gVuHyeqnpCv0l3zb7yGYff2gyoQwSwbfIcTm2LZv0nACbfqXiMSvBLV4CAD56kXBB9
         NyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=J0Eb4BeQ/LcK1uQlkM6nbhOgm0bqw0Va6B9G5XeIs/c=;
        b=Op7bg77BZ8iNJFqjOdTsTV5n1EFqUxTZBnh/B1/PQtMrSzSwplLmLZuVRfij9viyEc
         1vpJi2IfUyrHdYgU0o4RwGOT/YtRp3lb2OmB0GhKQlFWRuw73b3G/WQf622D0w7ALVJs
         Wz6fOY/cRXK1jv/I9FPdAJnI1NY1YQr8PuLDqHKbLytj4kN7AXhkTBy0MdDnJYnQTNLz
         8JprdpsuYeNmIEkgK8NxQCqbnZCdWIYaleVgnGJQ6gNdip36RI9CmvYb81YAc75GzTyD
         wJOt7tevbK9I+xlRninhn0VXnD+3+yHsdDutnbCrehEwpOSkyY5NyWSSytmWtdULmd4K
         X1SQ==
X-Gm-Message-State: AOAM531r+/B2ID8o5J09Alc6YTzsXCT4gw0D9QGqFknRp8dHPxgF4xW0
        j+jSsGGkKFXJ/VcPxNIVwHQEX97TPg==
X-Google-Smtp-Source: ABdhPJxmTkNn8dSf0mXO/8nbaHc1m97dXzGttRhBDBOeceqXXFnnwoaVfWShcAw9s0n6CMOx8pbkfpKh7Q==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e426:34b7:f237:f8d3])
 (user=elver job=sendgmr) by 2002:a25:c586:: with SMTP id v128mr7118421ybe.416.1614868803915;
 Thu, 04 Mar 2021 06:40:03 -0800 (PST)
Date:   Thu,  4 Mar 2021 15:40:00 +0100
Message-Id: <20210304144000.1148590-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH mm] kfence: fix reports if constant function prefixes exist
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, andreyknvl@google.com,
        jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures prefix all functions with a constant string ('.' on
ppc64). Add ARCH_FUNC_PREFIX, which may optionally be defined in
<asm/kfence.h>, so that get_stack_skipnr() can work properly.

Link: https://lkml.kernel.org/r/f036c53d-7e81-763c-47f4-6024c6c5f058@csgroup.eu
Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/report.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 519f037720f5..e3f71451ad9e 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -20,6 +20,11 @@
 
 #include "kfence.h"
 
+/* May be overridden by <asm/kfence.h>. */
+#ifndef ARCH_FUNC_PREFIX
+#define ARCH_FUNC_PREFIX ""
+#endif
+
 extern bool no_hash_pointers;
 
 /* Helper function to either print to a seq_file or to console. */
@@ -67,8 +72,9 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
 	for (skipnr = 0; skipnr < num_entries; skipnr++) {
 		int len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skipnr]);
 
-		if (str_has_prefix(buf, "kfence_") || str_has_prefix(buf, "__kfence_") ||
-		    !strncmp(buf, "__slab_free", len)) {
+		if (str_has_prefix(buf, ARCH_FUNC_PREFIX "kfence_") ||
+		    str_has_prefix(buf, ARCH_FUNC_PREFIX "__kfence_") ||
+		    !strncmp(buf, ARCH_FUNC_PREFIX "__slab_free", len)) {
 			/*
 			 * In case of tail calls from any of the below
 			 * to any of the above.
@@ -77,10 +83,10 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
 		}
 
 		/* Also the *_bulk() variants by only checking prefixes. */
-		if (str_has_prefix(buf, "kfree") ||
-		    str_has_prefix(buf, "kmem_cache_free") ||
-		    str_has_prefix(buf, "__kmalloc") ||
-		    str_has_prefix(buf, "kmem_cache_alloc"))
+		if (str_has_prefix(buf, ARCH_FUNC_PREFIX "kfree") ||
+		    str_has_prefix(buf, ARCH_FUNC_PREFIX "kmem_cache_free") ||
+		    str_has_prefix(buf, ARCH_FUNC_PREFIX "__kmalloc") ||
+		    str_has_prefix(buf, ARCH_FUNC_PREFIX "kmem_cache_alloc"))
 			goto found;
 	}
 	if (fallback < num_entries)
-- 
2.30.1.766.gb4fecdf3b7-goog

