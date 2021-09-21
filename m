Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6F0413DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 00:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhIUW5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 18:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhIUW5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 18:57:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAFDC061760
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:55:31 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mv7-20020a17090b198700b0019c843e7233so778863pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BMCtqiOaU3Jol7oGZtEshrlJBTqq3pP+pwS0DzJkKbY=;
        b=WUrJZf0jln8x+1NkJRqiuJD4j96lL5lrra7QkjEula1CPP8eIAHbWTaYz10ytJjzDq
         MXRCZlYVrvc/jaTbt2tllN6ooFAymt0FWO7TdzUroUKsG9fAEIzDYsGCQXDAy9safl+t
         /MSg2/mv0ajL2X/HWjlP/ZP2Uhlg/6Kli/C9fsBJo0gLVZyomc6Oq9Oy2TlJFkcMwER8
         nbBQFJBo90ZYXwOKbtO/TBf3pRV65oIgS3mOOfHDbnavrNLV3vM+CZxrAEAIvrRf1D1U
         7iSnnx2Ic5IRHAGDvxy20vh/IB4PrpXFeyNNC0EwXPr6rRDA0hQ7Nz93KoVNggx8Zm5q
         7Y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BMCtqiOaU3Jol7oGZtEshrlJBTqq3pP+pwS0DzJkKbY=;
        b=Mta6PI0r39bKPQKWHB3s9/a+bnpi0SaSd9eoHeuKhbLOPEFhMio2wr2tKynK/o/Vga
         hSlgRDFMpUvN0xVbyYARYvLAogt7kEGobzjXZrEUy7e6Foj6l+dEAvovxXmUL8dHWYQn
         N7Qe5B7l1svUXLbvHThNMEPdqFAlnOWXA2j27QQG6V5CqyfEuAnHLq793dCJWS+LjGAQ
         acvbMEPYm59/JOinAYsQafNzzlL2qzetvTdQOdp373+DM7vtYwrPqAdFeUl8Knqi2Vih
         fH/ICBszZE05r/z1GLjUWlsSLycU/somzz5bi+O9JCplt9PNfRHj3ElcQSnf6LXq2FM9
         oQDg==
X-Gm-Message-State: AOAM532FKpONdoOe3ykCGcR3kWQ1EaWbzGFZWHRui0ve41bIxNfgJPSA
        WIq7/YDq4uwremmREjsh2WiioQ==
X-Google-Smtp-Source: ABdhPJymBpI2KwZDqOXgMkOjIFujnaztfoYn8370U3QrI9Qud0OztAAXFb36D/GflBLBEplZvUcbrA==
X-Received: by 2002:a17:90b:4f49:: with SMTP id pj9mr7896768pjb.188.1632264930882;
        Tue, 21 Sep 2021 15:55:30 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id c23sm186603pgb.74.2021.09.21.15.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:55:30 -0700 (PDT)
Date:   Tue, 21 Sep 2021 22:55:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 6/6] KVM: nVMX: re-evaluate emulation_required on
 nested VM exit
Message-ID: <YUpi3rpTsoQ/dzp6@google.com>
References: <20210830125539.1768833-1-mlevitsk@redhat.com>
 <20210830125539.1768833-7-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830125539.1768833-7-mlevitsk@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021, Maxim Levitsky wrote:
> If L1 had invalid state on VM entry (can happen on SMM transactions
> when we enter from real mode, straight to nested guest),
> 
> then after we load 'host' state from VMCS12, the state has to become
> valid again, but since we load the segment registers with
> __vmx_set_segment we weren't always updating emulation_required.

Because I'm an idiot.

> Update emulation_required explicitly at end of load_vmcs12_host_state.

Can you also add

  Reported-by: kernel test robot <oliver.sang@intel.com>

which is how I ended up here, sort of.

Fixes: 816be9e9be8d ("KVM: nVMX: Don't evaluate "emulation required" on nested VM-Exit")

> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---

The below is overkill.  The state after VM-Exit _can't_ be invalid, which was the
whole point of moving to __vmx_set_segment(), I just forgot the minor detail of
clearing emulation_required.  So just:

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bc6327950657..55ac7211fb37 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4314,6 +4314,12 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
        if (nested_vmx_load_msr(vcpu, vmcs12->vm_exit_msr_load_addr,
                                vmcs12->vm_exit_msr_load_count))
                nested_vmx_abort(vcpu, VMX_ABORT_LOAD_HOST_MSR_FAIL);
+
+       /*
+        * All relevant vmcs12 host state is checked prior to VM-Entry, thus
+        * L1 guest can never be invalid after VM-Exit.
+        */
+       to_vmx(vcpu)->emulation_required = false;
 }
 
 static inline u64 nested_vmx_get_vmcs01_guest_efer(struct vcpu_vmx *vmx)

>  arch/x86/kvm/vmx/nested.c | 2 ++
>  arch/x86/kvm/vmx/vmx.c    | 8 ++++----
>  arch/x86/kvm/vmx/vmx.h    | 1 +
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 1a05ae83dae5..f915e1ac589c 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4319,6 +4319,8 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
>  	if (nested_vmx_load_msr(vcpu, vmcs12->vm_exit_msr_load_addr,
>  				vmcs12->vm_exit_msr_load_count))
>  		nested_vmx_abort(vcpu, VMX_ABORT_LOAD_HOST_MSR_FAIL);
> +
> +	to_vmx(vcpu)->emulation_required = vmx_emulation_required(vcpu);
>  }
>  
>  static inline u64 nested_vmx_get_vmcs01_guest_efer(struct vcpu_vmx *vmx)
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 02d061f5956a..7ff1e1daeb0a 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1323,7 +1323,7 @@ static void vmx_vcpu_put(struct kvm_vcpu *vcpu)
>  	vmx_prepare_switch_to_host(to_vmx(vcpu));
>  }
>  
> -static bool emulation_required(struct kvm_vcpu *vcpu)
> +bool vmx_emulation_required(struct kvm_vcpu *vcpu)
>  {
>  	return emulate_invalid_guest_state && !vmx_guest_state_valid(vcpu);
>  }
> @@ -1367,7 +1367,7 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
>  	vmcs_writel(GUEST_RFLAGS, rflags);
>  
>  	if ((old_rflags ^ vmx->rflags) & X86_EFLAGS_VM)
> -		vmx->emulation_required = emulation_required(vcpu);
> +		vmx->emulation_required = vmx_emulation_required(vcpu);
>  }
>  
>  u32 vmx_get_interrupt_shadow(struct kvm_vcpu *vcpu)
> @@ -3077,7 +3077,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
>  	}
>  
>  	/* depends on vcpu->arch.cr0 to be set to a new value */
> -	vmx->emulation_required = emulation_required(vcpu);
> +	vmx->emulation_required = vmx_emulation_required(vcpu);
>  }
>  
>  static int vmx_get_max_tdp_level(void)
> @@ -3330,7 +3330,7 @@ static void vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int
>  {
>  	__vmx_set_segment(vcpu, var, seg);
>  
> -	to_vmx(vcpu)->emulation_required = emulation_required(vcpu);
> +	to_vmx(vcpu)->emulation_required = vmx_emulation_required(vcpu);
>  }
>  
>  static void vmx_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 4858c5fd95f2..3a587c51a8d1 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -359,6 +359,7 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu);
>  void vmx_set_host_fs_gs(struct vmcs_host_state *host, u16 fs_sel, u16 gs_sel,
>  			unsigned long fs_base, unsigned long gs_base);
>  int vmx_get_cpl(struct kvm_vcpu *vcpu);
> +bool vmx_emulation_required(struct kvm_vcpu *vcpu);
>  unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu);
>  void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
>  u32 vmx_get_interrupt_shadow(struct kvm_vcpu *vcpu);
> -- 
> 2.26.3
> 
