Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1402A3A3758
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 00:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhFJWtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 18:49:05 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:43693 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhFJWtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 18:49:04 -0400
Received: by mail-qk1-f171.google.com with SMTP id j62so15313518qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 15:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=LrEBkTu83H7Tgc6v8uZSpjIax3E68F6f8T/pUY54qGg=;
        b=k/rytVQ284fUXmr1w94s7TKB8dvFcGCbJiQLPshA1k9hahCymncZwiJT3ZXlsRLVE7
         hhp0cWN8ZDyA0K0sK+LL8J6cgcTUaWlxyMggg8yZPQHAPL8NVeuAn+EVVL1AgO3oULeI
         OAyehqT1O0aAQWPg8tIy33HHL9tVsBd+dDkZ4ITaCF+Ts99EW2OWZMo/EF0j3Vrc1bMv
         ZqBjyRd/GR3sEcnl1dFQ6QlrFzvPtfGYyS28viISIRpIcfkC3UwEZmGX9l/T3VYU0S8X
         AR2+LKpMGb/jxMURdU1/L2jBvaxdU33irPX/WKcDeRx3aH/4Kbpp8GpDrSU3EWMFNMNB
         mKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=LrEBkTu83H7Tgc6v8uZSpjIax3E68F6f8T/pUY54qGg=;
        b=V7ycLrOug47u6TAlgs2sTrvoSQZTvVjCBUrPmq+suRGzh6kP6rnASV+DL96DMvibJk
         BFIaff/733tnI06qTjurFvjB1I0tbfpa6Y0qby/n5aWl/qZ0jTcsAmzJZD3SWYMMW/yJ
         WkK8VHwLR74e97WqLLxW1dxrYO51ppzrlS5Ha/l0FmO2i0cFIQ87oB8S48w3eyKa1xwx
         Ri5T59G+QXCbQQOUEqlxhzeKB6tu48J8UeJKq6uyupxuh4M88+iGH4E26xJw1TaU/i5T
         PEWbT9yxDbHJmmhloVigzU89+gxLmVYNfi2WHwyASCzPJ7CtU9y+w35eLPkjTllOxQln
         cg2w==
X-Gm-Message-State: AOAM533Ak/DrHdF5LB3TKC7gF+XDLpJM+2BFSnyc3C1Ur84oxszj0SK/
        VsHOUBH3/5kK5k/s6Svnamw8KA==
X-Google-Smtp-Source: ABdhPJyNtsaz2e5ksk0WiDP3q9z0Ftani3IKKbcVdDFB2GCLuhFNuQBp/mmI/yh6kunkaKk7GWrvKg==
X-Received: by 2002:a37:c447:: with SMTP id h7mr968199qkm.63.1623365152225;
        Thu, 10 Jun 2021 15:45:52 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 16sm2248459qty.15.2021.06.10.15.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 15:45:51 -0700 (PDT)
Date:   Thu, 10 Jun 2021 15:45:49 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Will Deacon <will@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] mm: page_vma_mapped_walk(): settle PageHuge on
 entry
In-Reply-To: <YMIe/mn9TKpK3n4K@t490s>
Message-ID: <52648396-6217-52a7-51e0-294863b5329c@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com> <e31a483c-6d73-a6bb-26c5-43c3b880a2@google.com> <YMIe/mn9TKpK3n4K@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021, Peter Xu wrote:
> On Wed, Jun 09, 2021 at 11:36:36PM -0700, Hugh Dickins wrote:
> > page_vma_mapped_walk() cleanup: get the hugetlbfs PageHuge case
> > out of the way at the start, so no need to worry about it later.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  mm/page_vma_mapped.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > index a6dbf714ca15..7c0504641fb8 100644
> > --- a/mm/page_vma_mapped.c
> > +++ b/mm/page_vma_mapped.c
> > @@ -153,10 +153,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >  	if (pvmw->pmd && !pvmw->pte)
> >  		return not_found(pvmw);
> >  
> > -	if (pvmw->pte)
> > -		goto next_pte;
> > -
> >  	if (unlikely(PageHuge(page))) {
> > +		/* The only possible mapping was handled on last iteration */
> > +		if (pvmw->pte)
> > +			return not_found(pvmw);
> > +
> >  		/* when pud is not present, pte will be NULL */
> >  		pvmw->pte = huge_pte_offset(mm, pvmw->address, page_size(page));
> >  		if (!pvmw->pte)
> 
> Would it be even nicer to move the initial check to be after PageHuge() too?
> 
> 	if (pvmw->pmd && !pvmw->pte)
> 		return not_found(pvmw);
> 
> It looks already better, so no strong opinion.

It hadn't occurred to me to move that.  I probably wanted those two
"The only possible mapping" comments near each other.  I don't see any
particular reason to change them around now - beyond the title saying
"settle PageHuge on entry", whereas this is a few lines after entry!

Let's leave it as is.

> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,
Hugh
