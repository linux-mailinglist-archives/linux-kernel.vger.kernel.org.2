Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8854237A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 07:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhJFF4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 01:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229621AbhJFFz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 01:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633499647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o4AZ2v0d2upoVgn5yMh1nIi8K7ql02Ob+W4jg2mRZPo=;
        b=Q7G5LN3X4R4b83DsKo/cShZWcStW6Ph+ptEupbfiumV+wQzqGDq8cCoTBHxdTMO6pHSWhS
        R+928jPR/sHfshcQh04oeeb0pZYPgzELTAS/y1haWbJuojRGGeWk3Rr89I+XWXdcbZMZmm
        DJXNrq44A7T2Yvx/+RxYN/OaxodCJ1c=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-ev8l8bhXOTSbLw1-MIL4Xg-1; Wed, 06 Oct 2021 01:54:04 -0400
X-MC-Unique: ev8l8bhXOTSbLw1-MIL4Xg-1
Received: by mail-oo1-f72.google.com with SMTP id i1-20020a4a9001000000b002a9c41e0eabso1139513oog.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 22:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o4AZ2v0d2upoVgn5yMh1nIi8K7ql02Ob+W4jg2mRZPo=;
        b=z/Ngv3eZue3yytekEZWNWMhOXSU+hhMEKaQFDTz3vtPuz7hP9hALkdMt+MZakOWXWn
         Jt5em7pZceOYk7vjQZIhRXt0qnF+/RgTfTRM+zPZO55EyhGDp2vBwoEJfo+7ddng1eyL
         j6SnKw1gDeeeSpt8QZ6jBBPKRgCZHXpmletfZUyjytJrIxVuVzMci2j72hYfLUctIt6k
         KFjb59kRc+bOrIcnshLKmt4Uu5VNEQ75/UZhWvwX/oVIr8JflrzCKozUilhVA32iYZQq
         Up8ALP4H2Ge4zKpVqUK43EsF76zieq6sQymmlznygRIbDONC/0ao54ErwmSeTGRYV1UG
         UagA==
X-Gm-Message-State: AOAM532+jMYy/vxYr8Za4G/8AL/aDH12nU5zqS/CyUz3IVSzAR/5pDGV
        pihbs/ss3e8gNAXT/m+t++KDrNdQbVsCwWZXaQlD+qM19LU98x04q+N8q1WgayVAupP6kGBQFeX
        ki3oiVoLiopBTzWkTT2aQA9Ng
X-Received: by 2002:a54:4807:: with SMTP id j7mr5725603oij.140.1633499643370;
        Tue, 05 Oct 2021 22:54:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjZoedDN6ykejdw4SAEmSPfsfZzklHzH6dAAnT/J+m5t+Q7kx7Mo2PyaT4sYzfuJ0esedWSg==
X-Received: by 2002:a54:4807:: with SMTP id j7mr5725589oij.140.1633499643163;
        Tue, 05 Oct 2021 22:54:03 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id i15sm432037otu.67.2021.10.05.22.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 22:54:02 -0700 (PDT)
Date:   Tue, 5 Oct 2021 22:53:59 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 05/11] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <20211006055359.svcqk36btq7zg3td@treble>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-6-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211005025205.1784480-6-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:51:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Guests communicate with VMMs with hypercalls. Historically, these
> are implemented using instructions that are known to cause VMEXITs
> like VMCALL, VMLAUNCH, etc. However, with TDX, VMEXITs no longer
> expose guest state to the host.  This prevents the old hypercall
> mechanisms from working. So to communicate with VMM, TDX
> specification defines a new instruction called TDCALL.
> 
> In a TDX based VM, since VMM is an untrusted entity, a intermediary
> layer (TDX module) exists between host and guest to facilitate
> secure communication. TDX guests communicate with the TDX module
> using TDCALL instruction. 

Most of the information in the second paragraph was already provided in
the first paragraph.

> +#ifdef CONFIG_FRAME_POINTER
> +/* Frame offset + 8 (for arg1) */
> +#define ARG7_SP_OFFSET		(FRAME_OFFSET + 0x08)
> +#else
> +#define ARG7_SP_OFFSET		(0x08)
> +#endif

No need for the #ifdef here, FRAME_OFFSET is already zero for
!FRAME_POINTER.  So it can just be unconditional:

#define ARG7_SP_OFFSET		(FRAME_OFFSET + 0x08)

> + * __tdx_hypercall()  - Helper function used by TDX guests to request
> + * services from the VMM. All requests are made via the TDX module
> + * using TDCALL instruction.
> + *
> + * This function serves as a wrapper to move user call arguments to the
> + * correct registers as specified by TDCALL ABI and share it with VMM
> + * via the TDX module. After TDCALL operation, output from the VMM is
> + * saved to the memory specified in the "out" (struct tdx_hypercall_output)
> + * pointer. 
> + *
> + *-------------------------------------------------------------------------
> + * TD VMCALL ABI:
> + *-------------------------------------------------------------------------
> + *
> + * Input Registers:
> + *
> + * RAX                 - TDCALL instruction leaf number (0 - TDG.VP.VMCALL)
> + * RCX                 - BITMAP which controls which part of TD Guest GPR
> + *                       is passed as-is to VMM and back.
> + * R10                 - Set 0 to indicate TDCALL follows standard TDX ABI
> + *                       specification. Non zero value indicates vendor
> + *                       specific ABI.
> + * R11                 - VMCALL sub function number
> + * RBX, RBP, RDI, RSI  - Used to pass VMCALL sub function specific arguments.
> + * R8-R9, R12–R15      - Same as above.
> + *
> + * Output Registers:
> + *
> + * RAX                 - TDCALL instruction status (Not related to hypercall
> + *                        output).
> + * R10                 - Hypercall output error code.
> + * R11-R15             - Hypercall sub function specific output values.
> + *
> + *-------------------------------------------------------------------------
> + *
> + * __tdx_hypercall() function ABI:
> + *
> + * @type  (RDI)        - TD VMCALL type, moved to R10
> + * @fn    (RSI)        - TD VMCALL sub function, moved to R11
> + * @r12   (RDX)        - Input parameter 1, moved to R12
> + * @r13   (RCX)        - Input parameter 2, moved to R13
> + * @r14   (R8)         - Input parameter 3, moved to R14
> + * @r15   (R9)         - Input parameter 4, moved to R15
> + *
> + * @out   (stack)      - struct tdx_hypercall_output pointer (cannot be NULL)
> + *
> + * On successful completion, return TDCALL status or -EINVAL for invalid
> + * inputs.
> + */

The documentation and comments for all the asm code are excellent!  If
only all kernel asm code were this readable!

I'm especially thankful that it's not all crammed into inline asm :-)

> +SYM_FUNC_START(__tdx_hypercall)
> +	FRAME_BEGIN
> +
> +	/* Move argument 7 from caller stack to RAX */
> +	movq ARG7_SP_OFFSET(%rsp), %rax
> +
> +	/* Check if caller provided an output struct */
> +	test %rax, %rax
> +	/* If out pointer is NULL, return -EINVAL */
> +	jz 1f
> +
> +	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
> +	push %r15
> +	push %r14
> +	push %r13
> +	push %r12
> +
> +	/*
> +	 * Save R9 and output pointer (rax) in stack, it will be used
> +	 * again when storing the output registers after TDCALL
> +	 * operation.
> +	 */
> +	push %r9
> +	push %rax

r9 is callee-clobbered, so we shouldn't need to push it here or pop it
("Restore state of R9 register" below) before returning.

> +/*
> + * Wrapper for standard use of __tdx_hypercall with BUG_ON() check
> + * for TDCALL error.
> + */
> +static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
> +				 u64 r15, struct tdx_hypercall_output *out)

Instead of calling the args r12-r15, I'm thinking it would be clearer to
call them arg1-arg4.  It's not the C code's job to worry about the
argument-to-register ABI mappings.

Same comment for the function declaration in the header file.

-- 
Josh

