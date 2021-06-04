Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2714439B055
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 04:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhFDCZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 22:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDCZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 22:25:15 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6291C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 19:23:13 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id a7so4255294qvf.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 19:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6gtl5ml3oidODRLTiq6SWXD7TlK86nyhuDo2wphJy1I=;
        b=nieY8GPV5VcbWLx7nkMjysrhPRr8sWODb8bEwy1mMCBVbAMQnmQWWK4pjsrcN5Qaij
         FGMdxt4G9Q1XxXKzbPskpoeg/Oc4kfvHEaxX2n6HNO57NxA7zbZ4UoUfJfXZf2zYLdDF
         xQq/1EXKmvYZT8bbuZEY/CxJPtidOGfwfrbpTlGOv9EfebdWtwDO5XcpS1U2PPpe0gtb
         jTUHlEdetUxRZMMFv0Na+/It04KyHaJfyYhHESYggmFEOjh8T0DT9rUD9ILm9RYLo7m1
         3/DsARInKvJlkUyjrYVnAwJLX1HDN19mSsFY/UV2XmziBkYNUyFT97NxN5OwTAaCAcye
         0NrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6gtl5ml3oidODRLTiq6SWXD7TlK86nyhuDo2wphJy1I=;
        b=h6QDEmqp/S/5te5eOTWCMqjGQ0N9IeJmYYTMxCC0bbkGguHUmFDeKypnOz7BXUhwxG
         oZqspQybyyN+bzXbSCYho71wzVjGGP6d5UB5qMm84Ie4gpSjluDq0N2nCY3V+qs3xzzP
         WSzplD/uUSEk9rbLEvPMaUWkFxAi1Njl6Z7kfr7gFGY9Hwvy7rv8P1K8aYbUw4xOndnC
         /m8RbOuWcH20axoTsnxIjhcdAcAPilbs02HpexMGlAA4HMRImpxd1clcvYwtPKY0m8ZK
         kS1tbhDQuI+LSeEESMbpTn3hCtptQuXFILLHjhSGvqqZ9k5cZhpqsoVrGxe3izmw1xyK
         T/fQ==
X-Gm-Message-State: AOAM532juaHj28U7P8yEhUvHtqmG4kRtAQbFfqMRvGxfoWPNpCq1febZ
        OxoyTyHWWrYMRTXXulaz5E3vNA==
X-Google-Smtp-Source: ABdhPJwwB2zxuvULDFNA+UdpVFjdXE9dq+wyPQR+joCvQKgMl+S5FbnsWQiOEBUl0NGPRn11ZbH6lQ==
X-Received: by 2002:a05:6214:260f:: with SMTP id gu15mr2627898qvb.21.1622773392735;
        Thu, 03 Jun 2021 19:23:12 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k13sm3132765qki.24.2021.06.03.19.23.10
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Jun 2021 19:23:12 -0700 (PDT)
Date:   Thu, 3 Jun 2021 19:22:59 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] mm/thp: fix __split_huge_pmd_locked() on shmem
 migration entry
In-Reply-To: <CAHbLzkobMaW15iN6y8Zot3kmpA1c4z2r6rSR7B9Pqwg5YY+hcA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2106031918400.12760@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils> <alpine.LSU.2.11.2106011403540.2148@eggly.anvils> <CAHbLzkobMaW15iN6y8Zot3kmpA1c4z2r6rSR7B9Pqwg5YY+hcA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021, Yang Shi wrote:
> On Tue, Jun 1, 2021 at 2:05 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > Are there more places that need to be careful about pmd migration entries?
> > None hit in practice, but several of those is_huge_zero_pmd() tests were
> > done without checking pmd_present() first: I believe a pmd migration entry
> > could end up satisfying that test.  Ah, the inversion of swap offset, to
> > protect against L1TF, makes that impossible on x86; but other arches need
> > the pmd_present() check, and even x86 ought not to apply pmd_page() to a
> > swap-like pmd.  Fix those instances; __split_huge_pmd_locked() was not
> > wrong to be checking with pmd_trans_huge() instead, but I think it's
> > clearer to use pmd_present() in each instance.
...
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 63ed6b25deaa..9fb7b47da87e 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1676,7 +1676,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >                 spin_unlock(ptl);
> >                 if (is_huge_zero_pmd(orig_pmd))
> >                         tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
> > -       } else if (is_huge_zero_pmd(orig_pmd)) {
> > +       } else if (pmd_present(orig_pmd) && is_huge_zero_pmd(orig_pmd)) {
> 
> If it is a huge zero migration entry, the code would fallback to the
> "else". But IIUC the "else" case doesn't handle the huge zero page
> correctly. It may mess up the rss counter.

A huge zero migration entry?  I hope that's not something special
that I've missed.

Do we ever migrate a huge zero page - and how do we find where it's
mapped, to insert the migration entries?  But if we do, I thought it
would use the usual kind of pmd migration entry; and the first check
in is_pmd_migration_entry() is !pmd_present(pmd).

(I have to be rather careful to check such details, after getting
burnt once by pmd_present(): which includes the "huge" bit even when
not otherwise present, to permit races with pmdp_invalidate().
I mentioned in private mail that I'd dropped one of my "fixes" because
it was harmless but mistaken: I had misunderstood pmd_present().)

The point here (see commit message above) is that some unrelated pmd
migration entry could pass the is_huge_zero_pmd() test, which rushes
off to use pmd_page() without even checking pmd_present() first.  And
most of its users have, one way or another, checked pmd_present() first;
but this place and a couple of others had not.

I'm just verifying that it's really a a huge zero pmd before handling
its case; the "else" still does not need to handle the huge zero page.

Hugh
