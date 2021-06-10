Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB043A24BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhFJGwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJGwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:52:37 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5443EC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 23:50:26 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id e18so14168264qvm.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=MW3P4dEVpzQaKkCia9N+0MaZJYQT+2IAhJVUZg7cfs8=;
        b=Do8aT0u+DdZZq8kaOVvB6kgFwGS6mToQyGIoS2wWY4uZ3M/EtH9HIcV12t4Dntbu4B
         GSIWT43fzAd1hVrjp33IgBv/via5r3NIF7MXRDjCH4X2pxhRMwAV7HcouDjLk6kIda0G
         C77fRSpITnyPd2/XRz/RJyywcVeEZYG/HfryDo45NoUasSyLQPKi1euqRC+PfEg+vddE
         PwCwcq6Iqa3GiwU4B6VYphKpI242PJS34F4JI0jv5njbSjFOXldXBll/yYyqDWeVRGb4
         STufu8xuwTwB7QL2nHvVLIOTQ95uumyfHuejvqKOZ/YfEufUrAtwIpjTPqeUgPnIP4BZ
         2yLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=MW3P4dEVpzQaKkCia9N+0MaZJYQT+2IAhJVUZg7cfs8=;
        b=mafG01UpPVUoCLctULj3lZ2B7pnBlyob5HJo1ydJyD27nUrGb3a0Te2xQDy0o4vXrM
         Wjc4FZbXNS6LloQJN/slOMJwXiTQxPjtftRxRT3CLjtgw+RHpcKvedqN3vC4OJFBfuXY
         NpX69BQPQZvxh5raLGImvpiiCd7+UxBaZi9lNQY050fss70SzM/cyDLg5OSG8H0+cn5X
         DXRS1Y1aFVB23l9ik7b3SRzTZxP4EPdfClaObjCxDirgNg90Er5+EzBsxkNmy/aqlAtP
         OxzpSvZWCUlibxfsbMo/0u4F2GXFFT126m+cg/2wtPMNYtc/7hFYJ6tqhHNDrNP+drdE
         7jGA==
X-Gm-Message-State: AOAM532S/qtJHWHrXXZj6Xn8RkZshC7Hm2A6s+x6d6RHuRy+N85AX1vv
        xBTMIfglpJVcDQ7zqCyJbF/pVA==
X-Google-Smtp-Source: ABdhPJxZswruLW9txlbS5dufC/7Inh5U9BCmjlx6PQDp97tfhKPQgM3yJjJJ09wVZQfRUJlz0FRbqw==
X-Received: by 2002:ad4:5fc7:: with SMTP id jq7mr3417734qvb.41.1623307825295;
        Wed, 09 Jun 2021 23:50:25 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 85sm1678043qko.14.2021.06.09.23.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 23:50:25 -0700 (PDT)
Date:   Wed, 9 Jun 2021 23:50:23 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] mm: page_vma_mapped_walk(): get vma_address_end()
 earlier
In-Reply-To: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
Message-ID: <4542b34d-862f-7cb4-bb22-e0df6ce830a2@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_vma_mapped_walk() cleanup: get THP's vma_address_end() at the start,
rather than later at next_pte.  It's a little unnecessary overhead on the
first call, but makes for a simpler loop in the following commit.

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/page_vma_mapped.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 006f4814abbc..f6839f536645 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -171,6 +171,15 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		return true;
 	}
 
+	/*
+	 * Seek to next pte only makes sense for THP.
+	 * But more important than that optimization, is to filter out
+	 * any PageKsm page: whose page->index misleads vma_address()
+	 * and vma_address_end() to disaster.
+	 */
+	end = PageTransCompound(page) ?
+		vma_address_end(page, pvmw->vma) :
+		pvmw->address + PAGE_SIZE;
 	if (pvmw->pte)
 		goto next_pte;
 restart:
@@ -239,10 +248,6 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		if (check_pte(pvmw))
 			return true;
 next_pte:
-		/* Seek to next pte only makes sense for THP */
-		if (!PageTransHuge(page))
-			return not_found(pvmw);
-		end = vma_address_end(page, pvmw->vma);
 		do {
 			pvmw->address += PAGE_SIZE;
 			if (pvmw->address >= end)
-- 
2.26.2

