Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A1930E616
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 23:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhBCWbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 17:31:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231230AbhBCWbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 17:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612391422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nS4bwQpjG/2qNM4NYd+hfWbJiuPcAKvoaI0hut8n+YY=;
        b=YiP4vQ9SAtttlHBQj4cDb21YQXm4bUUNv2feTGn1qpUVbInFLofWslvZFMUXgdnLF2Mc//
        GSEOYz2i6JQP5FqKGKVLnsYaFDLkVW/Br50Kuj1KTFJ/kgQzHxUSFLPIqk9Ajqgvxf3MiV
        iqJNbAgok7pjHEfQXyqnaCWIhcHbP7s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-vVfprMNdMjiINrZjkvum2g-1; Wed, 03 Feb 2021 17:30:20 -0500
X-MC-Unique: vVfprMNdMjiINrZjkvum2g-1
Received: by mail-qv1-f71.google.com with SMTP id q37so633921qvf.14
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 14:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nS4bwQpjG/2qNM4NYd+hfWbJiuPcAKvoaI0hut8n+YY=;
        b=J1Uj/yCEeg8PbvtRFHViYsHZQ5zviZGA+7iTMhoL+1gSqHzSv5tlLmcJMmYPYNRD5Z
         OBm57F+RjGxlgB94rKczkF1EACu8hgYwadQlRL5u1k1MeKR1OvL62lszEl7CmgHXSNS+
         7ALxVAV3dbQqVZ4EakoAzqdnIqWeSBu7tLIC9Avlb1w2tmmrPleKmPrw5DkOnKRj5yZD
         GOdIc1eyFihNRoDL3OLw2o6Ev0I7sy1++5rLthB5HFcO2X77FHL7QqVEeXjplJh+pK22
         HRmh5Q+DO6cbgMmLT/5Dl4ag/gVSMaV9BUhcs1QJgYLpSF+fl+jN2+mZNZJau5kmwHa6
         VZ9w==
X-Gm-Message-State: AOAM532G+ci6R3vkzjekcpU1LgokKLEKOTRhYN1XY1NI1xO9Y1NubE40
        wgYFReAXMIGd6NAQjhojiEKqz63c4BpgjQN0U3hQ9i/I8NBtoKpE8MWiaCqXxNqcar5ZAl9sL3V
        LOztsHrbkYID1ioCp77Vk5lMb
X-Received: by 2002:ad4:4e8c:: with SMTP id dy12mr5136399qvb.12.1612391419909;
        Wed, 03 Feb 2021 14:30:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwW62BAPMAnI9h3ciqdw6astnvPCbIY7pkEJ6Geu64NZ8XVFa6IvU6x4qbKXf20SwgSi4TiHw==
X-Received: by 2002:ad4:4e8c:: with SMTP id dy12mr5136377qvb.12.1612391419707;
        Wed, 03 Feb 2021 14:30:19 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id c127sm3233607qkd.87.2021.02.03.14.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 14:30:19 -0800 (PST)
Date:   Wed, 3 Feb 2021 17:30:17 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Wei Zhang <wzam@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Gal Pressman <galpress@amazon.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        David Gibson <david@gibson.dropbear.id.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/4] hugetlb: Do early cow when page pinned on src mm
Message-ID: <20210203223017.GK6468@xz-x1>
References: <20210203210832.113685-1-peterx@redhat.com>
 <20210203210832.113685-5-peterx@redhat.com>
 <2038a69e-8c2d-c959-4bdc-9d2ddf093061@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2038a69e-8c2d-c959-4bdc-9d2ddf093061@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 02:04:30PM -0800, Mike Kravetz wrote:
> > @@ -3816,6 +3832,54 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >  			}
> >  			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
> >  		} else {
> > +			entry = huge_ptep_get(src_pte);
> > +			ptepage = pte_page(entry);
> > +			get_page(ptepage);
> > +
> > +			if (unlikely(page_needs_cow_for_dma(vma, ptepage))) {
> > +				/* This is very possibly a pinned huge page */
> > +				if (!prealloc) {
> > +					/*
> > +					 * Preallocate the huge page without
> > +					 * tons of locks since we could sleep.
> > +					 * Note: we can't use any reservation
> > +					 * because the page will be exclusively
> > +					 * owned by the child later.
> > +					 */
> > +					put_page(ptepage);
> > +					spin_unlock(src_ptl);
> > +					spin_unlock(dst_ptl);
> > +					prealloc = alloc_huge_page(vma, addr, 0);
> 
> One quick question:
> 
> The comment says we can't use any reservation, and I agree.  However, the
> alloc_huge_page call has 0 as the avoid_reserve argument.  Shouldn't that
> be !0 to avoid reserves?

Good point..  so I obviously wanted to skip reservation check but successfully
got cheated by the inverted name. :)

Though I do checked the reservation, so it seems not extremely important - when
we fork and copy the vma, we have already dropped the vma resv map:

		if (is_vm_hugetlb_page(tmp))
			reset_vma_resv_huge_pages(tmp);

Then in alloc_huge_page() we checked vma_resv_map() mostly everywhere we'd
check avoid_reserve too (either in vma_needs_reservation, or calculating
deferred_reserve).  It seems to be mostly useful when vma_resv_map() existed.

But I completely agree I should pass in "1" here in v2.

Thanks,

-- 
Peter Xu

