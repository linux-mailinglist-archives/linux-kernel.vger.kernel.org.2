Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34523BBCAB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 14:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhGEMLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 08:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231193AbhGEMLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 08:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625486919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6IUe1pqjsnl6h6pzE1hlYlvrWwd2ZiBLis3OO/uItM=;
        b=hAx+Mo6IvFXL0zsoWEp0fSNiIh/1dMRunXkt5CYddc0E/DEXsRlqm1rUKuI3LD5ytFRfGW
        6BbyZyBnXFruEdWz5sfZ3ncaHKPOvFPX/iby7aJyK2s2tKC0drTSlaJ4rBcG5j1ZpiubPo
        in1gn4BUfqyFM9mWZabZlid21uLJK+U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-_4H-CkY5M42cFBUKDXq7tA-1; Mon, 05 Jul 2021 08:08:38 -0400
X-MC-Unique: _4H-CkY5M42cFBUKDXq7tA-1
Received: by mail-wr1-f72.google.com with SMTP id h104-20020adf90710000b029010de8455a3aso6122418wrh.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 05:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H6IUe1pqjsnl6h6pzE1hlYlvrWwd2ZiBLis3OO/uItM=;
        b=LHQENnrxFNt4WebQETNLOOZ/5Kt+mSOzUTFfVgdJS4ClJ083hbG83FRuXpzmb9sJ9Q
         znDL/BGeIaZ5xWvxi3oSyTk64vbjJ0QCU5B1gbfFmQeRVxSjFpfZEEGYyEVl2M6ewHIM
         H7fXNLFpmLr/VcO35uuOrRSol7f3LgcfYqHGBilIenjVKuduL4Rhgonmn7KZOt0RmAPj
         98jsGybUs/CHNNTQN59PGbF4Eioqx1bTC5Uk49wQiK7XTTv66RTQEWHuaMVdbiYlCX6L
         ia7iUu43U4TlywSOTQHiiAZ9S8F5ckBVh6VzXa2WvX13IUvj/l+UxrgDO6TgkuDJfKqN
         bXSA==
X-Gm-Message-State: AOAM531NNM0VO0chLTKlVH4nBFMSpvPWWQC9nRDXiZ3HfwnUHs2/T9V2
        tnGB8sftXDiy8yz9fd+ZI/2UMDvJKfUucfI1ThGYEDX6UM/MNP0cTrKgpU7ePvXoGyt0nrbjWZe
        9DlTsj4Qyw9e9zMdHYXZh6zEJWmJSTztCXNKUKqBb4bEoxYQjeCjvGmu/fre1lXkF8IgsKYVMuP
        I2
X-Received: by 2002:adf:d1e8:: with SMTP id g8mr15628192wrd.14.1625486917226;
        Mon, 05 Jul 2021 05:08:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJ9cZcFUKu+q/7/iHKb/ireWDtyt33kd7bofG6sYH2Jz7uCZA484Rro3+x4iN55SX+tAhAow==
X-Received: by 2002:adf:d1e8:: with SMTP id g8mr15628159wrd.14.1625486917033;
        Mon, 05 Jul 2021 05:08:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id j4sm13069372wra.1.2021.07.05.05.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 05:08:36 -0700 (PDT)
Subject: Re: [PATCH 3/6] KVM: nSVM: Introduce svm_copy_nonvmloadsave_state()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20210628104425.391276-1-vkuznets@redhat.com>
 <20210628104425.391276-4-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c79e83c-376f-0e60-f089-84eae7e91f49@redhat.com>
Date:   Mon, 5 Jul 2021 14:08:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628104425.391276-4-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/21 12:44, Vitaly Kuznetsov wrote:
> Separate the code setting non-VMLOAD-VMSAVE state from
> svm_set_nested_state() into its own function. This is going to be
> re-used from svm_enter_smm()/svm_leave_smm().
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   arch/x86/kvm/svm/nested.c | 36 +++++++++++++++++++++---------------
>   arch/x86/kvm/svm/svm.h    |  2 ++
>   2 files changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 1c6b0698b52e..a1dec2c40181 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -697,6 +697,26 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
>   	return ret;
>   }
>   
> +void svm_copy_nonvmloadsave_state(struct vmcb_save_area *from_save,
> +				  struct vmcb_save_area *to_save)

Probably best to name this svm_copy_vmrun_state and perhaps (as a 
cleanup) change nested_svm_vmloadsave to svm_copy_vmloadsave_state.

Paolo

> +{
> +	to_save->es = from_save->es;
> +	to_save->cs = from_save->cs;
> +	to_save->ss = from_save->ss;
> +	to_save->ds = from_save->ds;
> +	to_save->gdtr = from_save->gdtr;
> +	to_save->idtr = from_save->idtr;
> +	to_save->rflags = from_save->rflags | X86_EFLAGS_FIXED;
> +	to_save->efer = from_save->efer;
> +	to_save->cr0 = from_save->cr0;
> +	to_save->cr3 = from_save->cr3;
> +	to_save->cr4 = from_save->cr4;
> +	to_save->rax = from_save->rax;
> +	to_save->rsp = from_save->rsp;
> +	to_save->rip = from_save->rip;
> +	to_save->cpl = 0;
> +}
> +
>   void nested_svm_vmloadsave(struct vmcb *from_vmcb, struct vmcb *to_vmcb)
>   {
>   	to_vmcb->save.fs = from_vmcb->save.fs;
> @@ -1360,21 +1380,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
>   
>   	svm->nested.vmcb12_gpa = kvm_state->hdr.svm.vmcb_pa;
>   
> -	svm->vmcb01.ptr->save.es = save->es;
> -	svm->vmcb01.ptr->save.cs = save->cs;
> -	svm->vmcb01.ptr->save.ss = save->ss;
> -	svm->vmcb01.ptr->save.ds = save->ds;
> -	svm->vmcb01.ptr->save.gdtr = save->gdtr;
> -	svm->vmcb01.ptr->save.idtr = save->idtr;
> -	svm->vmcb01.ptr->save.rflags = save->rflags | X86_EFLAGS_FIXED;
> -	svm->vmcb01.ptr->save.efer = save->efer;
> -	svm->vmcb01.ptr->save.cr0 = save->cr0;
> -	svm->vmcb01.ptr->save.cr3 = save->cr3;
> -	svm->vmcb01.ptr->save.cr4 = save->cr4;
> -	svm->vmcb01.ptr->save.rax = save->rax;
> -	svm->vmcb01.ptr->save.rsp = save->rsp;
> -	svm->vmcb01.ptr->save.rip = save->rip;
> -	svm->vmcb01.ptr->save.cpl = 0;
> +	svm_copy_nonvmloadsave_state(save, &svm->vmcb01.ptr->save);
>   
>   	nested_load_control_from_vmcb12(svm, ctl);
>   
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index f89b623bb591..ff2dac2b23b6 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -463,6 +463,8 @@ void svm_leave_nested(struct vcpu_svm *svm);
>   void svm_free_nested(struct vcpu_svm *svm);
>   int svm_allocate_nested(struct vcpu_svm *svm);
>   int nested_svm_vmrun(struct kvm_vcpu *vcpu);
> +void svm_copy_nonvmloadsave_state(struct vmcb_save_area *from_save,
> +				  struct vmcb_save_area *to_save);
>   void nested_svm_vmloadsave(struct vmcb *from_vmcb, struct vmcb *to_vmcb);
>   int nested_svm_vmexit(struct vcpu_svm *svm);
>   
> 

