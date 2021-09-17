Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C5C40FE20
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbhIQQt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234729AbhIQQtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631897282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=grUUg8VAspODuuKM93nZK+6Ve54OZS2pE6wnY0B0Xh4=;
        b=OpcFe0vblWmvix7iA0r61WBZM6BEIbGKuzXwJ/i5qTO5uHUkQV9SkmZQ/pDtmjLMMdTL3N
        HlKkFJutVOCQT7EPoLHOgTvfF15lvsdNP0jNsqCdQ1S0zR+cg8d5M5SIiH1BLVB3jjUE1X
        GJq869fEYilwWFV6EMolzUdJtHQUSZs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-J9bGELOfMAGc8XlNVqNksg-1; Fri, 17 Sep 2021 12:48:01 -0400
X-MC-Unique: J9bGELOfMAGc8XlNVqNksg-1
Received: by mail-qt1-f200.google.com with SMTP id l22-20020a05622a175600b0029d63a970f6so90845950qtk.23
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grUUg8VAspODuuKM93nZK+6Ve54OZS2pE6wnY0B0Xh4=;
        b=S/rpwLx1/AexWVEfu+fqsuxPrvZhXwaMgF1wPu+p2Po7J85AIedoldp2lRvVSnL53V
         oWaoxGkt0guMyXCtcr4p4Jr+rgizMgONo9R1XQLDRVcGLSYE4+jo6BtXRUk989gIKEYf
         uH6AOJT/tLqbgRQpP9YV2PbXBKwIgGkO+c4I+TNo5l9sO1rb6AVL26vTOWAaEXGs9F1x
         8at8umkOOikAjM8eYD3in1TPB6Qo9mvlw2iOsclv1yQ9fmbmkQbKzq9s/QIzYi5x/AgS
         ydIpJKATZwFC9Pnl01F2AfROK7JEIeRQYSWcXfoLdvk4BH5eB7wHNHIIWMsOBCcLBotT
         EXSg==
X-Gm-Message-State: AOAM532riDbFjrqXtJe+bjan7XmGwDzoi++RLpPn9c3jrnu5YjqjYeXF
        sHt5+IWLOVv4l4u1cvb2GXr+PZgtvjXrogzwwj4kAkwKk8PA8S9g82KmmeB4M9Ubam7r5+mmVsc
        QgXYgsnpjW4neDl92YPmk/mSG
X-Received: by 2002:a37:a883:: with SMTP id r125mr11301937qke.408.1631897280446;
        Fri, 17 Sep 2021 09:48:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqphWd+Tlov8LMwfi4vrThplMRTxmltW9/KJp77jBhawRfzds+2s8yAR92mY6VZ+JYJoRaqg==
X-Received: by 2002:a37:a883:: with SMTP id r125mr11301917qke.408.1631897280218;
        Fri, 17 Sep 2021 09:48:00 -0700 (PDT)
Received: from t490s.phub.net.cable.rogers.com ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id t26sm4898057qkm.0.2021.09.17.09.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 09:47:59 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/3] mm/smaps: Fix shmem pte hole swap calculation
Date:   Fri, 17 Sep 2021 12:47:54 -0400
Message-Id: <20210917164756.8586-2-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917164756.8586-1-peterx@redhat.com>
References: <20210917164756.8586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shmem swap calculation on the privately writable mappings are using wrong
parameters as spotted by Vlastimil.  Fix them.  That's introduced in commit
48131e03ca4e, when rework shmem_swap_usage to shmem_partial_swap_usage.

Test program:

==================

void main(void)
{
    char *buffer, *p;
    int i, fd;

    fd = memfd_create("test", 0);
    assert(fd > 0);

    /* isize==2M*3, fill in pages, swap them out */
    ftruncate(fd, SIZE_2M * 3);
    buffer = mmap(NULL, SIZE_2M * 3, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    assert(buffer);
    for (i = 0, p = buffer; i < SIZE_2M * 3 / 4096; i++) {
        *p = 1;
        p += 4096;
    }
    madvise(buffer, SIZE_2M * 3, MADV_PAGEOUT);
    munmap(buffer, SIZE_2M * 3);

    /*
     * Remap with private+writtable mappings on partial of the inode (<= 2M*3),
     * while the size must also be >= 2M*2 to make sure there's a none pmd so
     * smaps_pte_hole will be triggered.
     */
    buffer = mmap(NULL, SIZE_2M * 2, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
    printf("pid=%d, buffer=%p\n", getpid(), buffer);

    /* Check /proc/$PID/smap_rollup, should see 4MB swap */
    sleep(1000000);
}
==================

Before the patch, smaps_rollup shows <4MB swap and the number will be random
depending on the alignment of the buffer of mmap() allocated.  After this
patch, it'll show 4MB.

Fixes: 48131e03ca4e ("mm, proc: reduce cost of /proc/pid/smaps for unpopulated shmem mappings")
Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/proc/task_mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index cf25be3e0321..2197f669e17b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -478,9 +478,11 @@ static int smaps_pte_hole(unsigned long addr, unsigned long end,
 			  __always_unused int depth, struct mm_walk *walk)
 {
 	struct mem_size_stats *mss = walk->private;
+	struct vm_area_struct *vma = walk->vma;
 
-	mss->swap += shmem_partial_swap_usage(
-			walk->vma->vm_file->f_mapping, addr, end);
+	mss->swap += shmem_partial_swap_usage(walk->vma->vm_file->f_mapping,
+					      linear_page_index(vma, addr),
+					      linear_page_index(vma, end));
 
 	return 0;
 }
-- 
2.31.1

