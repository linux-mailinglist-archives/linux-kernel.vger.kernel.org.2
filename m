Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2DC322EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhBWQjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhBWQjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:39:18 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84371C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:38:38 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p5so5281900plo.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=suqwHwnPZphs1adCEqjvleP9vgvwz73ppw4oBEyeBNI=;
        b=jPGQ6tlovoRBukQNilm0Yx/2c5WlEsi5gI/Ek7mWk8JLDM6mxb9Jhd9P3Wdqy+rb0t
         u5XOBgDVPAlArzrw/fynNA1OvmdWW6PZr4180C0RXv0YGkag+PHaljg0uWprtyqdW0QV
         NLapQe/oeVr2gmJ0yrcTG3EmDDfEnRMNemJZqgCxWkKbnGA2i1LPINbqhiljZjbMmpc6
         hBbyGvMltiAsLZg3HaSflKaLfXL4eY2DaSpU82n9wK6molLaAntF4jGSjraiGAZQhPsN
         x7/0G39qO+dYHPmTXmmtJ1SkFxeQT0wuryay2JnaDpE7VWfymiXdz2/cy3vJbpRfGgVu
         gAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=suqwHwnPZphs1adCEqjvleP9vgvwz73ppw4oBEyeBNI=;
        b=Aq+7iNGK+YfC/bQ+u/ZrP+11IS0F6Rd0X1MmJxG/xDP85XKMMet9EAxymm3J4J43Nr
         Qdayk1ROQoO27abniNBU42IcVczTIlw+GuDDwvxZlzxa9nmXRDvYZcaHzgx6XvhsgvBS
         +OHd9JrbpxUjgC6XhB6wLH8AD2ojXN+iMF9Q3iHWEI1fcVXbW1IkVyWMXbHHMtfDK5ew
         F7IgvTEa4EIAvs/UNxLNCNlNprodMv5P8q8oG6VEQ9iqU/Kl4SeqG+eCCPSr1p9MwGVf
         13RMsNr48l98/wGawlW7CUaoaawL+yGcNfJvuKvTvTtG4FSAjjXxTo9GKLV9su5JUm5Y
         OZAw==
X-Gm-Message-State: AOAM531g48LcxyotsNB0uGa4+G/MKeIQkaH9+UhZYwHd8QiXX7pd1EH1
        JA4Q2ua4W0m93WIApwPrnb0Q2Q==
X-Google-Smtp-Source: ABdhPJzqD/ZHpDe3KbQrsqBbtDmNeZBVMnQJMD94Zr4nxA+8z/0k5Hhdddat7e3AbETW4TeDM3ZhNA==
X-Received: by 2002:a17:902:a614:b029:e1:5b43:956a with SMTP id u20-20020a170902a614b02900e15b43956amr28719486plq.38.1614098317908;
        Tue, 23 Feb 2021 08:38:37 -0800 (PST)
Received: from google.com ([2620:15c:f:10:c939:813f:76bc:d651])
        by smtp.gmail.com with ESMTPSA id a19sm859293pjh.39.2021.02.23.08.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 08:38:37 -0800 (PST)
Date:   Tue, 23 Feb 2021 08:38:29 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: vmx/pmu: Clear DEBUGCTLMSR_LBR bit on the debug
 breakpoint event
Message-ID: <YDUvhTyFVwwZHnEj@google.com>
References: <20210223013958.1280444-1-like.xu@linux.intel.com>
 <20210223013958.1280444-2-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223013958.1280444-2-like.xu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021, Like Xu wrote:
> When the processor that support model-specific LBR generates a debug
> breakpoint event, it automatically clears the LBR flag. This action
> does not clear previously stored LBR stack MSRs. (Intel SDM 17.4.2)
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index e0a3a9be654b..4951b535eb7f 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4795,6 +4795,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
>  	u32 intr_info, ex_no, error_code;
>  	unsigned long cr2, rip, dr6;
>  	u32 vect_info;
> +	u64 lbr_ctl;
>  
>  	vect_info = vmx->idt_vectoring_info;
>  	intr_info = vmx_get_intr_info(vcpu);
> @@ -4886,6 +4887,10 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
>  		rip = kvm_rip_read(vcpu);
>  		kvm_run->debug.arch.pc = vmcs_readl(GUEST_CS_BASE) + rip;
>  		kvm_run->debug.arch.exception = ex_no;
> +		/* On the debug breakpoint event, the LBREn bit is cleared. */

Except this code is in BP_VECTOR, not DB_VECTOR as it should be.

  When the processor generates a debug exception (#DB), it automatically clears
  the LBR flag before executing the exception handler. This action does not
  clear previously stored LBR stack MSRs.

> +		lbr_ctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
> +		if (lbr_ctl & DEBUGCTLMSR_LBR)
> +			vmcs_write64(GUEST_IA32_DEBUGCTL, lbr_ctl & ~DEBUGCTLMSR_LBR);
>  		break;
>  	case AC_VECTOR:
>  		if (guest_inject_ac(vcpu)) {
> -- 
> 2.29.2
> 
