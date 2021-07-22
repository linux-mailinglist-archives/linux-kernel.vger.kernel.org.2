Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B133D2B01
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhGVQjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhGVQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:39:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F355C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 10:19:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p9so7140348pjl.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 10:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/3Yn5lGftevaZzFptJqzp7AFik0P8z+gOE4aOsnOdoI=;
        b=GAt81+CoV1RZ3kbS40olQxYkXRKHjw9dJtksmAc1gHtHUrzcOZp6iI7SF2bNxm28yk
         xk1dfU21iZbNpdMP2kDu2IShr/fL8wgNIA0idIDI3v9oCJc5g34bRcvQApg4hSEDKA9R
         N/WX9ERrbi9bZQmFtXQ5ANLvQn0DdPB6lfHvTfO1dQvNzNqQsKu+AIx1sP4XK5EfAVJi
         4J+CeD4pNY42EPReEReDWC6XqWJvTq1Z0NYAMyi94BesrR7hhQRTL9wYZDYnutxIH76m
         LMPDJxp/13zHN/W7f6Udoj0doWM+V0/M5wrvnJkEUTjahSLPO+JoBrGyCPE4VM2z/xde
         xdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/3Yn5lGftevaZzFptJqzp7AFik0P8z+gOE4aOsnOdoI=;
        b=MieLgKoWf+6Nq1X5Z1N4ggV/Py9DZV0TxYbkAxrYwWkQMQHEqu2nd8YysW5zlFaK9M
         WCLK7nOWfwspuuH4GmwSlPZzj7O7AoskjdOPBClrpMOx0Qh5ZvO5BC1gfI73hsSandL7
         YbktkqOEtEUTikYp8pp4wyAsyLgi9kRpiGo5TrzL8WCc2OmlOLJhoxmYuUu6//QZSDAB
         RQjf8nWt1impq+07pkh5jnpePhCeUcu64Y/9m704JrwDZ4zun/MTc80LmBpUZ/Ze6KRq
         vqnlYCigXESMqnfDZ5pNMElQKzZSwS+/WtREb7osHbvm8CiijL4VB9tHfgWExIRMMl9Z
         ESyA==
X-Gm-Message-State: AOAM533iptwCMzDVtqjGML/b69VuffEdAAvUIVpuBLVhQKK/MYBv03g7
        QD0r2B52Thl2XWGovtn70aID0A==
X-Google-Smtp-Source: ABdhPJzjKVMoAhpFwjzPcAUiY4cQADpfp1cv8osXVPebG3Yzibvqa7nPcInu/39qlg6bnXxuirch7A==
X-Received: by 2002:a17:902:8f95:b029:12b:7e4b:f191 with SMTP id z21-20020a1709028f95b029012b7e4bf191mr529478plo.63.1626974378943;
        Thu, 22 Jul 2021 10:19:38 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u190sm17954046pfb.95.2021.07.22.10.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 10:19:38 -0700 (PDT)
Date:   Thu, 22 Jul 2021 17:19:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Check the right feature bit for
 MSR_KVM_ASYNC_PF_ACK access
Message-ID: <YPmopoGY4hwuVHAp@google.com>
References: <20210722123018.260035-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722123018.260035-1-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021, Vitaly Kuznetsov wrote:
> MSR_KVM_ASYNC_PF_ACK MSR is part of interrupt based asynchronous page fault
> interface and not the original (deprecated) KVM_FEATURE_ASYNC_PF. This is
> stated in Documentation/virt/kvm/msr.rst.
> 
> Fixes: 66570e966dd9 ("kvm: x86: only provide PV features if enabled in guest's CPUID")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d715ae9f9108..88ff7a1af198 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3406,7 +3406,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			return 1;
>  		break;
>  	case MSR_KVM_ASYNC_PF_ACK:
> -		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF))
> +		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))

Do we want to require both, or do we want to let userspace be stupid?

>  			return 1;
>  		if (data & 0x1) {
>  			vcpu->arch.apf.pageready_pending = false;
> @@ -3745,7 +3745,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		msr_info->data = vcpu->arch.apf.msr_int_val;
>  		break;
>  	case MSR_KVM_ASYNC_PF_ACK:
> -		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF))
> +		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
>  			return 1;
>  
>  		msr_info->data = 0;
> -- 
> 2.31.1
> 
