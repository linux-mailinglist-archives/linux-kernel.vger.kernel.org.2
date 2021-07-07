Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AAF3BF09A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 22:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhGGUJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 16:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhGGUJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:09:18 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C268C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 13:06:36 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 128-20020a4a11860000b029024b19a4d98eso801926ooc.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 13:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=6qeso0vnhBwFs3iCYpWzxPK0i6KQqKKfr8ULWEkbKXE=;
        b=E4XHqX1GTIF3abK36LazO2Q/rAwhiw0uDpwxHRBjNPI0ptyVYh43DYr17icgNSzNtB
         0/l/8Pqy8JjsnqgavgUC69qzF0JNtN+UGO1Hb1cDGMQOkF2hSSx6+RbyIHdblu2e26dB
         3ObW5x1VTMLukGemHCj8VN/+JPYeOwwkBEnNJZKDlQPpkB+2g4uHfB+yRj19WmejuxrQ
         C1NyxojgX1ducwOiw4uUespqSgx8+tGJSDH8u5fhcG1l/EcTS3AudTXMYxx3bgpMmFZq
         WlTEGxCDfxB9UXGyu0goYz33hEhKhJYCWR04ludzqgYKCiID6ohesXIVBi22LvODtxZU
         6woQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=6qeso0vnhBwFs3iCYpWzxPK0i6KQqKKfr8ULWEkbKXE=;
        b=R+4hRt8RZbRIc9+IfkSXBqOVuGK+8NYrAq58ZZyqDJDJpmfD/Mn2tt8nFJR7frxJGT
         +MyBstMRcNkbbRqktt5D+yhPuuIcU94O95sWKTW9KVqjkunDqI/gmXpr/6KIIobON/WF
         LYEL2J4AdYPh5HyLaSonfN+A07zEJNw6PwagExXieQAwhSOyyAkb/sCHT9tpBgdONGAE
         k8XxNYjoZpvHrg8QD/my5urY+wb4YihfZaskZXZcDmb5RHsBSwwKX+uIc7buXmMrJfKl
         cXMbkm+IFXyrzaahDhE4UYr+JXjgMgifIQLNP+jUVuEVx6gimxybXRkpwQVRFjM6N4lV
         yGng==
X-Gm-Message-State: AOAM530mfgJ1g/zuD8GtWBA+JgWDym+MUOEv1HWTpi4aIuYf3uvxpqKW
        Pkx9soLffSaZwZgtxt6815phXQ==
X-Google-Smtp-Source: ABdhPJyi4Lm5LdstNhafbuakxVCafg4zCdocLCQA6UnRmid6Qr2q0/4YqFwgBUmok/SVzq5TKaqulg==
X-Received: by 2002:a4a:9e02:: with SMTP id t2mr19518865ook.73.1625688395773;
        Wed, 07 Jul 2021 13:06:35 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x29sm3635856ooj.10.2021.07.07.13.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 13:06:35 -0700 (PDT)
Date:   Wed, 7 Jul 2021 13:06:17 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/4] mm/rmap: fix comments left over from recent changes
Message-ID: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parallel developments in mm/rmap.c have left behind some out-of-date
comments: try_to_migrate_one() also accepts TTU_SYNC (already commented
in try_to_migrate() itself), and try_to_migrate() returns nothing at all.

TTU_SPLIT_FREEZE has just been deleted, so reword the comment about it in
mm/huge_memory.c; and TTU_IGNORE_ACCESS was removed in 5.11, so delete
the "recently referenced" comment from try_to_unmap_one() (once upon a
time the comment was near the removed codeblock, but they drifted apart).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/huge_memory.c | 2 +-
 mm/rmap.c        | 7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8b731d53e9f4..afff3ac87067 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2331,7 +2331,7 @@ static void remap_page(struct page *page, unsigned int nr)
 {
 	int i;
 
-	/* If TTU_SPLIT_FREEZE is ever extended to file, remove this check */
+	/* If unmap_page() uses try_to_migrate() on file, remove this check */
 	if (!PageAnon(page))
 		return;
 	if (PageTransHuge(page)) {
diff --git a/mm/rmap.c b/mm/rmap.c
index 37c24672125c..746013e282c3 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1439,8 +1439,6 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	while (page_vma_mapped_walk(&pvmw)) {
 		/*
 		 * If the page is mlock()d, we cannot swap it out.
-		 * If it's recently referenced (perhaps page_referenced
-		 * skipped over this mm) then we should reactivate it.
 		 */
 		if (!(flags & TTU_IGNORE_MLOCK)) {
 			if (vma->vm_flags & VM_LOCKED) {
@@ -1687,8 +1685,7 @@ void try_to_unmap(struct page *page, enum ttu_flags flags)
  * @arg: enum ttu_flags will be passed to this argument.
  *
  * If TTU_SPLIT_HUGE_PMD is specified any PMD mappings will be split into PTEs
- * containing migration entries. This and TTU_RMAP_LOCKED are the only supported
- * flags.
+ * containing migration entries.
  */
 static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 		     unsigned long address, void *arg)
@@ -1928,8 +1925,6 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
  *
  * Tries to remove all the page table entries which are mapping this page and
  * replace them with special swap entries. Caller must hold the page lock.
- *
- * If is successful, return true. Otherwise, false.
  */
 void try_to_migrate(struct page *page, enum ttu_flags flags)
 {
-- 
2.26.2

