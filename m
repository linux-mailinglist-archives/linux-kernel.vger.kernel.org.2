Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D9936AFF7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhDZIuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232078AbhDZIuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619426961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+hmNV/IZvupUHnll2PVZlj2hkS5F6Q9x72zJCUhsn3I=;
        b=Ifu8iIDINB3dG4EaZw8sYrOlokForwdtnxaNy+dQJ4Fk5hMR6zyxuWGZYJknovD47V1+1m
        /rI4gqPAHryy3NF15pBfPqtQfT28JRqXLCc6gP93+4sK7IFgXRFv7SEss5HT+0mIPNkoH5
        y3P4xKr+ietIj8bfpTz4bskg8tJ7Ae0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-rtU-eVzNOg6guOlvHqrueA-1; Mon, 26 Apr 2021 04:49:18 -0400
X-MC-Unique: rtU-eVzNOg6guOlvHqrueA-1
Received: by mail-ed1-f70.google.com with SMTP id bf25-20020a0564021a59b0290385169cebf8so15302939edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 01:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+hmNV/IZvupUHnll2PVZlj2hkS5F6Q9x72zJCUhsn3I=;
        b=tb3zj9dvcRVj1p77+Ok3QQtmYAjKezGNHmRxozs5Wl43aQBRG5Kppww5Cf9/OYxWGd
         +zH4uQEyvrz5YlQJ5LVD5M/7oEdj22UYFHS2qIGeHeyll1ax5ilnvQiEcGVF92evw5KR
         wlt+AFN9Z2yT0TFaXA2vxjBf2TpqynzTd3Wry2nMSMl6K09+2zbIE+NMCWYYlxnEUW+w
         Vk8HWJRUpN/c5YafmV96QIWddw9ieTte5OqVwQ4bx2zJMAH6sfT//mWMqlSSR76uxpgB
         mNZynMsyVnyYPzZiKnymfWb1OTsVMlGnWbmkYXdRBoOgBxngy9BFHeL8SYQqGCzf2CnY
         Lz6w==
X-Gm-Message-State: AOAM530I485oz+NlaC3ppyjQuJuy6a9FGBMfQjUcKLOXTNdKdaRt0YlK
        4RScGl/at1QIQ42RZbnzi3yOWbCSXdAfk82rsoJ/jKHdPOm7iPy437qotc9NNak2XPKWaGNo7rn
        L48uo9yHYXnwMyTKbAzkjmf6k
X-Received: by 2002:a17:906:3952:: with SMTP id g18mr17526722eje.104.1619426957430;
        Mon, 26 Apr 2021 01:49:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzELkyRim4QK/Bo4IrncIGNRy3SNheoBCmAkR33CDn1xefpGnrpKft5WPKQP0jLi48+Vmtseg==
X-Received: by 2002:a17:906:3952:: with SMTP id g18mr17526714eje.104.1619426957295;
        Mon, 26 Apr 2021 01:49:17 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id hc43sm11350506ejc.97.2021.04.26.01.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 01:49:16 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH v3 1/4] KVM: SVM: Inject #GP on guest MSR_TSC_AUX
 accesses if RDTSCP unsupported
In-Reply-To: <20210423223404.3860547-2-seanjc@google.com>
References: <20210423223404.3860547-1-seanjc@google.com>
 <20210423223404.3860547-2-seanjc@google.com>
Date:   Mon, 26 Apr 2021 10:49:15 +0200
Message-ID: <87mttlfn1w.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Inject #GP on guest accesses to MSR_TSC_AUX if RDTSCP is unsupported in
> the guest's CPUID model.
>
> Fixes: 46896c73c1a4 ("KVM: svm: add support for RDTSCP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/svm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index cd8c333ed2dc..9ed9c7bd7cfd 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2674,6 +2674,9 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_TSC_AUX:
>  		if (!boot_cpu_has(X86_FEATURE_RDTSCP))
>  			return 1;
> +		if (!msr_info->host_initiated &&
> +		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
> +			return 1;

Super-nit: a blank like before and after the condition would make this
consistent with the hunk you add to svm_set_msr() below.

>  		msr_info->data = svm->tsc_aux;
>  		break;
>  	/*
> @@ -2892,6 +2895,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  		if (!boot_cpu_has(X86_FEATURE_RDTSCP))
>  			return 1;
>  
> +		if (!msr->host_initiated &&
> +		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
> +			return 1;
> +
>  		/*
>  		 * This is rare, so we update the MSR here instead of using
>  		 * direct_access_msrs.  Doing that would require a rdmsr in

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

