Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E7A30ADD7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhBAR3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:29:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhBAR3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:29:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77E5F64EA9;
        Mon,  1 Feb 2021 17:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612200520;
        bh=uHAWWNmon96KsVjmF8ftVBBdEemkthXQ9UJ2fc8srng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CvvqVRBGSncQ6Xl0DR8gjXVt3iAOTkyc7pce4aId8ICWxg6VACch4KtFpnYVLnmM0
         PE7ItfKktIRiDNqh7Doo9Xfv5rmfLLKmU179IQx5nVT06+Lw2xgisT7u5GvGOLE94r
         eYoDXigDq3eE2yjj7UO32kd7q7wtHyt2j8Am/WYH6BPNqYtIUMwk3x2d+qVOfVK1aV
         bp6HTErm/mDCVqnYV2WdLnjlin63sROqBW/Hht+GatldssqbfS8MA5N1tlWKakjzZC
         nB83x2hfJxugpY+PMHwWVg7lnc4Y6rHRzCgJ66hnF4T/7xnjvdM4CZQelCzbAER10e
         0emvH5Ijw9whA==
Date:   Mon, 1 Feb 2021 17:28:34 +0000
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
Subject: Re: [RFC PATCH v2 03/26] arm64: kvm: Add standalone ticket spinlock
 implementation for use at hyp
Message-ID: <20210201172833.GA15632@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-4-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-4-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:15:01PM +0000, Quentin Perret wrote:
> From: Will Deacon <will@kernel.org>
> 
> We will soon need to synchronise multiple CPUs in the hyp text at EL2.
> The qspinlock-based locking used by the host is overkill for this purpose
> and relies on the kernel's "percpu" implementation for the MCS nodes.
> 
> Implement a simple ticket locking scheme based heavily on the code removed
> by commit c11090474d70 ("arm64: locking: Replace ticket lock implementation
> with qspinlock").
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/spinlock.h | 92 ++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 arch/arm64/kvm/hyp/include/nvhe/spinlock.h
> 
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/spinlock.h b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
> new file mode 100644
> index 000000000000..7584c397bbac
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
> @@ -0,0 +1,92 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * A stand-alone ticket spinlock implementation for use by the non-VHE
> + * KVM hypervisor code running at EL2.
> + *
> + * Copyright (C) 2020 Google LLC
> + * Author: Will Deacon <will@kernel.org>
> + *
> + * Heavily based on the implementation removed by c11090474d70 which was:
> + * Copyright (C) 2012 ARM Ltd.
> + */
> +
> +#ifndef __ARM64_KVM_NVHE_SPINLOCK_H__
> +#define __ARM64_KVM_NVHE_SPINLOCK_H__
> +
> +#include <asm/alternative.h>
> +#include <asm/lse.h>
> +
> +typedef union hyp_spinlock {
> +	u32	__val;
> +	struct {
> +#ifdef __AARCH64EB__
> +		u16 next, owner;
> +#else
> +		u16 owner, next;
> +	};
> +#endif

Looks like I put this #endif in the wrong place; probably needs to be a line
higher.

Will
