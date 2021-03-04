Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2382C32CFCD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbhCDJhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:37:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237673AbhCDJgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:36:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9676B64E12;
        Thu,  4 Mar 2021 09:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614850566;
        bh=aUCwW3jj37gsE9LUMM14Xw5xP93gdtuyBLN6zPMfMhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRepQvopve0BRwMP1x0C8iSKW1H3/57DIBbhqrqh8O6Yh2VhF3EIIGy5P6MoLORc6
         HYrFJ2FZPRuna/PJDx8dwZavn6/33Ud3C6Z7mQZ44s7nFVDWFgPrqi097ZEBDPWmTF
         ewjajTGONIJ9ZwiZHAXyDBJZEF94QrDV/CQHoA2OfYaxMQIbZ3WSiCfb/Ujd0OOX7A
         qHX1H9fnoxxJVYElKDpmbc2XNYCcyFgpWwpn+le4YyRGswifTQLMRb7l+bsIGo9XmK
         STTelBNSkpDfR2xRTGb3Zhmu2ER9vfmbzD38xRf9sD5exd4HLgz2aoZ9HYaU0JzI+l
         Fe1dvlQJd8dYQ==
Date:   Thu, 4 Mar 2021 09:36:00 +0000
From:   Will Deacon <will@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-mm@kvack.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        James Morse <james.morse@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, vkabatov@redhat.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
Message-ID: <20210304093559.GB20721@willie-the-truck>
References: <4d8f5156-8628-5531-1485-322ad92aa15c@redhat.com>
 <0e649f28-4d54-319d-f876-8a93870cda7f@arm.com>
 <20210205185552.GA23216@willie-the-truck>
 <20210211115354.GB29894@willie-the-truck>
 <23e5eb93-a39c-c68e-eac1-c5ccf9036079@arm.com>
 <a54d7dcc-8603-6d3d-143f-b09c431b8e32@redhat.com>
 <20210303190428.GB24035@arm.com>
 <20210303212406.GB20055@willie-the-truck>
 <b8dfa24d-e287-0039-ea6d-f644f52f4dbf@arm.com>
 <9872a864-15b1-12a7-6aac-0e68554bc744@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9872a864-15b1-12a7-6aac-0e68554bc744@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 09:12:31AM +0100, David Hildenbrand wrote:
> On 04.03.21 04:31, Anshuman Khandual wrote:
> > On 3/4/21 2:54 AM, Will Deacon wrote:
> > > On Wed, Mar 03, 2021 at 07:04:33PM +0000, Catalin Marinas wrote:
> > > > On Thu, Feb 11, 2021 at 01:35:56PM +0100, David Hildenbrand wrote:
> > > > > On 11.02.21 13:10, Anshuman Khandual wrote:
> > > > > > On 2/11/21 5:23 PM, Will Deacon wrote:
> > > > > > > ... and dropped. These patches appear to be responsible for a boot
> > > > > > > regression reported by CKI:
> > > > > > 
> > > > > > Ahh, boot regression ? These patches only change the behaviour
> > > > > > for non boot memory only.
> > > > > > 
> > > > > > > https://lore.kernel.org/r/cki.8D1CB60FEC.K6NJMEFQPV@redhat.com
> > > > > > 
> > > > > > Will look into the logs and see if there is something pointing to
> > > > > > the problem.
> > > > > 
> > > > > It's strange. One thing I can imagine is a mis-detection of early sections.
> > > > > However, I don't see that happening:
> > > > > 
> > > > > In sparse_init_nid(), we:
> > > > > 1. Initialize the memmap
> > > > > 2. Set SECTION_IS_EARLY | SECTION_HAS_MEM_MAP via
> > > > >     sparse_init_one_section()
> > > > > 
> > > > > Only hotplugged sections (DIMMs, dax/kmem) set SECTION_HAS_MEM_MAP without
> > > > > SECTION_IS_EARLY - which is correct, because these are not early.
> > > > > 
> > > > > So once we know that we have valid_section() -- SECTION_HAS_MEM_MAP is set
> > > > > -- early_section() should be correct.
> > > > > 
> > > > > Even if someone would be doing a pfn_valid() after
> > > > > memblocks_present()->memory_present() but before
> > > > > sparse_init_nid(), we should be fine (!valid_section() -> return 0).
> > > > 
> > > > I couldn't figure out how this could fail with Anshuman's patches.
> > > > Will's suspicion is that some invalid/null pointer gets dereferenced
> > > > before being initialised but the only case I see is somewhere in
> > > > pfn_section_valid() (ms->usage) if valid_section() && !early_section().
> > > > 
> > > > Assuming that we do get a valid_section(ms) && !early_section(ms), is
> > > > there a case where ms->usage is not initialised? I guess races with
> > > > section_deactivate() are not possible this early.
> > > > 
> > > > Another situation could be that pfn_valid() returns true when no memory
> > > > is mapped for that pfn.
> > > 
> > > The case I wondered about was __pfn_to_section() with a bogus pfn, since
> > > with patch 2/2 we call that *before* checking that pfn_to_section_nr() is
> > > sane.
> > 
> > Right, that is problematic. __pfn_to_section() should not be called without
> > first validating pfn_to_section_nr(), as it could cause out-of-bound access
> > on mem_section buffer. Will fix that order but as there is no test scenario
> > which is definitive for this reported regression, how should we ensure that
> > it fixes the problem ?
> 
> Oh, right, I missed that in patch #2. (and when comparing to generic
> pfn_valid()).
> 
> I thought bisecting pointed at patch #1, that's why I didn't even have
> another look at patch #2. Makes sense.

I don't think we ever bisected it beyond these two patches, so it could
be either of them. Anshuman -- please work with Veronika on this, as she
has access to the problematic machine and was really helpful in debugging
this last time.

Will
