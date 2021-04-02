Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185B735244B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbhDBARI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233677AbhDBARH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:17:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D0C461108;
        Fri,  2 Apr 2021 00:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617322626;
        bh=yvOC7g6hjva6PwptF3HloL9AiBm6EDs0+4B8McV/PdQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QyIFpMJshAUvLZYwHLCOhdXVDtK9dfFvBySkMkt94udWjnFtjDKE/iw3Bb4Hq2IDN
         W6avxIyQMFTFn8vlx/btxDZsAsvjcPHWWPVmWYXJ6vmYSVPZJDwo+CYh/Lewu2h5Z0
         3bEb+Jjyc+4XdaOInmnCd17pw5WB7Ewm7orWGssE=
Date:   Thu, 1 Apr 2021 17:17:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hugeltb: fix renaming of PF_MEMALLOC_NOCMA to
 PF_MEMALLOC_PIN
Message-Id: <20210401171705.9bd350411cdee0db91332c92@linux-foundation.org>
In-Reply-To: <CA+CK2bB7FuPV5z+j+8HS+wHOmNXAANYPLwo64ebV71AWNCjPSw@mail.gmail.com>
References: <20210331163816.11517-1-rppt@kernel.org>
        <CA+CK2bB7FuPV5z+j+8HS+wHOmNXAANYPLwo64ebV71AWNCjPSw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021 10:26:36 -0400 Pavel Tatashin <pasha.tatashin@soleen.com> wrote:

> On Wed, Mar 31, 2021 at 12:38 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > The renaming of PF_MEMALLOC_NOCMA to PF_MEMALLOC_PIN missed one occurrence
> > in mm/hugetlb.c which causes build error:
> >
> >   CC      mm/hugetlb.o
> > mm/hugetlb.c: In function ‘dequeue_huge_page_node_exact’:
> > mm/hugetlb.c:1081:33: error: ‘PF_MEMALLOC_NOCMA’ undeclared (first use in this function); did you mean ‘PF_MEMALLOC_NOFS’?
> >   bool pin = !!(current->flags & PF_MEMALLOC_NOCMA);
> >                                  ^~~~~~~~~~~~~~~~~
> >                                  PF_MEMALLOC_NOFS
> > mm/hugetlb.c:1081:33: note: each undeclared identifier is reported only once for each function it appears in
> > scripts/Makefile.build:273: recipe for target 'mm/hugetlb.o' failed
> > make[2]: *** [mm/hugetlb.o] Error 1
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  mm/hugetlb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index a5236c2f7bb2..c22111f3da20 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1078,7 +1078,7 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
> >  static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> >  {
> >         struct page *page;
> > -       bool pin = !!(current->flags & PF_MEMALLOC_NOCMA);
> > +       bool pin = !!(current->flags & PF_MEMALLOC_PIN);
> 
> Thank you Mike!
> 
> Andrew, since "mm cma: rename PF_MEMALLOC_NOCMA to PF_MEMALLOC_PIN" is
> not yet in the mainline, should I send a new version of this patch so
> we won't have bisecting problems in the future?

I've already added Mike's fix, as
mm-cma-rename-pf_memalloc_nocma-to-pf_memalloc_pin-fix.patch.  It shall
fold it into mm-cma-rename-pf_memalloc_nocma-to-pf_memalloc_pin.patch
prior to upstreaming, so no bisection issue.

