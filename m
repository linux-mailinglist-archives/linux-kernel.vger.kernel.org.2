Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1464135A1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhIUOxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233759AbhIUOxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632235940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HpHwM4IlNbbtXG5gk4xvKzJNKCkJO1w4ngTakIDhsD8=;
        b=Is79W1P+EM1lGztV9EwPq+F81c1LPcm4cdYVZcw25YA2qdoikhw5vfxKw6vPzy9VWonnri
        WxN6gkMhdhs8ydtEh9d3CW78YXzJ/lTghK29WS0mwZ4IGsll5MgP3TR42jHi2Zz0kl63je
        m4VjdZ0qpfSXhyQTTgpvbSuLwzNFKJs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-vZ85cPeDPGu9pkqOEYtltQ-1; Tue, 21 Sep 2021 10:52:19 -0400
X-MC-Unique: vZ85cPeDPGu9pkqOEYtltQ-1
Received: by mail-wr1-f71.google.com with SMTP id f11-20020adfc98b000000b0015fedc2a8d4so4762072wrh.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HpHwM4IlNbbtXG5gk4xvKzJNKCkJO1w4ngTakIDhsD8=;
        b=0HTnl1BhOQPAFW3eS7unN3pnf/Sm5F+yOPQJPjgPri8OcaQd2+a5rPVgXw2cgjp+/C
         2sUT0EAmWubZf6k3rt8maZKpLovxOab+NFb4UObP0zYeDLs9jUyFbo8l/2o2cFy9ttMR
         h4wiZG39OzH/NonNyJi0te7ixkll+FGgF1e3bkD0vbMt+3aYVvi1L1TjhJQ1mZXe3XJ2
         oGMszlXo9Cx7g3DpYjGuA1ZW8F1lF84AiGWv+0kha7rrUcQVNsVadasMZb7oiqh1X8QS
         muc30TNqN9GwivofEDX/F6c65WTInbuFJb+dd4XFqezdH79R++rhrh3d+Q9dv4Ku2XXg
         Ezqg==
X-Gm-Message-State: AOAM533OMuEToHjOZOL7TRczHFfdwriJC5j3Enrdu/nwhExYx4gPQkQG
        3uWGGDyxEgcQ/OVY/Ghvnarlc1zdvqZHTLzcWissrPfM7JYgzDHenifwMJuHX6gpDklqYS5ylit
        vd6rFBc95F8uwyuCyOOB8+tP6
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr5024426wma.83.1632235938224;
        Tue, 21 Sep 2021 07:52:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz89bRhSQKhdzxgLJDawIQc7RqTVfaU492Kzd7n2o2D9y4JPckvBeRqIBfPoRyJzEanJcpJCA==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr5024405wma.83.1632235938045;
        Tue, 21 Sep 2021 07:52:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o7sm24424262wro.45.2021.09.21.07.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 07:52:17 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH v2 06/10] KVM: x86: Fold fx_init() into
 kvm_arch_vcpu_create()
In-Reply-To: <20210921000303.400537-7-seanjc@google.com>
References: <20210921000303.400537-1-seanjc@google.com>
 <20210921000303.400537-7-seanjc@google.com>
Date:   Tue, 21 Sep 2021 16:52:16 +0200
Message-ID: <87tuie7zhb.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Move the few bits of relevant fx_init() code into kvm_arch_vcpu_create(),
> dropping the superfluous check on vcpu->arch.guest_fpu that was blindly
> and wrongly added by commit ed02b213098a ("KVM: SVM: Guest FPU state
> save/restore not needed for SEV-ES guest").

I have more questions to the above mentioned commit: why is it OK to
'return 0' from kvm_vcpu_ioctl_x86_set_xsave() without writing anything
to 'guest_xsave'? Same goes to kvm_arch_vcpu_ioctl_get_fpu(). Whould't
it be better to throw an error as we can't actually get this information
for encrypted guests? It's probably too late to change this now I
suppose ...

>
> Note, KVM currently allocates and then frees FPU state for SEV-ES guests,
> rather than avoid the allocation in the first place.  While that approach
> is inarguably inefficient and unnecessary, it's a cleanup for the future.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/x86.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6fd3fe21863e..ec61b90d9b73 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10614,17 +10614,6 @@ static int sync_regs(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> -static void fx_init(struct kvm_vcpu *vcpu)
> -{
> -	if (!vcpu->arch.guest_fpu)
> -		return;
> -
> -	fpstate_init(&vcpu->arch.guest_fpu->state);
> -	if (boot_cpu_has(X86_FEATURE_XSAVES))
> -		vcpu->arch.guest_fpu->state.xsave.header.xcomp_bv =
> -			host_xcr0 | XSTATE_COMPACTION_ENABLED;
> -}
> -
>  void kvm_free_guest_fpu(struct kvm_vcpu *vcpu)
>  {
>  	if (vcpu->arch.guest_fpu) {
> @@ -10703,7 +10692,10 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  		pr_err("kvm: failed to allocate vcpu's fpu\n");
>  		goto free_user_fpu;
>  	}
> -	fx_init(vcpu);
> +	fpstate_init(&vcpu->arch.guest_fpu->state);
> +	if (boot_cpu_has(X86_FEATURE_XSAVES))
> +		vcpu->arch.guest_fpu->state.xsave.header.xcomp_bv =
> +			host_xcr0 | XSTATE_COMPACTION_ENABLED;
>  
>  	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
>  	vcpu->arch.reserved_gpa_bits = kvm_vcpu_reserved_gpa_bits_raw(vcpu);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

