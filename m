Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A3739C26A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhFDVbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhFDVbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:31:23 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA26EC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 14:29:21 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t140so5862040oih.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=XCilaUhmoV4ajw4OBwjUyKW2dscXR1iV+XY/1Kzgmyc=;
        b=QkkeBjuuRUXrC5bcLPn/znSS6L1suJyev0jGsH/ObLM7ZRYw0FATlwRMlF+tOMsMYl
         jA+xzbmzCSA/ceeDvLA3vLeSbhewwpofvnaO6Ub2w8cqHT8TGLGTlHwbAamC3wdUgAf1
         TcuUtSGjWbOeOqj7cGJ1zSUQrXj5yQtJ71eR5xtm9lN7fVq+x686MEgNmcjQE5sgAVKx
         Vs23KwsbqMVXjGjgTijzaPX1w28ZxwQBtTCPxRK6SQ6FgFdEfH6xbaJkfenBQX5Xb4Y2
         SklLQrL1Gq0z8dPq4JRqnMhpbnq7PYvSqe0f+ReFbYSVfLuFBIZ1NCTSwNJTDeyb9ACd
         kZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=XCilaUhmoV4ajw4OBwjUyKW2dscXR1iV+XY/1Kzgmyc=;
        b=obYLknWoF0/PkB1ajS6lblHaiIejJBD9+wFyEv+XUb0JwfxyT5Mi6s8KLoTOls2e1G
         KHUefDrcem2n5+c/QKFqggaLI9i3Y42DZjIooSM4jvll59t2xqYUmmbFH2LuPXQfY3aN
         m1X9X4IUXf657mEnhNmXrgI5kleLb3DPXkT4Q/tnhM8kh5uLdGCV+H+k9JFoaJZk2LKV
         kG/YH3kW5KFfMTydXX4G2aWDVCUEetFasSBvEkE0hzKwunIJx75Es8UVY+vcKgp4GzTK
         3oKOp78iUYDQES50KUyHteCiMAbhLSoui8rAeFmYhArHsbP4eQSmdhBDegTBCxvp/4cS
         ktQw==
X-Gm-Message-State: AOAM5337WKyUEQ0W8BaSgQg+NL5/EzjjP1AZU2Wc0KObIUwg9MolMBqZ
        xSOWHs33JZxnfsK3v5JQLjNowQ==
X-Google-Smtp-Source: ABdhPJyQ57sys35NWkmseEMkaZ8FSDIEaje0ne/BirGc48zSKFNUnOdunQZg8p8FiLuVJJT4PG1cJQ==
X-Received: by 2002:aca:b107:: with SMTP id a7mr12136444oif.170.1622842161037;
        Fri, 04 Jun 2021 14:29:21 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o2sm555662oom.26.2021.06.04.14.29.19
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 04 Jun 2021 14:29:20 -0700 (PDT)
Date:   Fri, 4 Jun 2021 14:29:09 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 1/7] mm/thp: fix __split_huge_pmd_locked() on shmem
 migration entry
In-Reply-To: <20210604153432.b4lck4q75z5oopym@box.shutemov.name>
Message-ID: <alpine.LSU.2.11.2106041412270.14037@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils> <alpine.LSU.2.11.2106011403540.2148@eggly.anvils> <20210604153432.b4lck4q75z5oopym@box.shutemov.name>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021, Kirill A. Shutemov wrote:
> On Tue, Jun 01, 2021 at 02:05:45PM -0700, Hugh Dickins wrote:
> > Stressing huge tmpfs page migration racing hole punch often crashed on the
> > VM_BUG_ON(!pmd_present) in pmdp_huge_clear_flush(), with DEBUG_VM=y kernel;
> > or shortly afterwards, on a bad dereference in __split_huge_pmd_locked()
> > when DEBUG_VM=n.  They forgot to allow for pmd migration entries in the
> > non-anonymous case.
> > 
> > Full disclosure: those particular experiments were on a kernel with more
> > relaxed mmap_lock and i_mmap_rwsem locking, and were not repeated on the
> > vanilla kernel: it is conceivable that stricter locking happens to avoid
> > those cases, or makes them less likely; but __split_huge_pmd_locked()
> > already allowed for pmd migration entries when handling anonymous THPs,
> > so this commit brings the shmem and file THP handling into line.
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
> > 
> > And while there: make it clearer to the eye that the !vma_is_anonymous()
> > and is_huge_zero_pmd() blocks make early returns (and don't return void).
> > 
> > Fixes: e71769ae5260 ("mm: enable thp migration for shmem thp")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Cc: <stable@vger.kernel.org>
> 
> Looks like a two fixes got squashed into one patch. Zero-page fix and
> migration entries in __split_huge_pmd_locked() deserve separate patches,
> no?

Okay, I'll divide in two (and probably lose the "don't return void"
cleanup; but still keep the clearer separation of those two blocks).

> 
> Maybe add VM_BUG_ON(!pmd_present()) in is_huge_zero_pmd()?

Certainly not as part of any patch I'm aiming at stable!  But
I've remembered another approach, I'll say in response to Yang.

> 
> Also I wounder how much code we can remove if we would not establish
> migration ptes for file pages. We can make these page table entries 'none'
> on migration.

I'm not sure how far you're wondering to go with that (just in THP
case, or file ptes generally?). But you may recall that I disagree,
especially on mlocked vmas, where we break the contract by not using
migration entries.  Anyway, not something to get into here.

Thanks a lot for all your reviews, I'll get on with it.

Hugh
