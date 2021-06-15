Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68953A8347
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhFOOzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhFOOzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:55:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F62C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:53:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623768807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e93NAi6ZEiulkbcdd6o8Ahtb1+0Pma6KZlwIxXZGnpI=;
        b=jMoV7aWk49uxTY1kg2gMCOHt6ChpE95KIyYuXqF7ZNR9YOEtc1hivB2tT/UfbmF+ao8xyH
        rGGvCDZrjZlPpSBnMsqlt56FNz2+b/GG1hGeTSBOzV41a7RQuG0KDA9pmxx6Ghx9hpMqOv
        yWhJXETSXYYwus6sLsqKclWgG7TmNDBmtgoVCLhin5qK9PRC2hlISJ1NEDXN79Kzmj5ewt
        POBCJTmeykB3twO5sk6X7WfHiEvXuWY8CblQ2QkJCDbptyksDXLvHnohYoZYNUJ/lt6skR
        rsD3A9ftbVsCJBZQJVyGa0fswFhLiRhG2fYvoH7LAAZj0vQ4ghfl9xvz8qzoNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623768807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e93NAi6ZEiulkbcdd6o8Ahtb1+0Pma6KZlwIxXZGnpI=;
        b=JvI/9XwPrTpEfCpYz9x6ibWwJYy1EBrVh1uz2bHbaTVcVQ9kzkrtYCUmiaxXlC0q6ic9s7
        iGMhUWdmX5dvB2Cg==
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhang Yi <wetpzy@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Neel Natu <neelnatu@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, futex: Fix shared futex pgoff on shmem huge page
In-Reply-To: <b17d946b-d09-326e-b42a-52884c36df32@google.com>
References: <45e8fd67-51fd-7828-fe43-d261d6c33727@google.com> <YMTdtRZG+7q8OtkK@casper.infradead.org> <b17d946b-d09-326e-b42a-52884c36df32@google.com>
Date:   Tue, 15 Jun 2021 16:53:27 +0200
Message-ID: <87mtrrgowo.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12 2021 at 20:16, Hugh Dickins wrote:
> If more than one futex is placed on a shmem huge page, it can happen that
> waking the second wakes the first instead, and leaves the second waiting:
> the key's shared.pgoff is wrong.
>
> When 3.11 commit 13d60f4b6ab5 ("futex: Take hugepages into account when
> generating futex_key"), the only shared huge pages came from hugetlbfs,
> and the code added to deal with its exceptional page->index was put into
> hugetlb source.  Then that was missed when 4.8 added shmem huge pages.
>
> page_to_pgoff() is what others use for this nowadays: except that, as
> currently written, it gives the right answer on hugetlbfs head, but
> nonsense on hugetlbfs tails.  Fix that by calling hugetlbfs-specific
> hugetlb_basepage_index() on PageHuge tails as well as on head.
>
> Yes, it's unconventional to declare hugetlb_basepage_index() there in
> pagemap.h, rather than in hugetlb.h; but I do not expect anything but
> page_to_pgoff() ever to need it.
>
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Reported-by: Neel Natu <neelnatu@google.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Assuming this goes through mm:

Acked-by: Thomas Gleixner <tglx@linutronix.de>
