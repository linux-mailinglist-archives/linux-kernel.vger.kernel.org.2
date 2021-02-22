Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E753217CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 13:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhBVM7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 07:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231263AbhBVM0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 07:26:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 772AB64E2F;
        Mon, 22 Feb 2021 12:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613996751;
        bh=F61yD7TfzwZTNpXdixKLax2iqMRPofRipBni27VX2xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SAl1T7KZJQQwmBaF9he+BHXzMUkMmuxBth+/0xxzpsa6fqv5Oqis3kFS/MtYzCguy
         ATqJ/v6/dT1POnWGmADkz8WaOI+GwO8I4FMLp6eesSzsBRAfXXgNlB3+tLIStB9WZ4
         zBm+XwHVcygvLkB9feyhjgTBUP37E07KQG4Rq24EPDZboITntvu0XhiS9EhUnJyw6G
         XNkLQz14KNRFQmd4qbeR21szj/IZGbMceiFqH3CZscpl2UBYO86E8kWyDhaHFxtw0W
         5vtcegPw5+YMFPEuMJBSCq7+MR2y4WhdulKtm45bkEj5G9rr6dAj9DbiKPbRQekucp
         Fs1H68Bt2620w==
Date:   Mon, 22 Feb 2021 12:25:46 +0000
From:   Will Deacon <will@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v3 1/1] arm64: mm: correct the inside linear map range
 during hotplug check
Message-ID: <20210222122545.GA8847@willie-the-truck>
References: <20210216150351.129018-1-pasha.tatashin@soleen.com>
 <20210216150351.129018-2-pasha.tatashin@soleen.com>
 <20210219191807.GB6683@willie-the-truck>
 <CA+CK2bB13G4wTm6P_hdkwi2cbu=774GnpwBV7giy77-fEHDKow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bB13G4wTm6P_hdkwi2cbu=774GnpwBV7giy77-fEHDKow@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 02:44:49PM -0500, Pavel Tatashin wrote:
> On Fri, Feb 19, 2021 at 2:18 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Feb 16, 2021 at 10:03:51AM -0500, Pavel Tatashin wrote:
> > > Memory hotplug may fail on systems with CONFIG_RANDOMIZE_BASE because the
> > > linear map range is not checked correctly.
> > >
> > > The start physical address that linear map covers can be actually at the
> > > end of the range because of randomization. Check that and if so reduce it
> > > to 0.
> > >
> > > This can be verified on QEMU with setting kaslr-seed to ~0ul:
> > >
> > > memstart_offset_seed = 0xffff
> > > START: __pa(_PAGE_OFFSET(vabits_actual)) = ffff9000c0000000
> > > END:   __pa(PAGE_END - 1) =  1000bfffffff
> > >
> > > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > > Fixes: 58284a901b42 ("arm64/mm: Validate hotplug range before creating linear mapping")
> > > Tested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > ---
> > >  arch/arm64/mm/mmu.c | 21 +++++++++++++++++++--
> > >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > I tried to queue this as a fix, but unfortunately it doesn't apply.
> > Please can you send a v4 based on the arm64 for-next/fixes branch?
> 
> The previous version, that is not built against linux-next would still
> applies against current mainlein/for-next/fixes
> 
> https://lore.kernel.org/lkml/20210215192237.362706-2-pasha.tatashin@soleen.com/
> 
> I just tried it. I think it would make sense to take v2 fix, so it
> could also be backported to stables.

Taking that won't help either though, because it will just explode when
it meets 'mm' in Linus's tree.

So here's what I think we need to do:

  - I'll apply your v3 at -rc1
  - You can send backports based on your -v2 for stable once the v3 has
    been merged upstream.

Sound good?

Will
