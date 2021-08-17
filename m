Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206E93EE7FC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbhHQIHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbhHQIG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:06:59 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDBFC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:06:25 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id v1so10709763qva.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=O9s4DPf1EPyNh/heSsyriAAWi5ei5uslG+fh5iqpDHM=;
        b=cPdYKEewpU4jCNb8wD3BV92DYOU1v3r7O6UXdBAqUA0jBAcX2Eb69vIKyir7IuKIuS
         VEYU7UFk/+56re91uN29M8zzUUMSeznJT69W2RwnfVFR2xVnZ6b9KeKrnniGWWTGqtvF
         qtFlja3Z7RebrnzlTDc1i1CLy+RETxEVVSUBDxKeRIt/wwM2idapdUdqNxkh30zVOXmQ
         ONlY7AYGaRXdVN4L4kNZYDyuCuT99wM4j3h+T99pMiOwZKIPQWUMpRClOPv3LGo5XLCq
         MFFtAwNPKcBP7v8wx2EHGfNhaEq1cEFSYvJrk/AL/9c1pVwUn7KU/BRCaLtf3ibh1/gA
         yM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=O9s4DPf1EPyNh/heSsyriAAWi5ei5uslG+fh5iqpDHM=;
        b=AWKDvas2h5Ff+XJeBWNuVGGjUkwFw1Po9+1zhXc6f5nRopnTTF56miIY7Qv5yJujft
         /ldjT3cjITLu7zMF1im1Z1dMzIczW9dhSG5yM7nObaKuIY0UuiT2gkCq1Kt/AJVBSCVn
         pUCc2t9RZjnGo5oK4OgKBaxxbtmhrQrntrMpM+L2DNeSbgxf3MFZzOmcCXhI5usUMin+
         QigZ2YMXOjCQdQP22YOIPzgP0XNGYzmWD02uTOj9BD82xUJkRB4XR/znxcGjDQo71PHB
         oe/nB2WbIVh6nosIKU+Gcg0Rejm527KeJoLstKr8MagskOYIp7u70RoORlIRqMzEclY1
         T5Zw==
X-Gm-Message-State: AOAM5326ad7CLEHtOFGyZIllPmD9Df8QGkpt1quLoXTNRN9/jOWbPX/4
        xWiiDMSvWIUOXLPI321+8/y1GQ==
X-Google-Smtp-Source: ABdhPJwWtCeso79FFWIOIARYcHD6ce/4VjU95Aj+MM9ocNEv+dznWyCx4fajWaOxbQb+hvx/ZFX7aA==
X-Received: by 2002:a0c:f20c:: with SMTP id h12mr2013192qvk.56.1629187584811;
        Tue, 17 Aug 2021 01:06:24 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p187sm871565qkd.101.2021.08.17.01.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:06:24 -0700 (PDT)
Date:   Tue, 17 Aug 2021 01:06:22 -0700 (PDT)
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
Subject: [PATCH 1/9] huge tmpfs: fix fallocate(vanilla) advance over huge
 pages
In-Reply-To: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
Message-ID: <16201bd2-70e-37e2-e89b-5f929430da@google.com>
References: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shmem_fallocate() goes to a lot of trouble to leave its newly allocated
pages !Uptodate, partly to identify and undo them on failure, partly to
leave the overhead of clearing them until later.  But the huge page case
did not skip to the end of the extent, walked through the tail pages one
by one, and appeared to work just fine: but in doing so, cleared and
Uptodated the huge page, so there was no way to undo it on failure.

And by setting Uptodate too soon, it messed up both its nr_falloced and
nr_unswapped counts, so that the intended "time to give up" heuristic
did not work at all.

Now advance immediately to the end of the huge extent, with a comment on
why this is more than just an optimization.  But although this speeds up
huge tmpfs fallocation, it does leave the clearing until first use, and
some users may have come to appreciate slow fallocate but fast first use:
if they complain, then we can consider adding a pass to clear at the end.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
---
 mm/shmem.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 70d9ce294bb4..0cd5c9156457 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2736,7 +2736,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	inode->i_private = &shmem_falloc;
 	spin_unlock(&inode->i_lock);
 
-	for (index = start; index < end; index++) {
+	for (index = start; index < end; ) {
 		struct page *page;
 
 		/*
@@ -2759,13 +2759,26 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 			goto undone;
 		}
 
+		index++;
+		/*
+		 * Here is a more important optimization than it appears:
+		 * a second SGP_FALLOC on the same huge page will clear it,
+		 * making it PageUptodate and un-undoable if we fail later.
+		 */
+		if (PageTransCompound(page)) {
+			index = round_up(index, HPAGE_PMD_NR);
+			/* Beware 32-bit wraparound */
+			if (!index)
+				index--;
+		}
+
 		/*
 		 * Inform shmem_writepage() how far we have reached.
 		 * No need for lock or barrier: we have the page lock.
 		 */
-		shmem_falloc.next++;
 		if (!PageUptodate(page))
-			shmem_falloc.nr_falloced++;
+			shmem_falloc.nr_falloced += index - shmem_falloc.next;
+		shmem_falloc.next = index;
 
 		/*
 		 * If !PageUptodate, leave it that way so that freeable pages
-- 
2.26.2

