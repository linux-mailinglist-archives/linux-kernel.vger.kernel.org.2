Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9EC39A631
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 18:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhFCQt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 12:49:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhFCQt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 12:49:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B2D161026;
        Thu,  3 Jun 2021 16:48:08 +0000 (UTC)
Date:   Thu, 3 Jun 2021 17:48:06 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v13 5/8] KVM: arm64: Save/restore MTE registers
Message-ID: <20210603164805.GF20338@arm.com>
References: <20210524104513.13258-1-steven.price@arm.com>
 <20210524104513.13258-6-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524104513.13258-6-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 11:45:10AM +0100, Steven Price wrote:
> diff --git a/arch/arm64/include/asm/kvm_mte.h b/arch/arm64/include/asm/kvm_mte.h
> new file mode 100644
> index 000000000000..eae4bce9e269
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_mte.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020 ARM Ltd.

You may want to update some of the years.

> + */
> +#ifndef __ASM_KVM_MTE_H
> +#define __ASM_KVM_MTE_H
> +
> +#ifdef __ASSEMBLY__
> +
> +#include <asm/sysreg.h>
> +
> +#ifdef CONFIG_ARM64_MTE
> +
> +.macro mte_switch_to_guest g_ctxt, h_ctxt, reg1
> +alternative_if_not ARM64_MTE
> +	b	.L__skip_switch\@
> +alternative_else_nop_endif
> +	mrs	\reg1, hcr_el2
> +	and	\reg1, \reg1, #(HCR_ATA)
> +	cbz	\reg1, .L__skip_switch\@

Nitpick: TBZ would be shorter, though you need the bit number.

The patch looks fine (as per my understanding of the KVM context
switching code):

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
