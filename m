Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1247324E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 11:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhBYKiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 05:38:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45742 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233797AbhBYKQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 05:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614248125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MXujrRAJUsdt7pmUSQ6eDC3ZVL38WWSlzY8hkivUSCQ=;
        b=Kgt1VeMnQ3FnqiBxnsSNcCAvJDRwBLQOvBlc4xHZicCMuogPzXxdnOtpfFcjFeVN55YK48
        b9rE0TVXBelmVsZ8nh2F3Cy5ICrpDpuooVzyUVB9j75iDHVk5ZQMl9fKUcXnbJ46EZvp0P
        gSrhkHrtZAfFSpjWVNuOR8A3GJlB31A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-7Ds2dMGFNuuSCfG5ptY4lA-1; Thu, 25 Feb 2021 05:15:23 -0500
X-MC-Unique: 7Ds2dMGFNuuSCfG5ptY4lA-1
Received: by mail-ed1-f72.google.com with SMTP id u1so287191edt.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 02:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MXujrRAJUsdt7pmUSQ6eDC3ZVL38WWSlzY8hkivUSCQ=;
        b=E2CIzgXth39vM/rFbktHeEETKoV5m2B4Lix7PzEVlWoM2fq0kngK9y3g0ovpukEWXZ
         LlBP56zlerEr00SRpOrlvXoGMLFS1d8yy/962z30E6oK1uvjNkI7n1nmnD/CXtPVcytf
         ZsgJx91wbh4PbvVBlclx/8Wukws5yZquTXNCS012g56EPaPPzoPcKRhfWFwQ129gv543
         FabGu2mBrf6Jscz99BM6dmWAlWU38QmQXCskKrraitLfNJv/Sgma1QWBde3HkW5oMfjb
         fYyRTzTc327IXbW0T1EivFZjsYUQW+ZoiL+Y1w9lQWztzsn3sJzNkq2C6okYa+VAR+5W
         x7NA==
X-Gm-Message-State: AOAM5312dNj8qOTBIoUGRLGHb+RZqa7AoMa+qmjnC5cooGe1wV9+Mstk
        FaRt43NsbygDDzQBFo5FJnv2KNiwuqx9eVpdj+mskeLlzA+eum9dLySBXn0YuD10rnNAntBUAkl
        KBAFEwR4J8Ay5c531+QOadKPP2nRv8GwS91sfPpre0Tzse1c/nMhls2lZ4TgSFXkFpKofsgGEAd
        s5
X-Received: by 2002:aa7:d416:: with SMTP id z22mr2058105edq.239.1614248122255;
        Thu, 25 Feb 2021 02:15:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0TIHDu679C70uKt6RpUNxITWbouvozeuVL51y0fVl2B4IaBlUl3kBP1Xe4ijNWM5MhvoMHg==
X-Received: by 2002:aa7:d416:: with SMTP id z22mr2058090edq.239.1614248122092;
        Thu, 25 Feb 2021 02:15:22 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c9sm3230863edt.6.2021.02.25.02.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 02:15:21 -0800 (PST)
Subject: Re: [PATCH] KVM: SVM: Fix nested VM-Exit on #GP interception handling
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210224005627.657028-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3cd45ce5-fde0-eda1-9797-66d7d5212bd9@redhat.com>
Date:   Thu, 25 Feb 2021 11:15:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210224005627.657028-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/21 01:56, Sean Christopherson wrote:
> Fix the interpreation of nested_svm_vmexit()'s return value when
> synthesizing a nested VM-Exit after intercepting an SVM instruction while
> L2 was running.  The helper returns '0' on success, whereas a return
> value of '0' in the exit handler path means "exit to userspace".  The
> incorrect return value causes KVM to exit to userspace without filling
> the run state, e.g. QEMU logs "KVM: unknown exit, hardware reason 0".
> 
> Fixes: 14c2bf81fcd2 ("KVM: SVM: Fix #GP handling for doubly-nested virtualization")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/svm/svm.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 14e41dddc7eb..c4f2f2f6b945 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2200,13 +2200,18 @@ static int emulate_svm_instr(struct kvm_vcpu *vcpu, int opcode)
>   		[SVM_INSTR_VMSAVE] = vmsave_interception,
>   	};
>   	struct vcpu_svm *svm = to_svm(vcpu);
> +	int ret;
>   
>   	if (is_guest_mode(vcpu)) {
>   		svm->vmcb->control.exit_code = guest_mode_exit_codes[opcode];
>   		svm->vmcb->control.exit_info_1 = 0;
>   		svm->vmcb->control.exit_info_2 = 0;
>   
> -		return nested_svm_vmexit(svm);
> +		/* Returns '1' or -errno on failure, '0' on success. */
> +		ret = nested_svm_vmexit(svm);
> +		if (ret)
> +			return ret;
> +		return 1;
>   	}
>   	return svm_instr_handlers[opcode](vcpu);
>   }
> 

Queued, thanks.

Paolo

