Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2206390E92
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 04:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhEZC6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 22:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhEZC6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 22:58:02 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2F9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:56:31 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t193so24365654pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hd4sjVebDaf07tFQ+ywKu8o7Lsylb2YjfwTECIMO6nE=;
        b=Ta1KK1z9gai6K08ZovKvMdSgSV9RnsLmXbqa+T+Xb50myBGArf76QxkU700w5T/qGF
         zCIzMIr1tNMayGVp6AimjdFicj3Eo47zPZx1lYeqKcOoVgMxGNOZcyYVn35dyXS8Elys
         mHd7UkQ3a9hGvR0mfnodrP+x7LeD3cu/YE2e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hd4sjVebDaf07tFQ+ywKu8o7Lsylb2YjfwTECIMO6nE=;
        b=Kuvk+B8LLCVCddSPagicXBgQAN/hZZHq5ZqekN5rppLauE1suBFfBTMZgb1jgqQLMH
         maXPUv9s+sJmLsrphcosYTZksmuGsVS45ziJEYkJQwmB4E+RkjIbPgJByFKzACsgTl6Y
         jhvjn4qsHYerfVCR8s1aH/x0MwtWVZnAxysq9/bUn8K68lzZwgFKgGdOHDk/VPAOI/dn
         Fosq2Ou7/5NYg5wtXJqzM01hnYpwMOEwK3/CvsTttj9XX0LJeoJEPzm5on+g7N6Dkd4Y
         L/MPrImWS2rQXogsV9yVkCvxGEbQGhH/iWbP/32Qv8PjM6fjs8Z8QuX29AYIIeSqOMIi
         Ajcw==
X-Gm-Message-State: AOAM532Lj7LsJZBIfErPYrEoqaYyn20BtOeTHOJfuXGeYfZoEquT1iKx
        LXi2kywICTU+FtimVOK8Jkm6DLxcMJ4Dqw==
X-Google-Smtp-Source: ABdhPJyhEeKpf7bQdFgMTHoucSgu3s1fpigfxmxSqi30hy2i6YsoFfE7qEMhFXKp3ynkjQthhRwXnQ==
X-Received: by 2002:a63:6547:: with SMTP id z68mr15638232pgb.341.1621997790938;
        Tue, 25 May 2021 19:56:30 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5a1b:e4e5:eb10:8870])
        by smtp.gmail.com with ESMTPSA id 5sm2966295pjo.17.2021.05.25.19.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 19:56:30 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 3/4] slub: Indicate slab_fix() uses printf formats
Date:   Tue, 25 May 2021 19:56:24 -0700
Message-Id: <20210526025625.601023-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210526025625.601023-1-swboyd@chromium.org>
References: <20210526025625.601023-1-swboyd@chromium.org>
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

