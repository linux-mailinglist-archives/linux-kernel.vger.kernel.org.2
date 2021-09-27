Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AD741917B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhI0J0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhI0J0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:26:13 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68886C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:24:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u8so73622117lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tyy6Dv7V4fb/Ljhb18nEvTV2h/rNzPynwFMmcx94u8M=;
        b=Px18PFMmqv5tM0ES8a9DDmI150bGqOY2axThJnD9LQD345HFLscARXZ7aNBhhL6O9w
         OlBxtwbGSgDcaO1tiDwu4HCuvbedUfA5kRiqW9fCvubYCDFeF7rsQkeirLA6AB9lDB/+
         98D4prIrxs2zuHq+abJdHTtImN4MZ6SZcve32xEzHpT4+OdJq2l8OEAMiq83Zk87UMod
         klxZJpckzW1ev6CxHOj8DP4bmrRwNgWH8pm6RSylRwDUFPZ0tzQivrWecSDw+ffgv0fi
         DtnfuBWoG7JjfUuOBGdlE7kj2kcCELWQWqUxwX2lNaamIIYTGBkdCuSGw43dWJoeY49U
         rLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tyy6Dv7V4fb/Ljhb18nEvTV2h/rNzPynwFMmcx94u8M=;
        b=23fKEsD0B+uyYNy1ckEccQ8dLx5eyWgHaQNeuJtTqha2Q1qLfuKexEU6ywyWdRKl6Z
         qcQoouJf6oe3sw106s8Pqk2Ms1OZ2IdHkm44N5soqqwo3dhAFmNPAZjzPVyF/FmSTmv7
         fCXxNU0ft39bDVkh194rXB4dFctpcqm0r/7ljQrSeyZYEVgrXQNYUr20jDHheQLW0+2l
         Xqebc+RMox/BvDr107jpwAAEWXxT32g17xk6yosI+vstr9kfZyHyWDqzA3T+ABkISKlT
         rRoY2iUqINoLkVVl9wVrUkVhOq76WE5Sw0BcgpF5kXgr8KKRW2lu4yxgpz80Kmrxy/4Z
         RGqQ==
X-Gm-Message-State: AOAM530l42+NUmSa/QQ1B8vmW5NDIkheKKy5toKireJeZoc3Ra/yF9FG
        9FZJcvUFtzqrm6bG425hzuDGag==
X-Google-Smtp-Source: ABdhPJwlx60z2P3MK7KYZvU/sSyo2JgYRYCh8HGrQBPKJikovN0Mp+E6gRY9yo5sLsfCMA1mpREAFA==
X-Received: by 2002:a05:6512:3ee:: with SMTP id n14mr24062637lfq.589.1632734673773;
        Mon, 27 Sep 2021 02:24:33 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u14sm1538020lfi.231.2021.09.27.02.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 02:24:33 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B29CC10306C; Mon, 27 Sep 2021 12:24:32 +0300 (+03)
Date:   Mon, 27 Sep 2021 12:24:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 3/8] mm/madvise: remove unnecessary checks on
 madvise_free_single_vma()
Message-ID: <20210927092432.qdshyj67lkiq2cbv@box.shutemov.name>
References: <20210926161259.238054-1-namit@vmware.com>
 <20210926161259.238054-4-namit@vmware.com>
 <20210927091709.ksv2fjudjpqhnu3n@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927091709.ksv2fjudjpqhnu3n@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 12:17:09PM +0300, Kirill A. Shutemov wrote:
> On Sun, Sep 26, 2021 at 09:12:54AM -0700, Nadav Amit wrote:
> > From: Nadav Amit <namit@vmware.com>
> > 
> > madvise_free_single_vma() currently rechecks that the range fits within
> > the VMA, adapts it accordingly, and returns -EINVAL if the range is
> > entirely outside of the VMA.
> > 
> > The error-code of -EINVAL is incorrect according to the man pages (as it
> > should have been -ENOMEM), but anyhow the range that is provided to
> > madvise_free_single_vma() should always be valid. It is set correctly in
> > do_madvise() and then rechecked in madvise_dontneed_free() is the

s/is/if/

> > mmap-lock is dropped.
> > 
> > Remove this check.
> > 
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Colin Cross <ccross@google.com>
> > Cc: Suren Baghdasarya <surenb@google.com>
> > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Signed-off-by: Nadav Amit <namit@vmware.com>
> > ---
> >  mm/madvise.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index fe843513a4e8..17e39c70704b 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -716,14 +716,8 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
> >  	if (!vma_is_anonymous(vma))
> >  		return -EINVAL;
> >  
> > -	range.start = max(vma->vm_start, start_addr);
> > -	if (range.start >= vma->vm_end)
> > -		return -EINVAL;
> > -	range.end = min(vma->vm_end, end_addr);
> > -	if (range.end <= vma->vm_start)
> > -		return -EINVAL;
> 
> How did you test this change?
> 
> As far as I can see, you leave 'range' uninitialized, but used for
> walk_page_range() and mmu_notifiers.
> 
> NAK.

Sorry. My bad. mmu_notifier_range_init will init the range even if mmu
notifiers are disabled.

> 
> >  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
> > -				range.start, range.end);
> > +				start_addr, end_addr);
> >  
> >  	lru_add_drain();
> >  	tlb_gather_mmu(&tlb, mm);
> > -- 
> > 2.25.1
> > 
> > 
> 
> -- 
>  Kirill A. Shutemov

-- 
 Kirill A. Shutemov
