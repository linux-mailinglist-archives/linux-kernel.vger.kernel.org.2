Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243C73071A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhA1Ihu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:37:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231686AbhA1Ihl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611822974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nf0jnBmR9S7kgQakgFuMWWnzgzSE4QHvRdW36PL6dL8=;
        b=A2RrV93+HpUtkrWHL/7JqR1MXmF7QS01lfgek5Dcy7SAPJfLxXE7zD5fog83HqwVN9PVlm
        oCNC9Qpj2WT6YIgXSBctW1tdrhtHEfUuU7e//CvI8uHf1GKkotEcpZrNU3ONJSFapCAye8
        Ni2fu4jV9gZbNSLL8+gXiooJth09UJ4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-SrV_yv-sOaGv1HOC4dkSRA-1; Thu, 28 Jan 2021 03:36:12 -0500
X-MC-Unique: SrV_yv-sOaGv1HOC4dkSRA-1
Received: by mail-ed1-f71.google.com with SMTP id u19so2853931edr.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Nf0jnBmR9S7kgQakgFuMWWnzgzSE4QHvRdW36PL6dL8=;
        b=L2zt5RIQDhBaigITftInJJNgQ5nUzYE0xvH6tprYgXsV9riMJ1eipez6iY6EuTtTyt
         o0jHN1mhHNdzHWJhs71G5Qu2n6DBIOVKC+t48Ihk6HQzjyvjbgfrPfENN8WB7VzQP0TG
         WzPvubAg4oLfyTXzcUKIlPMHFefLGwTrbxE/XEhBNHk/Mb5wBw/I3vndebaKRc76BvPQ
         fOWC88O0joaR4FFndfMcJ6myMNILFExjAdr+qMDu+gq+AcvB1K/+dTyAXoCCMEN8+m3c
         VAxpnlePIefIHtoDLxJITE7VHUxw+w/oX0Wu2/8ix7HcEDcXErNLcnaTSr9Eta6dCFse
         B6sA==
X-Gm-Message-State: AOAM530BVP/vaMNzejJU0XIsmxevPn9YIIflmMj7bLVZwv43qYM9A8xx
        PFdgdNXTPau+jxzZCONE6sfwlXuKlBULnXO7wOkLmDAQhSUwcDNx830XqUCoqvlPkd7mkfboPoX
        rPPnhNx5gSuY+HoqnOnVZncM3
X-Received: by 2002:a05:6402:32c:: with SMTP id q12mr12910430edw.145.1611822971045;
        Thu, 28 Jan 2021 00:36:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWIui6+vrd5seJH5yGW9okKQwFC1Coh5JWb1vPz0BXTa+I+8gBtJNVZkGffRelSALyWXX+kw==
X-Received: by 2002:a05:6402:32c:: with SMTP id q12mr12910413edw.145.1611822970812;
        Thu, 28 Jan 2021 00:36:10 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m5sm1933153eja.11.2021.01.28.00.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 00:36:10 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Michael Roth <michael.roth@amd.com.com>
Subject: Re: [PATCH] KVM: x86: fix CPUID entries returned by KVM_GET_CPUID2
 ioctl
In-Reply-To: <20210128024451.1816770-1-michael.roth@amd.com>
References: <20210128024451.1816770-1-michael.roth@amd.com>
Date:   Thu, 28 Jan 2021 09:36:09 +0100
Message-ID: <87a6st31c6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Roth <michael.roth@amd.com> writes:

> Recent commit 255cbecfe0 modified struct kvm_vcpu_arch to make
> 'cpuid_entries' a pointer to an array of kvm_cpuid_entry2 entries
> rather than embedding the array in the struct. KVM_SET_CPUID and
> KVM_SET_CPUID2 were updated accordingly, but KVM_GET_CPUID2 was missed.
>
> As a result, KVM_GET_CPUID2 currently returns random fields from struct
> kvm_vcpu_arch to userspace rather than the expected CPUID values. Fix
> this by treating 'cpuid_entries' as a pointer when copying its
> contents to userspace buffer.
>
> Fixes: 255cbecfe0c9 ("KVM: x86: allocate vcpu->arch.cpuid_entries dynamically")
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com.com>
> ---
>  arch/x86/kvm/cpuid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 13036cf0b912..38172ca627d3 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -321,7 +321,7 @@ int kvm_vcpu_ioctl_get_cpuid2(struct kvm_vcpu *vcpu,
>  	if (cpuid->nent < vcpu->arch.cpuid_nent)
>  		goto out;
>  	r = -EFAULT;
> -	if (copy_to_user(entries, &vcpu->arch.cpuid_entries,
> +	if (copy_to_user(entries, vcpu->arch.cpuid_entries,
>  			 vcpu->arch.cpuid_nent * sizeof(struct kvm_cpuid_entry2)))
>  		goto out;
>  	return 0;

This is embarrassing but I have a (possible) excuse: copy_to_user's
argument is 'void *' so no warning was produced. Surprisingly, no test
caught the breakage. Thanks for debugging and fixing!

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

