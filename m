Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8FF40363C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350049AbhIHInJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34294 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348283AbhIHInF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631090515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hw7rjfopecKiPNs1gj6jXPb/jNV8mw5l8UNJZ/rvSQk=;
        b=dw2e9b0KXhXQkqRVexvy9ukFBVGCMd97chDLUmjRepulHS4AW0g7vImj2oujubIj5Od468
        68VkB6phlVYrlDPCKIm9VmkG6cWTQWSswNFrMn3hTrccso9BPHYfKOWlq+kTyub+J7UPEj
        E5SXQTs+BlQKScxVJRtSxNwH5B3an00=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-hvRtez6YO6ODSZbIxb-7kQ-1; Wed, 08 Sep 2021 04:41:54 -0400
X-MC-Unique: hvRtez6YO6ODSZbIxb-7kQ-1
Received: by mail-wr1-f69.google.com with SMTP id h15-20020adff18f000000b001574654fbc2so288481wro.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 01:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Hw7rjfopecKiPNs1gj6jXPb/jNV8mw5l8UNJZ/rvSQk=;
        b=oIiz9womUDzBb1yPfUNDJ3hOhDrocGdblCpoaCksZvW4WnFHdo4LFGOCnP65hjDYk9
         m0nDEPZehGEl/rzsVCQxqEyEujWYnYFWF1+OGP5lPDgCdGkSnonSjK1lrjAREiiTepQt
         nx39GhrkDCS2LQuCWkaJACJDb6q7u5OcOO/J56DjVJHlgoIELFPoz0Jyv+QPGbzqL3/5
         YUQ9mRc9Pco4P40q2APHp+YdlKOIcxjppJmmWicy6gFF1FFbMC4qc6wmKwiZ0lVr4Y7s
         oqe7i917F6YtZEXQ94+oPzkAEG/58RF3NE7SPUGDkGjxbRxaDmuW54PIfcIkDyQmIwke
         i4Bg==
X-Gm-Message-State: AOAM530v87IO4ZAUdwJiGaGMJjyl5jvCWYt8OaCoRo31jDngUnd45hgQ
        8kiyJc9GsaGwaajOg9tObRnWe4EwBNjMW1llBrNnfbxqmYikqdamMaVTPZ9bd6cp7zn2dHV4088
        rIJM2VQajVjGU0mSJJdMpC1/J
X-Received: by 2002:a1c:43c5:: with SMTP id q188mr2212837wma.175.1631090513623;
        Wed, 08 Sep 2021 01:41:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweE3MmeKl7/39WLjEVkd4I7ue217226XV3Qw+7onVSrj0Q82ajVjxJjneUuSkC8YrR/KLarg==
X-Received: by 2002:a1c:43c5:: with SMTP id q188mr2212819wma.175.1631090513449;
        Wed, 08 Sep 2021 01:41:53 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u25sm1414388wmj.10.2021.09.08.01.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 01:41:52 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Eduardo Habkost <ehabkost@redhat.com>,
        Juergen Gross <jgross@suse.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 3/6] x86/kvm: introduce per cpu vcpu masks
In-Reply-To: <20210907183457.53ws6tqqqpzkeil4@habkost.net>
References: <20210903130808.30142-1-jgross@suse.com>
 <20210903130808.30142-4-jgross@suse.com>
 <20210907183457.53ws6tqqqpzkeil4@habkost.net>
Date:   Wed, 08 Sep 2021 10:41:51 +0200
Message-ID: <87r1dz4fxs.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Sep 03, 2021 at 03:08:04PM +0200, Juergen Gross wrote:
>> In order to support high vcpu numbers per guest don't use on stack
>> vcpu bitmasks. As all those currently used bitmasks are not used in
>> functions subject to recursion it is fairly easy to replace them with
>> percpu bitmasks.
>> 
>> Disable preemption while such a bitmask is being used in order to
>> avoid double usage in case we'd switch cpus.
>> 
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>> V2:
>> - use local_lock() instead of preempt_disable() (Paolo Bonzini)
>> ---
>>  arch/x86/include/asm/kvm_host.h | 10 ++++++++++
>>  arch/x86/kvm/hyperv.c           | 25 ++++++++++++++++++-------
>>  arch/x86/kvm/irq_comm.c         |  9 +++++++--
>>  arch/x86/kvm/x86.c              | 22 +++++++++++++++++++++-
>>  4 files changed, 56 insertions(+), 10 deletions(-)
>> 
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 3513edee8e22..a809a9e4fa5c 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -15,6 +15,7 @@
>>  #include <linux/cpumask.h>
>>  #include <linux/irq_work.h>
>>  #include <linux/irq.h>
>> +#include <linux/local_lock.h>
>>  
>>  #include <linux/kvm.h>
>>  #include <linux/kvm_para.h>
>> @@ -1591,6 +1592,15 @@ extern bool kvm_has_bus_lock_exit;
>>  /* maximum vcpu-id */
>>  unsigned int kvm_max_vcpu_id(void);
>>  
>> +/* per cpu vcpu bitmasks, protected by kvm_pcpu_mask_lock */
>> +DECLARE_PER_CPU(local_lock_t, kvm_pcpu_mask_lock);
>> +extern unsigned long __percpu *kvm_pcpu_vcpu_mask;
>> +#define KVM_VCPU_MASK_SZ	\
>> +	(sizeof(*kvm_pcpu_vcpu_mask) * BITS_TO_LONGS(KVM_MAX_VCPUS))
>> +extern u64 __percpu *kvm_hv_vp_bitmap;
>> +#define KVM_HV_MAX_SPARSE_VCPU_SET_BITS DIV_ROUND_UP(KVM_MAX_VCPUS, 64)
>> +#define KVM_HV_VPMAP_SZ		(sizeof(u64) * KVM_HV_MAX_SPARSE_VCPU_SET_BITS)
>
> I have just realized that the Hyper-V sparse bitmap format can
> support only up to 4096 CPUs, and the current implementation of
> sparse_set_to_vcpu_mask() won't even work correctly if
> KVM_MAX_VCPUS is larger than 4096.

Nice catch! Indeed, we can only encode 64 'banks' with 64 vCPUs each. We
need to enforce the limit somehow. As a big hammer, I can suggest to
fail kvm_hv_vcpu_init() and write to HV_X64_MSR_VP_INDEX for vCPUs above
4095 for now (I seriously doubt there's real need to run such big
Windows guests anywhere but who knows).

>
> This means vp_bitmap can't and will never be larger than 512
> bytes.  Isn't a per-CPU variable for vp_bitmap overkill in this
> case?

Yes, it's OK to allocate 512 bytes on stack.

-- 
Vitaly

