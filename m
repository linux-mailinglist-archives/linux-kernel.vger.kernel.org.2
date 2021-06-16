Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AC13A973A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhFPK36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231769AbhFPK3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:29:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACDD760FE6;
        Wed, 16 Jun 2021 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623839268;
        bh=OntBdQanyH4j4587k9+3vVoVgxxu9A4265Aw3crQwWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5MiRgCyT2CgyazEYiT1/RJyRt3uFtZnlTAqXM65t9fftQVapUPYihY8Ia9pq7xaV
         wWgjTNpNXpgrwvUJnZs0HquC/biLZq0z8eGOtpvODYKhbFKMVVpBl29iKz3zyWOgST
         vaQ6YQLPeSrlWhBZ/mLtbc/9zmnsVvReGYCv2NfHkNnFMtz51abwgxFyDVd6WVGLAd
         4q3sC8QEG1kzpZonXKh6ETuZwtnnK7aq09C2VQelS/QMn3HWADfxI6woWzxt2D9zHQ
         4DMd4hKaMMyrXg3xwpR2Eca3xlh3xOwJfmLJ6FAdQC44FOcWVLAyHfqSObsWBGVEPH
         MBES7ArMpwcgg==
Date:   Wed, 16 Jun 2021 11:27:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] mm: page_vma_mapped_walk(): use pmd_read_atomic()
Message-ID: <20210616102742.GC22350@willie-the-truck>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <594c1f0-d396-5346-1f36-606872cddb18@google.com>
 <20210610090617.e6qutzzj3jxcseyi@box.shutemov.name>
 <20210610121542.GQ1096940@ziepe.ca>
 <aebb6b96-153e-7d7-59da-f6bad4337aa7@google.com>
 <20210611153613.GR1096940@ziepe.ca>
 <939a0fa-7d6c-f535-7c34-4c522903e6f@google.com>
 <20210611194249.GS1096940@ziepe.ca>
 <20210615094639.GC19878@willie-the-truck>
 <20210616004207.GU1096940@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616004207.GU1096940@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 09:42:07PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 15, 2021 at 10:46:39AM +0100, Will Deacon wrote:
> 
> > Then the compiler can allocate the same register for x and z, but will
> > issue an additional load for y. If a concurrent update takes place to the
> > pmd which transitions from Invalid -> Valid, then it will look as though
> > things went back in time, because z will be stale. We actually hit this
> > on arm64 in practice [1].
> 
> The fact you actually hit this in the real world just seem to confirm
> my thinking that the mm's lax use of the memory model is something
> that deserves addressing.
> 
> Honestly I'm not sure the fix to stick a READ_ONCE in the macros is
> very robust. I prefer the gup_fast pattern of:
> 
>   pmd_t pmd = READ_ONCE(*pmdp);
>   pte_offset_phys(&pmd, addr);
> 
> To correctly force the READ_ONCE under unlocked access and the
> consistently use the single read of the unstable data.
> 
> It seems more maintainable 'hey look at me, I have no locks!' and has
> fewer possibilities for obscure order related bugs to creep in.

Oh, no objection to cleaning this up. It was a "issuing msync(2) causes
data loss argh!" issue, so adding READ_ONCE() to all the macros was the
most straightforward way to solve the immediate problem.

Generally speaking, I think all accesses to live page-tables should be
using READ_ONCE(), as there's also hardware updates from the CPU table
walker to contend with. If that's done in the caller and the macros are
changed to operate on the loaded value, all the better (although this
probably doesn't work so well once you get into rmw operations such as
ptep_test_and_clear_young()).

Will
