Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEAA413489
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhIUNmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232953AbhIUNmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632231648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iVJ6jA04IK22G/jDsobPeYSFtrQJ6cK0uRhiwpn8U+A=;
        b=KCSuJABWtT48qm+phxfK/fq+avDlwVakQKpcBNZMP7HmXeh39E6ZKQ94ZBp5+jjaCJlWs+
        sa505kqYi9aEG4RMPLkPRPYlWVESQZAIA91NhMUm65Azsd3ez5qxZvQ1xdcLkD7etuTchV
        DJ5K54VIdC7wPkFGlRl2aOSd6FajMJk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-ziQtKy7dMSmNQmyxZm8gHw-1; Tue, 21 Sep 2021 09:40:45 -0400
X-MC-Unique: ziQtKy7dMSmNQmyxZm8gHw-1
Received: by mail-wr1-f72.google.com with SMTP id v15-20020adff68f000000b0015df51efa18so8836750wrp.16
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 06:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iVJ6jA04IK22G/jDsobPeYSFtrQJ6cK0uRhiwpn8U+A=;
        b=UecTBbgtJ8QVpza4teuBzNDBJ7jrkjt/fh2BoiMU9nNDwtHKgdAls+WiDs8VYF3Dwk
         62CmeooMoqCwt002BgAZPEUxmIeahattGseuLPIRPeHPnlrgldqrU7EQc499DJAAts5x
         nAk+nUyQGgDHreRHGPjXoNddOTu1wH/zp1XLSXfTSh6/BnCnxRBNIbPTDVSidkhK/fWh
         e9umyUnra1dg5EJnKb09M/j+nfh0Aq637UwTSHu2zuA18E+jVJLl8Lt4zGUMUGYr9mKj
         bwr0/pmBXkVdOqwTdSCjeZ9LX8sFpeixJbiZRpbIH+7ZJxSOVg5u343r49Tia6D0x4Ba
         N+jw==
X-Gm-Message-State: AOAM5303vfeKNtbUGO5c5xgm9c1RKMiu5HXKO9balnvqhIGOOQaHd7cy
        v2fliiHpjnxo8ArJ/L1JSGMcm71AfqReM+PTvPYZozJYkfav0efjHTeNwWyGvcIVRXQo0sb+SQa
        DlBwqkTaXRUi88K8bL/bLYSJe
X-Received: by 2002:adf:f98b:: with SMTP id f11mr35736938wrr.333.1632231644684;
        Tue, 21 Sep 2021 06:40:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlSORnU4CdGqTxRO6z9tsqPEPkQvl1bjfap/OC7IHg1t6vYcBPuzbONjGJRhB0te/lOAdMjQ==
X-Received: by 2002:adf:f98b:: with SMTP id f11mr35736908wrr.333.1632231644470;
        Tue, 21 Sep 2021 06:40:44 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id s15sm19581151wrb.22.2021.09.21.06.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:40:43 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH v2 01/10] KVM: x86: Mark all registers as avail/dirty at
 vCPU creation
In-Reply-To: <20210921000303.400537-2-seanjc@google.com>
References: <20210921000303.400537-1-seanjc@google.com>
 <20210921000303.400537-2-seanjc@google.com>
Date:   Tue, 21 Sep 2021 15:40:42 +0200
Message-ID: <87bl4m9hd1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Mark all registers as available and dirty at vCPU creation, as the vCPU has
> obviously not been loaded into hardware, let alone been given the chance to
> be modified in hardware.  On SVM, reading from "uninitialized" hardware is
> a non-issue as VMCBs are zero allocated (thus not truly uninitialized) and
> hardware does not allow for arbitrary field encoding schemes.
>
> On VMX, backing memory for VMCSes is also zero allocated, but true
> initialization of the VMCS _technically_ requires VMWRITEs, as the VMX
> architectural specification technically allows CPU implementations to
> encode fields with arbitrary schemes.  E.g. a CPU could theoretically store
> the inverted value of every field, which would result in VMREAD to a
> zero-allocated field returns all ones.
>
> In practice, only the AR_BYTES fields are known to be manipulated by
> hardware during VMREAD/VMREAD; no known hardware or VMM (for nested VMX)
> does fancy encoding of cacheable field values (CR0, CR3, CR4, etc...).  In
> other words, this is technically a bug fix, but practically speakings it's
> a glorified nop.

Just to make the picture complete, according to TLFS, Enlightened VMCS
must also be zero allocated and the encoding is known. Still a nop ;-)

>
> Failure to mark registers as available has been a lurking bug for quite
> some time.  The original register caching supported only GPRs (+RIP, which
> is kinda sorta a GPR), with the masks initialized at ->vcpu_reset().  That
> worked because the two cacheable registers, RIP and RSP, are generally
> speaking not read as side effects in other flows.
>
> Arguably, commit aff48baa34c0 ("KVM: Fetch guest cr3 from hardware on
> demand") was the first instance of failure to mark regs available.  While
> _just_ marking CR3 available during vCPU creation wouldn't have fixed the
> VMREAD from an uninitialized VMCS bug because ept_update_paging_mode_cr0()
> unconditionally read vmcs.GUEST_CR3, marking CR3 _and_ intentionally not
> reading GUEST_CR3 when it's available would have avoided VMREAD to a
> technically-uninitialized VMCS.
>
> Fixes: aff48baa34c0 ("KVM: Fetch guest cr3 from hardware on demand")
> Fixes: 6de4f3ada40b ("KVM: Cache pdptrs")
> Fixes: 6de12732c42c ("KVM: VMX: Optimize vmx_get_rflags()")
> Fixes: 2fb92db1ec08 ("KVM: VMX: Cache vmcs segment fields")
> Fixes: bd31fe495d0d ("KVM: VMX: Add proper cache tracking for CR0")
> Fixes: f98c1e77127d ("KVM: VMX: Add proper cache tracking for CR4")
> Fixes: 5addc235199f ("KVM: VMX: Cache vmcs.EXIT_QUALIFICATION using arch avail_reg flags")
> Fixes: 8791585837f6 ("KVM: VMX: Cache vmcs.EXIT_INTR_INFO using arch avail_reg flags")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/x86.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 86539c1686fa..e77a5bf2d940 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10656,6 +10656,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  	int r;
>  
>  	vcpu->arch.last_vmentry_cpu = -1;
> +	vcpu->arch.regs_avail = ~0;
> +	vcpu->arch.regs_dirty = ~0;
>  
>  	if (!irqchip_in_kernel(vcpu->kvm) || kvm_vcpu_is_reset_bsp(vcpu))
>  		vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

