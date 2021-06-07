Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6756939E84F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhFGUXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhFGUXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:23:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E3FC061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 13:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z7ZLcUGLD1CuKefmti9g45BjfBhezDkXgDccglbrfSo=; b=cB5nat+gRTIFlVwIsyDFgremu6
        RFkiCHi/3xBSfucVb4YN+iM0lGj6BGgHHy8mvidLMVRolJ5BUdzwuUKuJZs0tNCPpt+GZVwH/n02w
        pkqmRRiuVD316PrOQepdlNah8CGIWYZfKKDf0wQzA25qch3s705qMtTFXYf6YY6l1LWaNvdMDMhEd
        eKJrjWL2NR0U1dSoBivAWlS7xb1uCJws6Jp8X3tQZ0RWfVJynVHKD9a4bXq0D9GQbZ1VvT3mwIcZW
        8MsugKcw5YDzyyqFzQ7caCj8/OBtmichSa44yEbKlvVkerijgwJ/WHb/e948a8ruS+G+0id38Ly6P
        QHKsPWEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqLjn-00GCqZ-G7; Mon, 07 Jun 2021 20:20:53 +0000
Date:   Mon, 7 Jun 2021 21:20:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        chinwen.chang@mediatek.com,
        kernel list <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        syzbot <syzbot+1f52b3a18d5633fa7f82@syzkaller.appspotmail.com>
Subject: Re: split_huge_page_to_list() races with page_mapcount() on
 migration entry in smaps code? [was: Re: [syzbot] kernel BUG in
 __page_mapcount]
Message-ID: <YL5/mz4isnKra18c@casper.infradead.org>
References: <00000000000017977605c395a751@google.com>
 <CAG48ez0M=iwJu=Q8yUQHD-+eZDg6ZF8QCF86Sb=CN1petP=Y0Q@mail.gmail.com>
 <YL5fayfh03Wecyd7@casper.infradead.org>
 <CAG48ez08GhsK00-J=1hbZrccB7uZ10EbN8i1Zj4pfp4V=LZEZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez08GhsK00-J=1hbZrccB7uZ10EbN8i1Zj4pfp4V=LZEZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 09:55:09PM +0200, Jann Horn wrote:
> On Mon, Jun 7, 2021 at 8:03 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Mon, Jun 07, 2021 at 07:27:23PM +0200, Jann Horn wrote:
> > > === Short summary ===
> > > I believe the issue here is a race between /proc/*/smaps and
> > > split_huge_page_to_list():
> > >
> > > The codepath for /proc/*/smaps walks the pagetables and (e.g. in
> > > smaps_account()) calls page_mapcount() not just on pages from normal
> > > PTEs but also on migration entries (since commit b1d4d9e0cbd0a
> > > "proc/smaps: carefully handle migration entries", from Linux v3.5).
> > > page_mapcount() expects compound pages to be stable.
> > >
> > > The split_huge_page_to_list() path first protects the compound page by
> > > locking it and replacing all its PTEs with migration entries (since
> > > the THP rewrite in v4.5, I think?), then does the actual splitting
> > > using __split_huge_page().
> > >
> > > So there's a mismatch of expectations here:
> > > The smaps code expects that migration entries point to stable compound
> > > pages, while the THP code expects that it's okay to split a compound
> > > page while it has migration entries.
> >
> > Will it be a colossal performance penalty if we always get the page
> > refcount after looking it up?  That will cause split_huge_page() to
> > fail to split the page if it hits this race.
> 
> Hmm - but with that approach I'm not sure you could even easily take a
> refcount on a page whose refcount may be frozen and which may be in
> the middle of being shattered? get_page_unless_zero() is wrong because
> you can't take references on tail pages, right? (Or can you?) And
> try_get_page() is wrong because it bugs out if the refcount is zero -
> and even if it didn't do that, you might end up holding a reference on
> the head page while the page you're actually interested in is a tail
> page?
> 
> I guess if it was really necessary, it'd be possible to do some kind
> of retry thing that grabs a reference on the compound head, then
> checks that the tail page is still associated with the compound head,
> and if not, drops the compound head and tries again?

Right; that's how get_user_page_fast() works -- see
try_get_compound_head().  If it can't get the reference, it just fails.
I suspect for smaps, we can just choose to not count the page.  It'll be
an inaccuracy in the stats, but I don't think that's a big deal.
