Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0702C3FF8AE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 03:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhICBkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 21:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232013AbhICBki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 21:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630633178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W00JWM6LN9F7vwzH1kt4Gm8FUt1a8dgaBLhIJfS2rZ4=;
        b=G1cpq081joW60lf5JIqa1QjGpDTLCNtm6orAUbYIhMGzwUM9dsFHj9WOXv2xaQYl8NnpRR
        wafFUZZ3qHIZosnKCnLx51HEAw2r3aG2Av53GCq02QiLeaSwz81B2xTRs37sQxrw9R0h3T
        arkoNIQIpMGXxRmxx3Rj/gjGFHcw2jY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-PpUn_6MqMyiUKo0c1F51KA-1; Thu, 02 Sep 2021 21:39:37 -0400
X-MC-Unique: PpUn_6MqMyiUKo0c1F51KA-1
Received: by mail-qk1-f200.google.com with SMTP id h7-20020a37b707000000b003fa4d25d9d0so4825779qkf.17
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 18:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W00JWM6LN9F7vwzH1kt4Gm8FUt1a8dgaBLhIJfS2rZ4=;
        b=s2Hsmyv0NwLpq1axmtUxTlxWXGoq4JmqxJIqDZsA/UUjWgLGhlftmLSXCksbhorR7e
         0nrqulyqUOLwzJ3+4TOtI1BYEtb4wCZ+Dv46vmIa3Y2iKuaXIGhYU20z/Sh/8N9JaQKw
         ciWSLojwKvUmRo5bVGgAhg6aDoyq2sjQAq7MnUFTQo2p2KPFDZJwH2uFPcCaV6BJ3jzI
         G+M3PPf1eWXKn36t6IS/GweqoH5+wpLf3IpevwaZGhjDr5A2oul3qI/gqXxZ128tTMwO
         890aDr/t1b/Iw4ogTwLXLs2zLfJ+z1QBkSh/cy7H6o97bRZFydE/Q2ZY6YNIS84YiShE
         6RPw==
X-Gm-Message-State: AOAM5330O99lCHf1EeMKeia7xhM8Z6Ir/YWdpnCIzJB085NfgeUHncGk
        ziOYETIosYIXYq9Z0nLYAMVjegcoppOZVpBtBhhcChiSQ40obkowhsiHkXuYHFvYe4cLMGzuuPh
        202lkOddgQQwpIJ52r1ixkWRY
X-Received: by 2002:a0c:8d0f:: with SMTP id r15mr1019991qvb.1.1630633175502;
        Thu, 02 Sep 2021 18:39:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzv/7UQawEfBRbROuQEdhFsWgpMnvcwVEApFke+TCOv/QDPFLZuHkOyvez5rBrSXsAr9VdM+A==
X-Received: by 2002:a0c:8d0f:: with SMTP id r15mr1019966qvb.1.1630633175180;
        Thu, 02 Sep 2021 18:39:35 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id f28sm2859082qkk.10.2021.09.02.18.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 18:39:34 -0700 (PDT)
Date:   Thu, 2 Sep 2021 21:39:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 4/5] mm: Add zap_skip_check_mapping() helper
Message-ID: <YTF81ItjDYpHUe1J@t490s>
References: <20210902201721.52796-1-peterx@redhat.com>
 <20210902201819.53343-1-peterx@redhat.com>
 <1771631.QAr93JHi05@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1771631.QAr93JHi05@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 10:58:53AM +1000, Alistair Popple wrote:
> On Friday, 3 September 2021 6:18:19 AM AEST Peter Xu wrote:
> > Use the helper for the checks.  Rename "check_mapping" into "zap_mapping"
> > because "check_mapping" looks like a bool but in fact it stores the mapping
> > itself.  When it's set, we check the mapping (it must be non-NULL).  When it's
> > cleared we skip the check, which works like the old way.
> >
> > Move the duplicated comments to the helper too.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/mm.h | 15 ++++++++++++++-
> >  mm/memory.c        | 29 ++++++-----------------------
> >  2 files changed, 20 insertions(+), 24 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 69259229f090..81e402a5fbc9 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1720,10 +1720,23 @@ extern void user_shm_unlock(size_t, struct ucounts *);
> >   * Parameter block passed down to zap_pte_range in exceptional cases.
> >   */
> >  struct zap_details {
> > -	struct address_space *check_mapping;	/* Check page->mapping if set */
> > +	struct address_space *zap_mapping;	/* Check page->mapping if set */
> >  	struct page *single_page;		/* Locked page to be unmapped */
> >  };
> >  
> > +/*
> > + * We set details->zap_mappings when we want to unmap shared but keep private
> > + * pages. Return true if skip zapping this page, false otherwise.
> > + */
> > +static inline bool
> > +zap_skip_check_mapping(struct zap_details *details, struct page *page)
> > +{
> > +	if (!details || !page)
> > +		return false;
> > +
> > +	return details->zap_mapping != page_rmapping(page);
> 
> Shouldn't this check still be
> details->zap_mapping && details->zap_mapping != page_rmapping(page)?
> 
> Previously we wouldn't skip zapping pages if even_cows == true (ie.
> details->check_mapping == NULL). With this change the check when
> even_cows == true becomes NULL != page_rmapping(page). Doesn't this mean we
> will now skip zapping any pages with a mapping when even_cows == true?

Yes I think so.  Thanks for pointing that out, Alistair, I'll fix in v3.

But frankly I really think we should simply have that flag I used to introduce.
It'll make everything much clearer.

-- 
Peter Xu

