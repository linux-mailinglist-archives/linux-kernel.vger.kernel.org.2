Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C0C3E8452
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 22:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhHJUaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbhHJUaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:30:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A35C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 13:29:41 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k2so22872769plk.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g/pTJfigSCEh5kckZ70NaOFpwcYGnuFXZ4+14JoNPQc=;
        b=dgoxXGQqN4xU6YEPuThXK7v1DTae92iDRcALKgKvLO2p9wvXc8Gby6jXL9xrh8aXpl
         y+y77nHdKJy4yAOH1UFqMvuh4g9O+NHr4Ht99XWVyBt5f0fwwn6+hZ7jLPbljT3RgYhL
         tQUHdnnitxR33DRP87VLkRlI0Lp0a2N27Hmz199C9flOLfYc9sAMJpDKzpvthCaLI6ea
         NEjRwLAqOM76XT/HP8MwrM4IfhXwhfmGBR3b4wSo/RsLaZZDw/2cXUzy1webG25+GVTP
         8i8tmmlJyoQh0tyB5xBMrZ/gKNn7dpb9uENpx9XDvjaq2UZsGy7jP9wBgwzI34kvqQ5a
         n4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/pTJfigSCEh5kckZ70NaOFpwcYGnuFXZ4+14JoNPQc=;
        b=A7OjDpbZxMQD2mMY9qmUDKEc4cgNNErPuyWYD6DG1mTBRiRdJMBHnPiWoR99tnzsO4
         T0IpWgfFv8n0jbAeEaBqrMjcw8AZKsKr4C3529NN21BwQHdByGSNgYnKmwixwPRpLbqp
         r4VNswoDhMLOUR1WBeizhOItBzxZYdqvd9bdDYGTof5Z98YVTYonfglTZnKbSNsOpFQS
         Nt05jkQCFabUvtJDxmp9ge0OAkYTuKMAPOp8e2tU7D0yOrKv9IPDOgQpTVHi+OKfsRT3
         ySSBofviLBfDFcYwjbalqXnWxgOHAYk7fiuzh/4EeHYwCfi1LYVt5oqrn/XyBL0NuwA+
         M+UA==
X-Gm-Message-State: AOAM533nnzKf1mWqFUop3ea8TCTB/QmSbJmy/WZJopQQ+BedEsG5pUgd
        ciblwWRW8h/vLqJrmzNxFP0=
X-Google-Smtp-Source: ABdhPJw3R1cjaI6hRD7+jh7X4bu72Tk12gIFPbsf9htD7SeLAXnKzFekOLSN1lT9i7SmvtzvLMUGlA==
X-Received: by 2002:a62:87c5:0:b029:3b5:f90f:c2eb with SMTP id i188-20020a6287c50000b02903b5f90fc2ebmr31281252pfe.28.1628627381588;
        Tue, 10 Aug 2021 13:29:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id e12sm24697145pfc.214.2021.08.10.13.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 13:29:40 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     hughd@google.com, ying.huang@intel.com, linmiaohe@huawei.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Revert "mm/shmem: fix shmem_swapin() race with swapoff"
Date:   Tue, 10 Aug 2021 13:29:35 -0700
Message-Id: <20210810202936.2672-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210810202936.2672-1-shy828301@gmail.com>
References: <20210810202936.2672-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the change about how block layer detects congestion the
justification of commit 8fd2e0b505d1 ("mm: swap: check if swap backing device
is congested or not") doesn't stand anymore, so the commit could be just
reverted in order to solve the race reported by commit 2efa33fc7f6e ("mm/shmem:
fix shmem_swapin() race with swapoff"), so the fix commit could be just
reverted as well.

Suggested-by: Hugh Dickins <hughd@google.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/shmem.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index dcc07d14162e..d5427de5bf02 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1699,8 +1699,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
-	struct swap_info_struct *si;
-	struct page *page = NULL;
+	struct page *page;
 	swp_entry_t swap;
 	int error;
 
@@ -1708,12 +1707,6 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	swap = radix_to_swp_entry(*pagep);
 	*pagep = NULL;
 
-	/* Prevent swapoff from happening to us. */
-	si = get_swap_device(swap);
-	if (!si) {
-		error = EINVAL;
-		goto failed;
-	}
 	/* Look it up and read it in.. */
 	page = lookup_swap_cache(swap, NULL, 0);
 	if (!page) {
@@ -1775,8 +1768,6 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	swap_free(swap);
 
 	*pagep = page;
-	if (si)
-		put_swap_device(si);
 	return 0;
 failed:
 	if (!shmem_confirm_swap(mapping, index, swap))
@@ -1787,9 +1778,6 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 		put_page(page);
 	}
 
-	if (si)
-		put_swap_device(si);
-
 	return error;
 }
 
-- 
2.26.2

