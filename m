Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB83130BCC4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhBBLQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:16:06 -0500
Received: from foss.arm.com ([217.140.110.172]:47904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhBBLQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:16:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 893511396;
        Tue,  2 Feb 2021 03:15:16 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.49.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCA623F7D7;
        Tue,  2 Feb 2021 03:15:14 -0800 (PST)
Date:   Tue, 2 Feb 2021 11:15:12 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org
Subject: Re: [RFC PATCH 3/5] arm64: aarch64-insn: Add barrier encodings
Message-ID: <20210202111512.GC59049@C02TD0UTHF1T.local>
References: <20210120171745.1657762-1-jthierry@redhat.com>
 <20210120171745.1657762-4-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120171745.1657762-4-jthierry@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 06:17:43PM +0100, Julien Thierry wrote:
> Create necessary functions to encode/decode aarch64 data/instruction
> barriers.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>  arch/arm64/include/asm/aarch64-insn.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/aarch64-insn.h b/arch/arm64/include/asm/aarch64-insn.h
> index 200bee726172..d0fee47bbe6e 100644
> --- a/arch/arm64/include/asm/aarch64-insn.h
> +++ b/arch/arm64/include/asm/aarch64-insn.h
> @@ -379,6 +379,9 @@ __AARCH64_INSN_FUNCS(eret_auth,	0xFFFFFBFF, 0xD69F0BFF)
>  __AARCH64_INSN_FUNCS(mrs,	0xFFF00000, 0xD5300000)
>  __AARCH64_INSN_FUNCS(msr_imm,	0xFFF8F01F, 0xD500401F)
>  __AARCH64_INSN_FUNCS(msr_reg,	0xFFF00000, 0xD5100000)
> +__AARCH64_INSN_FUNCS(dmb,	0xFFFFF0FF, 0xD50330BF)
> +__AARCH64_INSN_FUNCS(dsb,	0xFFFFF0FF, 0xD503309F)
> +__AARCH64_INSN_FUNCS(isb,	0xFFFFF0FF, 0xD50330DF)

These match the encodings in ARM DDI 0487G.a, with a couple of caveats
for DSB.

Per section C6.2.82 on page C6-1000, when CRm != 0x00, the instruction
isn't considered a DSB. I believe per the "barriers" decode table on
page C4-289 that here "0x00" is actually a binary string and 'x' is a
"don't care" -- I've raised a ticket to get the documentation clarified.
I suspect we need to write a function to handle that.

There's also a secondary encoding for DSB with FEAT_XS, which we don't
currently use but might want to add.

>  #undef	__AARCH64_INSN_FUNCS
>  
> @@ -390,6 +393,12 @@ static inline bool aarch64_insn_is_adr_adrp(u32 insn)
>  	return aarch64_insn_is_adr(insn) || aarch64_insn_is_adrp(insn);
>  }
>  
> +static inline bool aarch64_insn_is_barrier(u32 insn)
> +{
> +	return aarch64_insn_is_dmb(insn) || aarch64_insn_is_dsb(insn) ||
> +	       aarch64_insn_is_isb(insn);
> +}

I assume this is meant to match the barriers instruction class, as per
the table on page C4-289? That also contains CLREX, SB, SSBB, and PSSBB,
and it might be worth adding them at the same time.

Thanks,
Mark.

>  enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
>  bool aarch64_insn_uses_literal(u32 insn);
>  bool aarch64_insn_is_branch(u32 insn);
> -- 
> 2.25.4
> 
