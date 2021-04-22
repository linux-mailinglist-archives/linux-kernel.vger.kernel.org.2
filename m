Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF1A367A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 08:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhDVGwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 02:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230316AbhDVGwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619074320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=srX3P7/j1Ug/AsNRwDkwCn+8YJjPvhxGiEWP6pFAMhU=;
        b=PMfPNIOqOxuUZcaJgvCBZ+H6Q0tQDL+kcJHEPZzJ1TTZXEQQmw0KutkdAjTOdI7l3m5rbA
        hJMVODPsKhFwLxEU2DKKVKBPlfvZEWioVek9YXlY6FDUnuJ8eay8GIc9t/CYQJEzUrhS0c
        Ms6pjnU8g3vW3GIt6xWD3GI1an5u46M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-yf_7ixLGMIqQ4u_DoVrN5A-1; Thu, 22 Apr 2021 02:51:58 -0400
X-MC-Unique: yf_7ixLGMIqQ4u_DoVrN5A-1
Received: by mail-ej1-f72.google.com with SMTP id d11-20020a170906370bb029037c87968c04so6848949ejc.17
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 23:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=srX3P7/j1Ug/AsNRwDkwCn+8YJjPvhxGiEWP6pFAMhU=;
        b=LdW/o+pYXqCLJ8L2eDW0m5ayLhttXhlXj306AQYFsHHqpuhSyZK5TIZtLKy4/dXS1x
         Kh9NlXvKUj37lzgxHDoF7gHsIDKJbYLaHkn5W3p0A8gZLERGUtxHj28t6lG+rEG929L4
         0DV+L1PrH3qguKbJRrTVSmwMdpfXgYPjRk8hs6RvP4a/tcYW7NkMXJ9gsgHZjZ3cNR2U
         F6bdsau9HzfOQyJKseQc9KMZLyUrvzh4Va9/QMSsu4un62moCgMa+cz0BXvzhxm5J+Yr
         Il75Sj9+PdFaimfliJDiJMmOxucTgYD27kogopIeAs2Ir+efWPtlPIMEQ51ZDadYa/sb
         XP4g==
X-Gm-Message-State: AOAM5336EBdwa5WuwQFa3xFWwzyLnks9GA5xwmQZKLucIKUFXkPfFY0y
        C/yZgeTrNkhyXhP1b9ohcLCs/K/Pl3EisrWLPKp1o9aMuKwTpclKPYBuZoRcCii5p6Vj8mR7Hl3
        QP+kwF2RggteiD6ZROm3+amVk
X-Received: by 2002:aa7:d541:: with SMTP id u1mr1899735edr.95.1619074316456;
        Wed, 21 Apr 2021 23:51:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyukGSxp6sRIjWFCtnKctYs0NzNqZO41qCrVqWZoH/w4RWbB+WlgB+1lrE6MWowoiPY7KTKqw==
X-Received: by 2002:aa7:d541:: with SMTP id u1mr1899728edr.95.1619074316248;
        Wed, 21 Apr 2021 23:51:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r17sm1191531edt.70.2021.04.21.23.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 23:51:55 -0700 (PDT)
Subject: Re: [PATCH v2 2/9] KVM: x86: Check CR3 GPA for validity regardless of
 vCPU mode
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Babu Moger <babu.moger@amd.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
References: <20210422022128.3464144-1-seanjc@google.com>
 <20210422022128.3464144-3-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8716951d-cddb-d5f9-e7e2-b651120a51e7@redhat.com>
Date:   Thu, 22 Apr 2021 08:51:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210422022128.3464144-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 04:21, Sean Christopherson wrote:
> Check CR3 for an invalid GPA even if the vCPU isn't in long mode.  For
> bigger emulation flows, notably RSM, the vCPU mode may not be accurate
> if CR0/CR4 are loaded after CR3.  For MOV CR3 and similar flows, the
> caller is responsible for truncating the value.
> 
> Note, SMRAM.CR3 is read-only, so this is mostly a theoretical bug since
> KVM will not have stored an illegal CR3 into SMRAM during SMI emulation.

Well, the guest could have changed it...

Paolo

> Fixes: 660a5d517aaa ("KVM: x86: save/load state on SMM switch")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/x86.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c9ba6f2d9bcd..63af93211871 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1078,10 +1078,15 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
>   		return 0;
>   	}
>   
> -	if (is_long_mode(vcpu) && kvm_vcpu_is_illegal_gpa(vcpu, cr3))
> +	/*
> +	 * Do not condition the GPA check on long mode, this helper is used to
> +	 * stuff CR3, e.g. for RSM emulation, and there is no guarantee that
> +	 * the current vCPU mode is accurate.
> +	 */
> +	if (kvm_vcpu_is_illegal_gpa(vcpu, cr3))
>   		return 1;
> -	else if (is_pae_paging(vcpu) &&
> -		 !load_pdptrs(vcpu, vcpu->arch.walk_mmu, cr3))
> +
> +	if (is_pae_paging(vcpu) && !load_pdptrs(vcpu, vcpu->arch.walk_mmu, cr3))
>   		return 1;
>   
>   	kvm_mmu_new_pgd(vcpu, cr3, skip_tlb_flush, skip_tlb_flush);
> 

