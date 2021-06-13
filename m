Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CCC3A57B1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 12:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhFMKaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 06:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhFMKaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 06:30:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6C2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GI1B2TWOcVYfBM9mpBoycoXz69MytErLgsWQehgKcn8=; b=pd2nYi5uyQvVnMy+oYDubRyjt4
        2t2NtygYzNzvYplPrjmJblv+Ykwp7dPQGc0CncRuC6WYasdtByDCy7K7SSpRZ34Jdyi7nWwnNXy+7
        sWxN6rGBiTDrF6Xtvl0XNaTYK/I8Yaw1L6Z7SXcvBPHqDzNeBmSWxXkRn7EfwDiPrq5e/Agckb8Vq
        eYh4llxjzT1/GKPdUetp9yFH/mZyC1fIqEbty6Ngx9+w6/PQFjsBKobr0qX2YYe/iguMjUIlZnrW5
        g0843wbMxEDJ1+Qz7NFUZY5KEx2QIv7Bo3thTFDOQXFMOXg+oTmbp5CBEeRiKRJFrOkXR2TwRZlWS
        uuUc0zeg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lsNKw-004SQS-T1; Sun, 13 Jun 2021 10:27:34 +0000
Date:   Sun, 13 Jun 2021 11:27:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhang Yi <wetpzy@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Neel Natu <neelnatu@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, futex: Fix shared futex pgoff on shmem huge page
Message-ID: <YMXdjhwpRzP6r8Uj@casper.infradead.org>
References: <45e8fd67-51fd-7828-fe43-d261d6c33727@google.com>
 <YMTdtRZG+7q8OtkK@casper.infradead.org>
 <b17d946b-d09-326e-b42a-52884c36df32@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b17d946b-d09-326e-b42a-52884c36df32@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 08:16:58PM -0700, Hugh Dickins wrote:
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

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
