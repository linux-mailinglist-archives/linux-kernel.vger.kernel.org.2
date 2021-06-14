Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF863A7118
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 23:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhFNVVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 17:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhFNVVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 17:21:12 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA68BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 14:19:08 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id f70so24723796qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kPFT6nLLi1vvs4YFnK7DHOeGhzIW1Fs6DFQ1T0gCrck=;
        b=biiUnj1ExqttolBbEAb89QL8bsuWSOP8ozPOvpGyIPVXaX48+dqGxyTo+1pSUVs7xJ
         DOM157n2vskD+MQ7M6Wa2ZyYhIffBRELYKQfSKi6vCy6qJb5yq2/FsmsOx3G9MErNhE5
         AckuooFjPNHwzfRp7zu4otoudRs+NTd3qiCWoDG9CwIpCJxBaNR4gt/3xYyuQVyhD6OG
         1UVooRbjWx3DLZnqMCgS4WVnS93O2FIHISxYKfYVa51c5PITxwNolcDZfLaMdSaftBNp
         RqHBG2wZ8AvQf0JWzVViLZjJbtEaow1MSGLmMKdErHotkPeWlY2SbSgzZPJdDRltjrUm
         Z4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kPFT6nLLi1vvs4YFnK7DHOeGhzIW1Fs6DFQ1T0gCrck=;
        b=JIUfYPya8+FC0H8WBk8hk09JC/BJ9Hq7YS0IzAxaV4rilQskx6Z2+y2I+GQjvIhETW
         cRQaQDoeszh/fbqYGU2eLz8m9Kv8Zc5/qNi5ymncxFJUeaOzirL+2hOhorJLm1nACljn
         siRwTxuG25G3RRXURavkWgql7MAqQWLn62+5RqVwISnbq3hvit+jfioehy29TrhZ8Bfd
         ctNnsSgaKSgelKfS0N33b9nckGmstM94I3XUiQZ/dBXIC2Hu8QYTk+lFmFHLZfDS6d6u
         lyP7Uy08a5H2iC8y4QHUL20yPMI+uKkFqpfjUUONNY3ZZ/mDJMXQgewn2mhdvcLelN4q
         L01g==
X-Gm-Message-State: AOAM5323P58wD2Xmkef6wn80DEsLSxlbNDMSsc4QU32DH4GY/R02vb4B
        gghJ0AS0BlDQ8St4F3zNUUaXuA==
X-Google-Smtp-Source: ABdhPJzvbqbfUECNW/9wGSUb5hxtP8w89hrKHvoC2k0yCleVRDRQ6BXu2QO6aCEMxPYVsmeHcsi6pg==
X-Received: by 2002:a37:814:: with SMTP id 20mr18822511qki.243.1623705547189;
        Mon, 14 Jun 2021 14:19:07 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id e4sm10146101qtw.62.2021.06.14.14.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 14:19:06 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/4] fs: drop_caches: fix skipping over shadow cache inodes
Date:   Mon, 14 Jun 2021 17:19:02 -0400
Message-Id: <20210614211904.14420-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614211904.14420-1-hannes@cmpxchg.org>
References: <20210614211904.14420-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When drop_caches truncates the page cache in an inode it also includes
any shadow entries for evicted pages. However, there is a preliminary
check on whether the inode has pages: if it has *only* shadow entries,
it will skip running truncation on the inode and leave it behind.

Fix the check to mapping_empty(), such that it runs truncation on any
inode that has cache entries at all.

Reported-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/drop_caches.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index f00fcc4a4f72..e619c31b6bd9 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -3,6 +3,7 @@
  * Implement the manual drop-all-pagecache function
  */
 
+#include <linux/pagemap.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
@@ -27,7 +28,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 		 * we need to reschedule to avoid softlockups.
 		 */
 		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
-		    (inode->i_mapping->nrpages == 0 && !need_resched())) {
+		    (mapping_empty(inode->i_mapping) && !need_resched())) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-- 
2.32.0

