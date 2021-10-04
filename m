Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E513E42151B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhJDRY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:24:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232314AbhJDRY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:24:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F62061BB5;
        Mon,  4 Oct 2021 17:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633368189;
        bh=gv8hofJ4KhhGHzowH/9QPyYT0fDWA92ram5srFO5pqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ff+6UZUVhw6AzhTTARMhvtWWi+I0K71sf/IYs23kIvu+XkK0bD5wR3MA4gaHzfdUj
         qljFu5Vw1gDvgdAmCZwLiB6XlEIH2VItEi8eaqpYzwUkAkcPJJmg9V3ynL7iTgg+Sc
         XVTOTVNBByTmDbvopYEw2m96f9lPWXVofiX299HkDe+jrDqzN4iHV5EDoaoB50CPR3
         Zrv1+y/GJ/MN/VcaPOkP2KxPlVeWu7oCFbVmCy9/15UJKhubzlbGTFQhuHS+DksOpc
         /uSlMAvxOQoHx9rV38AcMVk7kxTlFo0/fEUJp2hO0HL0h0ISnXH2FVbGX6b95+ehSG
         Z8y5j/EjQP4+w==
Date:   Mon, 4 Oct 2021 18:23:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/mm: Fix idmap on [16K|36VA|48PA]
Message-ID: <20211004172303.GA28223@willie-the-truck>
References: <1632807225-20189-1-git-send-email-anshuman.khandual@arm.com>
 <20211004104947.GA4430@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004104947.GA4430@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 11:49:58AM +0100, Mark Rutland wrote:
> Hi Anshuman,
> 
> On Tue, Sep 28, 2021 at 11:03:45AM +0530, Anshuman Khandual wrote:
> > When creating the idmap, the kernel may add one extra level to idmap memory
> > outside the VA range. But for [16K|36VA|48PA], we need two levels to reach
> > 48 bits. If the bootloader places the kernel in memory above (1 << 46), the
> > kernel will fail to enable the MMU. Although we are not aware of a platform
> > where this happens, it is worth to accommodate such scenarios and prevent a
> > possible kernel crash.
> 
> I think it's worth noting here that ARM64_VA_BITS_36 depends on EXPERT,
> so very few people are likely to be using this configuration.
> 
> > Lets fix this problem by carefully analyzing existing VA_BITS with respect
> > to maximum possible mapping with the existing PGDIR level i.e (PGDIR_SHIFT
> > + PAGE_SHIFT - 3) and then evaluating how many extra page table levels are
> > required to accommodate the reduced idmap_t0sz to map __idmap_text_end.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Fixes: 215399392fe4 ("arm64: 36 bit VA")
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > This applies on v5.15-rc3.
> > 
> > This is a different approach as compared to V1 which still applies on the
> > latest mainline. Besides this enables all upcoming FEAT_LPA2 combinations
> > as well. Please do suggest which approach would be preferred.
> > - Anshuman
> > 
> >  V1:  https://lore.kernel.org/all/1627879359-30303-1-git-send-email-anshuman.khandual@arm.com/
> > RFC: https://lore.kernel.org/lkml/1627019894-14819-1-git-send-email-anshuman.khandual@arm.com/
> 
> If we need something to backport, I'm not opposed to taking one of these
> patches (and as v1 is simpler, I'd prefer that), but I think either
> approach is further bodging around the `map_memory` macro not being a
> great fit for the idmap creation, and it would be better to rework the
> structure of the pagetable creation code to do the right thing from the
> outset.
> 
> Catalin, Will, do you have any preference as to having a backportable
> fix for this?

Given that I don't think this has ever worked (i.e. this isn't a
regression), I don't see the need to backport the fix unless somebody is
running into real problems.

Will
