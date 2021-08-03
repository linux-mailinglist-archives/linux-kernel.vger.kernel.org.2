Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F40F3DE937
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 11:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbhHCJGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 05:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234539AbhHCJGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:06:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDF6860EFD;
        Tue,  3 Aug 2021 09:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627981590;
        bh=FKrle88Edu62He8b5s6Ecrt4orNlwkVNmGaf7qpl304=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAlyIcFTaL2xanSx++DRnjzDz7odoAlHq5Ekq3mkn/p+DWCIQBF8PIKLiAIur91K6
         YBK9qqTE31EcynINDNMTdRR87ZU3Bc7GHDkuIzb1N+Z8dWAni+JvxOWBBvu5AyP7EY
         0KKcjyZGbc9vOkzjaZ8vxXWAGGvQD569BfxSUWozQ4AwSYt6o5F4MAB3iLVgL8NkUB
         HWA7CgTBOKpyyaIaZuu/vsQX+72e/35zNhFKnt4vFf4HJ92o3yEMwgOKkastZFCvUp
         3IFGW8qiHcGTWOk01Mg1kC9mXPQh1NArPVmN9WXtqL+XDON82Cia72xAspIuUW2LDK
         nO2po+GnB0trg==
Date:   Tue, 3 Aug 2021 10:06:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: move the (z)install rules to arch/arm64/Makefile
Message-ID: <20210803090626.GA30265@willie-the-truck>
References: <20210729140527.443116-1-masahiroy@kernel.org>
 <20210802124624.GG18685@arm.com>
 <CAK7LNARFWRgGsea03mZJfSPjyxYLxz3g6fjTs9aon9hxYvsxcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARFWRgGsea03mZJfSPjyxYLxz3g6fjTs9aon9hxYvsxcw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 02:40:44PM +0900, Masahiro Yamada wrote:
> On Mon, Aug 2, 2021 at 9:46 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > On Thu, Jul 29, 2021 at 11:05:27PM +0900, Masahiro Yamada wrote:
> > > Currently, the (z)install targets in arch/arm64/Makefile descend into
> > > arch/arm64/boot/Makefile to invoke the shell script, but there is no
> > > good reason to do so.
> > >
> > > arch/arm64/Makefile can run the shell script directly.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  arch/arm64/Makefile      | 7 +++++--
> > >  arch/arm64/boot/Makefile | 8 --------
> > >  2 files changed, 5 insertions(+), 10 deletions(-)
> >
> > Is this part of some cross-arch clean-up? I can see x86 for example does
> > the same thing.
> >
> > Thanks.
> >
> 
> Yes. I want to do these cleanups tree-wide, but
> I sent patches per arch.
> 
> Please pick it up to your arm64 tree
> if you do not mind.

Just to confirm -- this would be for 5.15, right?

Will
