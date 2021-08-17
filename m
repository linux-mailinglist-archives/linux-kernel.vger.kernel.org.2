Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEAA3EE856
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbhHQIXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhHQIXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:23:16 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFF8C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:22:43 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id y144so9101124qkb.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=uMoWHC9cCmkGmKGRd5MKhVSuBe7FnrhK9vgIvOjVdUQ=;
        b=ZBCIu8JrSYXp32UHfr0V7Utr7kxWRAe1330WqMcSxMAU6EkiQqUl+y1J5Qgw9zu6HD
         NbkPMfRczuZxY7kB6NMOGMop7Adk9XdWy838R5kRiHLdhQnSwo+amn5PLFOZlFHq4xxu
         fuiU/mu3Z1aAmGE7CU3PikodGjnJJAXDr6m6cRNcOYdL7N1MEgpdgWzqOSxyRIHdrPGM
         eNZoVBUcsUl/lVaaIPFBHo1n96GV6/jnDvZpc8M88qKmmCutIfCz0r1Pwv550TNDZfb3
         f5S0fTAcV1CggoawTLJg1zAyNa3uWYd8wePzYvXiseBVnqgsTnVYdKMYF4M1crB/QQrX
         fFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=uMoWHC9cCmkGmKGRd5MKhVSuBe7FnrhK9vgIvOjVdUQ=;
        b=UZlhRQLeFVjjCCe79kzRwQ4jzU3tIlr7oSaHsXDSfQgPx5d2/Q0PEZ8Q1f060taqY0
         moehBjhqumxnfah1NMpp4PiI0PcB0B7pGVYcxtutQuPXVnxk+cd/ca/86fX0SgAdWDHU
         yRhdKzUS+XY9aChD2XEkz9ioSRyKIi9zTVjKyNaGQQzOkNu8A+e9gppczmRBhq3recnl
         48ZYNPzgrH5XRLgG45/gbChLyt4HwP2fZvR7BdDG9QBhcLNQOueYBMqVfpgfWkL73zeS
         fBqdRTX5RMUewKDB0tSV1k+mS25S+Ihae1mW/uNOTq5rqS6gYWFNiKRk+MURPteQ5l2p
         1b/g==
X-Gm-Message-State: AOAM532zW/oK/0QjOZpfKaYe4+1rI3gEl4FvbVYXQtYa+TZmX9QfiD/B
        8ub0SSVtOkjUoAoVQ5olw0AXyKlfp+nsyA==
X-Google-Smtp-Source: ABdhPJysm9W9si8YZq6HQ/Q9doxawpakksZKCtswsPYBwhARLV5gH6YuEjM4S4T/sg5Os7AMzVnpvA==
X-Received: by 2002:a05:620a:16b7:: with SMTP id s23mr2582871qkj.154.1629188562319;
        Tue, 17 Aug 2021 01:22:42 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b25sm499732qka.23.2021.08.17.01.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:22:41 -0700 (PDT)
Date:   Tue, 17 Aug 2021 01:22:39 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 8/9] huge tmpfs: decide stat.st_blksize by shmem_is_huge()
In-Reply-To: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
Message-ID: <af7fb3f9-4415-9e8e-fdac-b1a5253ad21@google.com>
References: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18 commit 89fdcd262fd4 ("mm: shmem: make stat.st_blksize return huge
page size if THP is on") added is_huge_enabled() to decide st_blksize:
if hugeness is to be defined per file, that will need to be replaced by
shmem_is_huge().

This does give a different answer (No) for small files on a
"huge=within_size" mount: but that can be considered a minor bugfix.
And a different answer (No) for default files on a "huge=advise" mount:
I'm reluctant to complicate it, just to reproduce the same debatable
answer as before.

Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
---
 mm/shmem.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 56ee56b1cab6..b60a7abff27d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -689,15 +689,6 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-static inline bool is_huge_enabled(struct shmem_sb_info *sbinfo)
-{
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-	    (shmem_huge == SHMEM_HUGE_FORCE || sbinfo->huge) &&
-	    shmem_huge != SHMEM_HUGE_DENY)
-		return true;
-	return false;
-}
-
 /*
  * Like add_to_page_cache_locked, but error if expected item has gone.
  */
@@ -1078,7 +1069,6 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 {
 	struct inode *inode = path->dentry->d_inode;
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct shmem_sb_info *sb_info = SHMEM_SB(inode->i_sb);
 
 	if (info->alloced - info->swapped != inode->i_mapping->nrpages) {
 		spin_lock_irq(&info->lock);
@@ -1087,7 +1077,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 	}
 	generic_fillattr(&init_user_ns, inode, stat);
 
-	if (is_huge_enabled(sb_info))
+	if (shmem_is_huge(NULL, inode, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
 
 	return 0;
-- 
2.26.2

