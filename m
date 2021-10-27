Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E25A43CD15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbhJ0PKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbhJ0PKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:10:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13550C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 08:07:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so2293718pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cXTwAPJ+9CrT9PXvZbLyy/kVLXgo+ZtbEyaILHUCVEU=;
        b=NKO7zP7PGiGTfgRtOewFpGDUpIFZYjeRpAnxeXOQN/N5TLUkkgFtlCo0YUned1LO5M
         7WZdef4y8+cg/KFqrQXXrkXmYMF6F7nOcoyQZNg16IPD140L9fq3J0IztkH1zaFMPjPw
         vVyOhRaUTGs79A4/MdZkzQjpW+IzllrmJ8F7VFcJty4AhXHbYI4r2+r2jd4WbuetYEbg
         OKC8e4lKfK5tlXD+zvRDK8lWP9rdSFudcXoGARLWPBM4QTM02M+pf2XpG1rtCg4Zjj4+
         Tie15bo5KE6XOzmFutHyEy8B/+nyb8eeT5elrkNE1ofi426f5dNHPpI2yNYpHXYHbwln
         Yfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cXTwAPJ+9CrT9PXvZbLyy/kVLXgo+ZtbEyaILHUCVEU=;
        b=ZL/iUdLjqfvAIIS9AE//guCStIBcOa0L6KP4u2iO5Rqfu/ZXIyOnieQ4gaZnNAQJeL
         3pb5sGfpmoGFPbR/I/hIh9pQTNKzL37YiSsaqDZFkjtjhUiQ4hqFvlSNKWKSiwBnLruI
         eLJWOsZLCUHnmuqzyfOyoLJKBp6XuaMPx7sdsl9GITz/UddkU7yv9bv61Rq7c1iQRwl0
         H96a/y8kHeuWfSsI+q2BsdoLrBBMF7ZWLUIjLo1HKYhCimqAP6en5fN6eB0gZuGDU2aM
         Jh2pGGADNJ+wzsYku78Hdtsbi/53PNY9IAH7KUhH86Vj044NnzHsp4eQ6WnHVvRyeV0G
         rQqA==
X-Gm-Message-State: AOAM532Ao+PaTPs+1rM8OtZ6rZ0pJRZHIjvVtIWtjuWYpADM0kjReKd4
        lvi4QI3r29f7YBZPacyd9ZU=
X-Google-Smtp-Source: ABdhPJxaW3IZ8gm0ukoWLYCr4Cc/HY+9od8Z0ViKPWVJOc6pJOdVKmr1Hk4rV7GTZtCWvvLT6wEddw==
X-Received: by 2002:a17:90a:ce97:: with SMTP id g23mr3459187pju.149.1635347266390;
        Wed, 27 Oct 2021 08:07:46 -0700 (PDT)
Received: from localhost.localdomain ([94.177.118.99])
        by smtp.gmail.com with ESMTPSA id e14sm249677pfv.192.2021.10.27.08.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 08:07:45 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fscache: fix GPF in fscache_free_cookie
Date:   Wed, 27 Oct 2021 23:07:32 +0800
Message-Id: <20211027150732.4158273-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If fscache_alloc_cookie encounters memory allocation failure, it will
go to nomem label and invoke fscache_free_cookie. However,
fscache_alloc_cookie assumes current cookie is already linked into
fscache_cookies and directly calls list_del. This assumption does not
hold since list_add is not called in the above scenario. As a result, it
will lead to Null Pointer Dereference. The stack trace is in the
following.

Call Trace:
 __list_del_entry include/linux/list.h:132 [inline]
 list_del include/linux/list.h:146 [inline]
 fscache_free_cookie fs/fscache/cookie.c:71 [inline]
 fscache_free_cookie+0x3f/0x100 fs/fscache/cookie.c:66
 fscache_alloc_cookie+0x2e2/0x300 fs/fscache/cookie.c:195
 __fscache_acquire_cookie fs/fscache/cookie.c:296 [inline]
 __fscache_acquire_cookie+0x132/0x380 fs/fscache/cookie.c:257
 fscache_acquire_cookie include/linux/fscache.h:334 [inline]
 v9fs_cache_session_get_cookie+0x74/0x120 fs/9p/cache.c:60
 v9fs_session_init+0x724/0xa90 fs/9p/v9fs.c:471
 v9fs_mount+0x56/0x450 fs/9p/vfs_super.c:126
 legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
 vfs_get_tree+0x28/0x100 fs/super.c:1498
 do_new_mount fs/namespace.c:2988 [inline]
 path_mount+0xb92/0xfe0 fs/namespace.c:3318
 do_mount+0xa1/0xc0 fs/namespace.c:3331
 __do_sys_mount fs/namespace.c:3539 [inline]
 __se_sys_mount fs/namespace.c:3516 [inline]
 __x64_sys_mount+0xf4/0x160 fs/namespace.c:3516

Fix this by moving the list_add_tail before goto statements.

Fixes: 884a76881fc5 ("fscache: Procfile to display cookies")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 fs/fscache/cookie.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index cd42be646ed3..d101e212db74 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -150,6 +150,11 @@ struct fscache_cookie *fscache_alloc_cookie(
 	if (!cookie)
 		return NULL;
 
+	/* move list_add_tail before any error handling code */
+	write_lock(&fscache_cookies_lock);
+	list_add_tail(&cookie->proc_link, &fscache_cookies);
+	write_unlock(&fscache_cookies_lock);
+
 	cookie->key_len = index_key_len;
 	cookie->aux_len = aux_data_len;
 
@@ -186,9 +191,6 @@ struct fscache_cookie *fscache_alloc_cookie(
 	 * told it may not wait */
 	INIT_RADIX_TREE(&cookie->stores, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
 
-	write_lock(&fscache_cookies_lock);
-	list_add_tail(&cookie->proc_link, &fscache_cookies);
-	write_unlock(&fscache_cookies_lock);
 	return cookie;
 
 nomem:
-- 
2.25.1

