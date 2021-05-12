Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1D037B57B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 07:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhELFdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 01:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhELFdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 01:33:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EDC861370;
        Wed, 12 May 2021 05:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620797515;
        bh=TxWm1LIFrLgLEDN6G3IKv8ki7BMXodxEwq43YsP1HCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g8m/fPUZsByQlUglXc/EHxVww2QHzpdwYHP0WQ6Pwjn4PfpgBnQA52LWD1+KsGPIl
         dxWoC5o4qlbanljdgfmTcHpNi+HusqMu5OlW6ZWgL2YnL6DUJrQIKuU0K+d/xcbyfG
         Xh7JM3tVao4DQf8s7MKRLDYHlqLjcV6sTfgd11HPsMWnvHCQip3705mr9Qu6J2/DiK
         OJE1LqGTZW28lAamPRrpLM9D/Ww2gZPoZTSQzPi0/uQqUmD86Xe7qcaABVWzsyiwiC
         X1zJd+DSMOOE2z6qbGKnwfa/LfhtBr/+YPWmQ/7mn0GoJ99JrjPHJlBHalXq0USGYm
         SwPp8PBtbhJsA==
Date:   Wed, 12 May 2021 08:31:46 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 4/4] arm64: drop pfn_valid_within() and simplify
 pfn_valid()
Message-ID: <YJtoQhidtIJOhYsV@kernel.org>
References: <20210511100550.28178-1-rppt@kernel.org>
 <20210511100550.28178-5-rppt@kernel.org>
 <20210511164001.7e905659fdbb8a5e190d303a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511164001.7e905659fdbb8a5e190d303a@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 04:40:01PM -0700, Andrew Morton wrote:
> On Tue, 11 May 2021 13:05:50 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The arm64's version of pfn_valid() differs from the generic because of two
> > reasons:
> > 
> > * Parts of the memory map are freed during boot. This makes it necessary to
> >   verify that there is actual physical memory that corresponds to a pfn
> >   which is done by querying memblock.
> > 
> > * There are NOMAP memory regions. These regions are not mapped in the
> >   linear map and until the previous commit the struct pages representing
> >   these areas had default values.
> > 
> > As the consequence of absence of the special treatment of NOMAP regions in
> > the memory map it was necessary to use memblock_is_map_memory() in
> > pfn_valid() and to have pfn_valid_within() aliased to pfn_valid() so that
> > generic mm functionality would not treat a NOMAP page as a normal page.
> > 
> > Since the NOMAP regions are now marked as PageReserved(), pfn walkers and
> > the rest of core mm will treat them as unusable memory and thus
> > pfn_valid_within() is no longer required at all and can be disabled by
> > removing CONFIG_HOLES_IN_ZONE on arm64.
> > 
> > pfn_valid() can be slightly simplified by replacing
> > memblock_is_map_memory() with memblock_is_memory().
> > 
> > ...
> >
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1052,9 +1052,6 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
> >  	def_bool y
> >  	depends on NUMA
> >  
> > -config HOLES_IN_ZONE
> > -	def_bool y
> > -
> >  source "kernel/Kconfig.hz"
> >  
> >  config ARCH_SPARSEMEM_ENABLE
> 
> https://lkml.kernel.org/r/20210417075946.181402-1-wangkefeng.wang@huawei.com
> already did this, so I simply dropped that hunk? 
> And I don't think the changelog needs updating for this?

We need another hunk instead (below)

> And I don't think the changelog needs updating for this?

maybe "s/disabled by removing CONFIG_HOLES_IN_ZONE/disabled/", but does not
seem that important to me.

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3d6c7436a2fa..d7dc8698cf8e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -201,7 +201,6 @@ config ARM64
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_GENERIC_VDSO
-	select HOLES_IN_ZONE
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
