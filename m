Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEC33378F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhCKQPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:15:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234431AbhCKQOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:14:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFD5464F88;
        Thu, 11 Mar 2021 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615479288;
        bh=qYDGWCW64bxyZudXVN5dkVQ3DwMt7Dn8FEVKXvpunG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8MnI3+2/a4u7kdasK8yp0GaOhcv8jnkA0X0v12U8iXfzM0yXF00qlOJQJ8BLfxR5
         SnPL1CygmdEkO3n6m167qfRXk7n9zJx/PGswMJN3JnCgolPkglroyEnbPjel4Fq5LP
         1yHs7VglYuyH6+Eh34R9mwABULkfgq9200BQns63jNQjRiJATlopDnbhkoPGNlq66y
         ruNVpmIy/icGq9PgJjCT8YCHy4irUwrh0eyvmpmb0QZt7fz/XlOMiRbrRVgbCud2js
         0MrnSAz1IeSLEuIJbhrD54+im2PZkuBoIndFzApzln30phdH25lNkXlpxqIENZCiCV
         D+iGWJPBqZCCQ==
Date:   Thu, 11 Mar 2021 16:14:42 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 12/34] KVM: arm64: Introduce a Hyp buddy page allocator
Message-ID: <20210311161441.GC31206@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-13-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310175751.3320106-13-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:57:29PM +0000, Quentin Perret wrote:
> When memory protection is enabled, the hyp code will require a basic
> form of memory management in order to allocate and free memory pages at
> EL2. This is needed for various use-cases, including the creation of hyp
> mappings or the allocation of stage 2 page tables.
> 
> To address these use-case, introduce a simple memory allocator in the
> hyp code. The allocator is designed as a conventional 'buddy allocator',
> working with a page granularity. It allows to allocate and free
> physically contiguous pages from memory 'pools', with a guaranteed order
> alignment in the PA space. Each page in a memory pool is associated
> with a struct hyp_page which holds the page's metadata, including its
> refcount, as well as its current order, hence mimicking the kernel's
> buddy system in the GFP infrastructure. The hyp_page metadata are made
> accessible through a hyp_vmemmap, following the concept of
> SPARSE_VMEMMAP in the kernel.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/gfp.h    |  68 ++++++++
>  arch/arm64/kvm/hyp/include/nvhe/memory.h |  28 ++++
>  arch/arm64/kvm/hyp/nvhe/Makefile         |   2 +-
>  arch/arm64/kvm/hyp/nvhe/page_alloc.c     | 195 +++++++++++++++++++++++
>  4 files changed, 292 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kvm/hyp/include/nvhe/gfp.h
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/page_alloc.c

Eventually, we can replace the refcount with refcount_t, but for now this
looks pretty good:

Acked-by: Will Deacon <will@kernel.org>

Will
