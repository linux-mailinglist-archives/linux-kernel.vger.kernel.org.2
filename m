Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF4D3BF0A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 22:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhGGUOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 16:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhGGUOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:14:08 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56753C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 13:11:28 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id r29so4805772oiw.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 13:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=tkLvj3QVD7vexG4Xax0/Xf4fPxWesEvFOVTsRIctnbE=;
        b=DimYOBmWYQW/QLOGazZvGUH0cOp4BjeBWl22T5GUbw5wwRvZulCYsVwboNvrRtKgwq
         UttP+xcQqopqEmJD6lfcDBMwkXxLRzo/f/SBb31xXzpSiqzRSlNAV4u7fPRnCbdERf4M
         N43sXq0FVsEMNu1titCD6BMLDkz2zpPN+ncx2ARPRKlKM0SG0Y9sN34VgP4rYpAXkPYc
         HpInlzLrD5mBPl85Y5sp4MFCMAAgFK19Mv8ZUq5Hulea2JKiig9Mxr0xe7UzBOP8pluX
         u20w9JsZtnjA02ns/eiQtUMDKhoqTN12wsem090lv3CIc1F2oPoQwstOetuD2ObZUZom
         mcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=tkLvj3QVD7vexG4Xax0/Xf4fPxWesEvFOVTsRIctnbE=;
        b=iBSX6ZuHasngv0cFOrJ4zmcgY1SQWEDYdUUoySD3ZeN/mjJ4i6CrXgKt046v/h2xux
         pf1M3rf31YJ2gOVynoez8RjWYxLyF0qypc0OqSquDUwOJtx5SMGS4JFlvZjPw6KbOlII
         0aO5zfpWPs9aZ0y7GkHT1pPOZ2NBr9CNpe5rS5Cd/iLvwk6dJoDj9uXVsIAeI9B8CLJS
         mkLZkf3OryoPdK1t9cUu8bkjuD0uHw02Ir/95xOGp41oS5TXRvSC1Y/moNxkCoNqBnRk
         JSz8GSg5sW4DDy9mMnn66p/UuSthDlg370mv9EbAzqVE09UthqhAaEXdzycWY1qFLt4y
         +Tow==
X-Gm-Message-State: AOAM533QPCuRcVveuf1yNTmBWb3jtZedvJPcFKkDGiFL6IvSAqxkLziD
        g3c1maXk5et99sPiRd85XIUaWA==
X-Google-Smtp-Source: ABdhPJwD0mdBR7pybFHVGT2gLPjXxfazv3v8K3DlmpChS+1CEKZFMvIAsAQKMffg4mopu3SD6qgumw==
X-Received: by 2002:aca:4288:: with SMTP id p130mr20635827oia.80.1625688687563;
        Wed, 07 Jul 2021 13:11:27 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o2sm455650oia.47.2021.07.07.13.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 13:11:27 -0700 (PDT)
Date:   Wed, 7 Jul 2021 13:11:24 -0700 (PDT)
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
Subject: [PATCH 3/4] mm/rmap: fix new bug: premature return from
 page_mlock_one()
In-Reply-To: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com>
Message-ID: <f71f8523-cba7-3342-40a7-114abc5d1f51@google.com>
References: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the unlikely race case that page_mlock_one() finds VM_LOCKED has been
cleared by the time it got page table lock, page_vma_mapped_walk_done()
must be called before returning, either explicitly, or by a final call
to page_vma_mapped_walk() - otherwise the page table remains locked.

Fixes: cd62734ca60d ("mm/rmap: split try_to_munlock from try_to_unmap")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/rmap.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 0e83c3be8568..1235368f0628 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1990,14 +1990,13 @@ static bool page_mlock_one(struct page *page, struct vm_area_struct *vma,
 			 * this function is never called when PageDoubleMap().
 			 */
 			mlock_vma_page(page);
+			/*
+			 * No need to scan further once the page is marked
+			 * as mlocked.
+			 */
 			page_vma_mapped_walk_done(&pvmw);
+			return false;
 		}
-
-		/*
-		 * no need to continue scanning other vma's if the page has
-		 * been locked.
-		 */
-		return false;
 	}
 
 	return true;
-- 
2.26.2

