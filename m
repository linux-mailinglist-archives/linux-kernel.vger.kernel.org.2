Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCF53E3F04
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 06:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhHIE3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 00:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhHIE3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 00:29:53 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A8BC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 21:29:33 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id y18so21884869oiv.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 21:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=x6px4cJEMUh0LSKzJ+O2PybgqRw98ylZHdAHYBrlzPo=;
        b=ugbfYuMFVxaD3nAdyTA+EH+lP3+SPqNcfqUVCUmRLBE8e04+aOCKAUP9jm98J+Ybh1
         0/TgUB2cbUSS2yL2nb32a8coFWcYPTKNlMNTGKKDK7TqjHIVkhmKljfeC/anOwjvoJw2
         +f3BonQgf6C5fEfElQsltvz5w98FZWabRLR9yNZde10NbgGmmsVYUqFDDUt0DW4fFlLo
         DSCsVZHllceFsK3ZFtzpBsIRTglJP+JlOh1y2ZDFTrDuydhC8R+9lmBPTM9ozumfQu1L
         dbMOc4QHgclfSo3DPe+RuWWpRvIopEpOzjmLuvzZt3PPlpsHg2OQpDas1h2s7HiXLNB1
         DT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=x6px4cJEMUh0LSKzJ+O2PybgqRw98ylZHdAHYBrlzPo=;
        b=f33sb8xzKafwFZ9ssKgROU0KVVCGgaBVZ66aB3TgYHktrSb/Lkk3RcOT1JDuzeqhat
         IQDRXQN4gUVrOHSjeQPwSdw1lnbrjKeQpQw5Zox3pgFC9YNZCJgy31o1XNJ6V40D1RhG
         lXDb5fyU5J3ieYeQHSVuwj1PQAD9T2XG9zInnRKsqXd7L59mErsY+eNwxS0E/NtbKxWK
         CGoLyRfOfmOdLaA3jX8yy8NsR3iQc2PD3eofn8v8EPu/H05vQFhsoAnrK4vBHsv2tI8/
         X3t89mVobLZZ8mBW2uUzVybNUx3zk4Ef96SJYJs5w1psVIFZL/cj1ChswtQsvRU7vpXc
         vGQQ==
X-Gm-Message-State: AOAM5316ziMRHygpmLARJPGlIZ12eBVC+923GGE18sYiTZ/Xy2Uts+5G
        N+qhV+23SEW2mjNoLrXCJ8neJA==
X-Google-Smtp-Source: ABdhPJyPupTwRb5MNdzD1P8iHXEWiHVXy7eVfAPFKzJGnzzTYrjtP0dvZnuCymcetr+uuk++XTr25Q==
X-Received: by 2002:a05:6808:bcd:: with SMTP id o13mr23116015oik.61.1628483372998;
        Sun, 08 Aug 2021 21:29:32 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x16sm2667189ooj.1.2021.08.08.21.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 21:29:32 -0700 (PDT)
Date:   Sun, 8 Aug 2021 21:29:29 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot
 time parameter.
In-Reply-To: <YQ3dn1oR2d0sO5jl@casper.infradead.org>
Message-ID: <c2a4dd1d-c1ac-876b-4a3-c5ea7555498@google.com>
References: <20210805190253.2795604-1-zi.yan@sent.com> <0d374eed-cc52-a656-b338-1156782bdf7e@suse.cz> <F34DBD0A-22DE-4CF2-B784-BBDD80A8E85A@nvidia.com> <6ae6cd92-3ff4-7ed3-b337-a4dfe33da1c@google.com> <YQ3dn1oR2d0sO5jl@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Aug 2021, Matthew Wilcox wrote:
> 
> I am, however, of the opinion that 2MB pages give us so much trouble
> because they're so very special.  Few people exercise those code paths and
> it's easy to break them without noticing.  This is partly why I want to
> do arbitrary-order pages.  If everybody is running with compound pages
> all the time, we'll see the corner cases often, and people other than
> Hugh, Kirill and Mike will be able to work on them.

I don't entirely agree.  I'm all for your use of compound pages in page
cache, but don't think its problems are representative of the problems
in aiming for a PMD (or PUD) bar, with the weird page table transitions
we expect of "THP" there.

I haven't checked: is your use of compound pages in page cache still
limited to the HAVE_ARCH_TRANSPARENT_HUGEPAGE architectures?  When
the others could just as well use compound pages in page cache too.

Hugh
