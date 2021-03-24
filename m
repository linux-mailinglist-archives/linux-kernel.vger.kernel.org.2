Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8560F34707E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 05:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhCXEfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 00:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhCXEev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 00:34:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4210C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 21:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nd8YwkXvpGzQSlW2qKowPeOd11AY01MDS6JScgp+aEI=; b=CFWLUCSVS1gH90GWN+/Ah+p/37
        m80iAUqqZIuIdxl6uUt0w2ygzZNxUNJZQXBUomvb23aptykobERqCIUPWm4eSk+6Z8F6IvDxODhjf
        5IbR9G5e8gkYRSEu9rn6ou7x0sQ0Vhbg0trkZpzBrAz8dyW9S5/jsSEa14Yp0grnavcfsPIvAafeL
        wXVV0s58dKQS5cB+/VE1L0PMvuSk5CTNSH/3+9nUq4wcTwNOGbo+eKa+tcVIdDlc/HwuXVtBp3dvP
        WPfclbVw65IfRncdY+wLK3RQ+UHI4D2ZwHWs5rVK35PVC7M0mOg50AiyAy0Wnz6G6TE9U6Yf6S0p2
        zFGDL8CA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOvE2-00AvkO-I1; Wed, 24 Mar 2021 04:34:37 +0000
Date:   Wed, 24 Mar 2021 04:34:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, jhubbard@nvidia.com,
        digetx@gmail.com
Subject: Re: [PATCH v5] mm: cma: support sysfs
Message-ID: <20210324043434.GP1719932@casper.infradead.org>
References: <20210323195050.2577017-1-minchan@kernel.org>
 <20210324030224.GO1719932@casper.infradead.org>
 <YFqyk0/yXs2kMP76@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFqyk0/yXs2kMP76@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 08:31:31PM -0700, Minchan Kim wrote:
> On Wed, Mar 24, 2021 at 03:02:24AM +0000, Matthew Wilcox wrote:
> > On Tue, Mar 23, 2021 at 12:50:50PM -0700, Minchan Kim wrote:
> > > +	/* the number of CMA page successful allocations */
> > > +	atomic64_t nr_pages_succeeded;
> > 
> > > +void cma_sysfs_alloc_pages_count(struct cma *cma, size_t count)
> > > +{
> > > +	atomic64_add(count, &cma->nr_pages_succeeded);
> > > +}
> > 
> > I don't understand.  A size_t is a byte count.  But the variable is called
> > 'nr_pages'.  So which is it, a byte count or a page count?
> 
> It's page count. I followed the cma_alloc interface since it has
> size_t count variable for nr_pages.

That's very confusing.  cma_alloc is wrong; if it needs to be an
unsigned long, that's fine.  But it shouldn't be size_t.

7.17 of n1256 defines:

	size_t
which is the unsigned integer type of the result of the sizeof operator

Do you want to submit a patch to fix cma_alloc as well?

> Let's go with unsigned long nr_pages:
> void cma_sysfs_alloc_pages_count(struct cma *cma, unsigned long
> nr_pages)

Works for me!
