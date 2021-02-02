Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E97430BE51
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhBBMgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:36:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231628AbhBBMgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:36:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A521E64F4E;
        Tue,  2 Feb 2021 12:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612269329;
        bh=Lcs9qQjcI3+2E+x1vXYghwukVbPSnsQqMP3TbC6xXKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dzVcaBeFdnOZb/0yfeoH1l1czXIQg2qJYtK/9bnIZ8qI1iQymFQtnaKGfsglLpFvf
         W3cwgWnsOauscsflpjeoKqoWo4k6EqXLsDVYHlhOe+pXTNw7KMRiTXTxb3YFCX99gm
         QDJma4uloSNVNzLyPJLDErq7kVMHaKGjNKD0k/hHGurksnoqIXhneV5vCoqErzy8uB
         imHHv49AA2y4C/tBMVIqSAeClXDRnPH6kkMnCmHC2QLfrmMPahhWUvVS0Sq9+TTfE3
         fLZ060DZLXadKdcsn+BWAEulXbYhGFGGhgJyStCLIqISRlCq16c4J9qQmkyYMhxHw6
         U0mVXq71oao3g==
Date:   Tue, 2 Feb 2021 12:35:24 +0000
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH V2 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
Message-ID: <20210202123524.GB16868@willie-the-truck>
References: <1612239114-28428-1-git-send-email-anshuman.khandual@arm.com>
 <1612239114-28428-2-git-send-email-anshuman.khandual@arm.com>
 <20210202123215.GA16868@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202123215.GA16868@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 12:32:15PM +0000, Will Deacon wrote:
> On Tue, Feb 02, 2021 at 09:41:53AM +0530, Anshuman Khandual wrote:
> > pfn_valid() validates a pfn but basically it checks for a valid struct page
> > backing for that pfn. It should always return positive for memory ranges
> > backed with struct page mapping. But currently pfn_valid() fails for all
> > ZONE_DEVICE based memory types even though they have struct page mapping.
> > 
> > pfn_valid() asserts that there is a memblock entry for a given pfn without
> > MEMBLOCK_NOMAP flag being set. The problem with ZONE_DEVICE based memory is
> > that they do not have memblock entries. Hence memblock_is_map_memory() will
> > invariably fail via memblock_search() for a ZONE_DEVICE based address. This
> > eventually fails pfn_valid() which is wrong. memblock_is_map_memory() needs
> > to be skipped for such memory ranges. As ZONE_DEVICE memory gets hotplugged
> > into the system via memremap_pages() called from a driver, their respective
> > memory sections will not have SECTION_IS_EARLY set.
> > 
> > Normal hotplug memory will never have MEMBLOCK_NOMAP set in their memblock
> > regions. Because the flag MEMBLOCK_NOMAP was specifically designed and set
> > for firmware reserved memory regions. memblock_is_map_memory() can just be
> > skipped as its always going to be positive and that will be an optimization
> > for the normal hotplug memory. Like ZONE_DEVICE based memory, all normal
> > hotplugged memory too will not have SECTION_IS_EARLY set for their sections
> > 
> > Skipping memblock_is_map_memory() for all non early memory sections would
> > fix pfn_valid() problem for ZONE_DEVICE based memory and also improve its
> > performance for normal hotplug memory as well.
> 
> Hmm. Although I follow your logic, this does seem to rely on an awful lot of
> assumptions to continue to hold true as the kernel evolves. In particular,
> how do we ensure that early sections are always fully backed with

Sorry, typo here:       ^^^ should be *non-early* sections.

Will
