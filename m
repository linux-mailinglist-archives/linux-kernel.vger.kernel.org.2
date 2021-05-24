Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCE238E71F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhEXNJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46966 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232401AbhEXNJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621861674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GFpr7xpqlW6Vj08Ml2AtSZzFh7rEP3/yndl6gqUkb8A=;
        b=IY+LBjT3VKoV54sxqO8SRnWktj+pal7uItDY9vFGYliqfesFx2S20bYTZgPY6uk8Uwsf1+
        pHxpiRS64jhCeUdcgbraprSBh6HMijEpO/8mra3+Upoph21zwSQ/7c51WXuc45MT9tAXwA
        f5Ol3TEqw0G6cEHYaWTfDsAkqpibF34=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-d580W9bHNK6W1--cshTESg-1; Mon, 24 May 2021 09:07:52 -0400
X-MC-Unique: d580W9bHNK6W1--cshTESg-1
Received: by mail-wm1-f71.google.com with SMTP id g9-20020a1c39090000b029017545f2da89so3848736wma.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GFpr7xpqlW6Vj08Ml2AtSZzFh7rEP3/yndl6gqUkb8A=;
        b=AqIITeUA8CbVnpLa/18APTYnV+RnJ1n4uPGldsUhXiX/Lf7e2cdTjie7pz+lxH7yYW
         nZWy8QpwO9Bdith2++bk4EoP9j+dAW1tyP+8wh9N7GzvJFDD1l3h6rMp9mywvlB+rfYU
         Hi2nAGa6wjZIiTxQNhSzSN6sP1FDMsnt37AMiBGM5Ve65jV4l3/VS0WHSLJ642sh4zF5
         dXji/3bzE20oRsW+jo67hyir6DP4t1FAY0WlOr0XMpPG+R5RkWZga+K4XpruNcEthaUK
         SY2TphUgdLMuQm8yStJQvxKfJo6drPhS4rblK9eD3rbSD7FghyrLwRQghWFGtfAtEAQU
         tDRw==
X-Gm-Message-State: AOAM531kPQYLjzyJHHDNLhzMoRvJY8DnVN07l3rYvjr8Jo42kQIDeBsH
        QcmmMhco7KDf/sfq6CazZSB+y9sX/mZ9H1rRL2cLYn1RntEh7fKA/6whTKSk7GVNBMdE05bkvRd
        WSSuhBO37yOCVrzlz4FuVkys+7BeLrubIg3GD9XjCTLk0mzgzMrSBNLMNbyIgRPO4pK+vdHvuec
        lR
X-Received: by 2002:a5d:6701:: with SMTP id o1mr22721394wru.390.1621861671478;
        Mon, 24 May 2021 06:07:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiR36upgs9APJiWLdBravwbSYUku/sbb6wEKZBtV+gm8ln3jYbIHMOGn1qHgboPHAYeCFu8Q==
X-Received: by 2002:a5d:6701:: with SMTP id o1mr22721364wru.390.1621861671241;
        Mon, 24 May 2021 06:07:51 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p10sm11501879wrr.58.2021.05.24.06.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 06:07:50 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] KVM: nVMX: Reset eVMCS clean fields data from
 prepare_vmcs02()
In-Reply-To: <2abf028db2a77c940d89618d66c4e6cbc3347bc4.camel@redhat.com>
References: <20210517135054.1914802-1-vkuznets@redhat.com>
 <20210517135054.1914802-6-vkuznets@redhat.com>
 <2abf028db2a77c940d89618d66c4e6cbc3347bc4.camel@redhat.com>
Date:   Mon, 24 May 2021 15:07:49 +0200
Message-ID: <87wnro5lga.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Mon, 2021-05-17 at 15:50 +0200, Vitaly Kuznetsov wrote:
>> When nested state migration happens during L1's execution, it
>> is incorrect to modify eVMCS as it is L1 who 'owns' it at the moment.
>> At lease genuine Hyper-v seems to not be very happy when 'clean fields'
>> data changes underneath it.
>> 
>> 'Clean fields' data is used in KVM twice: by copy_enlightened_to_vmcs12()
>> and prepare_vmcs02_rare() so we can reset it from prepare_vmcs02() instead.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/vmx/nested.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>> index eb2d25a93356..3bfbf991bf45 100644
>> --- a/arch/x86/kvm/vmx/nested.c
>> +++ b/arch/x86/kvm/vmx/nested.c
>> @@ -2081,14 +2081,10 @@ void nested_sync_vmcs12_to_shadow(struct kvm_vcpu *vcpu)
>>  {
>>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>>  
>> -	if (vmx->nested.hv_evmcs) {
>> +	if (vmx->nested.hv_evmcs)
>>  		copy_vmcs12_to_enlightened(vmx);
>> -		/* All fields are clean */
>> -		vmx->nested.hv_evmcs->hv_clean_fields |=
>> -			HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
>> -	} else {
>> +	else
>>  		copy_vmcs12_to_shadow(vmx);
>> -	}
>>  
>>  	vmx->nested.need_vmcs12_to_shadow_sync = false;
>>  }
>> @@ -2629,6 +2625,12 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>>  
>>  	kvm_rsp_write(vcpu, vmcs12->guest_rsp);
>>  	kvm_rip_write(vcpu, vmcs12->guest_rip);
>> +
>> +	/* Mark all fields as clean so L1 hypervisor can set what's dirty */
>> +	if (hv_evmcs)
>> +		vmx->nested.hv_evmcs->hv_clean_fields |=
>> +			HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
>> +
>>  	return 0;
>>  }
>> 
>
> Hi!
>  
> If we avoid calling copy_enlightened_to_vmcs12 from 
> vmx_get_nested_state, then we don't need this patch, right?
>  

Right.

> In addition to that I think that we need to research on why 
> do we need to touch these clean bits, as from the spec, and
> assuming that the clean bits should behave similar to how AMD
> does it, clean bits should only be set by the L1 and never touched by
> us.
>  
> We currently set clean bits in two places:
>  
> 1. nested_vmx_handle_enlightened_vmptrld with vmlaunch, where it seems
> like it is a workaround for a case (as we discussed on IRC) where
> L1 keeps more than one active evmcs on a same vcpu, and 'vmresume's
> them. Since we don't support this and have to do full context switch
> when we switch a vmcs, we reset the clean bits so that evmcs is loaded
> fully.
> Also we reset the clean bits when a evmcs is 'vmlaunched' which
> is also something we need to check if needed, and if needed
> we probably should document that this is because of a bug in Hyper-V,
> as it really should initialize these bits in this case.
>  
> I think that we should just ignore the clean bits in those cases
> instead of resetting them in the evmcs.
>  
>  
> 2. In nested_sync_vmcs12_to_shadow which in practise is done only
> on nested vmexits, when we updated the vmcs12 and need to update evmcs.
> In this case you told me that Hyper-V has a bug that it expects
> the clean bits to be cleaned by us and doesn't clean it on its own.
> This makes sense although it is not documented in the Hyper-V spec,
> and I would appreciate if we were to document this explicitly in the code.

My memory is really foggy but I put 'hv_clean_fields' cleaning to KVM
because I discovered that Hyper-V doesn't do that: with every exit we
get more and more 'dirty' stuff which wasn't touched. It would probably
make sense to repeat the experiment. I'll put this to my backlog, thanks
for the feedback!

-- 
Vitaly

