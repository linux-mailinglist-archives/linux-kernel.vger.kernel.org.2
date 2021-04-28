Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902E436D365
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbhD1Hro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbhD1Hrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:47:43 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA92C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:46:59 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w10so6738628pgh.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=j5ZgSWzuhsKjqSUXE1GUgLCTEhguAnWn3LEnraKymSM=;
        b=OPW3C3yq6ygedhhFwi/oqANu9XBXK6su9rI9OM7RaKZRXDRHe6lT1jfg5SJh8n/q3z
         Famcekju/1YDZNbkOydklqg2sKettB78qUBsnqmbwG827bsruwPtUFkuw3bhKQVCJF9M
         MigxN+8I766+LDZIGKlfQnUNyNH4hoUQvNqNDVRdYPnTme/bfuAEXaWHvcgj4ZbPxD/2
         hGXr3kCjz1+ZgtoYAXyVSaDpLy7HNi3Ys81OjtQkgcntUTLzcxiDy0EI6gzTMQH6SY+U
         QDqVFFAhfzaA/CjBXYolDFlo1eVnsRiTIA+v/3vM3NcWs9wWk64oGoFFicUVqCEbyUsY
         mITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=j5ZgSWzuhsKjqSUXE1GUgLCTEhguAnWn3LEnraKymSM=;
        b=fTL/V+7Maz2N0zDolNtsaiAi8SHV1BsAe22NGM5nCmDyASuMEkJWJr6+v4PMRFS5n4
         434GN783FYpgksNtSGrTX65zwT4RXWrhkHVFaRecLiKfSw4/Plml3NUt7WaetT8+cSlE
         o03V7UiLYUzKsGh77V3G3jaYSBBmDYmzgclRFq/9696i7rD4wVeTJXXe7PHOgknAbAT/
         /htCa/wvGpTc1Hf9ektvEbAiIWsfRz1ZEUjPrbBb6l5Okn+9hAxVs+Y8aZUUqOHdNtMe
         ptC8BDHC0TPiTuwxQQF8aDSGgolpgnErjQe8cE0NF2tpAMDEsy8CUJWxrnypYcxpWBWe
         S8tg==
X-Gm-Message-State: AOAM530/DF/L4oR/Ajvu81+C16LjVme7MPtEhi+ZnUgO0W1UWaoQ4b2r
        JyBi9NEgdZuZEz1SrvsZ/7DtiBSnFj8zx/c=
X-Google-Smtp-Source: ABdhPJysCGbZBEIsLxIYtE1LTTryO9KWLqxsLKyiYbXbYM+D78Z7L7zP4aP5qePzvo1iveiyq0wMHw==
X-Received: by 2002:a63:a47:: with SMTP id z7mr25308472pgk.350.1619596018649;
        Wed, 28 Apr 2021 00:46:58 -0700 (PDT)
Received: from u2004 (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id q8sm4201339pfk.137.2021.04.28.00.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 00:46:58 -0700 (PDT)
Date:   Wed, 28 Apr 2021 16:46:54 +0900
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: [PATCH] mm,hwpoison: fix race with compound page allocation
Message-ID: <20210428074654.GA2093897@u2004>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210423080153.GA78658@hori.linux.bs1.fc.nec.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 08:01:54AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, Apr 22, 2021 at 08:27:46AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> > On Wed, Apr 21, 2021 at 11:03:24AM -0700, Mike Kravetz wrote:
> > > On 4/21/21 1:33 AM, HORIGUCHI NAOYA(堀口 直也) wrote:
> > > > On Wed, Apr 21, 2021 at 10:03:34AM +0200, Michal Hocko wrote:
> > > >> [Cc Naoya]
> > > >>
> > > >> On Wed 21-04-21 14:02:59, Muchun Song wrote:
> > > >>> The possible bad scenario:
> > > >>>
> > > >>> CPU0:                           CPU1:
> > > >>>
> > > >>>                                 gather_surplus_pages()
> > > >>>                                   page = alloc_surplus_huge_page()
> > > >>> memory_failure_hugetlb()
> > > >>>   get_hwpoison_page(page)
> > > >>>     __get_hwpoison_page(page)
> > > >>>       get_page_unless_zero(page)
> > > >>>                                   zero = put_page_testzero(page)
> > > >>>                                   VM_BUG_ON_PAGE(!zero, page)
> > > >>>                                   enqueue_huge_page(h, page)
> > > >>>   put_page(page)
> > > >>>
> > > >>> The refcount can possibly be increased by memory-failure or soft_offline
> > > >>> handlers, we can trigger VM_BUG_ON_PAGE and wrongly add the page to the
> > > >>> hugetlb pool list.
> > > >>
> > > >> The hwpoison side of this looks really suspicious to me. It shouldn't
> > > >> really touch the reference count of hugetlb pages without being very
> > > >> careful (and having hugetlb_lock held).
> > > > 
> > > > I have the same feeling, there is a window where a hugepage is refcounted
> > > > during converting from buddy free pages into free hugepage, so refcount
> > > > alone is not enough to prevent the race.  hugetlb_lock is retaken after
> > > > alloc_surplus_huge_page returns, so simply holding hugetlb_lock in
> > > > get_hwpoison_page() seems not work.  Is there any status bit to show that a
> > > > hugepage is just being initialized (not in free hugepage pool or in use)?
> > > > 
> > > 
> > > It seems we can also race with the code that makes a compound page a
> > > hugetlb page.  The memory failure code could be called after allocating
> > > pages from buddy and before setting compound page DTOR.  So, the memory
> > > handling code will process it as a compound page.
> > 
> > Yes, so get_hwpoison_page() has to call get_page_unless_zero()
> > only when memory_failure() can surely handle the error.
> > 
> > > 
> > > Just thinking that this may not be limited to the hugetlb specific memory
> > > failure handling?
> > 
> > Currently hugetlb page is the only type of compound page supported by memory
> > failure.  But I agree with you that other types of compound pages have the
> > same race window, and judging only with get_page_unless_zero() is dangerous.
> > So I think that __get_hwpoison_page() should have the following structure:
> > 
> >   if (PageCompound) {
> >       if (PageHuge) {
> >           if (PageHugeFreed || PageHugeActive) {
> >               if (get_page_unless_zero)
> >                   return 0;   // path for in-use hugetlb page
> >               else
> >                   return 1;   // path for free hugetlb page
> >           } else {
> >               return -EBUSY;  // any transient hugetlb page
> >           }
> >       } else {
> >           ... // any other compound page (like thp, slab, ...)
> >       }
> >   } else {
> >       ...   // any non-compound page
> >   }
> 
> The above pseudo code was wrong, so let me update my thought.
> I'm now trying to solve the reported issue by changing __get_hwpoison_page()
> like below:
> 
>   static int __get_hwpoison_page(struct page *page)
>   {
>           struct page *head = compound_head(page);
>   
>           if (PageCompound(page)) {
>                   if (PageSlab(page)) {
>                           return get_page_unless_zero(page);
>                   } else if (PageHuge(head)) {
>                           if (HPageFreed(head) || HPageMigratable(head))
>                                   return get_page_unless_zero(head);
>                   } else if (PageTransHuge(head)) {
>                           /*
>                            * Non anonymous thp exists only in allocation/free time. We
>                            * can't handle such a case correctly, so let's give it up.
>                            * This should be better than triggering BUG_ON when kernel
>                            * tries to touch the "partially handled" page.
>                            */
>                           if (!PageAnon(head)) {
>                                   pr_err("Memory failure: %#lx: non anonymous thp\n",
>                                          page_to_pfn(page));
>                                   return 0;
>                           }
>                           if (get_page_unless_zero(head)) {
>                                   if (head == compound_head(page))
>                                           return 1;
>                                   pr_info("Memory failure: %#lx cannot catch tail\n",
>                                           page_to_pfn(page));
>                                   put_page(head);
>                           }
>                   }
>                   return 0;
>           }
>   
>           return get_page_unless_zero(page);
>   }
> 
> Some notes: 
> 
>   - in hugetlb path, new HPage* checks should avoid the reported race,
>     but I still need more testing to confirm it,
>   - PageSlab check is added because otherwise I found that "non anonymous thp"
>     path is chosen, that's obviously wrong,
>   - thp's branch has a known issue unrelated to the current issue, which
>     will/should be improved later.
> 
> I'll send a patch next week.

I confirmed that the patch fixes the reported problem (in the testcase
triggering VM_BUG_ON_PAGE() without this patch).
So let me suggest this as a fix on hwpoison side.

Thanks,
Naoya Horiguchi

---
From: Naoya Horiguchi <naoya.horiguchi@nec.com>
Date: Wed, 28 Apr 2021 15:55:47 +0900
Subject: [PATCH] mm,hwpoison: fix race with compound page allocation

When hugetlb page fault (under overcommiting situation) and memory_failure()
race, VM_BUG_ON_PAGE() is triggered by the following race:

    CPU0:                           CPU1:

                                    gather_surplus_pages()
                                      page = alloc_surplus_huge_page()
    memory_failure_hugetlb()
      get_hwpoison_page(page)
        __get_hwpoison_page(page)
          get_page_unless_zero(page)
                                      zero = put_page_testzero(page)
                                      VM_BUG_ON_PAGE(!zero, page)
                                      enqueue_huge_page(h, page)
      put_page(page)

__get_hwpoison_page() only checks page refcount before taking additional
one for memory error handling, which is wrong because there's time
windows where compound pages have non-zero refcount during initialization.

So makes __get_hwpoison_page() check more page status for a few types
of compound pages. PageSlab() check is added because otherwise
"non anonymous thp" path is wrongly chosen for slab pages.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reported-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memory-failure.c | 48 +++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a3659619d293..61988e332712 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1095,30 +1095,36 @@ static int __get_hwpoison_page(struct page *page)
 {
 	struct page *head = compound_head(page);
 
-	if (!PageHuge(head) && PageTransHuge(head)) {
-		/*
-		 * Non anonymous thp exists only in allocation/free time. We
-		 * can't handle such a case correctly, so let's give it up.
-		 * This should be better than triggering BUG_ON when kernel
-		 * tries to touch the "partially handled" page.
-		 */
-		if (!PageAnon(head)) {
-			pr_err("Memory failure: %#lx: non anonymous thp\n",
-				page_to_pfn(page));
-			return 0;
+	if (PageCompound(page)) {
+		if (PageSlab(page)) {
+			return get_page_unless_zero(page);
+		} else if (PageHuge(head)) {
+			if (HPageFreed(head) || HPageMigratable(head))
+				return get_page_unless_zero(head);
+		} else if (PageTransHuge(head)) {
+			/*
+			 * Non anonymous thp exists only in allocation/free time. We
+			 * can't handle such a case correctly, so let's give it up.
+			 * This should be better than triggering BUG_ON when kernel
+			 * tries to touch the "partially handled" page.
+			 */
+			if (!PageAnon(head)) {
+				pr_err("Memory failure: %#lx: non anonymous thp\n",
+				       page_to_pfn(page));
+				return 0;
+			}
+			if (get_page_unless_zero(head)) {
+				if (head == compound_head(page))
+					return 1;
+				pr_info("Memory failure: %#lx cannot catch tail\n",
+					page_to_pfn(page));
+				put_page(head);
+			}
 		}
+		return 0;
 	}
 
-	if (get_page_unless_zero(head)) {
-		if (head == compound_head(page))
-			return 1;
-
-		pr_info("Memory failure: %#lx cannot catch tail\n",
-			page_to_pfn(page));
-		put_page(head);
-	}
-
-	return 0;
+	return get_page_unless_zero(page);
 }
 
 /*
-- 
2.25.1

