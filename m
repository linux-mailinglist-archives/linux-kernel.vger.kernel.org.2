Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0EC3979FC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbhFASX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbhFASXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:23:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5168AC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 11:22:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id j12so33347pgh.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 11:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+4kopGrPpDmNYqodYUvkjETu0gKLYPPcKDiSzcCSolk=;
        b=FdH1YFBnQgCff+7rGQ6EQDjWOQlazi5AGW5irmxbWACfjKF3jf3HzEcxIWIK/D69An
         71EwfeSug2avMa2n9ao3JFsMQkXHL4Eg3EVtoSxKvCxhgjCY1PS0YKWV9Cq1shXJqsb1
         g9ZkXirTMKZlH7yAO8UtAV9ojzlMdJAKJiAks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4kopGrPpDmNYqodYUvkjETu0gKLYPPcKDiSzcCSolk=;
        b=RgKNaaE62iJxFH1sSDih3dwXkz1FZU9YUi3LYMPuZ23L74mPo7WLVwhhxbCknqmO1y
         swB/RpjD6ru7cMNnxIPXx6kqy5LsEDGWjgPM5pyc6ep0OQlnNsCG8I1RBGMVlnswKOFM
         LCxVsyhODe+pf0B7G/J6TV1sraX/6jK6L6tC0hVKfZRyLw2LprVxXcpcz4zSPwRt5Oj8
         BstWH/NuAXIR8pvmBhM5dHrZUE74dKz4TrVUpgMxh/bO7utgyyLMsUwcPWPSojp0x03a
         voNugZvru8K0NyB4jos1uwiLm1BkjALY2sjYBdNd3HO5JySOTg4/G/IO6Xr010Dq6cMw
         j0hw==
X-Gm-Message-State: AOAM532hTeDw7/CuoDgQnd2kcjvRI42g79CqMNzYzOJSziGOaC11x3cm
        82QQ5ebAKqRpEiRv6fNi5E5nsA==
X-Google-Smtp-Source: ABdhPJx26aWTFfzLyGpF4prhXg+t+dlc0PPGGBZjuc0JwvcXYW9VyW07WF5AIG38G74nnkzD7F2i6w==
X-Received: by 2002:a63:5218:: with SMTP id g24mr28883071pgb.309.1622571728889;
        Tue, 01 Jun 2021 11:22:08 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:ee82:b2a7:c8bd:18e7])
        by smtp.gmail.com with ESMTPSA id g29sm14510982pgm.11.2021.06.01.11.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 11:22:08 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 3/4] slub: Indicate slab_fix() uses printf formats
Date:   Tue,  1 Jun 2021 11:22:01 -0700
Message-Id: <20210601182202.3011020-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
In-Reply-To: <20210601182202.3011020-1-swboyd@chromium.org>
References: <20210601182202.3011020-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>

Ideally, slab_fix() would be marked with __printf and the format here
would not use \n as that's emitted by the slab_fix(). Make these
changes.

Signed-off-by: Joe Perches <joe@perches.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 mm/slub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6168b3ce1b3e..bf4949115412 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -672,6 +672,7 @@ static void slab_bug(struct kmem_cache *s, char *fmt, ...)
 	va_end(args);
 }
 
+__printf(2, 3)
 static void slab_fix(struct kmem_cache *s, char *fmt, ...)
 {
 	struct va_format vaf;
@@ -777,7 +778,7 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
 static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
 						void *from, void *to)
 {
-	slab_fix(s, "Restoring %s 0x%p-0x%p=0x%x\n", message, from, to - 1, data);
+	slab_fix(s, "Restoring %s 0x%p-0x%p=0x%x", message, from, to - 1, data);
 	memset(from, data, to - from);
 }
 
@@ -1026,13 +1027,13 @@ static int on_freelist(struct kmem_cache *s, struct page *page, void *search)
 		slab_err(s, page, "Wrong number of objects. Found %d but should be %d",
 			 page->objects, max_objects);
 		page->objects = max_objects;
-		slab_fix(s, "Number of objects adjusted.");
+		slab_fix(s, "Number of objects adjusted");
 	}
 	if (page->inuse != page->objects - nr) {
 		slab_err(s, page, "Wrong object count. Counter is %d but counted were %d",
 			 page->inuse, page->objects - nr);
 		page->inuse = page->objects - nr;
-		slab_fix(s, "Object count adjusted.");
+		slab_fix(s, "Object count adjusted");
 	}
 	return search == NULL;
 }
-- 
https://chromeos.dev

