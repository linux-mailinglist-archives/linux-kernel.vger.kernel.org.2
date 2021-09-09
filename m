Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FFF405CBB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 20:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244157AbhIISPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 14:15:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237297AbhIISO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631211225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RIWjeeOoa1VabWi3B7TlOtz3Y4ofdlgGcEa+gLerJBI=;
        b=i6Pui8bj/iyI+VbNdm2sPK5s893npU84dCviXqjYBjEd3lWvL/OgAqFRu7GBAkw4wtt3MK
        fo2LElPXP8KMLAcch8nY/FOeAAo2MRZ6r1wwA13qhpT968wPRP9ZO6L2RPmh+ok389+YKH
        UeCuiZNlwuQyZdvmgVzHvLD+PBbJhyQ=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-18U08jF9Ozy_5I1pmKyJ0g-1; Thu, 09 Sep 2021 14:13:44 -0400
X-MC-Unique: 18U08jF9Ozy_5I1pmKyJ0g-1
Received: by mail-il1-f197.google.com with SMTP id s15-20020a056e02216f00b002276040aa1dso2820130ilv.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 11:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RIWjeeOoa1VabWi3B7TlOtz3Y4ofdlgGcEa+gLerJBI=;
        b=hglmctgno+8lvhHVc3Qx0StiuBGwoLFl79AswQNvd489EEclZaYtF+KOAQJx3pfCO9
         edW7kM6y88dqPZZqS3bgvvGgk5u2UyaFAY5Imra6+FToljGtjvbpVhORiLbJcsj6L/tU
         ytOk3HVkYrCUPDHj94juo1i7FC4Ats5v2IfngjVi/zE4uCJAmtKUR29gJr/wiDYmJTaW
         b98GeYD7nV/rO460ncqpBCrHlnyLGFdBQ6k5ArzqVV2nZ9QhzF40O14MsQXyLyLkGJc9
         WTWhMuy2ApIN9792U7Nzx+lmtpYuQ2izprwt8C+Hda1wlxstrF0mCmwRNMwMDWSlxRgO
         hxRw==
X-Gm-Message-State: AOAM531OBrz+UPb6vUNkGzIhCdX2t0eryr8jvl3+W/jx88XqzSVJfcc4
        CXx7D1Mm0XizYoA9g7JMM1gIzvUOm0iqGJnM9m3IBYiLetbDUunKqsKzQqb3T80b35wV69vBC47
        /P1QRN91RyJp9H6x4t1xbaKlL
X-Received: by 2002:a6b:7710:: with SMTP id n16mr3658165iom.101.1631211223657;
        Thu, 09 Sep 2021 11:13:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzkCSATJElsUKeXdLlSO3aGUQTKN6vio39mP/DTTO36pPZKKiCNGeWvgE4VfkouIG8DfjqVg==
X-Received: by 2002:a6b:7710:: with SMTP id n16mr3658143iom.101.1631211223417;
        Thu, 09 Sep 2021 11:13:43 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id f3sm1177173ilu.85.2021.09.09.11.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:13:42 -0700 (PDT)
Date:   Thu, 9 Sep 2021 14:13:40 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/5] mm: Drop first_index/last_index in zap_details
Message-ID: <YTpO1P2MaYWaOc5Y@t490s>
References: <20210908163516.214441-1-peterx@redhat.com>
 <20210908163622.214951-1-peterx@redhat.com>
 <20210909025417.occtqoo6l7x5tnuy@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210909025417.occtqoo6l7x5tnuy@revolver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 02:54:37AM +0000, Liam Howlett wrote:
> > @@ -3390,17 +3393,17 @@ void unmap_mapping_page(struct page *page)
> >  void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
> >  		pgoff_t nr, bool even_cows)
> >  {
> > +	pgoff_t	first_index = start, last_index = start + nr - 1;
> 
> Nit: If you respin, can first_index and last_index be two lines please?

Sure.

> 
> >  	struct zap_details details = { };
> >  
> >  	details.check_mapping = even_cows ? NULL : mapping;
> > -	details.first_index = start;
> > -	details.last_index = start + nr - 1;
> > -	if (details.last_index < details.first_index)
> > -		details.last_index = ULONG_MAX;
> 
> Nit: Maybe throw a comment about this being overflow check, if you
> respin.

It may not be "only" an overflow check, e.g., both unmap_mapping_range() and
unmap_mapping_pages() allows taking the npages to be zero:

For unmap_mapping_range:

 * @holelen: size of prospective hole in bytes.  This will be rounded
 * up to a PAGE_SIZE boundary.  A holelen of zero truncates to the
 * end of the file.

For unmap_mapping_pages:

 * @nr: Number of pages to be unmapped.  0 to unmap to end of file.

So we must set it to ULONG_MAX to make sure nr==0 will work like that.

I won't bother adding a comment, but if to add it I'll probably also mention
about that part on allowing a nr==0 use case, please let me know if you insist.

> 
> > +	if (last_index < first_index)
> > +		last_index = ULONG_MAX;
> >  
> >  	i_mmap_lock_write(mapping);
> >  	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
> > -		unmap_mapping_range_tree(&mapping->i_mmap, &details);
> > +		unmap_mapping_range_tree(&mapping->i_mmap, first_index,
> > +					 last_index, &details);
> >  	i_mmap_unlock_write(mapping);
> >  }
> >  
> > -- 
> > 2.31.1
> > 
> 
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks for reviewing.

-- 
Peter Xu

