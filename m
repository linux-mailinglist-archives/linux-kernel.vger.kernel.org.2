Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534ED30D427
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 08:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhBCHoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 02:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhBCHoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 02:44:13 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93F9C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 23:43:33 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y10so9710969plk.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 23:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PLK0fXGTV/aZy60gi4sbWRXrm5oJCyOUmMAwYs2l3kc=;
        b=DWHoq4YfpZvfFPggnMRXa0ICoZ94Hca5DYROPg7sTO1jlkKDNNlf8LrmNXukorgM2h
         L8/XCU/tUoRbqvRMa3OwT9jVSdeEndAUkZCxXmks1TM5rM05BaHcDa073DhuvXkVREae
         ARdnnoIIIU4ykk6DaR/PGU/fq/qKYll2HWK7We7sIumbRpNOqk93QQ5s6+pnzct0rn9H
         2y4SyZVcLXkpPi51NA9bqb7ygwGm1LXmqAddHulW2m4A0v95dMjb3KHGgPI4fv7iWVQZ
         FS/JazxwqUYvHkp+pFCQRoOJPDEPfFSW+qqFnbu0mXUtQHr0DIafJSs5ZTwQ6LGBz1Cv
         J+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLK0fXGTV/aZy60gi4sbWRXrm5oJCyOUmMAwYs2l3kc=;
        b=F1UHR+9uBUPrKcqA7weELWFvRXwcpvEQrt9UU251cCZhqU1ibf0oeejUH0YcQmsXOA
         LKTyy7VmZOYHVIg37sVcgUgjsa1AW9NUPYSHz9/MzCdb/xx4A3xXJjwnWjvM84dcARi4
         zQeseqcCscPRiqRCimW80QhyPSFVf3Jvs3H+vpKq8JUQqsF+wpgyZLnxjgqADPr2BHq0
         Q4CoONxhl+LvuF3bz3ndUS20heu4+rKG1VeDlsuKBneaQr+nuo0uhRkOjuuk1M8aVOZ3
         vwX9DwmIC6GnJGJwOyC3jdgib3Pbxv9coXocKcBzHx1i5I2SnZGNe7jzzJwUscN+0WyR
         J98w==
X-Gm-Message-State: AOAM531PizOibKTpZWOvopmCEdaVYmmaQCDS46Hwkd5MS2dKaF2Hm466
        grMZK4QbdH8YTkvCfMWm2zehCtKeNO2ZGge9+FKIUsMQgltGUjRB
X-Google-Smtp-Source: ABdhPJzWVaFIMz8/t6fWqkHg2driCh5/ifol7AZ9aj3rQdByOff7VRFs3n8EC750wIpZm23gngPk83gscPdA4v4clPE=
X-Received: by 2002:a17:902:b7c7:b029:e1:6cbe:db19 with SMTP id
 v7-20020a170902b7c7b02900e16cbedb19mr2161965plz.20.1612338213170; Tue, 02 Feb
 2021 23:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20210120013049.311822-1-mike.kravetz@oracle.com> <20210120013049.311822-3-mike.kravetz@oracle.com>
In-Reply-To: <20210120013049.311822-3-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 3 Feb 2021 15:42:57 +0800
Message-ID: <CAMZfGtUda+KoAZscU0718TN61cSFwp4zy=y2oZ=+6Z2TAZZwng@mail.gmail.com>
Subject: Re: [External] [PATCH v2 2/5] hugetlb: convert page_huge_active()
 HPageMigratable flag
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 9:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Use the new hugetlb page specific flag HPageMigratable to replace the
> page_huge_active interfaces.  By it's name, page_huge_active implied
> that a huge page was on the active list.  However, that is not really
> what code checking the flag wanted to know.  It really wanted to determine
> if the huge page could be migrated.  This happens when the page is actually
> added the page cache and/or task page table.  This is the reasoning behind
> the name change.
>
> The VM_BUG_ON_PAGE() calls in the *_huge_active() interfaces are not
> really necessary as we KNOW the page is a hugetlb page.  Therefore, they
> are removed.
>
> The routine page_huge_active checked for PageHeadHuge before testing the
> active bit.  This is unnecessary in the case where we hold a reference or
> lock and know it is a hugetlb head page.  page_huge_active is also called
> without holding a reference or lock (scan_movable_pages), and can race with
> code freeing the page.  The extra check in page_huge_active shortened the
> race window, but did not prevent the race.  Offline code calling
> scan_movable_pages already deals with these races, so removing the check
> is acceptable.  Add comment to racy code.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Hi Mike,

I found that you may forget to remove set_page_huge_active()
from include/linux/hugetlb.h.

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 37fd248ce271..6f680cf0eee6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -852,7 +852,7 @@ static inline void
huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 }
 #endif

-void set_page_huge_active(struct page *page);
+

Thanks.
