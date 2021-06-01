Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7755397B97
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhFAVNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbhFAVNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:13:08 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04671C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 14:11:26 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso559250otl.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 14:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=mGezqLCwqfVvLkMCE7dsqP76GlZ1rrIMTNorbY8nnRE=;
        b=XiFqJgKbQf+NFm9F2qeWGDqMQtIusE6tfI/d7uCReiNCeI8t1UgzW0tp8FS3tjI6Qn
         MM058Q8yao+WMfmJTIHUWTNzTCfxl0dIXFzHmnGtdNyydEMDn2/e3yjwWs/UzgnrXiML
         QqN3GCoZNMystw71jGSHVCRio97HkV3DOsCbiacwt0uIOU20iUscldneY3FmvXADytiw
         qcm939hv9ywb7M2e+4AI/6XxQYrUoTPfjXtvMcRDBA3OWOrUJYdf8NTD8fr9lVL5CNAr
         lijoUGLV2r+wmMfg5xsYNOja0Wpem4iA836KRAUuaYwYszImmI/uOurTB+d/d9VaEbPt
         V9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=mGezqLCwqfVvLkMCE7dsqP76GlZ1rrIMTNorbY8nnRE=;
        b=PL582XI12cIYohdq189+mlOC2Rr9pzWfWHSgdzjTfQC5L+x2hhY0LmqAFaPQXKIsXM
         RgsKOmHopERfP6SBj5sLVg6aRkdsDsv39JvEDTm04ok3mlzKdxaujRvEN5K/9h37CiIE
         wtnoG+xYP/8mLfMXwS0ZJ8UAM9xs/YkVA3lzEywS5R/YWcP2Y4Q2vOYGh8GaX1rCMCuH
         LRWeWI2Wmyy9CLXNkr3INn4vAsufTrJG72IlZtx9dlie5iF+t5gPcj2ddNMntLs3ouLH
         V7PjCSsYVN71aiPNMxNzrEp2+plFoh6/rXTF2jqetmTMAmxlGD2+Hf1vLUdvqPfepoUA
         KH4Q==
X-Gm-Message-State: AOAM533d1Ncmj1UXTSRVWIiUIZxgd4zk3DRAgD2im5BEfjoZI7faQdQj
        smhxmHgnXWzkHNRe+ScsGOxUSg==
X-Google-Smtp-Source: ABdhPJwbmIlsdvD15zqtJYc7eIWJ6uhy2nPvhdlXW5j9Ohe3labw6u0GYlOiclpWFjO1cjJLZLKpjg==
X-Received: by 2002:a9d:684e:: with SMTP id c14mr23250577oto.295.1622581885174;
        Tue, 01 Jun 2021 14:11:25 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t14sm3644391ooh.39.2021.06.01.14.11.23
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Jun 2021 14:11:24 -0700 (PDT)
Date:   Tue, 1 Jun 2021 14:11:22 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
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
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] mm/thp: fix page_address_in_vma() on file THP tails
In-Reply-To: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2106011409390.2148@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
2.32.0.rc0.204.g9fa02ecfa5-goog

