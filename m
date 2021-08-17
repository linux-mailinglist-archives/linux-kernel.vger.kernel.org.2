Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCCE3EE882
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhHQI3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbhHQI3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:29:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EADC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:29:00 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id e15so16503998qtx.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=4uvnY/LMX/fosu9BxO1MG6ugTMEZPtMwQldGntwsVH4=;
        b=NjCpK1NRhKmstHnpGiLXqM2SKOhBWtRSCCvP/5Amp0gqEwqp6QT1o+8ceJjU6jfYcL
         rDI6S2AFNamPsB4rByVDzyJlXKw4KZXU6D0rbktDv/9QfD0J2t8oUAaB2sOJGLBryTbW
         Eg9ME3auwtSoigl65liufDjtNbWJvOmgaeLq0eHHCyxJsULVCFf7GfGUgrPKsbxSwVQA
         cmdDUSbsnv+SoYjurKcsqszQmy4FQpbClnq9Zw42AWXe3ivRgU+PvAoZN1q5lME2rVm4
         TE3/faPz6Y+vVIFyvh3bn7WAE5/J5u/v0idpkWltxqrs69YoF8K/Vp1jMsvycr72ZwZl
         rKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=4uvnY/LMX/fosu9BxO1MG6ugTMEZPtMwQldGntwsVH4=;
        b=G8kGjULSYeS/UX5CG5Q5DII9tltulBxA9fpLBMLnsbLCdpo2enOfYZCG2hElnoQAq5
         PtbCXUglw8eCZ7xNDqvpZWEhUnYkC3+NobW5Q+zLwSTBkDNdo8AlKK8dQkLavhkgU4PB
         n4fGslz0or7bYL3hvAv8PPtM5C+pVQ4lcgOvvLDcPmg/8jyGdAprEER+lkp0cKD2PA0a
         cuW1lCekokz9d65gT7ELSf0JB3lW7FkQLHzymUHLo2HwwyRICTNKHTbSH1M0GptAGLCg
         6BlFfVL31xKQhm0sJmVNDCw+5xddHk/ng7+eyoJ44OkBICDcHJL+WqlPYKrvGXhoz97+
         DBzw==
X-Gm-Message-State: AOAM532Kv+QNH07W1zV229wiD0p0yjldc3UEjacxxg7Kc8/IYwgYSdC3
        QnhffHfgtJJJblmcapFBvDO/5Q==
X-Google-Smtp-Source: ABdhPJztKNjW9cvImVzVkZCglVqcSZySr11aNl7DJSxBXfIwHrFeR9hnzWG21G8vh8C8WBnA9lcvAg==
X-Received: by 2002:a05:622a:13d4:: with SMTP id p20mr2056913qtk.380.1629188939512;
        Tue, 17 Aug 2021 01:28:59 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y26sm884220qkm.65.2021.08.17.01.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:28:58 -0700 (PDT)
Date:   Tue, 17 Aug 2021 01:28:56 -0700 (PDT)
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
        Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 9/9] shmem: shmem_writepage() split unlikely i915 THP
In-Reply-To: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
Message-ID: <bac6158c-8b3d-4dca-cffc-4982f58d9794@google.com>
References: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/i915/gem/i915_gem_shmem.c contains a shmem_writeback()
which calls shmem_writepage() from a shrinker: that usually works well
enough; but if /sys/kernel/mm/transparent_hugepage/shmem_enabled has been
set to "always" (intended to be usable) or "force" (forces huge everywhere
for easy testing), shmem_writepage() is surprised to be called with a huge
page, and crashes on the VM_BUG_ON_PAGE(PageCompound) (I did not find out
where the crash happens when CONFIG_DEBUG_VM is off).

LRU page reclaim always splits the shmem huge page first: I'd prefer not
to demand that of i915, so check and split compound in shmem_writepage().

Patch history: when first sent last year
http://lkml.kernel.org/r/alpine.LSU.2.11.2008301401390.5954@eggly.anvils
https://lore.kernel.org/linux-mm/20200919042009.bomzxmrg7%25akpm@linux-foundation.org/
Matthew Wilcox noticed that tail pages were wrongly left clean.  This
version brackets the split with Set and Clear PageDirty as he suggested:
which works very well, even if it falls short of our aspirations.  And
recently I realized that the crash is not limited to the testing option
"force", but affects "always" too: which is more important to fix.

Fixes: 2d6692e642e7 ("drm/i915: Start writeback from the shrinker")
Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Yang Shi <shy828301@gmail.com>
---
 mm/shmem.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b60a7abff27d..a1ba03f39eaa 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1349,7 +1349,19 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	swp_entry_t swap;
 	pgoff_t index;
 
-	VM_BUG_ON_PAGE(PageCompound(page), page);
+	/*
+	 * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "always" or
+	 * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
+	 * and its shmem_writeback() needs them to be split when swapping.
+	 */
+	if (PageTransCompound(page)) {
+		/* Ensure the subpages are still dirty */
+		SetPageDirty(page);
+		if (split_huge_page(page) < 0)
+			goto redirty;
+		ClearPageDirty(page);
+	}
+
 	BUG_ON(!PageLocked(page));
 	mapping = page->mapping;
 	index = page->index;
-- 
2.26.2

