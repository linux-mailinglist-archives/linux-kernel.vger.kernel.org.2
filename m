Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C198E4016F0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbhIFHZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 03:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233050AbhIFHZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630913037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wf8KRCDP99l0Ftn5x2zHgfYJe6BFFbdxma/jTrXRbLU=;
        b=D2mAFF9k2duSUcY6aJ34UoIMQout2qhAIbD5S+8TRK4RD5Vdau2IxAsoO4CvpL/bmI1oOF
        Be/fH6NMKAhe04uo1ZA/Qv6+4uDLXziffrIvzpbothRXlGpBNuStOnGz9q3N2+7efN1y7/
        2r64YLNwCa9aScdldKKoEQYSl4Wa22A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-0wWyXA3gMbKcO-7tB4ED2A-1; Mon, 06 Sep 2021 03:23:55 -0400
X-MC-Unique: 0wWyXA3gMbKcO-7tB4ED2A-1
Received: by mail-wr1-f69.google.com with SMTP id p10-20020adfce0a000000b001572d05c970so907780wrn.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 00:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wf8KRCDP99l0Ftn5x2zHgfYJe6BFFbdxma/jTrXRbLU=;
        b=l3hw1UdBID3W56vR9BT+R7EJH+1lqa5srFDU2matrSmp1i7BepZ4YRfyRVNZcDXbTw
         OwWWPkHTcD2DFGrpUIwjEEbh3M8E6h6Lg1e0oWHSh4Q3mvg01Q/SvQNDr9IOPhJ5XaD+
         Th86vgjh14mIC0o31603QXa7EPWcnxM2YY2neJ13ANGDBGzuvxkENRxUiZdWDjBAOSkv
         CKX6jNWugQdZF2wZeBS/UzAXSpVn8AMDT4+EXoJe1AJDjRd8gaZ6JQmGz4quY0SMhZGE
         updGG/B5DYOX/A0JGR7y5y6mav+kDvdeieFcs/JTJfFk/UfiCiES3SRDW0s3b95U6zWO
         wt2w==
X-Gm-Message-State: AOAM533kF0c2HIPiO3CW6Q9XyawHZmY9HCgFKMJ6x5goRIEb6IKa2y/k
        wGmNGKzhJKe/VyHvxStiVm3mo4HgF/BfpQdLMh23c6eqo504NWD0BZNb/B34otvcRpiy6xtRsYl
        3srnB4nG7i/WgFHgWGXEg2rzgJM20sbbMF08+AL6mEsM/f3ocSLgxqKiY4IggmRPaALYkkqWEiH
        7f
X-Received: by 2002:adf:fb91:: with SMTP id a17mr11227368wrr.376.1630913034569;
        Mon, 06 Sep 2021 00:23:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdaR3Mh8cLUnR+nwZrbR2K1Bv76qt2OHscdhtOpNYxiADNGF0/XvoztVGTSICRDJ/6aJonwg==
X-Received: by 2002:adf:fb91:: with SMTP id a17mr11227346wrr.376.1630913034375;
        Mon, 06 Sep 2021 00:23:54 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o12sm6471190wmr.2.2021.09.06.00.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:23:53 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 8/8] KVM: Make kvm_make_vcpus_request_mask() use
 pre-allocated cpu_kick_mask
In-Reply-To: <YTJMvI1GE5Ux7eVE@google.com>
References: <20210903075141.403071-1-vkuznets@redhat.com>
 <20210903075141.403071-9-vkuznets@redhat.com>
 <YTJMvI1GE5Ux7eVE@google.com>
Date:   Mon, 06 Sep 2021 09:23:52 +0200
Message-ID: <87wnnu416f.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Sep 03, 2021, Vitaly Kuznetsov wrote:
>> kvm_make_vcpus_request_mask() already disables preemption so just like
>> kvm_make_all_cpus_request_except() it can be switched to using
>> pre-allocated per-cpu cpumasks. This allows for improvements for both
>> users of the function: in Hyper-V emulation code 'tlb_flush' can now be
>> dropped from 'struct kvm_vcpu_hv' and kvm_make_scan_ioapic_request_mask()
>> gets rid of dynamic allocation.
>> 
>> cpumask_available() checks in kvm_make_vcpu_request() and
>> kvm_kick_many_cpus() can now be dropped as they checks for an impossible
>> condition: kvm_init() makes sure per-cpu masks are allocated.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
>

Thanks!

>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index a4752dcc2a75..91c1e6c98b0f 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -9224,14 +9224,8 @@ static void process_smi(struct kvm_vcpu *vcpu)
>>  void kvm_make_scan_ioapic_request_mask(struct kvm *kvm,
>>  				       unsigned long *vcpu_bitmap)
>>  {
>> -	cpumask_var_t cpus;
>> -
>> -	zalloc_cpumask_var(&cpus, GFP_ATOMIC);
>> -
>>  	kvm_make_vcpus_request_mask(kvm, KVM_REQ_SCAN_IOAPIC,
>> -				    vcpu_bitmap, cpus);
>> -
>> -	free_cpumask_var(cpus);
>> +				    vcpu_bitmap);
>
> Nit, this can all go on a single line.
>

Sorry, you've mentioned this on v4 but I forgot. Hope this can be fixed
upon commit...

>>  }
>>  
>>  void kvm_make_scan_ioapic_request(struct kvm *kvm)
>

-- 
Vitaly

