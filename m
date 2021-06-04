Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A7F39C389
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 00:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhFDWha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 18:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhFDWh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 18:37:29 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3C1C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 15:35:30 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id u30so10912000qke.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 15:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=A03XgQU8NzlglslD3mgWrvExCaUvRjm0SZn+MYd0Pp8=;
        b=X/4CL2PGoA18iROPFhrbyp2pwp7ZytWLyseVMQXcP/w0zdtKE8XuOSpKZx9dv0qJ7e
         Njk/P2eCAmGz94pogEB31kEyhZ/tntf2WQqoJZ7dkekqmgjsjc5SAX/nC+PVUcM5lftz
         OxLljBVLJJTwR24+PSElQRyp45uBruxVF7fbGCI5VdRYoAJ+eGlM1ZPRRXCAI7ueGAs7
         uplWoK9fhugWy21Ki/Wxf4hZzdzgLL/zpNHP01Ddj3uY4HUpxNldkPneaJEBPsZg2XfZ
         wq1T9qd0lHQRaGtFfEd67WYv4hllOTByc5Ai5C4XdZG643c4yILw9JazpH8czUgV4YG6
         peqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=A03XgQU8NzlglslD3mgWrvExCaUvRjm0SZn+MYd0Pp8=;
        b=VOua223hXs+61YiNmIZiG6TulPwEtcTVA7wXeG7/vHUnLXgbaiPnTr/yqMZgLt6JGv
         HRMvjmfptIGHU7SaFPD1AjDjGdtolfGo/lZvQIHgmYX9ndvDWebtMKFYFHpvQxwUETOh
         qc/p7DAntWR4ws0rugLaoqxc8Fi2uzcEH5+E7Jc+sC90147ErqvhpgXJDoHZ3VHeGPqQ
         ChgRLqyyri6d+MhVmUoz8B3qcZcBQaoB+dSMgWRxNmHakPLXjRpv8cK0OoW+9nSK2ohP
         zzB9mPCyS/aP0efvJI9ACKTxT9jWBQvihflB+2XPlNRkooMU4cDcQZUgxjyMY80e7aY+
         uM+g==
X-Gm-Message-State: AOAM533mO0JXed8htdJUvNHMmx4mT6Wghu/Gvwo6QPWYHO1m/4ekTSau
        XGDKSoyD2JTSmiQp+f6/a3iiCw==
X-Google-Smtp-Source: ABdhPJyDBcBc9VWfgQFBvbaA6O1/dUXrownxIqW+LyEIRIdNb+5KDkwCIpZARxPFqG0DKzPrGgkcog==
X-Received: by 2002:a05:620a:13c4:: with SMTP id g4mr6604115qkl.219.1622846126751;
        Fri, 04 Jun 2021 15:35:26 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f13sm4792637qkk.107.2021.06.04.15.35.24
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 04 Jun 2021 15:35:26 -0700 (PDT)
Date:   Fri, 4 Jun 2021 15:35:24 -0700 (PDT)
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
Subject: Re: [PATCH v2 3/7] mm/thp: fix vma_address() if virtual address
 below file offset
In-Reply-To: <YLpkirfozSeH4F8N@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2106041527350.14037@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils> <alpine.LSU.2.11.2106011408020.2148@eggly.anvils> <YLanDVVbKwwPmW/0@casper.infradead.org> <alpine.LSU.2.11.2106031427200.11704@eggly.anvils> <alpine.LSU.2.11.2106031436390.11704@eggly.anvils>
 <YLpkirfozSeH4F8N@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021, Matthew Wilcox wrote:
> On Thu, Jun 03, 2021 at 02:40:30PM -0700, Hugh Dickins wrote:
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
> > +		   pgoff + compound_nr(page) > vma->vm_pgoff) {
> 
> I think on 32-bit, you need ...
> 
> 		   pgoff + compound_nr(page) - 1 >= vma->vm_pgoff
> 
> ... right?

Hey, beating me at my own game ;-) I'm pretty sure you're right (and
it's true that I first wrote this patch before becoming conscious of
the 32-bit MAX_LFS_FILESIZE issue); but caution tells me to think
some more and check some places before committing to that.

Thanks,
Hugh
