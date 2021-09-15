Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8761D40BEB3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 06:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhIOECw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 00:02:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59836 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229450AbhIOECv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 00:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631678492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S9dfG7lCjbIPE3UCUF5+rBdd5RDuUrQqvL6WJoW4FK4=;
        b=M2MvKFu/NJHolbVjihGVrqYbwprtApB9J2Sk6waKzQduhYHAwHYR7SgmPDJPlsK2SVJq0S
        fL2luVTKrO6MZuGapu/PfxsfG8Yh6Mpgosr1ba9UNzd93PAglmFD1zoWGy0gnGJ2Hu4aCB
        N41C6g10TDJ3ZPEG29Xr1w15aUKMe9Q=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-aGjwT_TKMtyzqPBPaIvp4w-1; Wed, 15 Sep 2021 00:01:30 -0400
X-MC-Unique: aGjwT_TKMtyzqPBPaIvp4w-1
Received: by mail-il1-f198.google.com with SMTP id t10-20020a056e02160a00b0022c6a64f952so998438ilu.20
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 21:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S9dfG7lCjbIPE3UCUF5+rBdd5RDuUrQqvL6WJoW4FK4=;
        b=2YHZr1Fm7MFWcKYcm+TpsW5a/P41+skRadjT7YENhYGX3vkdhicluaxIBa2PFaZAAe
         Wldy12aUC57gQq9i60q8CFJ7a9cN3AdAQbnd4cNC8mCb5d8rnfxIimcF79n3aDfbhkNa
         P65L/lqaGR/eapuFJQGwsoE1IXUF7YkiyzpC6chv5b3Ew4r0UTM3+NbQZLlddplaklLt
         UhSlw4jtFjYbQTYL4S+AZ96LKdxnkvx4bT45MCVV20R+144EdYtdKgiq0OkaIyz1dX2s
         Re6XeTrX8J2AArZqW2BEEOXdfp95+sG4wZ9FGjS1VbaM6ToccZf7a6SIiwits5qghCRe
         EMfA==
X-Gm-Message-State: AOAM531Xe48hiIfOyDkEUbe9UIS0QpjzDaNclK0HGCV5IKTC+ekJ5OKw
        sYwyEkL3sRQPI0SBrvb12HM8ZgpGzZRhREcpWp38RCAkUUMUJvtOrHRBot38xsXKEFrhpftoEDi
        6h9DJOh99487ezt3MJcf74C+p
X-Received: by 2002:a6b:5a08:: with SMTP id o8mr3643431iob.35.1631678489343;
        Tue, 14 Sep 2021 21:01:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLc18r6Nzd78R4QD2X5j5xamAcB5xT+admlIK+WELr04EisOSgNFcAvGwqNShkdwopm5vIIg==
X-Received: by 2002:a6b:5a08:: with SMTP id o8mr3643403iob.35.1631678489059;
        Tue, 14 Sep 2021 21:01:29 -0700 (PDT)
Received: from xz-m1.local ([2607:fea8:56a2:9100:358a:bf89:d33a:76ad])
        by smtp.gmail.com with ESMTPSA id x5sm7656139ioa.35.2021.09.14.21.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 21:01:28 -0700 (PDT)
Date:   Wed, 15 Sep 2021 00:01:24 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 5/5] mm: Add ZAP_FLAG_SKIP_SWAP and zap_flags
Message-ID: <YUFwFGB2JElaBOGt@xz-m1.local>
References: <20210908163516.214441-1-peterx@redhat.com>
 <2576475.WBpAVSM2eX@nvdebian>
 <YUFgAPJJxy8L4GMP@xz-m1.local>
 <2497776.C4p5gPNQJS@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2497776.C4p5gPNQJS@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 01:21:30PM +1000, Alistair Popple wrote:
> On Wednesday, 15 September 2021 12:52:48 PM AEST Peter Xu wrote:
> 
> > > > The flag introduced in this patch will be a preparation for more bits defined
> > > > in the future, e.g., for a new bit in flag to show whether to persist the
> > > > upcoming uffd-wp bit in pgtable entries.
> > > 
> > > That's kind of the problem. The patch itself looks correct to me however as
> > > mentioned it is mostly reverting a previous cleanup and it's hard to tell why
> > > that's justified without the subsequent patches. Perhaps it makes the usage of
> > > zap_details a bit clearer, but a comment also would with less code.
> > > 
> > > I know you want to try and shrink the uffd-wp series but I think this patch
> > > might be easier to review if it was included as part of that series.
> > 
> > I posted it because I think it's suitable to have it even without uffd-wp.
> > 
> > I tried to explain it above on two things this patch wanted to fix:
> > 
> > Firstly the comment is wrong; we've moved back and forth on changing the
> > zap_details flags but the comment is not changing along the way and it's not
> > matching the code right now.
> > 
> > Secondly I do think we should have a flag showing explicit willingness to skip
> > swap entries.  Yes, uffd-wp is the planned new one, but my point is anyone who
> > will introduce a new user of zap_details pointer could overlook this fact.  The
> > new flag helps us to make sure someone will at least read the flags and know
> > what'll happen with it.
> > 
> > For the 2nd reasoning, I also explicitly CCed Kirill too, so Kirill can provide
> > any comment if he disagrees.  For now, I still think we should keep having such
> > a flag otherwise it could be error-prone.
> > 
> > Could you buy-in above reasoning?
> 
> Kind of, I do think it makes the usage of details a bit clearer or at least
> harder to miss. It is just that if that was the sole aim of this patch I think
> there might be simpler (less code) ways of doing so.

Yes you're right, we can add a big enough comment above zap_details to state
that, but then it'll be reverted when adding the uffd-wp flag in the other
series, because uffd-wp will still needs a way to specify !SKIP_SWAP and
KEEP_UFFD_WP.  Then it'll make the "series split" make less sense as you said.

I split the series only because I hope it could ease the reviewers, and also
that's probably the only thing I can do now to still try to smooth the process
of having a complete uffd-wp finally got proper reviewed and merged.

> 
> > Basically above is what I wanted to express in my commit message.  I hope that
> > can justify that this patch (even if extremly simple) can still be considered
> > as acceptable upstream even without uffd-wp series.
> > 
> > If you still insist on this patch not suitable for standalone merging and
> > especially if some other reviewer would think the same, I can move it back to
> > uffd-wp series for sure.  Then I'll repost this series with 4 patches only.
> 
> I won't insist, the code looks correct and it doesn't make things any less
> clear so you can put my Reviewed-by on it and perhaps leave it to Andrew or
> another reviewer to determine if this should be taken in this series or as part
> of a future uffd-wp series.

Will do; thanks.

-- 
Peter Xu

