Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B2A32CF93
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbhCDJXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:23:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:43924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237443AbhCDJXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:23:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05D2A64F02;
        Thu,  4 Mar 2021 09:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614849748;
        bh=avry0IOR9EUhJ4b3KzhzYcucO6mG947RxdRJZ7zr5kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDvy8nkwPefjbYpb/xgtzMqWmoJHtdpuQvK2ZiPE1QuSssOdZ+atKE9MOEniu52pr
         E0sik1L95uCb0gjCmJ/FmAzDzZ48PE2l790hhio+TUCbCSmA0DMJn7HfDqHGT0Ydj4
         q1W75z4jGf5PLBwwiO12BY+d4syKAW2jBttFk9P0kQjwPCPNY2n+KEHJSaM9Ii4nEc
         Ez03U+uTZDQdFtBMQHPwyXrjhYOb16tmFsrVFAsM4Xl6e/PzkK1twB16pi2QKxEKjR
         QwDDnwAMeoxk8P7Crh4xF0XjgwWWnJO4z3mI2bnk34Ins4SFSVA3IJqwBk9FmXZhoN
         bNwESzX+gVbBg==
Date:   Thu, 4 Mar 2021 09:22:22 +0000
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Justin He <Justin.He@arm.com>, kvmarm@lists.cs.columbia.edu,
        James Morse <James.Morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix unaligned addr case in mmu walking
Message-ID: <20210304092222.GA20662@willie-the-truck>
References: <20210303024225.2591-1-justin.he@arm.com>
 <20210303112934.GA18452@willie-the-truck>
 <87mtvkys1y.wl-maz@kernel.org>
 <20210303211325.GA20055@willie-the-truck>
 <AM6PR08MB437695640C272E4F065A8B2DF7979@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <5bd4fa0b0590e548288b8f6dc3659ea5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd4fa0b0590e548288b8f6dc3659ea5@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 09:16:25AM +0000, Marc Zyngier wrote:
> On 2021-03-04 00:46, Justin He wrote:
> > > On Wed, Mar 03, 2021 at 07:07:37PM +0000, Marc Zyngier wrote:
> > > > From e0524b41a71e0f17d6dc8f197e421e677d584e72 Mon Sep 17 00:00:00 2001
> > > > From: Jia He <justin.he@arm.com>
> > > > Date: Wed, 3 Mar 2021 10:42:25 +0800
> > > > Subject: [PATCH] KVM: arm64: Fix range alignment when walking page tables
> > > >
> > > > When walking the page tables at a given level, and if the start
> > > > address for the range isn't aligned for that level, we propagate
> > > > the misalignment on each iteration at that level.
> > > >
> > > > This results in the walker ignoring a number of entries (depending
> > > > on the original misalignment) on each subsequent iteration.
> > > >
> > > > Properly aligning the address at the before the next iteration
> > > 
> > > "at the before the next" ???
> > > 
> > > > addresses the issue.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Reported-by: Howard Zhang <Howard.Zhang@arm.com>
> > > > Signed-off-by: Jia He <justin.he@arm.com>
> > > > Fixes: b1e57de62cfb ("KVM: arm64: Add stand-alone page-table walker
> > > infrastructure")
> > > > [maz: rewrite commit message]
> > > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > > Link: https://lore.kernel.org/r/20210303024225.2591-1-justin.he@arm.com
> > > > ---
> > > >  arch/arm64/kvm/hyp/pgtable.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > > > index 4d177ce1d536..124cd2f93020 100644
> > > > --- a/arch/arm64/kvm/hyp/pgtable.c
> > > > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > > > @@ -223,7 +223,7 @@ static inline int __kvm_pgtable_visit(struct
> > > kvm_pgtable_walk_data *data,
> > > >  		goto out;
> > > >
> > > >  	if (!table) {
> > > > -		data->addr += kvm_granule_size(level);
> > > > +		data->addr = ALIGN(data->addr, kvm_granule_size(level));
> > 
> > What if previous data->addr is already aligned with
> > kvm_granule_size(level)?
> > Hence a deadloop? Am I missing anything else?
> 
> Indeed, well spotted. I'll revert to your original suggestion
> if everybody agrees...

Heh, yeah, at least one of us is awake.
For the original patch, with the updated (including typo fix) commit
message:

Acked-by: Will Deacon <will@kernel.org>

If that still counts for anything!

Will
