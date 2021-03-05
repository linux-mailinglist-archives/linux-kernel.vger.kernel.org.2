Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E5E32EBA3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 13:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCEMw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 07:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhCEMwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 07:52:51 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE6EC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 04:52:51 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id i14so1803756pjz.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 04:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JYg8YweLZdbUf9BN7yPIkniCjV+jX92R/nckK3AvHhc=;
        b=tFPJRWdH2tWcIqtx7mrEbL3daOlr0XKJcsYshWPLJ0jG2WXB/dVzEYt6L5J1do7uDn
         eY07dalaGhpJNWbPSgmmUagLf9LfvE8azvtlXDjXjD3C8W2lZtzfIs4fabFMzyMsn1zt
         NrKPGV4S4T8Bc72Zpa/QtDkVtpOyYLsRuNNjKQght6NGDhZ6iiiqcplI2o5NIY0nQkGU
         92u5DCL6aDEIrxV/OnrX8PItWFpzMCw9965b2yHplUUuTz7/t7pty7W0+nXqOnhRCNeX
         0jL+J8AgUeRAsYhBPBN64PF43LCt6AUtewA2HKqNCZLUubJAdX05Hqn55T4GKz0AufWx
         795Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JYg8YweLZdbUf9BN7yPIkniCjV+jX92R/nckK3AvHhc=;
        b=C7KS5vg4YnpL2ec0ngwhz0qA9crEmz6yuEk+vkKw/xgRur5odKb/DYu5sFa3FSTpeW
         Kk9I/Jti1a7pt9H5L5j+TK9HvPcouHTcMaRlrrj9v7nVteQShwzzzLDywFYbaQPyAOnO
         de9IB1fqIwP9E1RctCaYOMM6vNFE1NeieMtIZKWGp49CogB/eQH16Rv5kx2gBxpmWk4e
         fXE2kNSucf3t8SqVGBknsE+eApZzgZuEGPnFamr2t7uvTH8Ob4cPecgD4vP4otS/bjlR
         NbaNyYVdsBG95Ah0RwjRz26gKBpf/VajfACbJnUOQq6seicEE594y6mTG2ZiBUDO6V+u
         klVQ==
X-Gm-Message-State: AOAM533lMmUdWJtqROEJSV0fJG1k4OjNR2ca16YKhsZ5Ma5Vdn4YWbrx
        8nwcVtaaVjqLPG+tlIMfLA==
X-Google-Smtp-Source: ABdhPJzSoZMhJZPnneKHc3zpAGUojwCBTR2wIIFm3TRC+QgRacC5MnnvKDXue7tjNNjwCpm2LFU4Ew==
X-Received: by 2002:a17:90a:71c3:: with SMTP id m3mr10214603pjs.186.1614948770657;
        Fri, 05 Mar 2021 04:52:50 -0800 (PST)
Received: from u2004 (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id ms21sm2524497pjb.5.2021.03.05.04.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 04:52:50 -0800 (PST)
Date:   Fri, 5 Mar 2021 21:52:46 +0900
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm, hwpoison: do not lock page again when me_huge_page()
 successfully recovers
Message-ID: <20210305125246.GA975517@u2004>
References: <20210304064437.962442-1-nao.horiguchi@gmail.com>
 <20210305072652.GA18868@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline
In-Reply-To: <20210305072652.GA18868@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oscar,

On Fri, Mar 05, 2021 at 08:26:58AM +0100, Oscar Salvador wrote:
> On Thu, Mar 04, 2021 at 03:44:37PM +0900, Naoya Horiguchi wrote:
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Hi Naoya,
> 
> good catch!
> 
> > Currently me_huge_page() temporary unlocks page to perform some actions
> > then locks it again later. My testcase (which calls hard-offline on some
> > tail page in a hugetlb, then accesses the address of the hugetlb range)
> > showed that page allocation code detects the page lock on buddy page and
> > printed out "BUG: Bad page state" message.  PG_hwpoison does not prevent
> > it because PG_hwpoison flag is set on any subpage of the hugetlb page
> > but the 2nd page lock is on the head page.
> 
> I am having difficulties to parse "PG_hwpoison does not prevent it because
> PG_hwpoison flag is set on any subpage of the hugetlb page".
> 
> What do you mean by that?

What was in my mind is that check_new_page_bad() does not consider
a page with __PG_HWPOISON as bad page, so this flag works as kind of
filter, but this filtering doesn't work in my case because the
"bad page" is not the actual hwpoisoned page.

Thank for nice comment, I've updated the patch below with this description.

> 
> > 
> > This patch suggests to drop the 2nd page lock to fix the issue.
> > 
> > Fixes: commit 78bb920344b8 ("mm: hwpoison: dissolve in-use hugepage in unrecoverable memory error")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> The fix looks fine to me:
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thank you!

Have a nice weekend.
- Naoya

---
From eaaaab05750c13fe9b637190410289a3168b097e Mon Sep 17 00:00:00 2001
From: Naoya Horiguchi <naoya.horiguchi@nec.com>
Date: Fri, 5 Mar 2021 21:44:47 +0900
Subject: [PATCH v2] mm, hwpoison: do not lock page again when me_huge_page()
 successfully recovers

Currently me_huge_page() temporary unlocks page to perform some actions
then locks it again later. My testcase (which calls hard-offline on some
tail page in a hugetlb, then accesses the address of the hugetlb range)
showed that page allocation code detects this page lock on buddy page and
printed out "BUG: Bad page state" message.

check_new_page_bad() does not consider a page with __PG_HWPOISON as bad
page, so this flag works as kind of filter, but this filtering doesn't work
in this case because the "bad page" is not the actual hwpoisoned page.

This patch suggests to drop the 2nd page lock to fix the issue.

Fixes: commit 78bb920344b8 ("mm: hwpoison: dissolve in-use hugepage in unrecoverable memory error")
Cc: stable@vger.kernel.org
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory-failure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e9481632fcd1..d8aba15295c5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -830,7 +830,6 @@ static int me_huge_page(struct page *p, unsigned long pfn)
 			page_ref_inc(p);
 			res = MF_RECOVERED;
 		}
-		lock_page(hpage);
 	}
 
 	return res;
@@ -1286,7 +1285,8 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 
 	res = identify_page_state(pfn, p, page_flags);
 out:
-	unlock_page(head);
+	if (PageLocked(head))
+		unlock_page(head);
 	return res;
 }
 
-- 
2.25.1
