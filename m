Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECDC36DEB5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 20:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243382AbhD1SCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 14:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241704AbhD1SCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 14:02:18 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA212C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 11:01:31 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id v18-20020ac857920000b02901bad9e4241dso954621qta.15
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nf8i5zc/CF74bPP2ccA5udCaSNmHZYeuQlI0W716jnY=;
        b=HKG1evztST1oyuQsk7u0HTBIeKZoVDWVDIphqea7uW3br0SFbKO8xX4AEbjbA97tg9
         bYQ8PYvw0YmkXElXeR0MuH/5Xr9FoyTUUm098WeRi1+9FBNA5NS+tYYvHOOSvYOh6T1V
         vtpFlhisjl6TuLCxitRSb8aA6A/04ee6TJq1htNwhP/seMTW9XvvzDKPktJeUtppDQT3
         onMwRslSMIN0NTInxzBZSu2BEK1VmnQlQjAEAoHGuW8pNPb1D+NZoxJ+rwycstttffjI
         fz1hjox625joRSOcz4lP/OwLFn3NMieOLouW1rBHqO3Cxy4Jsc9Hgv1m8v1kBfIe4VyL
         DsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nf8i5zc/CF74bPP2ccA5udCaSNmHZYeuQlI0W716jnY=;
        b=Lk1ZYpft5zLn7WJPIBCWkR/VKLVDUypoiGQuQ3SHnW14uMHpfSAwrzV6hHZOdub/0P
         EDDt51UDAZ4F64A+xRsUX9isU8xHCb3IQpn8tqZqbtD3ZF4PEwZxhoaQmsmd59Edctmk
         suNLXAMRANqc4oa7zQMQZbdamxiAoUPhZ06cOUKZicdnRxcukRcPb598ruHqQ295jSC5
         fxWgXOvg5InuNG+JI1rTQcSznpPPQ9hyxIZbwcnfgq/YLLsKPSXBh7KBZPSEaYSaZ137
         VC3QAMYLVq9oVolRf9tnRdAyazsSaqS7+AlqzyouL4MUFM0SdIigb03esb79EGQ0fDv7
         GqfQ==
X-Gm-Message-State: AOAM530+60KZUt7GxsrnwExfiSHGICEtP8M/zv/slzvXkg/etOvzaqpD
        2lcgsCuRszjfI4E4GmliI8dRl+BVfk50uMk3iEGa
X-Google-Smtp-Source: ABdhPJzsD0nTdGceEOL3UE6Ru96fIeoOZ7OkQlhmlKn4qnc+6fUXsrzld5XqhSB5tzg8EnOmjF2eZHL7mAroh2t8RaMJ
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:ed44:e19a:52ee:e8cc])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:54c5:: with SMTP id
 j5mr23475834qvx.4.1619632890610; Wed, 28 Apr 2021 11:01:30 -0700 (PDT)
Date:   Wed, 28 Apr 2021 11:01:09 -0700
Message-Id: <20210428180109.293606-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH] userfaultfd: release page in error path to avoid BUG_ON
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

Consider the following sequence of events (described from the point of
view of the commit that introduced the bug - see "Fixes:" below):

1. Userspace issues a UFFD ioctl, which ends up calling into
   shmem_mcopy_atomic_pte(). We successfully account the blocks, we
   shmem_alloc_page(), but then the copy_from_user() fails. We return
   -EFAULT. We don't release the page we allocated.
2. Our caller detects this error code, tries the copy_from_user() after
   dropping the mmap_sem, and retries, calling back into
   shmem_mcopy_atomic_pte().
3. Meanwhile, let's say another process filled up the tmpfs being used.
4. So shmem_mcopy_atomic_pte() fails to account blocks this time, and
   immediately returns - without releasing the page. This triggers a
   BUG_ON in our caller, which asserts that the page should always be
   consumed, unless -EFAULT is returned.

(Later on in the commit history, -EFAULT became -ENOENT, mmap_sem became
mmap_lock, and shmem_inode_acct_block() was added.)

A malicious user (even an unprivileged one) could trigger this
intentionally without too much trouble.

To fix this, detect if we have a "dangling" page when accounting fails,
and if so, release it before returning.

Fixes: cb658a453b93 ("userfaultfd: shmem: avoid leaking blocks and used blocks in UFFDIO_COPY")
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/shmem.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 26c76b13ad23..46766c9d7151 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2375,8 +2375,19 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
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
+			unlock_page(*pagep);
+			put_page(*pagep);
+			*pagep = NULL;
+		}
 		goto out;
+	}
 
 	if (!*pagep) {
 		page = shmem_alloc_page(gfp, info, pgoff);
-- 
2.31.1.498.g6c1eba8ee3d-goog

