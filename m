Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1944438D77F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 23:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhEVVVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 17:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231379AbhEVVVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 17:21:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 563916108D;
        Sat, 22 May 2021 21:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621718387;
        bh=B2lsAOJv9bBu+Fx6RHHX+xG31xxgaNCxYEIIJz6iKxA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sgp/w7olg0sWa71S4TzAXyW6gyVDBPvnlKHmMEIBP4LzHDfYcml+EbiARYx+qp+Sz
         XDUB7XBRx3czU4D+WzbHYPsPGEj7DsAv8E5eS6SnKiO7bsrDi3tBl9CorywX6ktEez
         135FnFU5z/MBQnFZ1GhV+WyczYaFiiCJ53sjv8+E=
Date:   Sat, 22 May 2021 14:19:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm, hugetlb: fix resv_huge_pages underflow on
 UFFDIO_COPY
Message-Id: <20210522141946.f8a62010350a76302b9508fb@linux-foundation.org>
In-Reply-To: <20210521074433.931380-1-almasrymina@google.com>
References: <20210521074433.931380-1-almasrymina@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021 00:44:33 -0700 Mina Almasry <almasrymina@google.com> wrote:

> The userfaultfd hugetlb tests detect a resv_huge_pages underflow. This
> happens when hugetlb_mcopy_atomic_pte() is called with !is_continue on
> an index for which we already have a page in the cache. When this
> happens, we allocate a second page, double consuming the reservation,
> and then fail to insert the page into the cache and return -EEXIST.
> 
> To fix this, we first if there exists a page in the cache which already

                       ^ check

> consumed the reservation, and return -EEXIST immediately if so.
> 
> Secondly, if we fail to copy the page contents while holding the
> hugetlb_fault_mutex, we will drop the mutex and return to the caller
> after allocating a page that consumed a reservation. In this case there
> may be a fault that double consumes the reservation. To handle this, we
> free the allocated page, fix the reservations, and allocate a temporary
> hugetlb page and return that to the caller. When the caller does the
> copy outside of the lock, we again check the cache, and allocate a page
> consuming the reservation, and copy over the contents.
> 
> Test:
> Hacked the code locally such that resv_huge_pages underflows produce
> a warning and the copy_huge_page_from_user() always fails, then:
> 
> ./tools/testing/selftests/vm/userfaultfd hugetlb_shared 10
> 	2 /tmp/kokonut_test/huge/userfaultfd_test && echo test success
> ./tools/testing/selftests/vm/userfaultfd hugetlb 10
> 	2 /tmp/kokonut_test/huge/userfaultfd_test && echo test success
> 
> Both tests succeed and produce no warnings. After the test runs
> number of free/resv hugepages is correct.
>
> ...
>
>  include/linux/hugetlb.h |   4 ++
>  mm/hugetlb.c            | 103 ++++++++++++++++++++++++++++++++++++----
>  mm/migrate.c            |  39 +++------------
>  3 files changed, 103 insertions(+), 43 deletions(-)

I'm assuming we want this in -stable?

Are we able to identify a Fixes: for this?

It's a large change.  Can we come up with some smaller and easier to
review and integrate version which we can feed into 5.13 and -stable
and do the fancier version for 5.14?

If you don't think -stable needs this then this version will be OK as-is.
