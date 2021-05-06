Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F15374CDF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 03:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhEFBc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 21:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEFBcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 21:32:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7CBC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 18:31:26 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x7-20020a17090a5307b02901589d39576eso1559533pjh.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 18:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JqBOzORC8TCN+TAvEv5mh2kPfbvuSNtE/HHJhl6GmcY=;
        b=pQp18OSOYI9c0F5d+qtvUO9Xq7cnQ1nVHDgXxhXa01MQrzUkF1MRziKdmJGECRvGJV
         /TmbXl+Z+GGyNaZ8XVCCZiWI3AG/9PoOROehVrnEJxnN6Ijvx8FkTzZbmDZbhSb7MOts
         ZYb1m2b1ai0DS2t4zdmqPO5J2vws4HW5HLimHVYUqn7Hh0vz5GXePAeskXDDDWNCfHzg
         UxAwPptWFFvpA24KgV6ke5sujxaI7Mcs+NLg+vpKOGKLarLw9++hCDkJ698DreVQJSOs
         U6OrGOmjVLXlvYWNOLsjIileCweVtcvDm2NOTKuh475tjlpkUUQOkiuHakeDzK2M/jtM
         6xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JqBOzORC8TCN+TAvEv5mh2kPfbvuSNtE/HHJhl6GmcY=;
        b=Re+gN43V0hhVgaU63iFC0deDK5FVwtjbOrdCb9zRoxioli/BnH+3nRMexJZwk3cYhF
         mZ4CBZqeP52vuW6iFIgpc5qxI3UESG6Ln+N4CTi6APAYK4uTTX4ukyZlcsPOB3f/vlBr
         MdidFK4wtvC+cFfcIyOvBUjrpKqBl3EotGB2UjMMdebce/5smL68UN87Bzgek55qCmBy
         WOLOiKMoQ4R1m/uhU3UgxDT2w7eh+HnOs7xoiFFAhb0hzmb3vXlsp5vo9W//LVgAx19l
         NA/3HX/ns7jDOn0bK1daxldUSvSWhRBX5qGQa22UZLqRwaiPl8G6fwJbPUstItNhhNJ+
         A5MA==
X-Gm-Message-State: AOAM532TzlGYxU00WhJDihUaZieeGXXuLKBDba4hFomebJ4QKVbHcylV
        FAfkP7Y9xui81Yp4szPLXw==
X-Google-Smtp-Source: ABdhPJzYPpQHgAokgwGqUEZIvxt+P6HAjlKLcIwbKMvD3pZDWr4ePaf2osbkv/QF6ieCF7hxIeoi+A==
X-Received: by 2002:a17:903:3091:b029:ee:ef64:c389 with SMTP id u17-20020a1709033091b02900eeef64c389mr1810668plc.74.1620264686322;
        Wed, 05 May 2021 18:31:26 -0700 (PDT)
Received: from u2004 (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id z18sm405232pfa.39.2021.05.05.18.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 18:31:25 -0700 (PDT)
Date:   Thu, 6 May 2021 10:31:22 +0900
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mm,hwpoison: fix race with compound page allocation
Message-ID: <20210506013122.GA2240524@u2004>
References: <20210423080153.GA78658@hori.linux.bs1.fc.nec.co.jp>
 <20210428074654.GA2093897@u2004>
 <20210428082344.GA29213@linux>
 <20210428091835.GA273940@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210428091835.GA273940@hori.linux.bs1.fc.nec.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 09:18:36AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Wed, Apr 28, 2021 at 10:23:49AM +0200, Oscar Salvador wrote:
> > On Wed, Apr 28, 2021 at 04:46:54PM +0900, Naoya Horiguchi wrote:
> > > ---
> > > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > Date: Wed, 28 Apr 2021 15:55:47 +0900
> > > Subject: [PATCH] mm,hwpoison: fix race with compound page allocation
> > > 
> > > When hugetlb page fault (under overcommiting situation) and memory_failure()
> > > race, VM_BUG_ON_PAGE() is triggered by the following race:
> > > 
> > >     CPU0:                           CPU1:
> > > 
> > >                                     gather_surplus_pages()
> > >                                       page = alloc_surplus_huge_page()
> > >     memory_failure_hugetlb()
> > >       get_hwpoison_page(page)
> > >         __get_hwpoison_page(page)
> > >           get_page_unless_zero(page)
> > >                                       zero = put_page_testzero(page)
> > >                                       VM_BUG_ON_PAGE(!zero, page)
> > >                                       enqueue_huge_page(h, page)
> > >       put_page(page)
> > > 
> > > __get_hwpoison_page() only checks page refcount before taking additional
> > > one for memory error handling, which is wrong because there's time
> > > windows where compound pages have non-zero refcount during initialization.
> > > 
> > > So makes __get_hwpoison_page() check more page status for a few types
> > > of compound pages. PageSlab() check is added because otherwise
> > > "non anonymous thp" path is wrongly chosen for slab pages.
> > 
> > Was it wrongly chosen even before? If so, maybe a Fix tag is warranted.
> 
> OK, I'll check when this was introduced.
> 
> > 
> > > 
> > > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > Reported-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  mm/memory-failure.c | 48 +++++++++++++++++++++++++--------------------
> > >  1 file changed, 27 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > index a3659619d293..61988e332712 100644
> > > --- a/mm/memory-failure.c
> > > +++ b/mm/memory-failure.c
> > > @@ -1095,30 +1095,36 @@ static int __get_hwpoison_page(struct page *page)
> > 
> > > +	if (PageCompound(page)) {
> > > +		if (PageSlab(page)) {
> > > +			return get_page_unless_zero(page);
> > > +		} else if (PageHuge(head)) {
> > > +			if (HPageFreed(head) || HPageMigratable(head))
> > > +				return get_page_unless_zero(head);
> > 
> > There were concerns raised wrt. memory-failure should not be fiddling with page's
> > refcount without holding a hugetlb lock.
> > So, if we really want to make this more stable, we might want to hold the lock
> > here.
> > 
> > The clearing and setting of HPageFreed happens under the lock, and for HPageMigratable
> > that is also true for the clearing part, so I think it would be more sane to do
> > this under the lock to close any possible race.
> > 
> > Does it make sense?
> 
> Thanks, I'll update to do the check under hugetlb_lock.

Hi,

Let me share the update below.  Two changes:
    - hold hugetlb_lock in hugetlb path,
    - added Fixes tag and cc to stable. I limited the stable branch only to 5.12+
      due to the dependency on HPage* pseudo flags.

- Naoya

---
From: Naoya Horiguchi <naoya.horiguchi@nec.com>
Date: Thu, 6 May 2021 09:54:39 +0900
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
"non anonymous thp" path is wrongly chosen.

Fixes: ead07f6a867b ("mm/memory-failure: introduce get_hwpoison_page() for consistent refcount handling")
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reported-by: Muchun Song <songmuchun@bytedance.com>
Cc: stable@vger.kernel.org # 5.12+
---
 mm/memory-failure.c | 53 +++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a3659619d293..966a1d6b0bc8 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1095,30 +1095,41 @@ static int __get_hwpoison_page(struct page *page)
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
+			int ret = 0;
+
+			spin_lock(&hugetlb_lock);
+			if (HPageFreed(head) || HPageMigratable(head))
+				ret = get_page_unless_zero(head);
+			spin_unlock(&hugetlb_lock);
+			return ret;
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
