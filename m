Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A9242A160
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhJLJvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:51:49 -0400
Received: from foss.arm.com ([217.140.110.172]:59854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232891AbhJLJvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:51:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5B6B1063;
        Tue, 12 Oct 2021 02:49:45 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.22.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 029083F694;
        Tue, 12 Oct 2021 02:49:43 -0700 (PDT)
Date:   Tue, 12 Oct 2021 10:49:36 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/mm: Fix idmap on [16K|36VA|48PA]
Message-ID: <20211012094936.GA14289@C02TD0UTHF1T.local>
References: <1632807225-20189-1-git-send-email-anshuman.khandual@arm.com>
 <20211004104947.GA4430@C02TD0UTHF1T.local>
 <fe138d79-56d3-14a4-fbb7-586d624e89df@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe138d79-56d3-14a4-fbb7-586d624e89df@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 10:19:49AM +0530, Anshuman Khandual wrote:
> On 10/4/21 4:19 PM, Mark Rutland wrote:
> > On Tue, Sep 28, 2021 at 11:03:45AM +0530, Anshuman Khandual wrote:
> > Ignoring backports, I'd prefer if we could refactor things such that we
> > decouple the `idmap_pg_dir` creation from the `init_pg_dir` creation,
> 
> Decoupling both page table creation makes sense.
> 
> > and create the idmap in terms of the architectural levels rather than
> > pgd/p4d/pud/pmd/pte, so that we can consistently create the idmap with
> > at least 48 bits of VA.
> 
> The rationale for creating the idmap table in terms of architectural
> levels, rather than kernel pgd/p4d/pud/pmd/pte is to avoid handling
> page table folding stuff and also to make it simpler ?

Yup; decoupling it from the pgd/p4d/pud/pmd/pte levels means that we can
avoid the conditional extension logic (which always has to be precisely
the inverse of the regular table creation code), and means we can always
map the idmap at page granularity regardless of whether we're using
section mappings for the init_pg_dir.

> > Pseudo-code wise, I'd like something that looks like:
> > 
> > 	create_idmap(...)
> > 	{
> > 		idmap_va_bits = 48;
> > 		idmap_t0size = TCR_T0SZ(48);
> > 
> > 		if (need_52_bit_va(__idmap_text_start)) {
> 
> s/__idmap_text_start/__idmap_text_end/ instead ?

I don't think that's necessary. The idmap is always 4K aligned, and we
force it to be no more than 4K in size, so as long as we can map the
start we can map the rest.

If the idmap were exactly 4K in size, and happend to be placed at PA
0x0000ffff_fffff000, we can map that with a 48-bit VA, but checking
__idmap_text_end would force a 52-bit VA.

That shouldn't really matter either way since the idmap is in the middle
of the .text section, but I'd prefer we just check the start address so
that we're using hte same address we'll use to create the mapping from.

> 
> > 			if (!supports_52bit_va()) {
> > 				some_early_spin_loop();
> 
> With a new CPU_STUCK_REASON_ code ?

I'm happy with reusing CPU_STUCK_REASON_52_BIT_VA, or with adding some
new CPU_STUCK_REASON_IDMAP_${whatever}.

> > 			}
> > 			idmap_va_bits = 52;
> > 			idmap_t0size = TCR_T0SZ(52);
> > 		}
> > 	
> > 		if (need_table_level(idmap_va_bits, -1))
> > 			create_table_level(-1, ...);
> > 
> > 		if (need_table_level(idmap_va_bits, 0))
> > 			create_table_level(0, ...);
> > 
> > 		if (need_table_level(idmap_va_bits, 1))
> > 			create_table_level(1, ...);
> > 
> > 		if (need_table_level(idmap_va_bits, 2))
> > 			create_table_level(2, ...);
> > 
> > 		create_table_level(3, ...);
> > 	}
> > 
> > ... which I think would be much easier to reason about consistently.
> > 
> > How does that sound to you?
> 
> This approach will be simpler and as you mentioned, easier to reason about.
> 
> > 
> > I've pushed some preparatory rework out to my arm64/pgtable/idmap
> > branch, splitting out a __create_idmap_tables() function (and ensuring
> > that idmap_t0sz doesn't get silently overridden elsewhere):
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/pgtable/idmap
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/pgtable/idmap
> > 
> > ... but I haven't had the chance to do the actual rework of the idmap
> > creation code.
> > 
> > I can send that as a series if that's helpful.
> 
> I could also just pick those changes from the above branch and complete
> the rework.

I'm happy with that if it works for you.

Thanks,
Mark.
