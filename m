Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419244019A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 12:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241839AbhIFKUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 06:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241838AbhIFKUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 06:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630923537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWpmDbcEbSm0Okke4LZTWt3w83gOvwYXRtRV7WcLiDs=;
        b=Fn/gQXVZRSBEYsCnqNcsqVl1pbi88Url713SYQNoH/u28JvMwLBmoYY+Wk31Sg6o0N8Dbj
        9XK1gB40O5TsCCn03rkRr0OlUwhFN7kM67znObg2wbEinOK1U81RWUwb7UTfdYSuiWxuIf
        tVZqQKVYIoR8rIK4Ol8bJeZcnbfcn8I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-EIrRp2OLOju6oSIpDEwTXA-1; Mon, 06 Sep 2021 06:18:54 -0400
X-MC-Unique: EIrRp2OLOju6oSIpDEwTXA-1
Received: by mail-ed1-f71.google.com with SMTP id ch11-20020a0564021bcb00b003c8021b61c4so3318021edb.23
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 03:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WWpmDbcEbSm0Okke4LZTWt3w83gOvwYXRtRV7WcLiDs=;
        b=OD0Vw7geowPs22hVw04d6g2WElpCnu+b4BrM02Nu4bp9+aD+UlWWTpl/4VmcqL/4iJ
         sMQSmtngXkwYXRmYz31rsCW2oItQIIvH7Jwnr4mwKd1/p37f7o7x5mlEUOJh8/Ch2MDu
         Gb74q6/0s17JROIL31PXP9RiH+er154RjNtAOe9NYRsWHDcbcjQJGI1GOlSOW9unLeyB
         QKaiV2hmChY/vKxlC1UYDDCnN7CKWRmIDG9pjCQ3gFwShNclXjzJiWUf4AGT1j/mZRhB
         Wh4hlrYA6i4JEJnpJ1jitrPkayrPlrmPKJuHA2C+4g+zBmCjJLuzsV42vnpAkuY+/bFL
         yEdg==
X-Gm-Message-State: AOAM5316XFWrseH6RcWLbYWS+/xu+SI9w+tOiO+RauYLRr/cp7CHJyZE
        iD1qQzpl+BTmNUNkJ8kL8oodDfOlA/aUaj4wUN5GkhfFZZmm63JMviMn3FuThmmy4wIx2/VPNJC
        9uZf4HeI6DjlodyrxnUTtpl4B
X-Received: by 2002:a17:906:d88:: with SMTP id m8mr13259109eji.250.1630923532876;
        Mon, 06 Sep 2021 03:18:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkzQfQmZPnjFcXGPe6wFvf5xEgz1GZoQB35c6h64SDOVYdSlvMUgDNwNPVjF3x7KtRlMvn4w==
X-Received: by 2002:a17:906:d88:: with SMTP id m8mr13259081eji.250.1630923532668;
        Mon, 06 Sep 2021 03:18:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p23sm4468657edw.94.2021.09.06.03.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 03:18:52 -0700 (PDT)
Subject: Re: [PATCH 1/3] Revert "KVM: x86: mmu: Add guest physical address
 check in translate_gpa()"
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+200c08e88ae818f849ce@syzkaller.appspotmail.com
References: <20210831164224.1119728-1-seanjc@google.com>
 <20210831164224.1119728-2-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3384c70c-f510-e95f-ea3b-520281d59a16@redhat.com>
Date:   Mon, 6 Sep 2021 12:18:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210831164224.1119728-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/21 18:42, Sean Christopherson wrote:
> Revert a misguided illegal GPA check when "translating" a non-nested GPA.
> The check is woefully incomplete as it does not fill in @exception as
> expected by all callers, which leads to KVM attempting to inject a bogus
> exception, potentially exposing kernel stack information in the process.
> 
>   WARNING: CPU: 0 PID: 8469 at arch/x86/kvm/x86.c:525 exception_type+0x98/0xb0 arch/x86/kvm/x86.c:525
>   CPU: 1 PID: 8469 Comm: syz-executor531 Not tainted 5.14.0-rc7-syzkaller #0
>   RIP: 0010:exception_type+0x98/0xb0 arch/x86/kvm/x86.c:525
>   Call Trace:
>    x86_emulate_instruction+0xef6/0x1460 arch/x86/kvm/x86.c:7853
>    kvm_mmu_page_fault+0x2f0/0x1810 arch/x86/kvm/mmu/mmu.c:5199
>    handle_ept_misconfig+0xdf/0x3e0 arch/x86/kvm/vmx/vmx.c:5336
>    __vmx_handle_exit arch/x86/kvm/vmx/vmx.c:6021 [inline]
>    vmx_handle_exit+0x336/0x1800 arch/x86/kvm/vmx/vmx.c:6038
>    vcpu_enter_guest+0x2a1c/0x4430 arch/x86/kvm/x86.c:9712
>    vcpu_run arch/x86/kvm/x86.c:9779 [inline]
>    kvm_arch_vcpu_ioctl_run+0x47d/0x1b20 arch/x86/kvm/x86.c:10010
>    kvm_vcpu_ioctl+0x49e/0xe50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3652
> 
> The bug has escaped notice because practically speaking the GPA check is
> useless.  The GPA check in question only comes into play when KVM is
> walking guest page tables (or "translating" CR3), and KVM already handles
> illegal GPA checks by setting reserved bits in rsvd_bits_mask for each
> PxE, or in the case of CR3 for loading PTDPTRs, manually checks for an
> illegal CR3.  This particular failure doesn't hit the existing reserved
> bits checks because syzbot sets guest.MAXPHYADDR=1, and IA32 architecture
> simply doesn't allow for such an absurd MAXPHADDR, e.g. 32-bit paging
> doesn't define any reserved PA bits checks, which KVM emulates by only
> incorporating the reserved PA bits into the "high" bits, i.e. bits 63:32.
> 
> Simply remove the bogus check.  There is zero meaningful value and no
> architectural justification for supporting guest.MAXPHYADDR < 32, and
> properly filling the exception would introduce non-trivial complexity.
> 
> This reverts commit ec7771ab471ba6a945350353617e2e3385d0e013.
> 
> Fixes: ec7771ab471b ("KVM: x86: mmu: Add guest physical address check in translate_gpa()")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+200c08e88ae818f849ce@syzkaller.appspotmail.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/mmu/mmu.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 4853c033e6ce..4b7908187d05 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -334,12 +334,6 @@ static bool check_mmio_spte(struct kvm_vcpu *vcpu, u64 spte)
>   static gpa_t translate_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u32 access,
>                                     struct x86_exception *exception)
>   {
> -	/* Check if guest physical address doesn't exceed guest maximum */
> -	if (kvm_vcpu_is_illegal_gpa(vcpu, gpa)) {
> -		exception->error_code |= PFERR_RSVD_MASK;
> -		return UNMAPPED_GVA;
> -	}
> -
>           return gpa;
>   }
>   
> 

Queued this one only, for now.  Thanks,

Paolo

