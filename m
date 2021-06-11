Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBD43A3C11
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 08:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhFKGkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 02:40:32 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:39541 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhFKGkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 02:40:32 -0400
Received: by mail-oi1-f172.google.com with SMTP id m137so4821298oig.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 23:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=VKm3T1Odyz0ZAhRDKXF4FISye7BrXp7gG7KZ7V0xVOQ=;
        b=t9zuitMWt/r6/xbNdcai1NFoBvDEUjr/rp+v+67BLojyRnz8wjugEERnH0LkjKrot2
         c94qOCfPZvABgyhFkx6sBvbxW8NlLJpRkUgr5nwXJkaXchb6qXDUh/k/WwoSjZLlODoI
         ZaEKy7H9b0e1ujSsDgn/hvwkTk9SjDqdM0eWXHNNNiLO4iQtrLFojjqEOBjmhXsvJXgP
         KonLusRAze5/hAFnyareYDCszaiU586diXVjsVJ7vY0oCgLm5cElqXfs8utOE2Km2Kx0
         RGA5ijZYmSEQq3Mx4zp+3jvvmcJhDb1LaIMbPdb/1V+pCmfHvd5Sf+BqSbsMwpx10jQj
         XhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=VKm3T1Odyz0ZAhRDKXF4FISye7BrXp7gG7KZ7V0xVOQ=;
        b=AFUFXvY+KTH6d8Tjuk1EpLUUF7H+hQLoGYbLP+PWF/YTTb/ibFjBmtEiaSs9cEE6IY
         /P0F+GXJ/+L3irXLFwrL7SMrNvAH/BjEtaSDsCNNNdU3/dXk+HDDGyEEbB3r4YPwW2FL
         2KWddrUtj8JDlEPsflI0xq5tMRjycuYuGpxn8DsJPN5b3Lo4ELtxkkItbWjejtUWKoQk
         rpAkdkN67p+Cn9hKrTqhZhx3xh/ovlrc0521ZEAGDdlUXHEB5ybE7+Y7F/oVIAzmO4ik
         Gdn4HP9D6kjqPJx/qb0YnncEIideTYZuaJjkGlaz81KFE1QU9+PhdYfqzWiVMbrERpFd
         7mbQ==
X-Gm-Message-State: AOAM532ZpFxTmWQbKlNZxva7tAvMlIGnz/Cd8ekypTxldIjIRFB/ohQC
        gIQaOCo5b/veIbqxwR7pk0KgBA==
X-Google-Smtp-Source: ABdhPJwLMof1GZcoftZlnQm6GtT9Q+NrzYtdcsPJJAuw7+zy/jvCCukGxX3heazMl6T8nOUSOxZXow==
X-Received: by 2002:aca:ab4c:: with SMTP id u73mr1416506oie.26.1623393454374;
        Thu, 10 Jun 2021 23:37:34 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b8sm1133630ots.6.2021.06.10.23.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 23:37:33 -0700 (PDT)
Date:   Thu, 10 Jun 2021 23:37:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jason Gunthorpe <jgg@ziepe.ca>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
In-Reply-To: <20210610121542.GQ1096940@ziepe.ca>
Message-ID: <aebb6b96-153e-7d7-59da-f6bad4337aa7@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com> <594c1f0-d396-5346-1f36-606872cddb18@google.com> <20210610090617.e6qutzzj3jxcseyi@box.shutemov.name> <20210610121542.GQ1096940@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021, Jason Gunthorpe wrote:
> On Thu, Jun 10, 2021 at 12:06:17PM +0300, Kirill A. Shutemov wrote:
> > On Wed, Jun 09, 2021 at 11:38:11PM -0700, Hugh Dickins wrote:
> > > page_vma_mapped_walk() cleanup: use pmd_read_atomic() with barrier()
> > > instead of READ_ONCE() for pmde: some architectures (e.g. i386 with PAE)
> > > have a multi-word pmd entry, for which READ_ONCE() is not good enough.
> > > 
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > Cc: <stable@vger.kernel.org>
> > >  mm/page_vma_mapped.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > > index 7c0504641fb8..973c3c4e72cc 100644
> > > +++ b/mm/page_vma_mapped.c
> > > @@ -182,13 +182,16 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> > >  	pud = pud_offset(p4d, pvmw->address);
> > >  	if (!pud_present(*pud))
> > >  		return false;
> > > +
> > >  	pvmw->pmd = pmd_offset(pud, pvmw->address);
> > >  	/*
> > >  	 * Make sure the pmd value isn't cached in a register by the
> > >  	 * compiler and used as a stale value after we've observed a
> > >  	 * subsequent update.
> > >  	 */
> > > -	pmde = READ_ONCE(*pvmw->pmd);
> > > +	pmde = pmd_read_atomic(pvmw->pmd);
> > > +	barrier();
> > > +
> > 
> > Hm. It makes me wounder if barrier() has to be part of pmd_read_atomic().
> > mm/hmm.c uses the same pattern as you are and I tend to think that the
> > rest of pmd_read_atomic() users may be broken.
> > 
> > Am I wrong?
> 
> I agree with you, something called _atomic should not require the
> caller to provide barriers.
> 
> I think the issue is simply that the two implementations of
> pmd_read_atomic() should use READ_ONCE() internally, no?

I've had great difficulty coming up with answers for you.

This patch was based on two notions I've had lodged in my mind
for several years:

1) that pmd_read_atomic() is the creme-de-la-creme for reading a pmd_t
atomically (even if the pmd_t spans multiple words); but reading again
after all this time the comment above it, it seems to be more specialized
than I'd thought (biggest selling point being for when you want to check
pmd_none(), which we don't).  And has no READ_ONCE() or barrier() inside,
so really needs that barrier() to be as safe as the previous READ_ONCE().

2) the barrier() in mm_find_pmd(), that replaced an earlier READ_ONCE(),
because READ_ONCE() did not work (did not give the necessary guarantee? or
did not build?) on architectures with multiple word pmd_ts e.g. i386 PAE.

But I've now come across some changes that Will Deacon made last year:
the include/asm-generic/rwonce.h READ_ONCE() now appears to allow for
native word type *or* type sizeof(long long) (e.g. i386 PAE) - given
"a strong prevailing wind" anyway :)  And 8e958839e4b9 ("sparc32: mm:
Restructure sparc32 MMU page-table layout") put an end to sparc32's
typedef struct { unsigned long pmdv[16]; } pmd_t.

It looks like my justification for this 03/11 patch is out-of-date,
and the patch should be dropped from the series.

As to your questions about pmd_read_atomic() usage elsewhere:
please don't force me to think so hard!  (And you've set me half-
wondering, whether there are sneaky THP transitions, perhaps of the
"unstable" kind, that page_vma_mapped_walk() should be paying more
attention to: but for sanity's sake I won't go there, not now.)

Hugh
