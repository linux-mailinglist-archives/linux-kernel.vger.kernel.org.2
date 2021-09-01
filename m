Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE753FE4F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344756AbhIAV3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344714AbhIAV3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:29:30 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BF5C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:28:33 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id v2so707892ilg.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3+fQjcpnHNJkqOcBZgMNk/OB4ownjP+XnDHYqaehO9M=;
        b=B7N1+QDUbmAfLhhac7/CGzREYbLmaoWc2UO3Uwmy+f8N/Tf61TlXo0vB1T3IdPludk
         wssgaP7caejDQvt9MIh2u18lv5UelfS+beMnCiaRISTiUV/mDFka9UC/Z+oEXM3LmahT
         Kl3e8+8LI7SDihRD8M47czPSScJ3e7pDYvJFqmuFsaZy8vherdtKtNnBydHONNsAr93U
         H5PtAQieR0RlLOSVqno4mYeT2S/Ew9TdOTO6pXS/MIdqt2tSaBtsO/L7TQ5r8QeItLZa
         iN2aw+Ib2M8/mMMqv3UG6CyVgvLC3eFZrLDf7dNPxP/Uk5lkpr9HMp9w2dWC5MSErVgX
         p71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3+fQjcpnHNJkqOcBZgMNk/OB4ownjP+XnDHYqaehO9M=;
        b=q/Jsp9XPYmRsbUnmWe0wAdm6t+jWJ/w7B7oDeO6Z3gENcpBC7FmjkSfsXAQQlbIa5b
         1s9DrXiV7FMV9lERD9cxFuN4T1qLBOdhPYH+SO6Ath7f9c8Uxw5W/pQvWdxaxKwDeLfD
         u2XaCWQsOydUjDfAKLJZ6tSmssoLxhGWhOH+WB5NzSgWCkoDe5qI5fMLctXV2SeghZZ1
         GyXqBiyMhTec6O3HwR0GvYGABbtiBqemBvWMVTFbSescrFAGEBPHigvTGhEOoo0U+WlY
         R2mx5qGJenaA8jw+IS85xXHeGQj+RjE/4Ndfsxs/Wlx+xolcXGCy+5J9sxgBfa45c9Yd
         JMVw==
X-Gm-Message-State: AOAM5330vTZMUpiZvVt4TbKauqPiTIqm7TlRBgdPr49vAcRlF/t/qDi2
        jVFOYit1t/p2/xfJZ9evksjemA==
X-Google-Smtp-Source: ABdhPJwcjOd7yA5KEboXCvNkf3GIALGCyQJLoG6CXjyw8BUk2rI03Z+9XHa7gQw/Jp1e1Rt2HSPjcA==
X-Received: by 2002:a92:8747:: with SMTP id d7mr1084202ilm.173.1630531712121;
        Wed, 01 Sep 2021 14:28:32 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id 7sm425362ilx.16.2021.09.01.14.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 14:28:31 -0700 (PDT)
Date:   Wed, 1 Sep 2021 21:28:28 +0000
From:   Oliver Upton <oupton@google.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 02/12] KVM: arm64: selftests: Add write_sysreg_s and
 read_sysreg_s
Message-ID: <YS/wfBTnCJWn05Kn@google.com>
References: <20210901211412.4171835-1-rananta@google.com>
 <20210901211412.4171835-3-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901211412.4171835-3-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 09:14:02PM +0000, Raghavendra Rao Ananta wrote:
> For register names that are unsupported by the assembler or the ones
> without architectural names, add the macros write_sysreg_s and
> read_sysreg_s to support them.
> 
> The functionality is derived from kvm-unit-tests and kernel's
> arch/arm64/include/asm/sysreg.h.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>

Would it be possible to just include <asm/sysreg.h>? See
tools/arch/arm64/include/asm/sysreg.h

> ---
>  .../selftests/kvm/include/aarch64/processor.h | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
> index 3cbaf5c1e26b..082cc97ad8d3 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> @@ -118,6 +118,67 @@ void vm_install_exception_handler(struct kvm_vm *vm,
>  void vm_install_sync_handler(struct kvm_vm *vm,
>  		int vector, int ec, handler_fn handler);
>  
> +/*
> + * ARMv8 ARM reserves the following encoding for system registers:
> + * (Ref: ARMv8 ARM, Section: "System instruction class encoding overview",
> + *  C5.2, version:ARM DDI 0487A.f)
> + *	[20-19] : Op0
> + *	[18-16] : Op1
> + *	[15-12] : CRn
> + *	[11-8]  : CRm
> + *	[7-5]   : Op2
> + */
> +#define Op0_shift	19
> +#define Op0_mask	0x3
> +#define Op1_shift	16
> +#define Op1_mask	0x7
> +#define CRn_shift	12
> +#define CRn_mask	0xf
> +#define CRm_shift	8
> +#define CRm_mask	0xf
> +#define Op2_shift	5
> +#define Op2_mask	0x7
> +
> +/*
> + * When accessed from guests, the ARM64_SYS_REG() doesn't work since it
> + * generates a different encoding for additional KVM processing, and is
> + * only suitable for userspace to access the register via ioctls.
> + * Hence, define a 'pure' sys_reg() here to generate the encodings as per spec.
> + */
> +#define sys_reg(op0, op1, crn, crm, op2) \
> +	(((op0) << Op0_shift) | ((op1) << Op1_shift) | \
> +	 ((crn) << CRn_shift) | ((crm) << CRm_shift) | \
> +	 ((op2) << Op2_shift))
> +
> +asm(
> +"	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n"
> +"	.equ	.L__reg_num_x\\num, \\num\n"
> +"	.endr\n"
> +"	.equ	.L__reg_num_xzr, 31\n"
> +"\n"
> +"	.macro	mrs_s, rt, sreg\n"
> +"	.inst	0xd5200000|(\\sreg)|(.L__reg_num_\\rt)\n"
> +"	.endm\n"
> +"\n"
> +"	.macro	msr_s, sreg, rt\n"
> +"	.inst	0xd5000000|(\\sreg)|(.L__reg_num_\\rt)\n"
> +"	.endm\n"
> +);
> +
> +/*
> + * read_sysreg_s() and write_sysreg_s()'s 'reg' has to be encoded via sys_reg()
> + */
> +#define read_sysreg_s(reg) ({						\
> +	u64 __val;							\
> +	asm volatile("mrs_s %0, "__stringify(reg) : "=r" (__val));	\
> +	__val;								\
> +})
> +
> +#define write_sysreg_s(reg, val) do {					\
> +	u64 __val = (u64)val;						\
> +	asm volatile("msr_s "__stringify(reg) ", %x0" : : "rZ" (__val));\
> +} while (0)
> +
>  #define write_sysreg(reg, val)						  \
>  ({									  \
>  	u64 __val = (u64)(val);						  \
> -- 
> 2.33.0.153.gba50c8fa24-goog
> 
