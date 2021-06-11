Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BAA3A4977
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhFKTgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFKTgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:36:12 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA10C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:34:02 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so4205775oth.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=9KC1WlvZCoYfqYiySVqCF52BYldtrMLa/9NrPxZB38U=;
        b=s3Mli2zklAXF+ZbXmuW9tm1ImNKrtBdKTHxo/PFxqVNnoah48XzwpEIZBMnd3V3Bzk
         d4SA4+7LYVF7HdkzXFdfEFXeYyrRYEoWVaCkLBvj2LuQzqy5coz8nmMhvtcaoymwBF0P
         +3fT5OtAluNA+zY3kKlsD/nqQ67NdjxtXJWbWV8rDR8PXcpeD8pqRItA4uRqhnSdDF++
         Le/f6nA88n/quDVoWVyUQDlTVeEijeMp048FBJFZ2yVJGRBdjSvaJfa8IH7U4eQyiqzk
         BdPh+Rl+/vVhG+knNsZTYSwGyMkc4/xCdQG0l1Ow+/vg5QstK9tGTpht8vQaInB2XdbG
         w90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=9KC1WlvZCoYfqYiySVqCF52BYldtrMLa/9NrPxZB38U=;
        b=nQqs8F3Wr9uv3vWlzlnEr1WcPsB2tDAaYUp6tl/4ixk5vSqKy9J/2BdFiPbfTSrSVW
         PzVhtKsK5ctJrP481tI/HNJvbHF35Gph0luTgfGNRwbJlokOK4DWaw/QyXpuAz/ftIGG
         /WFVddbHvYbWxgkrKDi76Nzy9iCYZp0FasJwQ9adHhIziCIO22gG/vK/1sINyhHuTcJ4
         YgjZv7nKuc3OQdBAgrMXYAMyQUkwkct4bDqL/XtUAOJ5tske2Qi+fWEfkWWRzCZnIwF9
         9wfAz+RAFxUt3RGjMsmoHkqxYVGi2nXv/dgX/gI7S8YWmIZFRLxitr07Wv2Kgk+4Q/zl
         /Q6Q==
X-Gm-Message-State: AOAM530zrf5SS71Oc24XMuwSQyowKKFhhiS2LqWtDlLYc54/mOKR9/7+
        0EbYLuVT6fnpxraO26SgItylrw==
X-Google-Smtp-Source: ABdhPJxOUhBU+bQdZhK5J/qK2+/M+sj1IXnZgj4uy8bYedMJf0BZ2BvegiL+1874ZuiIeHMbp479Og==
X-Received: by 2002:a05:6830:168e:: with SMTP id k14mr4529195otr.280.1623440041630;
        Fri, 11 Jun 2021 12:34:01 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w4sm1473227otm.31.2021.06.11.12.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 12:34:01 -0700 (PDT)
Date:   Fri, 11 Jun 2021 12:33:58 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] mm: page_vma_mapped_walk(): use
 pmd_read_atomic()
In-Reply-To: <20210611153613.GR1096940@ziepe.ca>
Message-ID: <c4e26fc6-8788-b656-532b-5f8ccb59937@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com> <594c1f0-d396-5346-1f36-606872cddb18@google.com> <20210610090617.e6qutzzj3jxcseyi@box.shutemov.name> <20210610121542.GQ1096940@ziepe.ca> <aebb6b96-153e-7d7-59da-f6bad4337aa7@google.com>
 <20210611153613.GR1096940@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021, Jason Gunthorpe wrote:
> On Thu, Jun 10, 2021 at 11:37:14PM -0700, Hugh Dickins wrote:
> > On Thu, 10 Jun 2021, Jason Gunthorpe wrote:
> > > On Thu, Jun 10, 2021 at 12:06:17PM +0300, Kirill A. Shutemov wrote:
> > > > On Wed, Jun 09, 2021 at 11:38:11PM -0700, Hugh Dickins wrote:
> > > > > page_vma_mapped_walk() cleanup: use pmd_read_atomic() with barrier()
> > > > > instead of READ_ONCE() for pmde: some architectures (e.g. i386 with PAE)
> > > > > have a multi-word pmd entry, for which READ_ONCE() is not good enough.
> > > > > 
> > > > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > > > Cc: <stable@vger.kernel.org>
> > > > >  mm/page_vma_mapped.c | 5 ++++-
> > > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > > > > index 7c0504641fb8..973c3c4e72cc 100644
> > > > > +++ b/mm/page_vma_mapped.c
> > > > > @@ -182,13 +182,16 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> > > > >  	pud = pud_offset(p4d, pvmw->address);
> > > > >  	if (!pud_present(*pud))
> > > > >  		return false;
> > > > > +
> > > > >  	pvmw->pmd = pmd_offset(pud, pvmw->address);
> > > > >  	/*
> > > > >  	 * Make sure the pmd value isn't cached in a register by the
> > > > >  	 * compiler and used as a stale value after we've observed a
> > > > >  	 * subsequent update.
> > > > >  	 */
> > > > > -	pmde = READ_ONCE(*pvmw->pmd);
> > > > > +	pmde = pmd_read_atomic(pvmw->pmd);
> > > > > +	barrier();
> > > > > +

Andrew, please drop this patch from your queue: it's harmless,
but pretending to do some good when it does not.  The situation has
changed since I originally wrote it, gcc min version has been raised,
Will Deacon has corrected the applicability of READ_ONCE() to pmd_t in
April 2020 commits, pmd_read_atomic() is not as magic as I thought (it
has good uses but not here), and the commit comment is no longer right.

However... if you're nearing the point of a fresh mmotm, probably best
to leave it in for now and we sort out the mess later.  Because although
it's functionally independent from the other patches in the series,
there is of course the "indentation" patch, and this falls in the middle
of what's indented a level there.

I don't imagine that will tax your abilities to their limit, but after
that there's the main bugfix patch, which expects a blank line I added
in this one, that's no longer there when reverted.  Enough to make me
sigh, and just write to say "drop, when you have time".

Let me know if you'd prefer a resend of the series (today? not sure).

(Discussion of pmd_read_atomic() and barrier() and mm_find_pmd() and
suchlike may continue in this thread, but this 03/11 should just be
dropped.  Whether it's in or out should not affect Alistair's series.)

Thanks,
HUgh
