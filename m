Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775943A2F01
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhFJPIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231467AbhFJPIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623337569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ed14xuc5GLdj1NrbGE3OdC+GrAhtNU/6LCzI+jZmJEs=;
        b=aW7kIPNAJgu0194i8vVJvhJ7wap+iPm6lCM4QPedbhEtn4wOvIZK5onFf4MqUWE2FaAFo8
        29MK6TfMUilVTl2S4Nc6BL8fMbHxjJrsGqMnxEgFCUGT8ANr1d0ysDfFdbkbYQN1uwUp7R
        PR6Su2V2MCHPIWICpGo6xIbWmdiI2WA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-Z3wXpCWQNGCwcuOzGps6iQ-1; Thu, 10 Jun 2021 11:06:07 -0400
X-MC-Unique: Z3wXpCWQNGCwcuOzGps6iQ-1
Received: by mail-wm1-f70.google.com with SMTP id n21-20020a7bcbd50000b02901a2ee0826aeso3895373wmi.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ed14xuc5GLdj1NrbGE3OdC+GrAhtNU/6LCzI+jZmJEs=;
        b=UAbv0snBnEPj3USOcYmbsHMd/9Hy1/x+C748DkVYZOO7LXIwRrMYZZ5dn8aVXTadCn
         4FhaIznjC3GYKnM1K7HJT/kfqaGMVQUkOoE78kvNFUz5gqtFxMqP9advcmg6J0nBMN0/
         Oy0wY/vQZsMYNJBJAjgK3H9oi64cfMiWyOXEUBcJ0l4w0Qd2c6RDuD4wRPepE03I+t7S
         bKgWH5Prigv5+NpRE1Cg2TltBfk2BaANJE4dn2sNzzljoX2pHWLrd2/yuUYh0aFR+u7C
         y7QAZWXxSBXMCfQHx8qbZ9HipzkMV1R/z747al9QDZ6zRxlVavCjtOaJeBxKU+mEU3hK
         i2GA==
X-Gm-Message-State: AOAM530aSVad5GF5hUE4H2ImT2KxpnSEqcwiZugzkP4inwY1p4/IY35C
        0Pb/tDZq3UE/hKRkDHWyWn3+QG7BdFQCVbKzzf5446bdcC9cK0sXlvJSf2llgKipFTxpoTfsBtk
        XAkYjpT71O5IW3I447+UBiTPZ
X-Received: by 2002:a7b:c098:: with SMTP id r24mr15327303wmh.35.1623337566497;
        Thu, 10 Jun 2021 08:06:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHf4OlESk6cmnALRE3mUEXEeyjVHsEEQZzI40uQXGVsfJoMugcGZk20BYFlr8EDnNLDWIA9w==
X-Received: by 2002:a7b:c098:: with SMTP id r24mr15327292wmh.35.1623337566335;
        Thu, 10 Jun 2021 08:06:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id u15sm8514366wmq.1.2021.06.10.08.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 08:06:05 -0700 (PDT)
Subject: Re: [PATCH v3 7/8] KVM: x86: Introduce KVM_GET_SREGS2 /
 KVM_SET_SREGS2
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20210607090203.133058-1-mlevitsk@redhat.com>
 <20210607090203.133058-8-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f6a0aed8-2cfe-0af3-dd6f-26e4f203be9e@redhat.com>
Date:   Thu, 10 Jun 2021 17:06:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210607090203.133058-8-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/21 11:02, Maxim Levitsky wrote:
> +static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2)
> +{
> +	int mmu_reset_needed = 0;
> +	bool valid_pdptrs = sregs2->flags & KVM_SREGS2_FLAGS_PDPTRS_VALID;
> +	int i, ret;
>   
> +	if (sregs2->flags & ~KVM_SREGS2_FLAGS_PDPTRS_VALID)
> +		return -EINVAL;
> +
> +	ret = __set_sregs_common(vcpu, (struct kvm_sregs *)sregs2,
> +				 &mmu_reset_needed, !valid_pdptrs);
> +	if (ret)
> +		return ret;
> +
> +	if (valid_pdptrs) {
> +		if (!is_pae_paging(vcpu))
> +			return -EINVAL;
> +		if (vcpu->arch.guest_state_protected)
> +			return -EINVAL;
> +		for (i = 0 ; i < 4 ; i++)
> +			kvm_pdptr_write(vcpu, i, sregs2->pdptrs[i]);
> +
> +		kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
> +		mmu_reset_needed = 1;
> +	}
> +	if (mmu_reset_needed)
> +		kvm_mmu_reset_context(vcpu);
> +	return 0;
>   }

It's a bit nicer if the checks are done early:

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f20c7c06bd4a..c6f8fec78c53 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10248,22 +10248,23 @@ static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2)
  {
         int mmu_reset_needed = 0;
         bool valid_pdptrs = sregs2->flags & KVM_SREGS2_FLAGS_PDPTRS_VALID;
+       bool pae = (sregs2->cr0 & X86_CR0_PG) && (sregs2->cr4 & X86_CR4_PAE) &&
+               !(sregs2->efer & EFER_LMA);
         int i, ret;
  
         if (sregs2->flags & ~KVM_SREGS2_FLAGS_PDPTRS_VALID)
                 return -EINVAL;
  
+       if (valid_pdptrs && (!pae || vcpu->arch.guest_state_protected))
+               return -EINVAL;
+
         ret = __set_sregs_common(vcpu, (struct kvm_sregs *)sregs2,
                                  &mmu_reset_needed, !valid_pdptrs);
         if (ret)
                 return ret;
  
         if (valid_pdptrs) {
-               if (!is_pae_paging(vcpu))
-                       return -EINVAL;
-               if (vcpu->arch.guest_state_protected)
-                       return -EINVAL;
-               for (i = 0 ; i < 4 ; i++)
+               for (i = 0; i < 4 ; i++)
                         kvm_pdptr_write(vcpu, i, sregs2->pdptrs[i]);
  
                 kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);

Paolo

