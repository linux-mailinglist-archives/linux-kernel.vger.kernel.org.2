Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68264532A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 14:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbhKPNOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 08:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbhKPNON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:14:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E77C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 05:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dl8IoZ6MAGLIhgXEhnN0d3xfaeoF2eUenAyR+CVzOrM=; b=PgGOieImMeqalQ4+tNzV9/H78n
        eJzGvN9GdWYZ1Dbs3j144iAMAU4UtAQp2sVGa/h8k9heFdjnUaqO2i+lHTyqjiDzI40+t+Fw/OQ2n
        QojiZB7vf/UvEdg9vekzbiXdVVxPL6f/QzUPejW0Bgnj3PqrR/yrg+Wq+BSEnSfWSv4a1HzmEpXze
        myb7o4IR5blpM7gbdyRrn8wZEolPt5ov4wCO8hmnSH62xMl0wttWziM+th+oDkDnqShb3v9D5nJIZ
        W4g42cj8I/5G4Mw6k/au6S5nwIpmXysx+5C2i5UV3ftYFikbGbXiyoEv78XrCL8G40qJF+hQScGFg
        HQVKoJJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmyEw-006lgt-Js; Tue, 16 Nov 2021 13:11:10 +0000
Date:   Tue, 16 Nov 2021 13:11:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 2/2] mm: Rework swap handling of zap_pte_range
Message-ID: <YZOt7qD6yeSXJgv4@casper.infradead.org>
References: <20211115134951.85286-1-peterx@redhat.com>
 <20211115134951.85286-3-peterx@redhat.com>
 <YZJnTKKXDqKWZ6UP@casper.infradead.org>
 <8a5e44aa-243f-3a9d-e917-09cd3cf6609a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a5e44aa-243f-3a9d-e917-09cd3cf6609a@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 12:51:13AM -0800, John Hubbard wrote:
> On 11/15/21 05:57, Matthew Wilcox wrote:
> > On Mon, Nov 15, 2021 at 09:49:51PM +0800, Peter Xu wrote:
> > > Clean the code up by merging the device private/exclusive swap entry handling
> > > with the rest, then we merge the pte clear operation too.
> > > 
> > > struct* page is defined in multiple places in the function, move it upward.
> > 
> > Is that actually a good thing?  There was a time when declaring
> 
> Yes. It is a very good thing. Having multiple cases of shadowed variables
> (in this case I'm using programming language terminology, or what I
> remember it as, anyway) provides lots of opportunities to create
> hard-to-spot bugs.

I think you're misremembering.  These are shadowed variables:

int a;

int b(void)
{
	int a;
	if (c) {
		int a;
	}
}

This is not:

int b(void)
{
	if (c) {
		int a;
	} else {
		int a;
	}
}

I really wish we could turn on -Wshadow, but we get compilation warnings
from header files right now.  Or we did last time I checked.

