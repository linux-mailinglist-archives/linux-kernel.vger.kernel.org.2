Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E0538098C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhENMca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233446AbhENMcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620995473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0wcDpE/Q+m1DFHQZr7axynmSMqacQ9s1VDrFV+vCPSw=;
        b=jIznZmZ3EOlhmOrWjLQzDMRfhw6NlAqwAhoxyVUqgN0nk+BQfIC1gDSjdXW+ACg6EddNaM
        fYkpY4KtNVQFDzQDeSVF+BBk8wlM5thbGBT5t7AyNq1ssN7H+ljIKPxICm9VByKbN/Aoin
        vXOhvQMtPSut/6mPidrrkjcERZk//wI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-RLiJ6h0xPMWD24XduIprzQ-1; Fri, 14 May 2021 08:31:11 -0400
X-MC-Unique: RLiJ6h0xPMWD24XduIprzQ-1
Received: by mail-qk1-f198.google.com with SMTP id v1-20020a05620a1221b02902ea88445e01so18571083qkj.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0wcDpE/Q+m1DFHQZr7axynmSMqacQ9s1VDrFV+vCPSw=;
        b=mHGvMdZv9yeN9hNy0tbl4h9Qv110S9uTJboXvn5v3dRGS9HoF3JDESK73ZegE3Bp3M
         mb2yoSd+jjezyG1Mu9NXukUbspk5vmVbn1Z0spWk4Lz1KyVEB/dfWQRm7kxMnJ/gE0rF
         /A0BaIP33fjW9BSMJds5U1pmeUFikvvC1+95vE+oUXIUxmHDoIyvAwCwRivHFhPnYVyK
         w5y41e9/hWTzv/M3htpUZTFE1B/m92NQef4J5UPkTiCNv2J/HryB9yyAd+gBZv/zJdVi
         GtmgkmlEZeLf0Jg0dDysQAUCXEE6M+875eZwLJWrmNwl1wfXnQv8dhn52zvxII4QwKzd
         RZuQ==
X-Gm-Message-State: AOAM533x4XvUL5dMqvFdZRLcFnwJC8bdN9dw6E3yVgwi7B+4nkXnznby
        4uhz5DaY6xK6iely0GzUClxuPCcPz4CA3r9mDX0p0aiTWPEBiGwVfvy3gcQ2LJyc6b3rBY4VLgB
        hMJ7ZWoY6E2zxso8wdCANvru3
X-Received: by 2002:a37:f512:: with SMTP id l18mr42878514qkk.89.1620995470943;
        Fri, 14 May 2021 05:31:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUc7ycbD+8M+157LnMfInY8crn9Z3vRgQFv1/EnGb3Xrs/M5OLOrdoQdqzSDyHPZxJim98iQ==
X-Received: by 2002:a37:f512:: with SMTP id l18mr42878477qkk.89.1620995470612;
        Fri, 14 May 2021 05:31:10 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id n15sm4462637qti.51.2021.05.14.05.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:31:10 -0700 (PDT)
Date:   Fri, 14 May 2021 08:31:09 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
Message-ID: <YJ5tjWKyVZk2mvxo@t490s>
References: <20210513234309.366727-1-almasrymina@google.com>
 <CAHS8izNkBvS9gkSjy8FbWBOPDynwr8PXXXbMHt_2=5sZJsa6-Q@mail.gmail.com>
 <09dc0712-48e8-8ba2-f170-4c2febcfff83@oracle.com>
 <CAHS8izPFc+bSrKN-6gRguGefAqrj6kXaMUvgeUL5U7QxhXfWDw@mail.gmail.com>
 <f9c85756-62e1-3d5c-9fbc-f38c6e8f07f3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9c85756-62e1-3d5c-9fbc-f38c6e8f07f3@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mike,

On Thu, May 13, 2021 at 09:02:15PM -0700, Mike Kravetz wrote:

[...]

> I am also concerned with the semantics of this approach and what happens
> when a fault races with the userfaultfd copy.  Previously I asked Peter
> if we could/should use a page found in the cache for the copy.  His
> answer was as follows:
> 
>  AFAICT that's the expected behavior, and it need to be like that so as to avoid
>  silent data corruption (if the page cache existed, it means the page is not
>  "missing" at all, then it does not suite for a UFFDIO_COPY as it's only used
>  for uffd page missing case).

I didn't follow the rest discussion in depth yet... but just to mention that
the above answer was for the question whether we can "update the page in the
page cache", rather than "use a page found in the page cache".

I think reuse the page should be fine, however it'll definitely break existing
user interface (as it'll expect -EEXIST for now - we have kselftest covers
that), meanwhile I don't see why the -EEXIST bothers a lot: it still tells the
user that this page was filled in already.  Normally it was filled in by
another UFFDIO_COPY (as we could have multiple uffd service threads) along with
a valid pte, then this userspace thread can simply skip this message as it
means the event has been handled by some other servicing thread.

(This also reminded me that there won't be a chance of UFFDIO_COPY race on page
 no page fault at least, since no page fault will always go into the uffd
 missing handling rather than filling in the page cache for a VM_UFFD_MISSING
 vma; while mmap read lock should guarantee VM_UFFD_MISSING be persistent)

Thanks,

-- 
Peter Xu

