Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E123A0B0F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhFIEUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:20:08 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:38843 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhFIEUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:20:07 -0400
Received: by mail-qk1-f175.google.com with SMTP id c138so9629039qkg.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 21:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=pMyjc9CYqvbfrzl29URaDu3TgxtX0dXCEwyNP3GAvus=;
        b=e+RJ2E4Zeq65xDwtDBfefBHjqSQnt+ObhFB8cWd4WRWktC46wAECrkAZKegtHdI57U
         HyS/iTRZE/hQ/0dcjCit9KO1wTdujI5nzTGsQKyg9bQ9N2gU1tj4YVT8ng8kZREo+E96
         xARjzVhT8FwML3scpPqULTgmVCY4SQM+lYFSWhA8HS/odAxZoSccQjNwV2nTcEMzZSqQ
         DIY1QHUYRNURhsUZE2XmNWgYyGCdf5Aae/6I2/mYb8dovDNSfNE1rHjzju6+5ttvsrpP
         qJbZyxiXkKTI3g8+QTZRDVwQ/qMO+rxvZW0EGckKBU+OweiVkeyZ3hQbL4N4AXxrI7DL
         0XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=pMyjc9CYqvbfrzl29URaDu3TgxtX0dXCEwyNP3GAvus=;
        b=hSe2qO4mSqIfIpC+ynNAUP2244hqKLc7bEjWO8ckFTe3V6uGzjQAxCqfV/ttoeZWtw
         e/2OKDSPwWN0g4MAEfm6IqPEsdgtqFXehw4Vz6dsLzn9my09832wXKaVXWgyQVHvQHfj
         SnLE35uVqodah0fVeZiZLCaQba8waG0EJfZD3/J6rXtzX1QkdqVPxnet6Wi3fVtWxqIY
         /95yFAYW19HLfpIlNCnCL6LAEHJDJ2FNKgb5U1iv+w4bSs+BtrCrIpltz4zrlFlYr+y2
         oafGj+yDKzbeh8aDPLeHwI+rn6EnuCuXHm/Z/vke5xPn5FX8xpH7hyybTk3OKE8bWSRh
         L+hw==
X-Gm-Message-State: AOAM530jvHgfYcrnJjTq5BY/HkzrjT93ujhYFc2Rv3nyCRVhh++OURxk
        BZbILmoq7YW7WeCrJFXifwLQ2g==
X-Google-Smtp-Source: ABdhPJzwS8WKYUfmOquNK2fdMAaAFTRZEgzgFXIqA/SGDE+nqIO6HtJ9kNcpbTsmL3mRhIqH41zW8g==
X-Received: by 2002:a05:620a:39e:: with SMTP id q30mr25347667qkm.116.1623212219181;
        Tue, 08 Jun 2021 21:16:59 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k19sm7673587qkj.89.2021.06.08.21.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 21:16:58 -0700 (PDT)
Date:   Tue, 8 Jun 2021 21:16:55 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] mm/thp: fix page_address_in_vma() on file THP
 tails
In-Reply-To: <af88612-1473-2eaa-903-8d1a448b26@google.com>
Message-ID: <a0d9b53-bf5d-8bab-ac5-759dc61819c1@google.com>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jue Wang <juew@google.com>

Anon THP tails were already supported, but memory-failure may need to use
page_address_in_vma() on file THP tails, which its page->mapping check did
not permit: fix it.

hughd adds: no current usage is known to hit the issue, but this does fix
a subtle trap in a general helper: best fixed in stable sooner than later.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Signed-off-by: Jue Wang <juew@google.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: <stable@vger.kernel.org>
---
 mm/rmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 144de54efc1c..e05c300048e6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -716,11 +716,11 @@ unsigned long page_address_in_vma(struct page *page, struct vm_area_struct *vma)
 		if (!vma->anon_vma || !page__anon_vma ||
 		    vma->anon_vma->root != page__anon_vma->root)
 			return -EFAULT;
-	} else if (page->mapping) {
-		if (!vma->vm_file || vma->vm_file->f_mapping != page->mapping)
-			return -EFAULT;
-	} else
+	} else if (!vma->vm_file) {
+		return -EFAULT;
+	} else if (vma->vm_file->f_mapping != compound_head(page)->mapping) {
 		return -EFAULT;
+	}
 
 	return vma_address(page, vma);
 }
-- 
2.26.2

