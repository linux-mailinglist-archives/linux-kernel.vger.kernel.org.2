Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324EF30EE49
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbhBDI02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:26:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231767AbhBDI00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612427100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Agalob5eH11KcCncI5ANijYagbVsZf9dz5lRtY7dI2Y=;
        b=S7Tvpps98jw+G0uLDqfUbc5wz3oF+LCbBoak2PnZvhndvfTuXLa4kEzExVOj7oMhpu6tKw
        wzjAS3FbXJ50Ir0xufFCszvHko7zkV6uNuT34v2bL/MKlrfvlSwamkaxY7aYROXq/QY9Xd
        cCNEiVj5+m5gW7fzeCEVOikYA4PZJvk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-rMfLuVO9OMulMBUfHL8iGQ-1; Thu, 04 Feb 2021 03:24:58 -0500
X-MC-Unique: rMfLuVO9OMulMBUfHL8iGQ-1
Received: by mail-ed1-f72.google.com with SMTP id b1so2229454edt.22
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 00:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Agalob5eH11KcCncI5ANijYagbVsZf9dz5lRtY7dI2Y=;
        b=DlJFLMcaABO62tWoa5/NWNDG+aGIjgrlgruhR+1DJwveK70idwnSEIgISiOGFx19ta
         FER9NVYQap6Op0fYdmBhInwCrPRe3s+ijQo6v+g4UNYcXOjU+YSM2AmWSB1OPuIol0nV
         SvcyanRITv/r0JJMoMHhhpwM+KVAJ44U8QjVD9GnjMGvf/6P6Q3gzU0KdYHbXXT+pJDA
         DOmosqFDs5Nzo4KoBLBLS5l4nyl2sX3xJbetJ7EMdYr1Grvnsvuj5rfyeF3MWlcuvFb6
         OTlyXj/f0UZKfuM4dt/0i0Hu9GlfbVphaosPdhf9DiUNvlHWfAMzTGItUZoHPeXs6EEe
         5EJA==
X-Gm-Message-State: AOAM531PpYS7O1OytQL3Bu6IDmqM/1OOfZ/vNCOG6tio15LfhqFL+8sc
        7XhTMFK9HfX9yUTQZgpsef1WEfmAxefbu7ApJOXebOa3wfAlZukZ8ual6+WNTF2O/bN04dCcIXs
        sge/HpRDIGW5/kr+n7XpO6wbE
X-Received: by 2002:a17:906:2583:: with SMTP id m3mr6857473ejb.499.1612427097593;
        Thu, 04 Feb 2021 00:24:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkBsKd0x1+29QtLLCUtiLfJ0rT3W7EMCqt70rGR6r6kWVYSj6J+x9/P+2cL4zFLhIyoC3J/w==
X-Received: by 2002:a17:906:2583:: with SMTP id m3mr6857462ejb.499.1612427097363;
        Thu, 04 Feb 2021 00:24:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x25sm1776375ejc.33.2021.02.04.00.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 00:24:56 -0800 (PST)
Subject: Re: [PATCH v15 04/14] KVM: x86: Add #CP support in guest exception
 dispatch
To:     Sean Christopherson <seanjc@google.com>,
        Yang Weijiang <weijiang.yang@intel.com>
Cc:     jmattson@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, yu.c.zhang@linux.intel.com
References: <20210203113421.5759-1-weijiang.yang@intel.com>
 <20210203113421.5759-5-weijiang.yang@intel.com> <YBsZwvwhshw+s7yQ@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5b822165-9eff-bfa9-000f-ae51add59320@redhat.com>
Date:   Thu, 4 Feb 2021 09:24:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBsZwvwhshw+s7yQ@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 22:46, Sean Christopherson wrote:
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index dbca1687ae8e..0b6dab6915a3 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2811,7 +2811,7 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
>                 /* VM-entry interruption-info field: deliver error code */
>                 should_have_error_code =
>                         intr_type == INTR_TYPE_HARD_EXCEPTION && prot_mode &&
> -                       x86_exception_has_error_code(vector);
> +                       x86_exception_has_error_code(vcpu, vector);
>                 if (CC(has_error_code != should_have_error_code))
>                         return -EINVAL;
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 28fea7ff7a86..0288d6a364bd 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -437,17 +437,20 @@ EXPORT_SYMBOL_GPL(kvm_spurious_fault);
>  #define EXCPT_CONTRIBUTORY     1
>  #define EXCPT_PF               2
> 
> -static int exception_class(int vector)
> +static int exception_class(struct kvm_vcpu *vcpu, int vector)
>  {
>         switch (vector) {
>         case PF_VECTOR:
>                 return EXCPT_PF;
> +       case CP_VECTOR:
> +               if (vcpu->arch.cr4_guest_rsvd_bits & X86_CR4_CET)
> +                       return EXCPT_BENIGN;
> +               return EXCPT_CONTRIBUTORY;
>         case DE_VECTOR:
>         case TS_VECTOR:
>         case NP_VECTOR:
>         case SS_VECTOR:
>         case GP_VECTOR:
> -       case CP_VECTOR:
>                 return EXCPT_CONTRIBUTORY;
>         default:
>                 break;
> @@ -588,8 +591,8 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
>                 kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
>                 return;
>         }
> -       class1 = exception_class(prev_nr);
> -       class2 = exception_class(nr);
> +       class1 = exception_class(vcpu, prev_nr);
> +       class2 = exception_class(vcpu, nr);
>         if ((class1 == EXCPT_CONTRIBUTORY && class2 == EXCPT_CONTRIBUTORY)
>                 || (class1 == EXCPT_PF && class2 != EXCPT_BENIGN)) {
>                 /*
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index a14da36a30ed..dce756ffb577 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -120,12 +120,16 @@ static inline bool is_la57_mode(struct kvm_vcpu *vcpu)
>  #endif
>  }
> 
> -static inline bool x86_exception_has_error_code(unsigned int vector)
> +static inline bool x86_exception_has_error_code(struct kvm_vcpu *vcpu,
> +                                               unsigned int vector)
>  {
>         static u32 exception_has_error_code = BIT(DF_VECTOR) | BIT(TS_VECTOR) |
>                         BIT(NP_VECTOR) | BIT(SS_VECTOR) | BIT(GP_VECTOR) |
>                         BIT(PF_VECTOR) | BIT(AC_VECTOR) | BIT(CP_VECTOR);
> 
> +       if (vector == CP_VECTOR && (vcpu->arch.cr4_guest_rsvd_bits & X86_CR4_CET))
> +               return false;
> +
>         return (1U << vector) & exception_has_error_code;
>  }
> 
> 
> 
> 

Squashed, thanks.  I made a small change to the last hunk:

         if (!((1U << vector) & exception_has_error_code))
                 return false;

         if (vector == CP_VECTOR)
                 return !(vcpu->arch.cr4_guest_rsvd_bits & X86_CR4_CET);

         return true;

