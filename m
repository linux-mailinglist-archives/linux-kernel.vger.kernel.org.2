Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DCF32C465
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbhCDANi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:13:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1388709AbhCCVYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 16:24:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C11464ECF;
        Wed,  3 Mar 2021 21:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614806652;
        bh=SvDkyFYVfStCWghVCxzZppYFC8pvCQWOR+Jyt6ehiU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F3rj6IXEb6fHjyfgV6MYWIZut/FnM46xza/gLI9u5IDTdM4DgbipZtTBm2Vw7SqhZ
         HUO/gMJwfdc5mTH7EKTNt6JIVINRFXPXxNwKyGBi29zue98pxpPopeLBjU6iLBaCeG
         CtDrGTxtIS613mZkEy4X+aSWa6nx3vhSL/AXc5UcrSGJYm6bBhUMIsQWQFHblyW1vU
         Z0ECDhsExjNlMAfmNwU092WdgG5YBGxj+SFen0TMro779wZC+g5ohCkxe9vzCMShQb
         2/A3IlK2HqY38IcfVjFFO1dexbVVMpoYPyuEzUY4I2k/uFiaku7EGfuikMI5WQEPwP
         Z8WhcZ4FUZ8Ow==
Date:   Wed, 3 Mar 2021 21:24:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-mm@kvack.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        James Morse <james.morse@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
Message-ID: <20210303212406.GB20055@willie-the-truck>
References: <20210202123524.GB16868@willie-the-truck>
 <f32e7caa-3414-9dd7-eb8c-220da1d925a1@redhat.com>
 <20210202125152.GC16868@willie-the-truck>
 <4d8f5156-8628-5531-1485-322ad92aa15c@redhat.com>
 <0e649f28-4d54-319d-f876-8a93870cda7f@arm.com>
 <20210205185552.GA23216@willie-the-truck>
 <20210211115354.GB29894@willie-the-truck>
 <23e5eb93-a39c-c68e-eac1-c5ccf9036079@arm.com>
 <a54d7dcc-8603-6d3d-143f-b09c431b8e32@redhat.com>
 <20210303190428.GB24035@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303190428.GB24035@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 07:04:33PM +0000, Catalin Marinas wrote:
> On Thu, Feb 11, 2021 at 01:35:56PM +0100, David Hildenbrand wrote:
> > On 11.02.21 13:10, Anshuman Khandual wrote:
> > > On 2/11/21 5:23 PM, Will Deacon wrote:
> > > > ... and dropped. These patches appear to be responsible for a boot
> > > > regression reported by CKI:
> > > 
> > > Ahh, boot regression ? These patches only change the behaviour
> > > for non boot memory only.
> > > 
> > > > https://lore.kernel.org/r/cki.8D1CB60FEC.K6NJMEFQPV@redhat.com
> > > 
> > > Will look into the logs and see if there is something pointing to
> > > the problem.
> > 
> > It's strange. One thing I can imagine is a mis-detection of early sections.
> > However, I don't see that happening:
> > 
> > In sparse_init_nid(), we:
> > 1. Initialize the memmap
> > 2. Set SECTION_IS_EARLY | SECTION_HAS_MEM_MAP via
> >    sparse_init_one_section()
> > 
> > Only hotplugged sections (DIMMs, dax/kmem) set SECTION_HAS_MEM_MAP without
> > SECTION_IS_EARLY - which is correct, because these are not early.
> > 
> > So once we know that we have valid_section() -- SECTION_HAS_MEM_MAP is set
> > -- early_section() should be correct.
> > 
> > Even if someone would be doing a pfn_valid() after
> > memblocks_present()->memory_present() but before
> > sparse_init_nid(), we should be fine (!valid_section() -> return 0).
> 
> I couldn't figure out how this could fail with Anshuman's patches.
> Will's suspicion is that some invalid/null pointer gets dereferenced
> before being initialised but the only case I see is somewhere in
> pfn_section_valid() (ms->usage) if valid_section() && !early_section().
> 
> Assuming that we do get a valid_section(ms) && !early_section(ms), is
> there a case where ms->usage is not initialised? I guess races with
> section_deactivate() are not possible this early.
> 
> Another situation could be that pfn_valid() returns true when no memory
> is mapped for that pfn.

The case I wondered about was __pfn_to_section() with a bogus pfn, since
with patch 2/2 we call that *before* checking that pfn_to_section_nr() is
sane.

Will
