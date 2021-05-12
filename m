Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F36E37B6C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhELHUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229627AbhELHUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620803986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K+VHnoXmzL0V36eoMMI4uRNuUvcDK3sLNlx3DJAoh68=;
        b=d7N2jeqK/vaByb+9oEZfa0saT8J1OYEQPiMEq9UXVh5DzdKDJRnCT46VonvyPf8WzV695B
        MVAzmXnyYb0wyu+C6D8iWVefr44iDI1G05R61W9uBpTQuN599Z7K95n2Qwmzbf7ygwnO/7
        uhNmPK5ROylzjAADxaS9iqUamWb1r7o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-I7MsvZItN5-tbz8a020a2g-1; Wed, 12 May 2021 03:19:43 -0400
X-MC-Unique: I7MsvZItN5-tbz8a020a2g-1
Received: by mail-wm1-f71.google.com with SMTP id u126-20020a1c60840000b029013f6df1cd5bso2703825wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 00:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=K+VHnoXmzL0V36eoMMI4uRNuUvcDK3sLNlx3DJAoh68=;
        b=bSGQNvM5TJCoyUs61xsySlg/ot9sbgmTQ4p8z3SRgyAnfjdvAs4sWXbo61/6x3fJRU
         wvV7l8ignoT18HwckE6qyd271uF5NZsCLWEF4blRxj24Y5ZWa4tIbHieUkgS1Jw3m9Se
         F0OWQ6W71P4zJkXDr/b9kpxUblj7Y4ujMLqnEoY9i5/QPowCnuCa4DzlkrShjvevSBuc
         oLSTN15UpwS9T2fuvr//dQTSRZzuP6THrdFfU1ADkGzIUOWDHcs95OkcGVqk/yfHQzJz
         myDOb5azVHrp/C0aqyMwe4tN8jhHj+lEXpXyVWYpBXhHX+0iE6ao5hS1mVkMOoL17IGb
         qeIw==
X-Gm-Message-State: AOAM533t7kxfjG01xGf9NraiAcU4EJxdal6GSweBb1jbG5I6AzzO3grb
        fp8YiFsL0I2zdM99AIcsX8OgV9GM4Gn0+ZoWIzdKES9Gb3sKHd7UhZimjVx3mTUwUOd20/GYs6h
        5Wus4Kv2vkGNN1lNxeu0/37gx
X-Received: by 2002:a1c:4cc:: with SMTP id 195mr3078062wme.175.1620803982214;
        Wed, 12 May 2021 00:19:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxY/o0g2hhuZvqaLWNsiHYVNGcmjq+++Iud184YRTrOS4kfvVHYDQbthz0S+m81ofMn6KIPyw==
X-Received: by 2002:a1c:4cc:: with SMTP id 195mr3078050wme.175.1620803982073;
        Wed, 12 May 2021 00:19:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b7sm29710099wri.83.2021.05.12.00.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:19:41 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 5/7] KVM: nVMX: Reset eVMCS clean fields data from
 prepare_vmcs02()
In-Reply-To: <YJqxmJg0HajlfDa/@google.com>
References: <20210511111956.1555830-1-vkuznets@redhat.com>
 <20210511111956.1555830-6-vkuznets@redhat.com>
 <YJqxmJg0HajlfDa/@google.com>
Date:   Wed, 12 May 2021 09:19:40 +0200
Message-ID: <87bl9gwh9v.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, May 11, 2021, Vitaly Kuznetsov wrote:
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
>>  arch/x86/kvm/vmx/nested.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>> index 3257a2291693..1661e2e19560 100644
>> --- a/arch/x86/kvm/vmx/nested.c
>> +++ b/arch/x86/kvm/vmx/nested.c
>> @@ -2090,9 +2090,6 @@ void nested_sync_vmcs12_to_shadow(struct kvm_vcpu *vcpu)
>>  
>>  	if (vmx->nested.hv_evmcs) {
>>  		copy_vmcs12_to_enlightened(vmx);
>> -		/* All fields are clean */
>> -		vmx->nested.hv_evmcs->hv_clean_fields |=
>> -			HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
>>  	} else {
>>  		copy_vmcs12_to_shadow(vmx);
>>  	}
>
> Looks like this makes both paths single lines, i.e. the curly braces can be
> dropped.
>

Yea, I've noticed that but I wasn't exactly sure the benefit of removing
one line here overwhelms the pain of needing an extra step while doing
code archeology with 'git blame' :-) Will drop on v2.

>> @@ -2636,6 +2633,12 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
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
>> -- 
>> 2.30.2
>> 
>

-- 
Vitaly

