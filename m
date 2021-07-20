Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343673CFE6E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbhGTPRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242667AbhGTPL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626796318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7D01Sf7WyFpDy5iBOSB8keAwNmDOKVpIqWY7HiG+shw=;
        b=B4rHv74MMGdmEukvxqcrtcs2Al8hJkEhv2r7yZ1lWdK8CE5VHdpoB8+WbruE8Qh9d6Ymbm
        Mq6iGTtIfq7W91IzOOLVGLiW7bM2ilO0vdnYQpsrbi2lS0d6H748SEpgYt7E8lN0MMA1D2
        K+GA14HnjYdsxIGgdrct0Nkl0xz4Ea4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-YBDt462POcm-FIpoY3xtyQ-1; Tue, 20 Jul 2021 11:51:56 -0400
X-MC-Unique: YBDt462POcm-FIpoY3xtyQ-1
Received: by mail-qv1-f71.google.com with SMTP id c22-20020a0ca9d60000b02902e60d75210eso19698551qvb.19
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 08:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7D01Sf7WyFpDy5iBOSB8keAwNmDOKVpIqWY7HiG+shw=;
        b=JCz/owUTUDeWz/PSIpXxFT+1if1pZMvrqbFT4tyiN5ftRWiSYeiH7CHEYiOM8LwUXS
         mUu7waj6fiTFz11L5ROZEnfwPwkz8IE4aPreMrSQy5MpqcFheGjpsjKEWSmaRa9P/vbF
         TKYA0j9IYmsH8FI7jWpvYmEv5MI8uy+Kqtlir+9ijybHY0ZpJcoUquB/Uf1Umc5Ni07F
         Zd8dUyrGUBtZwtgodChamybfkKsEtk8PC8bEwuh9fHQQ2Tq+rIRPw6OXBQbDbYjQOmi5
         6qwzsQfx9xaLXNwxWTS84y2XRO5iDaf5iNMECMHnN7uj5wM8OVAt+gUxFGWKZd8HQiNW
         lNNw==
X-Gm-Message-State: AOAM532h9v6i7BKnSblJJ5MX684R9WCmog6JpwwV2cKucUHd0SLhisWM
        gHuyOx+uJ7Og6oIQfmec6RVV2dyX0I57Ay6cD5LENgpFkymD29U3EUW/v1Fjoq/Vv1IsNciqYpE
        QjUvLeixRlYGd+siMgCyke8m9
X-Received: by 2002:a37:dcc2:: with SMTP id v185mr29847461qki.167.1626796316444;
        Tue, 20 Jul 2021 08:51:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9NUWZkskDEWU7mGn9bqckF/hMB20JHvsawHIkAgaxaveiacbm2PLft2c6YquFp8IjnR6I+Q==
X-Received: by 2002:a37:dcc2:: with SMTP id v185mr29847443qki.167.1626796316237;
        Tue, 20 Jul 2021 08:51:56 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id c15sm5467012qtc.37.2021.07.20.08.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 08:51:55 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     stable@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Hillf Danton <hdanton@sina.com>, Igor Raits <igor@gooddata.com>
Subject: [PATCH stable 5.13.y/5.12.y 1/2] mm/thp: simplify copying of huge zero page pmd when fork
Date:   Tue, 20 Jul 2021 11:51:49 -0400
Message-Id: <20210720155150.497148-2-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720155150.497148-1-peterx@redhat.com>
References: <796cbb7-5a1c-1ba0-dde5-479aba8224f2@google.com>
 <20210720155150.497148-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series "mm/uffd: Misc fix for uffd-wp and one more test".

This series tries to fix some corner case bugs for uffd-wp on either thp
or fork().  Then it introduced a new test with pagemap/pageout.

Patch layout:

Patch 1:    cleanup for THP, it'll slightly simplify the follow up patches
Patch 2-4:  misc fixes for uffd-wp here and there; please refer to each patch
Patch 5:    add pagemap support for uffd-wp
Patch 6:    add pagemap/pageout test for uffd-wp

The last test introduced can also verify some of the fixes in previous
patches, as the test will fail without the fixes.  However it's not easy
to verify all the changes in patch 2-4, but hopefully they can still be
properly reviewed.

Note that if considering the ongoing uffd-wp shmem & hugetlbfs work, patch
5 will be incomplete as it's missing e.g.  hugetlbfs part or the special
swap pte detection.  However that's not needed in this series, and since
that series is still during review, this series does not depend on that
one (the last test only runs with anonymous memory, not file-backed).  So
this series can be merged even before that series.

This patch (of 6):

Huge zero page is handled in a special path in copy_huge_pmd(), however it
should share most codes with a normal thp page.  Trying to share more code
with it by removing the special path.  The only leftover so far is the
huge zero page refcounting (mm_get_huge_zero_page()), because that's
separately done with a global counter.

This prepares for a future patch to modify the huge pmd to be installed,
so that we don't need to duplicate it explicitly into huge zero page case
too.

Link: https://lkml.kernel.org/r/20210428225030.9708-1-peterx@redhat.com
Link: https://lkml.kernel.org/r/20210428225030.9708-2-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Brian Geffon <bgeffon@google.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
Cc: Mina Almasry <almasrymina@google.com>
Cc: Oliver Upton <oupton@google.com>
Cc: Shaohua Li <shli@fb.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Wang Qing <wangqing@vivo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 5fc7a5f6fd04bc18f309d9f979b32ef7d1d0a997)
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8857ef1543eb..4cea1e218b48 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1088,17 +1088,13 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	 * a page table.
 	 */
 	if (is_huge_zero_pmd(pmd)) {
-		struct page *zero_page;
 		/*
 		 * get_huge_zero_page() will never allocate a new page here,
 		 * since we already have a zero page to copy. It just takes a
 		 * reference.
 		 */
-		zero_page = mm_get_huge_zero_page(dst_mm);
-		set_huge_zero_page(pgtable, dst_mm, vma, addr, dst_pmd,
-				zero_page);
-		ret = 0;
-		goto out_unlock;
+		mm_get_huge_zero_page(dst_mm);
+		goto out_zero_page;
 	}
 
 	src_page = pmd_page(pmd);
@@ -1122,6 +1118,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	get_page(src_page);
 	page_dup_rmap(src_page, true);
 	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+out_zero_page:
 	mm_inc_nr_ptes(dst_mm);
 	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
 
-- 
2.31.1

