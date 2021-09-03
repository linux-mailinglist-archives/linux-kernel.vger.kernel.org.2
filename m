Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBD33FFB04
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 09:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347887AbhICHVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 03:21:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24701 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234803AbhICHVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630653648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I8/c475Ts5fBIR2oCP1eGnpxl20tC/NN4uRiEu1Qkfg=;
        b=TXN5WN3ApmR3hz0DTO/IE8Q66qkwGMbfk90ppwrySTltXPfpGaIs6KubH+lMwFKcuRg0Vp
        pHT+/QsP35cRiq2rccjTPCTeZ5PyKbob+8oaGtMfgQ/NFPocAIXvLTxy4yeBQvluGT+/jR
        u7kCqa8VXB7LUkSaWB5GVLda1HRGW3A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-S6tRPtaOPGmvkjyjrZryIQ-1; Fri, 03 Sep 2021 03:20:47 -0400
X-MC-Unique: S6tRPtaOPGmvkjyjrZryIQ-1
Received: by mail-wm1-f69.google.com with SMTP id h1-20020a05600c350100b002e751bf6733so1635785wmq.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 00:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=I8/c475Ts5fBIR2oCP1eGnpxl20tC/NN4uRiEu1Qkfg=;
        b=J/JNl18ebRzg3qamRERbZPeI2oaWHxPjdeSjkwt/EYUuyYMXaTFxdG7cSY1x4crrMM
         hA0AIsrcQaGkXvAVNvPX13fHAY4J73YhOo8RlnDNr9nQQotrs+PSpgRHTc4EBVPenrOJ
         LepU4qc1LsCEBLnr+L6yOA7jBScyPotNpTjFrdEx9EpHHDvRpjXB4HIi7Tznt6AkADZU
         u4MCz56ThrvvMGIvv/b6SRxsyRyGNCrQPF6vayIGWf6D8j2qR2y9EsdHw7ZH9wxehaHd
         6SIseNFTTJRZxU8qBPNPUr33g6tOEMR1AL4ZmX5FoRufaMeTTidfyNMZkBdb9l9vC3yU
         pVQw==
X-Gm-Message-State: AOAM5323ROal250qwcuKKovfWE6NAI09qe3HSKdZH2JtJauqyzIZYool
        zAWJu9RSwAroyrhYrCCYXzof+babMJWp2NBDmkqhx4oSsEugBQRvH9vNb0H9/X/Gxtt1FPJg/rC
        IzuhXzE8x2ePtEiS7vcjAxOLZlqHXez0WS/q6CSwElGsBx4YVcmKzq2TZk4udYqS+Y2P3aBjXRP
        x/
X-Received: by 2002:a1c:4a:: with SMTP id 71mr6839683wma.87.1630653646231;
        Fri, 03 Sep 2021 00:20:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEofdzl+EnW4UZb0xe5+G5NBGxfT3AmBcnFgerxtF6/kNm2P4gaQxK/q7MERMN6QXk21cWBQ==
X-Received: by 2002:a1c:4a:: with SMTP id 71mr6839646wma.87.1630653645931;
        Fri, 03 Sep 2021 00:20:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m30sm1613869wrb.3.2021.09.03.00.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 00:20:45 -0700 (PDT)
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
Subject: Re: [PATCH v4 7/8] KVM: Pre-allocate cpumasks for
 kvm_make_all_cpus_request_except()
In-Reply-To: <YTE9OsXABLzUitUd@google.com>
References: <20210827092516.1027264-1-vkuznets@redhat.com>
 <20210827092516.1027264-8-vkuznets@redhat.com>
 <YTE9OsXABLzUitUd@google.com>
Date:   Fri, 03 Sep 2021 09:20:44 +0200
Message-ID: <87o89am8fn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Aug 27, 2021, Vitaly Kuznetsov wrote:
>> Allocating cpumask dynamically in zalloc_cpumask_var() is not ideal.
>> Allocation is somewhat slow and can (in theory and when CPUMASK_OFFSTACK)
>> fail. kvm_make_all_cpus_request_except() already disables preemption so
>> we can use pre-allocated per-cpu cpumasks instead.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  virt/kvm/kvm_main.c | 29 +++++++++++++++++++++++------
>>  1 file changed, 23 insertions(+), 6 deletions(-)
>> 
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 2e9927c4eb32..2f5fe4f54a51 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -155,6 +155,8 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm);
>>  static unsigned long long kvm_createvm_count;
>>  static unsigned long long kvm_active_vms;
>>  
>> +static DEFINE_PER_CPU(cpumask_var_t, cpu_kick_mask);
>> +
>>  __weak void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
>>  						   unsigned long start, unsigned long end)
>>  {
>> @@ -323,14 +325,15 @@ bool kvm_make_all_cpus_request_except(struct kvm *kvm, unsigned int req,
>>  				      struct kvm_vcpu *except)
>>  {
>>  	struct kvm_vcpu *vcpu;
>> -	cpumask_var_t cpus;
>> +	struct cpumask *cpus;
>>  	bool called;
>>  	int i, me;
>>  
>> -	zalloc_cpumask_var(&cpus, GFP_ATOMIC);
>> -
>>  	me = get_cpu();
>>  
>> +	cpus = this_cpu_cpumask_var_ptr(cpu_kick_mask);
>> +	cpumask_clear(cpus);
>> +
>>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>>  		if (vcpu == except)
>>  			continue;
>> @@ -340,7 +343,6 @@ bool kvm_make_all_cpus_request_except(struct kvm *kvm, unsigned int req,
>>  	called = kvm_kick_many_cpus(cpus, !!(req & KVM_REQUEST_WAIT));
>>  	put_cpu();
>>  
>> -	free_cpumask_var(cpus);
>>  	return called;
>>  }
>>  
>> @@ -5581,9 +5583,15 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
>>  		goto out_free_3;
>>  	}
>>  
>> +	for_each_possible_cpu(cpu) {
>> +		if (!alloc_cpumask_var_node(&per_cpu(cpu_kick_mask, cpu),
>> +					    GFP_KERNEL, cpu_to_node(cpu)))
>> +			goto out_free_4;
>
> 'r' needs to be explicitly set to -EFAULT, e.g. in the current code it's
> guaranteed to be 0 here.

Oops, yes. Any particular reason to avoid -ENOMEM? (hope not, will use
this in v5)

>
>> +	}
>> +
>>  	r = kvm_async_pf_init();
>>  	if (r)
>> -		goto out_free;
>> +		goto out_free_5;
>>  
>>  	kvm_chardev_ops.owner = module;
>>  	kvm_vm_fops.owner = module;
>> @@ -5609,7 +5617,11 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
>>  
>>  out_unreg:
>>  	kvm_async_pf_deinit();
>> -out_free:
>> +out_free_5:
>> +	for_each_possible_cpu(cpu) {
>
> Unnecessary braces.
>
>> +		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
>> +	}
>> +out_free_4:
>>  	kmem_cache_destroy(kvm_vcpu_cache);
>>  out_free_3:
>>  	unregister_reboot_notifier(&kvm_reboot_notifier);
>> @@ -5629,8 +5641,13 @@ EXPORT_SYMBOL_GPL(kvm_init);
>>  
>>  void kvm_exit(void)
>>  {
>> +	int cpu;
>> +
>>  	debugfs_remove_recursive(kvm_debugfs_dir);
>>  	misc_deregister(&kvm_dev);
>> +	for_each_possible_cpu(cpu) {
>
> Same here.
>
>> +		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
>> +	}
>>  	kmem_cache_destroy(kvm_vcpu_cache);
>>  	kvm_async_pf_deinit();
>>  	unregister_syscore_ops(&kvm_syscore_ops);
>> -- 
>> 2.31.1
>> 
>

-- 
Vitaly

