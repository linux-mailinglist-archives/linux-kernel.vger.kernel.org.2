Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EC942D1D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 07:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhJNFMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 01:12:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhJNFMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 01:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634188240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ge0ebwviz5Bm5d/fEKQmZixoWz8JO7cHa468HpLZEu4=;
        b=hPnqsQ0xKl7GPUg7RzASZU/p3/fTr+Q+WDMjxQjhQs1aTn3HVJHe+So5xqiqeGq2qllRQi
        88RBXm/0ZvI/mRJZqZKD7Hke+i3q6zbri3EJRgZrzHvmn5Xfw2TLtLcMuinzUE/PmIbaHd
        6VnJrQ+qXyxZe0rbyxYbVAKS4xjnlPE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-tIrdi-9AOP6KmlywBuY-KQ-1; Thu, 14 Oct 2021 01:10:38 -0400
X-MC-Unique: tIrdi-9AOP6KmlywBuY-KQ-1
Received: by mail-pg1-f198.google.com with SMTP id b5-20020a6541c5000000b002661347cfbcso2828161pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 22:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ge0ebwviz5Bm5d/fEKQmZixoWz8JO7cHa468HpLZEu4=;
        b=rgYtvlTYmcaVw6Iv8Sc8dot2t5XusNFMepmOA3LGeX5PUEok+G2YKFLNBZvNzXs0Tz
         uGJcwBD7r7su2/ZR3Eaj/DUsXRB8mDdjMpn5HvtcW1pXxPxGsvZlDJiNx+13uajznoBN
         sOKinOfWqqIJdb1aodcqSDWJIHxuh2YZ15Ax37tsPRXSb6fzA4RdHsvA/fSGLdNOsrvT
         DbYcHCnERdQIOfkJkUa/RNNBRMLFDVF+g1P44ViF+GWZkGzm4S5rFl5F8t9pCPCpuO3Q
         41BhM5+zhmIm06h9V6GNC2IE1ydOaD+XxLbA0IwW6MHkZhnK4W7BLgzx4g7PMSA9n5mH
         FWAw==
X-Gm-Message-State: AOAM533mu/6Ttjn2oS0PuhAuXWzJhmGdQ0SxfXuMVWraRIKUG6VkTNGZ
        09JY4QoWWKlYtPynGme+bz0pFGWGbMoXCaRA2+od4O/eqRXSPrbFXFlVmnDAW9STAS/PqOtIP+S
        uxmiunzsbgZ/GRKFmcE+Amuhz
X-Received: by 2002:a63:d64c:: with SMTP id d12mr2759059pgj.186.1634188237422;
        Wed, 13 Oct 2021 22:10:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+HfqtT1TmCrQjEW4TrA+TZHaBbrb5CUaGbIoddwpaWRpF41OyDzFEtYlCm87Zo5uV3KfwLQ==
X-Received: by 2002:a63:d64c:: with SMTP id d12mr2759040pgj.186.1634188237099;
        Wed, 13 Oct 2021 22:10:37 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u3sm1062553pfl.155.2021.10.13.22.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 22:10:36 -0700 (PDT)
Date:   Thu, 14 Oct 2021 13:10:31 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: mm: unnecessary COW phenomenon
Message-ID: <YWe7x5DK0sMDskYE@t490s>
References: <FFA0057D-1A17-4DF4-9550-A8CDEE9E0CE0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FFA0057D-1A17-4DF4-9550-A8CDEE9E0CE0@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 03:42:08PM -0700, Nadav Amit wrote:
> Andrea, Peter, others,

Hi, Nadav,

> 
> I encountered many unnecessary COW operations on my development kernel
> (based on Linux 5.13), which I did not see a report about and I am not
> sure how to solve. An advice would be appreciated.
> 
> Commit 09854ba94c6aa ("mm: do_wp_page() simplification”) prevents the reuse of
> a page on write-protect fault if page_count(page) != 1. In that case,
> wp_page_reuse() is not used and instead the page is COW'd by wp_page_copy
> (). wp_page_copy() is obviously much more expensive, not only because of the
> copying, but also because it requires a TLB flush and potentially a TLB
> shootodwn.
> 
> The scenario I encountered happens when I use userfaultfd, but presumably it
> might happen regardless of userfaultfd (perhaps swap device with
> SWP_SYNCHRONOUS_IO). It involves two page faults: one that maps a new
> anonymous page as read-only and a second write-protect fault that happens
> shortly after on the same page. In this case the page count is almost always
> elevated and therefore a COW is needed.
> 
> [ The specific scenario that I have as as follows: I map a page to the
> monitored process using UFFDIO_COPY (actually a variant I am working on) as
> write-protected. Then, shortly after an write access to the page triggers a
> page fault. The uffd monitor quickly resolves the page fault using
> UFFDIO_WRITEPROTECT. The kernel keeps the page write protected in the page
> tables but marked logically as uffd-unprotected and the page table is
> retried. The retry triggers a COW. ]
> 
> It turns out that the elevated page count is due to the caching of the page in
> the local LRU cache (by lru_cache_add() which is called by
> lru_cache_add_inactive_or_unevictable() in the case userfaultfd). Since the
> first fault happened shortly before the second write-protect fault, the LRU
> cache was still not drained, so the page count was not decreased and a COW is
> needed.
> 
> Calling lru_add_drain() during this flow resolves the issue most of the time.
> Obviously, it needs to be called on the core that allocated (i.e., faulted
> in) the page initially to work. It is possible to do it conditionally only if
> the page-count is greater than 1.
> 
> My questions to you (if I may) are:
> 
> 1. Am I missing something?

I agree with your analysis.  I didn't even notice the lru_cache_add() can cause
it very likely to trigger the COW in your uffd use case (and also for swap),
but that's indeed something could happen with the current page reuse logic in
do_wp_page(), afaiu.

> 2. Should it happen in other cases, specifically SWP_SYNCHRONOUS_IO?

Frankly I don't know why SWP_SYNCHRONOUS_IO matters here, as that seems to me a
flag to tell whether the swap device is fast on IO so swapping can be done
synchronously and skip swap cache.  E.g., I think normal swapping could have
similar issue too?  As long as in do_swap_page() the reuse_swap_page() call is
either not triggered (which means it's a read fault) or it returned false
(which means there's more than 1 map+swap count).

> 3. Do you have a better solution?

What you suggested as "conditionally lru draining in fault path" seems okay,
but that does look like yet another band-aid to the page reuse logic..
Meanwhile sorry I don't have anything better in mind.  Andrea proposed the
mapcount unshare solution [1] (I believe you should be aware of it now; it
definitely needs some time reading if you didn't follow that previusly...) and
that definitely can resolve this issue too, it's just that upstream hasn't
reached a consensus on that, so the page reuse is kept the current way on
depending on refcount rather than mapcount.

[1] https://github.com/aagit/aa/tree/mapcount_unshare

Thanks,

-- 
Peter Xu

