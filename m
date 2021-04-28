Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3B836E1DE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbhD1WwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 18:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237050AbhD1WwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619650277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikZqRIOJ+24TbcCJgwh1xPSL1L/jSOOAtcHmb6Z6UD4=;
        b=NBF8g1n0mN5zruzXAL+v811Sao4hxFBKeMvyy3Gl2LKXtkbg/WrmVXNTlzZKFxB0tFx+Zq
        nKmMxk4CVGwa4DwXmsKjY7e1xeUycVqn+16oS3BaZJ7oGoWe26sdh1U2cCUcqSazPu5AZi
        AKFOHXkw7rmwHT+14Rf0NWrb3d/7iSs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-J9NiAw0hOR-4FYzWt3pnCw-1; Wed, 28 Apr 2021 18:51:15 -0400
X-MC-Unique: J9NiAw0hOR-4FYzWt3pnCw-1
Received: by mail-qk1-f198.google.com with SMTP id y9-20020ae9f4090000b02902e4caf24229so6010165qkl.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 15:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikZqRIOJ+24TbcCJgwh1xPSL1L/jSOOAtcHmb6Z6UD4=;
        b=VyvK0T52ILEldlLHeFQ95B77i8MfOf2nCig2Z8wqNdU8Q3X7nt4bw2bbbZO/X0Z5wm
         aZ76lV6JFhAGFzyS2cPQFdn+JZ3/Q/DnsucVro1bZcbVKYJRYDsqRdQN2OGzzHQ0TNPM
         tSkH24K3fsoEqOOFxwP9I1fSAoJ8LJWotnJkVWCEXzhjqGC2RSusYSC/DL88F9/w0xPw
         kBsS7Awn8jO8lOSOVNffGlJ2CUZV+aStW85+ZzU2R28JZS3ZMTBaUPnpcEI3NMxJxXZ8
         yX8tzQTrFsmc7ImpQURMhbezEAiuo3Y7QD1lr8V2h/uaIsAPNgWdmRcdO6bjC0JawjW2
         CqMA==
X-Gm-Message-State: AOAM532mqQiDqRIP4ZQePkddXw6jx2WCrx+rybmsChaZ3YgHLZYePB+2
        aDKR9jyNWPxAVPtViSWa5fhdTs9Hip4Ps992aA91UWs2C2P0LDZvBarZkg6vPYItnneUeiypidJ
        hOnwnB5OB8oTVV8TuFu3NGAT0
X-Received: by 2002:a05:622a:589:: with SMTP id c9mr28868875qtb.363.1619650274989;
        Wed, 28 Apr 2021 15:51:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrX3v3lU9B1pVnyP5Nb9hlKNKEN2NRRr8EhEd2xq4l8HH5y/69IZS/YQAW1T0WiwuZgL+rNg==
X-Received: by 2002:a05:622a:589:: with SMTP id c9mr28868855qtb.363.1619650274762;
        Wed, 28 Apr 2021 15:51:14 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id 191sm897459qkk.31.2021.04.28.15.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 15:51:14 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH 1/6] mm/thp: Simplify copying of huge zero page pmd when fork
Date:   Wed, 28 Apr 2021 18:50:25 -0400
Message-Id: <20210428225030.9708-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210428225030.9708-1-peterx@redhat.com>
References: <20210428225030.9708-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huge zero page is handled in a special path in copy_huge_pmd(), however it
should share most codes with a normal thp page.  Trying to share more code with
it by removing the special path.  The only leftover so far is the huge zero
page refcounting (mm_get_huge_zero_page()), because that's separately done with
a global counter.

This prepares for a future patch to modify the huge pmd to be installed, so
that we don't need to duplicate it explicitly into huge zero page case too.

Cc: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 98456017744d6..22bf2d0fff79b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1076,17 +1076,13 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
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
@@ -1110,6 +1106,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	get_page(src_page);
 	page_dup_rmap(src_page, true);
 	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+out_zero_page:
 	mm_inc_nr_ptes(dst_mm);
 	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
 
-- 
2.26.2

