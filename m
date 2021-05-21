Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011E638C648
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhEUMNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhEUMM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:12:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39442C061763
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:11:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n2so20935262wrm.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3PtvIn3e83BJKazxoRmqSdndVRiSDgFlBve83mzSb0=;
        b=lWo0CnDeza1lg1y/wl0wstJvMhHfAumf114y9xzRjwZTnbUeMXVE0HNqg24Uerkn/j
         jG2Cx8StiDpVjcp2++hDyzfPQ9XoAGSPQP1npC720ODVBqWDMR9FxsRc1vI1PbBC5p9i
         CIYLPCk1UZ3oGnnLmUSVAdWoUA1Xui6x/MY/Rd1HZzrH/F3RSoAGAIif4tNRyXDzRXv7
         cOjqCOum6LSTCJ4y0GDGCv97FqImIFPn1taGtcelrXNxuojOn2JTWXrh07dDN1xADLGq
         VqC5EQYKkSqWeJ0VC6LG6j0NuYeIYYpET3cXlffeE5D7wVLHs0aazL4EdrKfzAI6LdyS
         V+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3PtvIn3e83BJKazxoRmqSdndVRiSDgFlBve83mzSb0=;
        b=SLY97lhgMjRAUwV4FDAk6IaxaZMgkc14tjx0ChP1ThzOLs/LZMviUUxH+5lrdDnwiv
         G/U/X9w/mPCRDIUFrOCrYMSpqNCQQ0LIfbpClpJ52ysEiWQp5x9cDBRIWZ9z5ERIfWG7
         f4Ekv9VO0RzXQhtBeIXe6swo7aotUTFHmEkYBWrTL9N53ACGfn5/IlEk3q38fJ6D+Wio
         dD7XMWzXwo98V1Ow/qDAPYzVLWcI1JAYqG5pAVJeq3tVs4f9VZqeRvDFm+ZiJfOL0SSB
         ZAV/3bGQydzRWpwRToMjv2jUIYj2ePHCsUKnXkNmumFjV/N4HC7DZg16NCrFBMggeFTN
         L6Gw==
X-Gm-Message-State: AOAM533UtBMACSGvw4GVUzL5IjQEvLaozn/tJoSSfmN2dZGaCBLjaELR
        u+TCgm0HNiG6rVEGA+oDnl8=
X-Google-Smtp-Source: ABdhPJwrgnwHqggWQ/pppvxseMU9ZskSzS2UEsOWZW6JmOTj/pMlpOtg3UuT78DMFju3VNdIhAveMA==
X-Received: by 2002:adf:f10c:: with SMTP id r12mr9416310wro.26.1621599090895;
        Fri, 21 May 2021 05:11:30 -0700 (PDT)
Received: from oliver-Z170M-D3H.cuni.cz ([2001:718:1e03:5128:e010:8b67:85b8:dc89])
        by smtp.gmail.com with ESMTPSA id c64sm3339401wma.15.2021.05.21.05.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 05:11:30 -0700 (PDT)
From:   glittao@gmail.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        faiyazm@codeaurora.org, Oliver Glitta <glittao@gmail.com>
Subject: [RFC 2/3] mm/slub: sort objects in cache by frequency of stack trace
Date:   Fri, 21 May 2021 14:11:26 +0200
Message-Id: <20210521121127.24653-2-glittao@gmail.com>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a5
In-Reply-To: <20210521121127.24653-1-glittao@gmail.com>
References: <20210521121127.24653-1-glittao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Glitta <glittao@gmail.com>

Sort objects in slub cache by the frequency of stack trace used
in object location in alloc_calls and free_calls implementation
in debugfs. Most frequently used stack traces will be the first.

Signed-off-by: Oliver Glitta <glittao@gmail.com>
---
 mm/slub.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index d5ed6ed7d68b..247983d647cd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -37,6 +37,7 @@
 #include <linux/memcontrol.h>
 #include <linux/random.h>
 #include <kunit/test.h>
+#include <linux/sort.h>
 
 #include <linux/debugfs.h>
 #include <trace/events/kmem.h>
@@ -5893,6 +5894,17 @@ static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
 	return NULL;
 }
 
+static int cmp_loc_by_count(const void *a, const void *b, const void *data)
+{
+	struct location *loc1 = (struct location *)a;
+	struct location *loc2 = (struct location *)b;
+
+	if (loc1->count > loc2->count)
+		return -1;
+	else
+		return 1;
+}
+
 static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
 {
 	struct kmem_cache_node *n;
@@ -5944,6 +5956,11 @@ static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
 				process_slab(&t, s, page, alloc);
 			spin_unlock_irqrestore(&n->list_lock, flags);
 		}
+
+		/* Sort locations by count */
+		sort_r(t.loc, t.count, sizeof(struct location),
+				cmp_loc_by_count, NULL, NULL);
+
 	}
 
 	if (*ppos < t.count) {
-- 
2.31.1.272.g89b43f80a5

