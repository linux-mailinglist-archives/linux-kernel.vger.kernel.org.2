Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FF2396A59
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 02:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhFAAif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 20:38:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232446AbhFAAid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 20:38:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D380F6124B;
        Tue,  1 Jun 2021 00:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622507813;
        bh=vcDVecllsyG6dl5tUH0HL/qOl+Lovf/V3ktxDvPMV30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XWnGUr8lks1OLZCW9x42MeS9dKXPOt/EGofJqiMObT/X690JH+OGZ50ZygOhct5+R
         zUSqFswaRwzKU9OXbeRdDhLBYwFDByklCXy5/tOCELE/Sii8RoWvSEgNbGLe0qTTM7
         Pol7ZvLKfSLkoOUX+VAf8mWh2wc1YfPL3TtqiI7w=
Date:   Mon, 31 May 2021 17:36:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] mm, hugetlb: fix racy resv_huge_pages underflow on
 UFFDIO_COPY
Message-Id: <20210531173652.c21404a16a8f8542ce40afa8@linux-foundation.org>
In-Reply-To: <CAHS8izMCb4Ws46X3xXGcmrvV6J36qsAPTVCA_gdcH65FU0OeUg@mail.gmail.com>
References: <20210528005029.88088-1-almasrymina@google.com>
        <20210531162527.caeae9545ea2843c5f62bc9c@linux-foundation.org>
        <CAHS8izMCb4Ws46X3xXGcmrvV6J36qsAPTVCA_gdcH65FU0OeUg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021 17:11:52 -0700 Mina Almasry <almasrymina@google.com> wrote:

> On Mon, May 31, 2021 at 4:25 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 27 May 2021 17:50:29 -0700 Mina Almasry <almasrymina@google.com> wrote:
> >
> > > On UFFDIO_COPY, if we fail to copy the page contents while holding the
> > > hugetlb_fault_mutex, we will drop the mutex and return to the caller
> > > after allocating a page that consumed a reservation. In this case there
> > > may be a fault that double consumes the reservation. To handle this, we
> > > free the allocated page, fix the reservations, and allocate a temporary
> > > hugetlb page and return that to the caller. When the caller does the
> > > copy outside of the lock, we again check the cache, and allocate a page
> > > consuming the reservation, and copy over the contents.
> > >
> > > Test:
> > > Hacked the code locally such that resv_huge_pages underflows produce
> > > a warning and the copy_huge_page_from_user() always fails, then:
> > >
> > > ./tools/testing/selftests/vm/userfaultfd hugetlb_shared 10
> > >         2 /tmp/kokonut_test/huge/userfaultfd_test && echo test success
> > > ./tools/testing/selftests/vm/userfaultfd hugetlb 10
> > >       2 /tmp/kokonut_test/huge/userfaultfd_test && echo test success
> > >
> > > Both tests succeed and produce no warnings. After the
> > > test runs number of free/resv hugepages is correct.
> >
> > Many conflicts here with material that is queued for 5.14-rc1.
> >
> > How serious is this problem?  Is a -stable backport warranted?
> >
> 
> I've sent 2 similar patches to the list:
> 
> 1. "[PATCH v4] mm, hugetlb: Fix simple resv_huge_pages underflow on UFFDIO_COPY"
> 
> This one is sent to -stable and linux-mm and is a fairly simple fix.
> 
> 2. "[PATCH v4] mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY"

Ah, OK, the title of the first patch was changed, which threw me off.

I'd skipped "[PATCH v4] mm, hugetlb: Fix simple resv_huge_pages
underflow on UFFDIO_COPY" because Mike's comments appeared to require a
v5.  I applied it and made Mike's changelog suggestions.  Queued for
5.13 and -stable.

And I queued "[PATCH v4] mm, hugetlb: fix racy resv_huge_pages
underflow on UFFDIO_COPY" for 5.14.


