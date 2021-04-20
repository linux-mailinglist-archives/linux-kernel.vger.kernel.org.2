Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27B636595F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 14:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhDTM6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 08:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231718AbhDTM6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 08:58:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89A4A613C3;
        Tue, 20 Apr 2021 12:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618923481;
        bh=pj7iH5/7ryvKV0103e/WzDqoTVMCnCeOsU1aueXSSWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AELGbPakwwA189udgGAWTMEERvHJSzMiJJ6zXc+pUHeHypJdz0V2fLe+BD1bzM3Nx
         u9j/1K2l5BkbehD9ogeiYm7EMiRtZo3pybYvM6cZGY5LcQAnHIi9VRZ7v8vxG+stQK
         GZ2TdxDIffeM0R+97tZrgAqWdhdoTu45VU5HxgOq9PfOoGh0glAUuurDI2Bad4nDOo
         KZECeDYreSNaGkVAIyk8uMOKfQSmqol2Tr19JuTT7Jw0eQB08RumVkZeFP3Qz2yLts
         SHCbpptQUT2ALWZS3QX0qSFE7JldhhO5+xK9SIm7k9tZyQCR2vjrXrovnnIkVMTz5M
         Ap+IrrXFwGzUw==
Date:   Tue, 20 Apr 2021 15:57:52 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/4] include/linux/mmzone.h: add documentation for
 pfn_valid()
Message-ID: <YH7P0J4+1erJK7v5@kernel.org>
References: <20210420090925.7457-1-rppt@kernel.org>
 <20210420090925.7457-2-rppt@kernel.org>
 <f900f889-f059-7d48-dfc7-145c8cd54cf6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f900f889-f059-7d48-dfc7-145c8cd54cf6@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 11:22:53AM +0200, David Hildenbrand wrote:
> On 20.04.21 11:09, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Add comment describing the semantics of pfn_valid() that clarifies that
> > pfn_valid() only checks for availability of a memory map entry (i.e. struct
> > page) for a PFN rather than availability of usable memory backing that PFN.
> > 
> > The most "generic" version of pfn_valid() used by the configurations with
> > SPARSEMEM enabled resides in include/linux/mmzone.h so this is the most
> > suitable place for documentation about semantics of pfn_valid().
> > 
> > Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >   include/linux/mmzone.h | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 47946cec7584..961f0eeefb62 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1410,6 +1410,17 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
> >   #endif
> >   #ifndef CONFIG_HAVE_ARCH_PFN_VALID
> > +/**
> > + * pfn_valid - check if there is a valid memory map entry for a PFN
> > + * @pfn: the page frame number to check
> > + *
> > + * Check if there is a valid memory map entry aka struct page for the @pfn.
> > + * Note, that availability of the memory map entry does not imply that
> > + * there is actual usable memory at that @pfn. The struct page may
> > + * represent a hole or an unusable page frame.
> > + *
> > + * Return: 1 for PFNs that have memory map entries and 0 otherwise
> > + */
> >   static inline int pfn_valid(unsigned long pfn)
> >   {
> >   	struct mem_section *ms;
> > 
> 
> I'd rephrase all "there is a valid memory map" to "there is a memory map"
> and add "pfn_valid() does to indicate whether the memory map as actually
> initialized -- see pfn_to_online_page()."
> 
> pfn_valid() means that we can do a pfn_to_page() and don't get a fault when
> accessing the "struct page". It doesn't state anything about the content.

Well, I mean valid in the sense you can access the struct page :)
How about:

/**
 * pfn_valid - check if there is a memory map entry for a PFN
 * @pfn: the page frame number to check
 *
 * Check if there is a memory map entry aka struct page for the @pfn and it
 * is safe to access that struct page; the struct page state may be
 * uninitialized -- see pfn_to_online_page().
 *
 * Note, that availability of the memory map entry does not imply that
 * there is actual usable memory at that @pfn. The struct page may
 * represent a hole or an unusable page frame.
 *
 * Return: 1 for PFNs that have memory map entries and 0 otherwise.
 */

-- 
Sincerely yours,
Mike.
