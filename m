Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB5A44FFB5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbhKOIIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:08:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55677 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234849AbhKOIGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636963406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ILY47EUAX8YWGrwtSg12WPG1Xh7JfzVTNjA+1Egv88U=;
        b=cZ7ef8m71jqt5slTBUXB9MzyLT3tASANifzSiQP58oTRCZqbBGowF2BcC0A+kIjlq7D7up
        fsVA6FrqK9ng0s+Ku+62bS5Sst2wwosro5zYso0xbd5lt16GiqZAI9p5bEBy1/KM4/dU1L
        uPMNOHyEoY4NqDKTnMJ23isEtlfEYy4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-rYIIYGCJOUuIq3zRTmpzwQ-1; Mon, 15 Nov 2021 03:03:24 -0500
X-MC-Unique: rYIIYGCJOUuIq3zRTmpzwQ-1
Received: by mail-pl1-f200.google.com with SMTP id x18-20020a170902ec9200b00143c6409dbcso489678plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:03:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ILY47EUAX8YWGrwtSg12WPG1Xh7JfzVTNjA+1Egv88U=;
        b=BRKdOjf4/euoVHmP/N7ROBa1nV3Iiaui/q2U1gNpdD+BObg7N1TRyX/5WR0C3h5eea
         CecRbrrHL/wc0zkWhKqHYfckL9rZ3l6DVRfBQWAFJvhLmnddSxvLfM7kmRIdoVnkadp7
         7wn2bZZ2eY79S4Y16AthXpBNazeHR/6eisQutQLS8lqP5ucAWojgXSJkolMJRQ7+Yivs
         hIMwtr/EKTOHG5bHHe7SnGSMnCZRH2R6Es2F7xVLL0VTVgDAT9J9UyXBYmPNGFkJmuP6
         bwbgGUqsaH9lh/LcVT8lIHxOTucnrWfMhJQS2FvcWlZV9/ATWtejUUuzeLp7hOQlcN2S
         vZSA==
X-Gm-Message-State: AOAM532esvAmfCoTCM+ilJrtUVb9LDocbTEYOvVZBsOcMQ/e3xeEEiZ2
        mK4D9o/jKdyjlljsysG8C8Z8BxyZO7nAbSL/0wNC7aqcz+Q77g1x80SaVtr2I7OUd6SlgpZhJpj
        HhctGRGXO/WHRudDFKuVG9OUX
X-Received: by 2002:a17:90b:1d0e:: with SMTP id on14mr62720941pjb.119.1636963403592;
        Mon, 15 Nov 2021 00:03:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxn0Rp/rkm5Ee0ybXP2u5WW8WzuvnOkz9ms/eTShUG9S2uyIUVwsqBwYx3b+PT9/ChdhtyCSA==
X-Received: by 2002:a17:90b:1d0e:: with SMTP id on14mr62720896pjb.119.1636963403271;
        Mon, 15 Nov 2021 00:03:23 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.89])
        by smtp.gmail.com with ESMTPSA id rm10sm12783901pjb.29.2021.11.15.00.03.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:03:22 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v6 19/23] mm/khugepaged: Don't recycle vma pgtable if uffd-wp registered
Date:   Mon, 15 Nov 2021 16:03:10 +0800
Message-Id: <20211115080310.75154-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we're trying to collapse a 2M huge shmem page, don't retract pgtable pmd
page if it's registered with uffd-wp, because that pgtable could have pte
markers installed.  Recycling of that pgtable means we'll lose the pte markers.
That could cause data loss for an uffd-wp enabled application on shmem.

Instead of disabling khugepaged on these files, simply skip retracting these
special VMAs, then the page cache can still be merged into a huge thp, and
other mm/vma can still map the range of file with a huge thp when proper.

Note that checking VM_UFFD_WP needs to be done with mmap_sem held for write,
that avoids race like:

         khugepaged                             user thread
         ==========                             ===========
     check VM_UFFD_WP, not set
                                       UFFDIO_REGISTER with uffd-wp on shmem
                                       wr-protect some pages (install markers)
     take mmap_sem write lock
     erase pmd and free pmd page
      --> pte markers are dropped unnoticed!

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/khugepaged.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e99101162f1a..9c75153a36de 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1454,6 +1454,10 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE))
 		return;
 
+	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
+	if (userfaultfd_wp(vma))
+		return;
+
 	hpage = find_lock_page(vma->vm_file->f_mapping,
 			       linear_page_index(vma, haddr));
 	if (!hpage)
@@ -1594,7 +1598,15 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 * reverse order. Trylock is a way to avoid deadlock.
 		 */
 		if (mmap_write_trylock(mm)) {
-			if (!khugepaged_test_exit(mm)) {
+			/*
+			 * When a vma is registered with uffd-wp, we can't
+			 * recycle the pmd pgtable because there can be pte
+			 * markers installed.  Skip it only, so the rest mm/vma
+			 * can still have the same file mapped hugely, however
+			 * it'll always mapped in small page size for uffd-wp
+			 * registered ranges.
+			 */
+			if (!khugepaged_test_exit(mm) && !userfaultfd_wp(vma)) {
 				spinlock_t *ptl = pmd_lock(mm, pmd);
 				/* assume page table is clear */
 				_pmd = pmdp_collapse_flush(vma, addr, pmd);
-- 
2.32.0

