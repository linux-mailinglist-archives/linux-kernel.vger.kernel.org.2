Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44302361EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242881AbhDPLlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235422AbhDPLlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:41:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89260610F7;
        Fri, 16 Apr 2021 11:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618573239;
        bh=3OCC+s3KXL3CRYXcQVOMoxBoZGtDVHKh4WAw7RykLgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pDOaH7UQSaGo/ZCEp5A6OFR9uKMDuK6uGnOs2vHTEXGRtAtsQKGjkGGsk3PWg0Rzz
         fg5+KAwrz0HnwaACc7tBFZJ0FiU+6QY7Mde5xF2bzgD5zKfq/0GkWvGZ39EIc0HE+g
         tlqJxhMX4svoPScIQ+NGKWutY1J3JP937aGi8BuabkOZ8RMt2ezysxFP/7zD0dNvZK
         XbxNl1K61A4bZMmOBWAoDp7p997vg1b6XUfa5J4Z770LWLkdcLFOcY1vZqHi2ZHjEw
         oeYfAwmsxCuYLBl5rTkg+43fXyLPqRl2huPLf6sA4MxYe08eveLy7DEAKMjqBLXamR
         eC3XO8P7cO9bw==
Date:   Fri, 16 Apr 2021 14:40:28 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC/RFT PATCH 2/3] arm64: decouple check whether pfn is normal
 memory from pfn_valid()
Message-ID: <YHl3rM6D6/Y2rtru@kernel.org>
References: <20210407172607.8812-1-rppt@kernel.org>
 <20210407172607.8812-3-rppt@kernel.org>
 <4a788546-b854-fd35-644a-f1d9075a9a78@arm.com>
 <9c0956f0-494e-5c6b-bdc2-d4213afd5e2f@redhat.com>
 <YHdQtmuxpqi4wCE/@kernel.org>
 <62161846-4f03-e4b1-ae0b-fdf96f78d97c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62161846-4f03-e4b1-ae0b-fdf96f78d97c@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 11:31:26AM +0200, David Hildenbrand wrote:
> On 14.04.21 22:29, Mike Rapoport wrote:
> > On Wed, Apr 14, 2021 at 05:58:26PM +0200, David Hildenbrand wrote:
> > > On 08.04.21 07:14, Anshuman Khandual wrote:
> > > > 
> > > > On 4/7/21 10:56 PM, Mike Rapoport wrote:
> > > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > > 
> > > > > The intended semantics of pfn_valid() is to verify whether there is a
> > > > > struct page for the pfn in question and nothing else.
> > > > 
> > > > Should there be a comment affirming this semantics interpretation, above the
> > > > generic pfn_valid() in include/linux/mmzone.h ?
> > > > 
> > > > > 
> > > > > Yet, on arm64 it is used to distinguish memory areas that are mapped in the
> > > > > linear map vs those that require ioremap() to access them.
> > > > > 
> > > > > Introduce a dedicated pfn_is_memory() to perform such check and use it
> > > > > where appropriate.
> > > > > 
> > > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > > > ---
> > > > >    arch/arm64/include/asm/memory.h | 2 +-
> > > > >    arch/arm64/include/asm/page.h   | 1 +
> > > > >    arch/arm64/kvm/mmu.c            | 2 +-
> > > > >    arch/arm64/mm/init.c            | 6 ++++++
> > > > >    arch/arm64/mm/ioremap.c         | 4 ++--
> > > > >    arch/arm64/mm/mmu.c             | 2 +-
> > > > >    6 files changed, 12 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > > > > index 0aabc3be9a75..7e77fdf71b9d 100644
> > > > > --- a/arch/arm64/include/asm/memory.h
> > > > > +++ b/arch/arm64/include/asm/memory.h
> > > > > @@ -351,7 +351,7 @@ static inline void *phys_to_virt(phys_addr_t x)
> > > > >    #define virt_addr_valid(addr)	({					\
> > > > >    	__typeof__(addr) __addr = __tag_reset(addr);			\
> > > > > -	__is_lm_address(__addr) && pfn_valid(virt_to_pfn(__addr));	\
> > > > > +	__is_lm_address(__addr) && pfn_is_memory(virt_to_pfn(__addr));	\
> > > > >    })
> > > > >    void dump_mem_limit(void);
> > > > > diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> > > > > index 012cffc574e8..32b485bcc6ff 100644
> > > > > --- a/arch/arm64/include/asm/page.h
> > > > > +++ b/arch/arm64/include/asm/page.h
> > > > > @@ -38,6 +38,7 @@ void copy_highpage(struct page *to, struct page *from);
> > > > >    typedef struct page *pgtable_t;
> > > > >    extern int pfn_valid(unsigned long);
> > > > > +extern int pfn_is_memory(unsigned long);
> > > > >    #include <asm/memory.h>
> > > > > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > > > > index 8711894db8c2..ad2ea65a3937 100644
> > > > > --- a/arch/arm64/kvm/mmu.c
> > > > > +++ b/arch/arm64/kvm/mmu.c
> > > > > @@ -85,7 +85,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
> > > > >    static bool kvm_is_device_pfn(unsigned long pfn)
> > > > >    {
> > > > > -	return !pfn_valid(pfn);
> > > > > +	return !pfn_is_memory(pfn);
> > > > >    }
> > > > >    /*
> > > > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > > > index 3685e12aba9b..258b1905ed4a 100644
> > > > > --- a/arch/arm64/mm/init.c
> > > > > +++ b/arch/arm64/mm/init.c
> > > > > @@ -258,6 +258,12 @@ int pfn_valid(unsigned long pfn)
> > > > >    }
> > > > >    EXPORT_SYMBOL(pfn_valid);
> > > > > +int pfn_is_memory(unsigned long pfn)
> > > > > +{
> > > > > +	return memblock_is_map_memory(PFN_PHYS(pfn));
> > > > > +}
> > > > > +EXPORT_SYMBOL(pfn_is_memory);> +
> > > > 
> > > > Should not this be generic though ? There is nothing platform or arm64
> > > > specific in here. Wondering as pfn_is_memory() just indicates that the
> > > > pfn is linear mapped, should not it be renamed as pfn_is_linear_memory()
> > > > instead ? Regardless, it's fine either way.
> > > 
> > > TBH, I dislike (generic) pfn_is_memory(). It feels like we're mixing
> > > concepts.
> > 
> > Yeah, at the moment NOMAP is very much arm specific so I'd keep it this way
> > for now.
> > 
> > >   NOMAP memory vs !NOMAP memory; even NOMAP is some kind of memory
> > > after all. pfn_is_map_memory() would be more expressive, although still
> > > sub-optimal.
> > > 
> > > We'd actually want some kind of arm64-specific pfn_is_system_memory() or the
> > > inverse pfn_is_device_memory() -- to be improved.
> > 
> > In my current version (to be posted soon) I've started with
> > pfn_lineary_mapped() but then ended up with pfn_mapped() to make it
> > "upward" compatible with architectures that use direct rather than linear
> > map :)
> 
> And even that is moot. It doesn't tell you if a PFN is *actually* mapped
> (hello secretmem).
> 
> I'd suggest to just use memblock_is_map_memory() in arch specific code. Then
> it's clear what we are querying exactly and what the semantics might be.

Ok, let's export memblock_is_map_memory() for the KEEP_MEMBLOCK case.

-- 
Sincerely yours,
Mike.
