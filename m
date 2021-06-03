Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D8339AD04
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFCVjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:39:25 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:45001 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhFCVjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:39:24 -0400
Received: by mail-pj1-f47.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so4676353pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 14:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Cj9U35yyPKE7pmK1j+7Q/zTNdC/H5R4M+AV3/2neWss=;
        b=fTsaDKhxAw8PVvd83BCP/cC6qKJlN6V1o9LrtB/y3O9S4mwmZ7uBGouH9gCJd104kY
         PZGI/0aZo+mptQPhKHftz5U4u85THlEgNu5bQMPzs6a+YQkqQ57RwoSNgRYalz7ptdhw
         IGMVfkwHNUiIyZxIffwW4micgcNNdthk2pqKYXrpmRGJF7huGilIH8RIJWIjqsgrWZqR
         vwWw9rKAR1q1dSmix/yth+LRJLlDHM9LahZcA6C0E1lY0g+D/g67Q8VxV7Frne4HCZ1e
         KQB0ShNLnsBLe9kyi0y1MjeJjSt/1pALCv0tgcAsRiu024W3Ppj/HdX6xrBumsGr6XWk
         91Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Cj9U35yyPKE7pmK1j+7Q/zTNdC/H5R4M+AV3/2neWss=;
        b=JzJfyrL/ZaC1jJaWUsGqnauCGk3EVd2CANTX3wRrrvBLqtGAL6NxPf2S1B8QIf/VjT
         oDqo2O0CKWtME2xhXn+UpEqa7tf/jmlT2/tdI0W7RjWpVbCCZecG0KIb80u7c1yfzpvp
         r/o1kC+AoR6R4uqLy2MduE/9NIQGSXOjelviMmK9WUTO/kWlFitlYsgQg9YZfy4Ls/+d
         s1hYgDDhJimDmcz/EFbwc8mcXrqKXUkAIJN6nsYOGsO35oj1/XRhRHecBlmsxjjieAmU
         T3HCpgtlRX0OiaM576rLOXE4xcbPwYfNlQyplyrFIda256EfEw3ohGHTP71dBPe+cgFe
         aaFg==
X-Gm-Message-State: AOAM533v9uH5IabYnW9JxOerQNpgUQ64esUaWIw7kU6aOojR7vugFhrx
        vpJWPdm87GdsYm5xNufxsHyZvQ==
X-Google-Smtp-Source: ABdhPJxQrzqM3TCx+SozMQdopXsTTrnp+llKpDAJG/mbFkZdwHQNSDq/sHeU1qLGTrDBrMOAmuLtzg==
X-Received: by 2002:a17:902:b683:b029:ee:f0e3:7a50 with SMTP id c3-20020a170902b683b02900eef0e37a50mr1103742pls.7.1622756185123;
        Thu, 03 Jun 2021 14:36:25 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id mr23sm2966147pjb.12.2021.06.03.14.36.23
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Jun 2021 14:36:24 -0700 (PDT)
Date:   Thu, 3 Jun 2021 14:36:11 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mm/thp: fix vma_address() if virtual address below
 file offset
In-Reply-To: <YLanDVVbKwwPmW/0@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2106031427200.11704@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils> <alpine.LSU.2.11.2106011408020.2148@eggly.anvils> <YLanDVVbKwwPmW/0@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021, Matthew Wilcox wrote:
> On Tue, Jun 01, 2021 at 02:09:31PM -0700, Hugh Dickins wrote:
> >  static inline unsigned long
> > -__vma_address(struct page *page, struct vm_area_struct *vma)
> > +vma_address(struct page *page, struct vm_area_struct *vma)
> >  {
> > -	pgoff_t pgoff = page_to_pgoff(page);
> > -	return vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> > +	pgoff_t pgoff;
> > +	unsigned long address;
> > +
> > +	VM_BUG_ON_PAGE(PageKsm(page), page);	/* KSM page->index unusable */
> > +	pgoff = page_to_pgoff(page);
> > +	if (pgoff >= vma->vm_pgoff) {
> > +		address = vma->vm_start +
> > +			((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> > +		/* Check for address beyond vma (or wrapped through 0?) */
> > +		if (address < vma->vm_start || address >= vma->vm_end)
> > +			address = -EFAULT;
> > +	} else if (PageHead(page) &&
> > +		   pgoff + (1UL << compound_order(page)) > vma->vm_pgoff) {
> 
> 	} else if (PageHead(page) &&
> 		   pgoff + compound_nr(page) > vma->vm_pgoff) {

Yes, that's better, thanks.

I was tempted to leave out the preliminary PageHead() test altogether;
but you didn't suggest that, and I've concluded that perhaps it makes
for good documentation, even though not strictly needed.

> 
> > +vma_address_end(struct page *page, struct vm_area_struct *vma)
> >  {
> > +	pgoff_t pgoff;
> > +	unsigned long address;
> > +
> > +	VM_BUG_ON_PAGE(PageKsm(page), page);	/* KSM page->index unusable */
> > +	pgoff = page_to_pgoff(page);
> > +	if (PageHead(page))
> > +		pgoff += 1UL << compound_order(page);
> > +	else
> > +		pgoff++;
> 
> Again, can use compound_nr here.  In fact, the whole thing can be:
> 
> 	pgoff += compound_nr(page);

Even nicer; and I've taken the liberty of just saying

	pgoff = page_to_pgoff(page) + compound_nr(page);

v2 of this patch coming up now, thanks.

Hugh
