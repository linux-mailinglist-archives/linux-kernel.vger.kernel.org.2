Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B665413540
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhIUOZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233461AbhIUOZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632234215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wDh0oMN6VwKrbIN4CU/frP4g1lxciAjNHJADjKyJ4Io=;
        b=B4t04PyrDzAbQCLfHk/jOQO7OZpC1hVj/K7ULKlFaIGgifU6oBoe6azoMdYihbqBJcZUja
        GGbA7TL/rwlOwfLHRFwPaSVU5M/Nt4um1r/P3FNtZG9D6Jd9wc3JIra8NvN3xg6nPfawMO
        bMGMnLaLNT4/Gs16E4GQyFfPN5dfaTs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-qJLtbyuHNb6h8b97DgKxxg-1; Tue, 21 Sep 2021 10:23:33 -0400
X-MC-Unique: qJLtbyuHNb6h8b97DgKxxg-1
Received: by mail-wr1-f72.google.com with SMTP id f7-20020a5d50c7000000b0015e288741a4so8960720wrt.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wDh0oMN6VwKrbIN4CU/frP4g1lxciAjNHJADjKyJ4Io=;
        b=Fk4FtgNVrpJemcTI8IV0fhmNeXKeeOzq1uMpmRZGG22GBs8YB5pgy63AA1cJWO9Wcd
         8/AhBljmc6Wo6U2NjJsBlt2qo8Jobf4UBXkc08aVKNxJVdRhd4oUUN6X1ug4AxFOrzs0
         So5sMr9jWXH66VbA//6aSbIXYXucrng0uNx4lr3pPJklSwMt69Jkbj26dzfwgntyvmYT
         aEqVts1UWczrMHZXK21FqYSzDGdKiLIZYqNROUBpvIipwZrg9oEuJdcAthQKNrkKf6r1
         gQ98BemGBcw9/pt/D3O2h6jMiSiin/woCEmeoEtzy+AYfwySdj2WT+FnsOOLhOWOkYsT
         AuEw==
X-Gm-Message-State: AOAM530+hDTVgk/uCDmFpeHPYhySJrSMBbWpGeiYekZclnkxLMMM/ly9
        MHfeUQS17EnkaFD41QFFQvcC6DQYDY+u2cBXhdMCi3f0NOH02twkeAv4+dIVLFZs3tmjTjhTCWJ
        przOQTa5wk+nepduhyCnZn8Gy
X-Received: by 2002:a05:600c:1552:: with SMTP id f18mr4829441wmg.184.1632234212185;
        Tue, 21 Sep 2021 07:23:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8dBsUGmpSS/VnNnROL3eISK4+6sMfIjPu7vf/SpQmq1Qcp7XpNAZWxQfzCtY6FcM1lKR9/g==
X-Received: by 2002:a05:600c:1552:: with SMTP id f18mr4829420wmg.184.1632234212000;
        Tue, 21 Sep 2021 07:23:32 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id k6sm2873679wmo.37.2021.09.21.07.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 07:23:31 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH v2 04/10] KVM: x86: Remove defunct setting of CR0.ET for
 guests during vCPU create
In-Reply-To: <20210921000303.400537-5-seanjc@google.com>
References: <20210921000303.400537-1-seanjc@google.com>
 <20210921000303.400537-5-seanjc@google.com>
Date:   Tue, 21 Sep 2021 16:23:30 +0200
Message-ID: <87zgs680t9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Drop code to set CR0.ET for the guest during initialization of the guest
> FPU.  The code was added as a misguided bug fix by commit 380102c8e431
> ("KVM Set the ET flag in CR0 after initializing FX") to resolve an issue
> where vcpu->cr0 (now vcpu->arch.cr0) was not correctly initialized on SVM
> systems.  While init_vmcb() did set CR0.ET, it only did so in the VMCB,
> and subtly did not update vcpu->cr0.  Stuffing CR0.ET worked around the
> immediate problem, but did not fix the real bug of vcpu->cr0 and the VMCB
> being out of sync.  That underlying bug was eventually remedied by commit
> 18fa000ae453 ("KVM: SVM: Reset cr0 properly on vcpu reset").
>
> No functional change intended.

fx_init() is only called from kvm_arch_vcpu_create() (and inlined later
in the series) a few lines before kvm_vcpu_reset() which stuffs CR0 with 
X86_CR0_ET too and it doesn't seem that arch.cr0 value is important in
between.

>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/x86.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ab907a0b9eeb..e0bff5473813 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10628,8 +10628,6 @@ static void fx_init(struct kvm_vcpu *vcpu)
>  	 * Ensure guest xcr0 is valid for loading
>  	 */
>  	vcpu->arch.xcr0 = XFEATURE_MASK_FP;
> -
> -	vcpu->arch.cr0 |= X86_CR0_ET;
>  }
>  
>  void kvm_free_guest_fpu(struct kvm_vcpu *vcpu)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

