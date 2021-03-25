Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEAF348B35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 09:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCYIKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 04:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhCYIKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616659824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+UtRoqVjed4aeKlxkJktBDTzmzBfPqmMyTKVge7J/2I=;
        b=YWGYbQwGkuV8CxBf3XWBb7iCNyK5wGTC8ukluJ7dfiQR7CYC6DYTr3FEkmaI2CMBoNY63D
        XSIb9SFE+vWo69rUTjS/OMLn/G+v0YgfkcE3YW4StrMDNM/Ch31nwK3EgB2+1vG0DWQxKw
        S2jdLfqACkxCssBPJD0Z8NQyG13FD38=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-dOJiswdfMLa7CAEI8CM45g-1; Thu, 25 Mar 2021 04:10:22 -0400
X-MC-Unique: dOJiswdfMLa7CAEI8CM45g-1
Received: by mail-ed1-f72.google.com with SMTP id t27so2293007edi.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 01:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+UtRoqVjed4aeKlxkJktBDTzmzBfPqmMyTKVge7J/2I=;
        b=Ww1cwToqeRvBW2v9yH3vlwjykCcqP8W2PC7C4qE6octVYAjTmJ9P+yhKYoRBHSqsjP
         oYeBNEX1YK137d+6pvi7vmcuPBGEm+tiI4cE+IyefuachG5x7J/7Ridf7cyeKC+h7gOB
         ZrWmMsP42TasktrJBbPlSfh0zoPiMgZfjN2OFjy6N6La57DMfAIUcnpsIlLAExvIWwEt
         JwAINPlJxAvTFvsMQHKtX1wFrlV/k9ii4+s4zOIwG64Fdy7ciU4aTsPCe1NbDi5jw9qF
         4wLTEPGHZE5yIRGBZDusNTaJ2UW4HFaybfEnknNe3NMxPvv7pnDL4vLZ/4ob+J8u6Po+
         hHFA==
X-Gm-Message-State: AOAM530PniiQ3f/dzzDSJQf5TZ3djz2UxASjT+QFj27fcnWi3Ugb84Qs
        cB3gvojNhZz7wuY5zy1hSYhK6nCYOXSKL5ySIoOn+EyyKE9BlEZ2MTfu9NKbO+N8oF9Q2g5G0+i
        38D/VTaTEzisLhaGuc/cBf1++pOg6lLYXe7kKptU+FoRjwVuXyaluMU14bsDV7WnFLG82K1iB7C
        iu
X-Received: by 2002:a05:6402:3487:: with SMTP id v7mr7642739edc.302.1616659821096;
        Thu, 25 Mar 2021 01:10:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCH7/kZCaLKJLGLs+892JY4VEzBJJej4rycGn0YPjm5aY4RIiCSuOOUBxCB9OIoN9ZZxkMAg==
X-Received: by 2002:a05:6402:3487:: with SMTP id v7mr7642711edc.302.1616659820812;
        Thu, 25 Mar 2021 01:10:20 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v8sm2297629edc.30.2021.03.25.01.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 01:10:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Haiwei Li <lihaiwei.kernel@gmail.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Wei Huang <wei.huang2@amd.com>, Joerg Roedel <joro@8bytes.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86/vPMU: Forbid writing to MSR_F15H_PERF MSRs
 when guest doesn't have X86_FEATURE_PERFCTR_CORE
In-Reply-To: <CAB5KdObQ7t4aXFsYioNdVfNt6B+ChJLB5dKsWxAtoXMYpgSoBA@mail.gmail.com>
References: <20210323084515.1346540-1-vkuznets@redhat.com>
 <CAB5KdObQ7t4aXFsYioNdVfNt6B+ChJLB5dKsWxAtoXMYpgSoBA@mail.gmail.com>
Date:   Thu, 25 Mar 2021 09:10:19 +0100
Message-ID: <87czvny7pw.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haiwei Li <lihaiwei.kernel@gmail.com> writes:

> On Tue, Mar 23, 2021 at 4:48 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> MSR_F15H_PERF_CTL0-5, MSR_F15H_PERF_CTR0-5 MSRs are only available when
>> X86_FEATURE_PERFCTR_CORE CPUID bit was exposed to the guest. KVM, however,
>> allows these MSRs unconditionally because kvm_pmu_is_valid_msr() ->
>> amd_msr_idx_to_pmc() check always passes and because kvm_pmu_set_msr() ->
>> amd_pmu_set_msr() doesn't fail.
>>
>> In case of a counter (CTRn), no big harm is done as we only increase
>> internal PMC's value but in case of an eventsel (CTLn), we go deep into
>> perf internals with a non-existing counter.
>>
>> Note, kvm_get_msr_common() just returns '0' when these MSRs don't exist
>> and this also seems to contradict architectural behavior which is #GP
>> (I did check one old Opteron host) but changing this status quo is a bit
>> scarier.
>
> When msr doesn't exist, kvm_get_msr_common() returns KVM_MSR_RET_INVALID
> in `default:` and kvm_complete_insn_gp() will inject #GP to guest.
>

I'm looking at the following in kvm_get_msr_common():

        switch (msr_info->index) {
        ...
 	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:
        ...
		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
			return kvm_pmu_get_msr(vcpu, msr_info);
		msr_info->data = 0;
		break;
        ...
	}
	return 0;

so it's kind of 'always exists' or am I wrong?

> Also i have wrote a kvm-unit-test, tested both on amd EPYC and intel
> CascadeLake. A #GP error was printed.
> Just like:
>
> Unhandled exception 13 #GP at ip 0000000000400420
> error_code=0000      rflags=00010006      cs=00000008
> rax=0000000000000000 rcx=0000000000000620 rdx=00000000006164a0
> rbx=0000000000009500
> rbp=0000000000517490 rsi=0000000000616ae0 rdi=0000000000000001
>  r8=0000000000000001  r9=00000000000003f8 r10=000000000000000d
> r11=0000000000000000
> r12=0000000000000000 r13=0000000000000000 r14=0000000000000000
> r15=0000000000000000
> cr0=0000000080000011 cr2=0000000000000000 cr3=000000000040b000
> cr4=0000000000000020
> cr8=0000000000000000
> STACK: @400420 400338

Did this happen on read or write? The later is expected, the former is
not. Could you maybe drop your code here, I'd like to see what's going
on.

-- 
Vitaly

