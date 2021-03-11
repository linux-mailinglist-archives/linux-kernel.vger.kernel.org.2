Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD82F33792B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbhCKQVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:21:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234455AbhCKQVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:21:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 753FC6146B;
        Thu, 11 Mar 2021 16:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615479681;
        bh=T+Bt7gZGUjrxDrEQ2211vo0Svgs66BNqHKZT8ttELhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=msyy8vEG3L5NnRfp90UsA3PFVsDk+faHyWPzudfFi2aM/2Lvau5b/GnFNFcjIXYZ4
         /FPfplr6+dJ+Ygyxek9GF75aVSIKUAhjFY2DwV7sWVm97x5FwS8KoEB8jv0f+eOe5r
         D+CB5H+c+4unbcsz4kmfZUKT6e4dOQsekhttSnJwJ+Gu+i2j6CiZKKViTJq3oSyeGj
         9AHJddEqOypI8jb3iT3JG8m/gWS/Dj0XdFiyEnFY3k24jWWUF64Kk2DzTpcsNKGuQO
         DVxwDWaJDzz/tETwYwz9YuW6E9q1MifTBV3A3QBKQr83A1938NCDySQy65h8ppgjBl
         2vXAIC0pBrEsg==
Date:   Thu, 11 Mar 2021 16:21:13 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 16/34] KVM: arm64: Prepare the creation of s1 mappings
 at EL2
Message-ID: <20210311162112.GD31206@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-17-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310175751.3320106-17-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:57:33PM +0000, Quentin Perret wrote:
> When memory protection is enabled, the EL2 code needs the ability to
> create and manage its own page-table. To do so, introduce a new set of
> hypercalls to bootstrap a memory management system at EL2.
> 
> This leads to the following boot flow in nVHE Protected mode:
> 
>  1. the host allocates memory for the hypervisor very early on, using
>     the memblock API;
> 
>  2. the host creates a set of stage 1 page-table for EL2, installs the
>     EL2 vectors, and issues the __pkvm_init hypercall;
> 
>  3. during __pkvm_init, the hypervisor re-creates its stage 1 page-table
>     and stores it in the memory pool provided by the host;
> 
>  4. the hypervisor then extends its stage 1 mappings to include a
>     vmemmap in the EL2 VA space, hence allowing to use the buddy
>     allocator introduced in a previous patch;
> 
>  5. the hypervisor jumps back in the idmap page, switches from the
>     host-provided page-table to the new one, and wraps up its
>     initialization by enabling the new allocator, before returning to
>     the host.
> 
>  6. the host can free the now unused page-table created for EL2, and
>     will now need to issue hypercalls to make changes to the EL2 stage 1
>     mappings instead of modifying them directly.
> 
> Note that for the sake of simplifying the review, this patch focuses on
> the hypervisor side of things. In other words, this only implements the
> new hypercalls, but does not make use of them from the host yet. The
> host-side changes will follow in a subsequent patch.
> 
> Credits to Will for __pkvm_init_switch_pgd.
> 
> Co-authored-by: Will Deacon <will@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h     |   4 +
>  arch/arm64/include/asm/kvm_host.h    |   7 +
>  arch/arm64/include/asm/kvm_hyp.h     |   8 ++
>  arch/arm64/include/asm/kvm_pgtable.h |   2 +
>  arch/arm64/kernel/image-vars.h       |  16 +++
>  arch/arm64/kvm/hyp/Makefile          |   2 +-
>  arch/arm64/kvm/hyp/include/nvhe/mm.h |  71 ++++++++++
>  arch/arm64/kvm/hyp/nvhe/Makefile     |   4 +-
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S   |  27 ++++
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c   |  49 +++++++
>  arch/arm64/kvm/hyp/nvhe/mm.c         | 173 +++++++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/setup.c      | 197 +++++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/pgtable.c         |   2 -
>  arch/arm64/kvm/hyp/reserved_mem.c    |  92 +++++++++++++
>  arch/arm64/mm/init.c                 |   3 +
>  15 files changed, 652 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm64/kvm/hyp/include/nvhe/mm.h
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/mm.c
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/setup.c
>  create mode 100644 arch/arm64/kvm/hyp/reserved_mem.c

Acked-by: Will Deacon <will@kernel.org>

Will
