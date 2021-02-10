Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BD5316D01
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhBJRkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:40:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232462AbhBJRkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612978723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ulIYs4vjX02SWt4rVxo1O7Hqi68QURFqQUhPnrYP8Yo=;
        b=LT3DY1B9zY5ihNTzlCQxbxgttFyUqQnLpk5CkUTS0fiEGDtJDLrH56W1NixsRd5oswMqIP
        zPRVWnfssoJ0eDN41e17soDP26BUHKXbeuJ7ecd7mxJJJu2tHLoSyKvpe460jg4y0Sz9jw
        vlzIxAm85pfs6Z69kXRNwPVqRl8hx7M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-8qdlWlLtO8u5TUO6_XoD_A-1; Wed, 10 Feb 2021 12:38:42 -0500
X-MC-Unique: 8qdlWlLtO8u5TUO6_XoD_A-1
Received: by mail-wr1-f71.google.com with SMTP id u15so2256275wrn.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ulIYs4vjX02SWt4rVxo1O7Hqi68QURFqQUhPnrYP8Yo=;
        b=Dqi+/D8knLWe6BRW98oQeuaYuJBbY8qFj7O83ph14nqjwNxOox3oE/Qp7Iudzsul9W
         jE54fKFCihXaqeaINFKa1yHR2V2nL72KxOGMe2MJ+4PlMfYWAbndIATCUpG8Uu0yM0zc
         UYuE/z4aH5Mvptj2s1DWyZ9BDQmmg9J8RjWUvWAvGN/pRN9xyL8azCkhqDtQ5zSESFgo
         Cg90U3e7JU093HduQ5lEvrVTvH3qkGvvtFQLKc9b5ZijpMJXEKFLhoLp7ydlnKLLHhZ/
         7Ira4FLGQrvtdTYV1yUfNerS2WOrxMZFc0qPJjy1XwCoxiKnt0urpdOcjuVh99Tr8pYq
         nxow==
X-Gm-Message-State: AOAM532b2vfDjTLRv38cbU7+240QsL4d0rW5GgvRcclYPgmg+nCzQrO9
        zalZpcLEB43hda5QuP5VPvJiu100LeAb1XYYBIz17nizDx8E4P56zgPCS88xFtWTY9Q3qIcRF75
        avOUIx8R/uBXZhfy2I3kUUrw6
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr4631958wru.178.1612978721161;
        Wed, 10 Feb 2021 09:38:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8JVANRHxS+2EHhZNuHVwfrl6kd0Bb3JcxGG2kluWZGGBJ6/u/SH7eyaNJgQBWAKclRo4CIA==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr4631940wru.178.1612978720923;
        Wed, 10 Feb 2021 09:38:40 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r17sm4171824wro.46.2021.02.10.09.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 09:38:38 -0800 (PST)
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20210210155937.141569-1-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: nSVM: call nested_svm_load_cr3 on nested state load
Message-ID: <9314afe0-7808-7877-0270-87f29a5f1191@redhat.com>
Date:   Wed, 10 Feb 2021 18:38:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210210155937.141569-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/21 16:59, Maxim Levitsky wrote:
> While KVM's MMU should be fully reset by loading of nested CR0/CR3/CR4
> by KVM_SET_SREGS, we are not in nested mode yet when we do it and therefore
> only root_mmu is reset.
> 
> On regular nested entries we call nested_svm_load_cr3 which both updates the
> guest's CR3 in the MMU when it is needed, and it also initializes
> the mmu again which makes it initialize the walk_mmu as well when nested
> paging is enabled in both host and guest.
> 
> Since we don't call nested_svm_load_cr3 on nested state load,
> the walk_mmu can be left uninitialized, which can lead to a NULL pointer
> dereference while accessing it if we happen to get a nested page fault
> right after entering the nested guest first time after the migration and
> we decide to emulate it, which leads to emulator trying to access
> walk_mmu->gva_to_gpa which is NULL.
> 
> Therefore we should call this function on nested state load as well.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   arch/x86/kvm/svm/nested.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 519fe84f2100..c209f1232928 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1282,6 +1282,14 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
>   
>   	nested_vmcb02_prepare_control(svm);
>   
> +	ret = nested_svm_load_cr3(&svm->vcpu, vcpu->arch.cr3,
> +				  nested_npt_enabled(svm));
> +
> +	if (ret) {
> +		svm_leave_nested(svm);
> +		goto out_free;
> +	}
> +
>   	kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
>   	ret = 0;
>   out_free:
> 

I think you have to delay this to KVM_REQ_GET_NESTED_STATE_PAGES, 
because the !nested_npt case can be accessing memory before the VM is 
started (PDPTRs!).

In fact the same is true for VMX: this code

         /* Shadow page tables on either EPT or shadow page tables. */
         if (nested_vmx_load_cr3(vcpu, vmcs12->guest_cr3, 
nested_cpu_has_ept(vmcs12),
                                 entry_failure_code))
                 return -EINVAL;

must be moved from prepare_vmcs02 to both nested_vmx_enter_non_root_mode 
and nested_get_vmcs12_pages.

Thanks,

Paolo

