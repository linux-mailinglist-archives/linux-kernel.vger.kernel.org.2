Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B2936E1FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhD1XJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 19:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhD1XJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 19:09:49 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C883EC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 16:09:02 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id i3-20020a0c9c830000b02901bb3405e50aso7250352qvf.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 16:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i1GiJbmx4c6CwH/DZDMM7LMoubeTmN2YjmWg8BjfUo4=;
        b=t6dEc0kYwYtucEIA0MfNTqRIaZQdQr5TRyZEyQ+l4esJqNuNymiL+THr1F91O0RlLa
         KXnWLbGLzMSgUG1QrnFRtffehJ5493CxwfktVlLKb3/Fk2O1rBVSLiocksWe+gCX6sLm
         6GGPvkQBg5fwRJfCJ6sfvvydK1aVGcSUMhZvtCidXFWW638mbynyZ1wNQsF+16CoyD+/
         6Wa2hkPL3YcWaIeR0Jxhy8JLLOD2tuVgiaCv0RU+DZRy5RCV5uVsA+9zWCVIuByNG6DP
         Iq7IAVrn6M9w3BWKwW6f9VVEWg8CMHmtnFudx9AGZYE6UPzDzvliuUNtqMaSwgjWbSig
         ptrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i1GiJbmx4c6CwH/DZDMM7LMoubeTmN2YjmWg8BjfUo4=;
        b=ABF5bEJ/BzHom3ASypGh7JPovUEnZ7+AfXnZtlsPPpCy8WyqoXrjk2ICcakSYlgea4
         ZDhlYZAVsaa+jhlkrnlH42ZH6Edy/C6zRJs+pV1jlISmgXx9NiEvoquCcbrkpt8SiFBV
         /M/2KTB/bUQE6Wld9iwEP+NOCFy96ayULTZWQOMqbHbrY7gdVhJxOEs1rlk63YcNy6iU
         580KxTFbJ/YfNJeT80s/5uX35YB8bcamzHDMjvwHvHhRS7VNU5tAPPgXhMWG2pxf6ncA
         vg3rSP3p+haqZpEU8v00BtaxqQEP+Ep+WbS7Q8G3V/1Lens/YgfYdxScSOLD0ZDsLGeX
         JmYw==
X-Gm-Message-State: AOAM5324jTqucBWFfegwJaIEvpNgPryRDnmHVliTZiY+QGHy5s+UioZj
        j7ac0rlpgSCqmhBTd+a+IEOGt5zzmqgZSNhqanjB
X-Google-Smtp-Source: ABdhPJyUP7JxteYpJxt8ZDYt5abz9mFFKsb5Bqpj0SvGj2jW49PdVtIfkMUN5AUTE4HZGrOQonJJIi320UBsR0xOGPhp
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:ed44:e19a:52ee:e8cc])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:ebc9:: with SMTP id
 k9mr32020308qvq.32.1619651341988; Wed, 28 Apr 2021 16:09:01 -0700 (PDT)
Date:   Wed, 28 Apr 2021 16:08:58 -0700
In-Reply-To: <20210428180109.293606-1-axelrasmussen@google.com>
Message-Id: <20210428230858.348400-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210428180109.293606-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v2] userfaultfd: release page in error path to avoid BUG_ON
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the following sequence of events:

1. Userspace issues a UFFD ioctl, which ends up calling into
   shmem_mfill_atomic_pte(). We successfully account the blocks, we
   shmem_alloc_page(), but then the copy_from_user() fails. We return
   -ENOENT. We don't release the page we allocated.
2. Our caller detects this error code, tries the copy_from_user() after
   dropping the mmap_lock, and retries, calling back into
   shmem_mfill_atomic_pte().
3. Meanwhile, let's say another process filled up the tmpfs being used.
4. So shmem_mfill_atomic_pte() fails to account blocks this time, and
   immediately returns - without releasing the page.

This triggers a BUG_ON in our caller, which asserts that the page
should always be consumed, unless -ENOENT is returned.

To fix this, detect if we have such a "dangling" page when accounting
fails, and if so, release it before returning.

Fixes: cb658a453b93 ("userfaultfd: shmem: avoid leaking blocks and used blocks in UFFDIO_COPY")
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/shmem.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 26c76b13ad23..8def03d3f32a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2375,8 +2375,18 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	pgoff_t offset, max_off;
 
 	ret = -ENOMEM;
-	if (!shmem_inode_acct_block(inode, 1))
+	if (!shmem_inode_acct_block(inode, 1)) {
+		/*
+		 * We may have got a page, returned -ENOENT triggering a retry,
+		 * and now we find ourselves with -ENOMEM. Release the page, to
+		 * avoid a BUG_ON in our caller.
+		 */
+		if (unlikely(*pagep)) {
+			put_page(*pagep);
+			*pagep = NULL;
+		}
 		goto out;
+	}
 
 	if (!*pagep) {
 		page = shmem_alloc_page(gfp, info, pgoff);
-- 
2.31.1.498.g6c1eba8ee3d-goog

