Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AAC4247E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 22:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhJFU2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 16:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55010 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229677AbhJFU22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 16:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633551996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I2Q0+mRozN3eSjmjWTl3h/HNMMBHtGxlh1OcwvpPGqk=;
        b=O470+ailem44UM2zTLxzCSWMTOYgxfQekIlsejM+cuISrcIu6NcNop8A6jrx1Devft2/Op
        syLM0HN6YoN63MYpmyB9IvreYy0YS+fCjjltX5bxbQl5zAbXpiiOOF02YxIiBkilg0GuEL
        /XQpRiEkJFCpgxK1jiujwbhBR3rCsR8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-CZCJvbZDMa6AaoFkfq_6cA-1; Wed, 06 Oct 2021 16:26:35 -0400
X-MC-Unique: CZCJvbZDMa6AaoFkfq_6cA-1
Received: by mail-qk1-f198.google.com with SMTP id s20-20020a05620a0bd400b0045e893f2ed8so3104961qki.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 13:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I2Q0+mRozN3eSjmjWTl3h/HNMMBHtGxlh1OcwvpPGqk=;
        b=8N7q8cTXMXhVrYkeGFxNb54XQN38oinHQamm94cfwetbtEo060QbsVaakBzQIr93ED
         jU8RZ85RMEoAlBB+VhZiaii1a6QkpDTxzMX/JPteAb6hTnUL6hm2TFpPfoIBgDMPjpBd
         FkfgSIQGMrwWOFKcKxXJ1mp2uNyP7zT0GRqcIT6g/eLTHUM4FY5YPVLuJ7n8ruwUl0ib
         IiJHsCyENL1hVyi5QHhXrUiz7fYpL8SDZ4zxxhnaTjps8iFm8luVmy6osOfJe00j8UdM
         BfvhggYGVOa6TQx6VUTu9cPOXcl6BDT+5eHy+1Xyf0GLceQuD/n/I+RU0a9XOag6fr6I
         6eGA==
X-Gm-Message-State: AOAM530m6bhJuKAmEojABZ/jCJNXeP9GKFJX3I7QXp3NriQKrbCWiR+U
        l/RXVGfa3Uyx6vRHppJQ/FdplyxFo+3d0jXgRas0YY2i9fQZbIYsGYjmaWeJL4yvwZ7lRuRQNQz
        ALcy6UfQZ1bFvpbf62zhIIJwn
X-Received: by 2002:ae9:d8c6:: with SMTP id u189mr142255qkf.391.1633551994557;
        Wed, 06 Oct 2021 13:26:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7Hd9PIbk5V+6tMold3q0nCpYJGa7xW0DMKLEN1CCrSmKKIxlFGCFnruR2Z+DvGHPzLsptEg==
X-Received: by 2002:ae9:d8c6:: with SMTP id u189mr142236qkf.391.1633551994323;
        Wed, 06 Oct 2021 13:26:34 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id m6sm13489403qti.38.2021.10.06.13.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 13:26:33 -0700 (PDT)
Date:   Wed, 6 Oct 2021 13:26:30 -0700
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
Subject: Re: [PATCH v8 11/11] x86/tdx: Handle CPUID via #VE
Message-ID: <20211006202630.chblrhdqepsbtdaa@treble>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-12-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005025205.1784480-12-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:52:05PM -0700, Kuppuswamy Sathyanarayanan wrote:
> +static u64 tdx_handle_cpuid(struct pt_regs *regs)
> +{
> +	struct tdx_hypercall_output out = {0};
> +	u64 ret;
> +
> +	/*
> +	 * Emulate CPUID instruction via hypercall. More info about
> +	 * ABI can be found in TDX Guest-Host-Communication Interface
> +	 * (GHCI), section titled "VP.VMCALL<Instruction.CPUID>".
> +	 */
> +	ret = _tdx_hypercall(EXIT_REASON_CPUID, regs->ax, regs->cx, 0, 0, &out);
> +
> +	/*
> +	 * As per TDX GHCI CPUID ABI, r12-r15 registers contains contents of
> +	 * EAX, EBX, ECX, EDX registers after CPUID instruction execution.
> +	 * So copy the register contents back to pt_regs.
> +	 */
> +	regs->ax = out.r12;
> +	regs->bx = out.r13;
> +	regs->cx = out.r14;
> +	regs->dx = out.r15;

Does it still make sense to save the regs if _tdx_hypercall() returns an
error?

> +
> +	return ret;

Also I'm wondering about error handling for all these _tdx_hypercall()
wrapper functions which are called by the #VE handler.

First, there are some inconsistencies in whether and how they return the
r10 error.

- _tdx_halt() warns and doesn't return anything.

- tdx_read_msr_safe() and tdx_write_msr_safe() convert all errors to -EIO.

- tdx_handle_cpuid() returns the raw vmcall error.

Second, as far as I can tell, the #VE handler doesn't check the actual
return code value, other than checking for non-zero.  Should it at least
be printed in a warning?

-- 
Josh

