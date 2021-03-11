Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A07337D56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 20:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhCKTKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 14:10:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhCKTJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:09:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93B0E64E60;
        Thu, 11 Mar 2021 19:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615489766;
        bh=tjRqrEnr46TNCZjccx2NGAuGGxIXCeGJ/0pAUdHa0PI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TEL/EMvYZ0+zWrD5EIuzTfjrSYY7hC23Y2j+Z8/RVD2RPw5nW9nlL9OVPhdujco5H
         IxG1S4eYeByD+3RC4CtWTm2v9bPW3Wp6RTwwEhrAiNVg9ByP/3LKt8qv9TQ5TVf6Rn
         168ARlFFeWq63rb7WsPBEmDpUngQIhcuvG3mb/Z3ZznNYhYt5+gDPEnWHMJqgnNnU6
         DbcYWMOsemicENDMIBBoIaq6WYPEw+CKiBbYO2yOeJZ7nzkg3ohIzcM+MwF6wA2NPY
         Cwys5Ma+XGmLRC4S6IjWhKdvD0b1cOPkjRYIdkkA/ct10QYWQmLHVz/w6VMUFp/FOf
         87T98ajA+CTHg==
Date:   Thu, 11 Mar 2021 19:09:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 31/34] KVM: arm64: Wrap the host with a stage 2
Message-ID: <20210311190919.GC31586@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-32-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310175751.3320106-32-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:57:48PM +0000, Quentin Perret wrote:
> When KVM runs in protected nVHE mode, make use of a stage 2 page-table
> to give the hypervisor some control over the host memory accesses. The
> host stage 2 is created lazily using large block mappings if possible,
> and will default to page mappings in absence of a better solution.
> 
> From this point on, memory accesses from the host to protected memory
> regions (e.g. marked PROT_NONE) are fatal and lead to hyp_panic().
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h              |   1 +
>  arch/arm64/include/asm/kvm_cpufeature.h       |   2 +
>  arch/arm64/kernel/image-vars.h                |   3 +
>  arch/arm64/kvm/arm.c                          |  10 +
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  34 +++
>  arch/arm64/kvm/hyp/nvhe/Makefile              |   2 +-
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S            |   1 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  11 +
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 246 ++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/setup.c               |   5 +
>  arch/arm64/kvm/hyp/nvhe/switch.c              |   7 +-
>  arch/arm64/kvm/hyp/nvhe/tlb.c                 |   4 +-
>  12 files changed, 319 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/mem_protect.c

I like this a lot more now, thanks:

Acked-by: Will Deacon <will@kernel.org>

Will
