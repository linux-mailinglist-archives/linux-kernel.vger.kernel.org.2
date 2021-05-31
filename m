Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5045E396A0D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 01:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhEaX1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 19:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231144AbhEaX1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 19:27:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DE676127C;
        Mon, 31 May 2021 23:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622503527;
        bh=c7naDVv/eC6perkruWntIRarp9ADf3gqHd+mZMh5/1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f86MkgRpXm8WajcJUugg9vDhDy2s4dJ8YWA2yzT+eXYvlf8iJzz/mb7VLpuXhVLMM
         r1mPJtC6+ZRiXaMzUzM1cAeBZ+ijw/qdvmiD6bG9iphl/kqf8+Ve/6RZRuEHm1X8Hj
         3iGOJHRyHcWH/hbkvpVI1CnDrrKLpHbls90I/bII=
Date:   Mon, 31 May 2021 16:25:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm, hugetlb: fix racy resv_huge_pages underflow on
 UFFDIO_COPY
Message-Id: <20210531162527.caeae9545ea2843c5f62bc9c@linux-foundation.org>
In-Reply-To: <20210528005029.88088-1-almasrymina@google.com>
References: <20210528005029.88088-1-almasrymina@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 17:50:29 -0700 Mina Almasry <almasrymina@google.com> wrote:

> On UFFDIO_COPY, if we fail to copy the page contents while holding the
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
>         2 /tmp/kokonut_test/huge/userfaultfd_test && echo test success
> ./tools/testing/selftests/vm/userfaultfd hugetlb 10
> 	2 /tmp/kokonut_test/huge/userfaultfd_test && echo test success
> 
> Both tests succeed and produce no warnings. After the
> test runs number of free/resv hugepages is correct.

Many conflicts here with material that is queued for 5.14-rc1.

How serious is this problem?  Is a -stable backport warranted?

If we decide to get this into 5.13 (and perhaps -stable) then I can
take a look at reworking all the 5.14 material on top.  If not very
serious then we could rework this on top of the already queued
material.

