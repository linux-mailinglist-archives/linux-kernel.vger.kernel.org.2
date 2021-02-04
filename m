Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5667530F52D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbhBDOkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236808AbhBDOhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:37:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7490864F5E;
        Thu,  4 Feb 2021 14:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612449385;
        bh=q+Q5OcQ6akzkt/aKtlVLcbW3FULf1J4eGOwrszsVCug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rTmic4TMup6IFFAFKWQx3xr963WJyxq5iq7OlxQrCxnv+5bTzGvamdKhsPYWYiAel
         Q1+7Gz821B0byhtUOHN+nyWHIHJdvJVh6hgjatpUO3UWjbwV+vzppDXMNokGZDJaq6
         OGiBFaBMHIjRKRQPKbks6XQQpvM86D+PpgnmeKddLybIn5TYJDK3qYLPouOt9iSYBN
         ZPJt0EsmandHOY1E4gWEPJJTQIqCfDK/gxBfBpt6vx+bWwTOKNkLd6jBWA8pWutj/2
         SKHhmaVDyEQaaKBdiwI3vkRVxAMyZOeeAgETPxMweukOqAFYQzYwMU8Xcdq0Wjk1vi
         2fs8AS0XL5X0w==
Date:   Thu, 4 Feb 2021 14:36:19 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 24/26] KVM: arm64: Make memcache anonymous in
 pgtable allocator
Message-ID: <20210204143618.GA20815@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-25-qperret@google.com>
 <20210203155944.GH18974@willie-the-truck>
 <YBwDrBH8p0aEpKKC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBwDrBH8p0aEpKKC@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 02:24:44PM +0000, Quentin Perret wrote:
> On Wednesday 03 Feb 2021 at 15:59:44 (+0000), Will Deacon wrote:
> > On Fri, Jan 08, 2021 at 12:15:22PM +0000, Quentin Perret wrote:
> > > The current stage2 page-table allocator uses a memcache to get
> > > pre-allocated pages when it needs any. To allow re-using this code at
> > > EL2 which uses a concept of memory pools, make the memcache argument to
> > > kvm_pgtable_stage2_map() anonymous. and let the mm_ops zalloc_page()
> > > callbacks use it the way they need to.
> > > 
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> > > ---
> > >  arch/arm64/include/asm/kvm_pgtable.h | 6 +++---
> > >  arch/arm64/kvm/hyp/pgtable.c         | 4 ++--
> > >  2 files changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > > index 8e8f1d2c5e0e..d846bc3d3b77 100644
> > > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > > @@ -176,8 +176,8 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt);
> > >   * @size:	Size of the mapping.
> > >   * @phys:	Physical address of the memory to map.
> > >   * @prot:	Permissions and attributes for the mapping.
> > > - * @mc:		Cache of pre-allocated GFP_PGTABLE_USER memory from which to
> > > - *		allocate page-table pages.
> > > + * @mc:		Cache of pre-allocated memory from which to allocate page-table
> > > + *		pages.
> > 
> > We should probably mention that this memory must be zeroed, since I don't
> > think the page-table code takes care of that.
> 
> OK, though I think this is unrelated to this change -- this is already
> true today I believe. Anyhow, I'll pile a change on top.

It is, but GFP_PGTABLE_USER implies __GFP_ZERO, so the existing comment
captures that.

Will
