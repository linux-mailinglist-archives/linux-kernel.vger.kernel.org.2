Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA0E3DEED7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbhHCNMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:12:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236270AbhHCNMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:12:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6330160EFD;
        Tue,  3 Aug 2021 13:12:05 +0000 (UTC)
Date:   Tue, 3 Aug 2021 14:12:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Fix idmap on [16K|36VA|48PA]
Message-ID: <20210803131201.GB5786@arm.com>
References: <1627879359-30303-1-git-send-email-anshuman.khandual@arm.com>
 <20210803103440.GA5786@arm.com>
 <7bad50a2-76f1-7946-3a15-35e46fb289c0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bad50a2-76f1-7946-3a15-35e46fb289c0@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 04:57:04PM +0530, Anshuman Khandual wrote:
> On 8/3/21 4:04 PM, Catalin Marinas wrote:
> > On Mon, Aug 02, 2021 at 10:12:39AM +0530, Anshuman Khandual wrote:
> >> +/*
> >> + * In this particular CONFIG_ARM64_16K_PAGES config, there might be a
> >> + * scenario where 'idmap_text_end' ends up high enough in the PA range
> >> + * requiring two additional idmap page table levels. Reduce idmap_t0sz
> >> + * to cover the entire PA range. This prevents table misconfiguration
> >> + * when a given idmap_t0sz value just requires single additional level
> >> + * where as two levels have been built.
> >> + */
> >> +#if defined(CONFIG_ARM64_VA_BITS_36) && defined(CONFIG_ARM64_PA_BITS_48)

I don't think you need the PA_BITS_48 check in here. It's either this
one or PA_BITS_52 in the future. Anyway, I think so far our assumption
is that the kernel will always be placed in the first 48-bit, so we
don't need extra check.

> >> +	mov	x4, EXTRA_PTRS_1
> >> +	create_table_entry x0, x3, EXTRA_SHIFT_1, x4, x5, x6
> >> +
> >> +	mov	x4, PTRS_PER_PTE
> >> +	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
> >> +
> >> +	mov	x5, #64 - PHYS_MASK_SHIFT
> >> +	adr_l	x6, idmap_t0sz
> >> +	str	x5, [x6]
> >> +	dmb	sy
> >> +	dc	ivac, x6
> >> +#else
> >>  	mov	x4, EXTRA_PTRS
> >>  	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
> >> +#endif
> >>  #else
> >>  	/*
> >>  	 * If VA_BITS == 48, we don't have to configure an additional
> > 
> > There's a prior idmap_t0sz setting based on __idmap_text_end. Isn't that
> > sufficient? We don't care about covering the whole PA space, just the
> > __idmap_text_end.
> 
> Right but its bit tricky here.
> 
> __idmap_text_end could be any where between VA_BITS (36) and PA_BITS (48)
> which would require (one or two) additional page table levels. But in this
> solution it creates two additional page table levels for idmap which would
> completely map upto PA_BITS, regardless of __idmap_text_end's position. So
> in case __idmap_text_end is between VA_BITS (36) and VA_BITS(47), a single
> additional page table level is required where as we have created two ! So
> to avoid such a situation, adjust idmap_t0sz accordingly. Otherwise there
> will be a MMU mis-configuration.

I get it now. You need 4 levels with 16K pages for idmap as 3 levels
(one extra in head.S) are not sufficient. The normal page table uses 2
levels with 36-bit VA. Here you chose to go with 4 levels always as the
simplest option.

Do we need to adjust idmap_ptrs_per_pgd? I think even without your
patch, its value is wrong as it doesn't seem to be adjusted for the
extra level. I can't figure out whether it matter but I think we should
remove this variable altogether and just set the x4 register to what we
need in head.S

> This patch is indented for stable back port and hence tries to be as simple
> and minimal as possible. So it creates two additional page table levels
> mapping upto PA_BITS without just considering __idmap_text_end's position.
> Reducing __idmap_t0sz upto PA_BITS should not be a problem irrespective of
> ID_AA64MMFR0_EL1.PARANGE value. As __idmap_text_end would never be on a PA
> which is not supported. Hence out of range PA would never be on the bus for
> translation.

I'd rather have a clean solution (might as well be this one) than
worrying about a stable back-port. It's highly unlikely that we'll trip
over this problem in practice: first you'd need RAM above 47-bit and
second you'd have to enable EXPERT and 36-bit VA.

It looks like idmap_t0sz is used by the kvm_mmu_init() code to calculate
hyp_va_bits. Does it mean that idmap_t0sz should always match PA_SIZE?
Or maybe we should just decouple the two.

-- 
Catalin
