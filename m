Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4293DBB5B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbhG3Ouh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239561AbhG3OuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627656610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j5uCBe8xFVnv+/Gfajoxa0wC5i9T4orScMoCzlIsbhU=;
        b=FdfUsPX86XqFBj1R7HsCn/2vyYcTUGhsvwIY177RNSVDuzk2h9V49RGGekLC/rlfel5JTz
        tCsA4gA7RYjwc7FV6dTM4WPTVKyXN36VNQivRM3nFjO7e3gtsvOQNCObTQZVC9YMSW88GF
        hgXLQ2TOGmhk493inh97/7Fh4ZVOGxQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-CyoSMnlcOUihSvtALUPx6w-1; Fri, 30 Jul 2021 10:50:08 -0400
X-MC-Unique: CyoSMnlcOUihSvtALUPx6w-1
Received: by mail-ed1-f72.google.com with SMTP id c16-20020aa7d6100000b02903bc4c2a387bso4675404edr.21
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=j5uCBe8xFVnv+/Gfajoxa0wC5i9T4orScMoCzlIsbhU=;
        b=pMAPLmW5GfWNLKDrnvK9TV1BlSH/3a4r9rQHk0oUDsBTznD6/4LfT8n0oY2sVbgXDu
         7NUTlgExDN09vuAFbxqZ+nOoAxhFBe7oCwlmtFdcCeLY33545iqTGUoK7vlsdSYRp44p
         JqXWPO4zGRMiaVR/bLIlVQJGVZEbM471fpb+gM1eb/hUanlfaT3BJ4lEEQCKR2/wlmDF
         mHjyZ+3wZ5mGjXTDGvFjTrpohKmIn3MZ1UytRdLFDesQoMu2Tyjn7T31Aa8Rh+adFQdj
         qD1drHxZR/Msa9ZNDV/ZdeuCyHehi0b0qhlC7+SKv3PH5fFNv4TnS6FncwIxV2ZuLe31
         076g==
X-Gm-Message-State: AOAM530B4MqIRFy90Rv1QAEHCncG0teCsF4V8SaXoBtkhRQas65Sg/RQ
        3qwuhG9J9NJ0ZOW/T7XLHb9ISvV8ss1xSiY3YIFHQc2/D01Kvx7l3du9J8QvBVOiJAb9/DkOn05
        CG1JMYXlc1MsYBkyby0AiNy5va2+umn7gsyhpnhWx2hTZCGp9sElvp3BWuijQ7B91C0MROWlqYb
        TD
X-Received: by 2002:a17:906:2c45:: with SMTP id f5mr2846603ejh.464.1627656607771;
        Fri, 30 Jul 2021 07:50:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyG2GEBcRoG3E5Q810oJbiMI6yjTmtHyKDhBsob2LmtAgVsuAQhH0dRZ99z3A0YhIMDX0HBAw==
X-Received: by 2002:a17:906:2c45:: with SMTP id f5mr2846583ejh.464.1627656607496;
        Fri, 30 Jul 2021 07:50:07 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id dn18sm779425edb.42.2021.07.30.07.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:50:07 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Siddharth Chandrasekaran <sidcha@amazon.de>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] KVM: selftests: Test access to XMM fast hypercalls
In-Reply-To: <20210730143530.GD20232@u366d62d47e3651.ant.amazon.com>
References: <20210730122625.112848-1-vkuznets@redhat.com>
 <20210730122625.112848-5-vkuznets@redhat.com>
 <20210730143530.GD20232@u366d62d47e3651.ant.amazon.com>
Date:   Fri, 30 Jul 2021 16:50:06 +0200
Message-ID: <878s1namap.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Siddharth Chandrasekaran <sidcha@amazon.de> writes:

> On Fri, Jul 30, 2021 at 02:26:25PM +0200, Vitaly Kuznetsov wrote:
>> HYPERV_CPUID_FEATURES.EDX and an 'XMM fast' hypercall is issued.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  .../selftests/kvm/include/x86_64/hyperv.h     |  5 ++-
>>  .../selftests/kvm/x86_64/hyperv_features.c    | 41 +++++++++++++++++--
>>  2 files changed, 42 insertions(+), 4 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/kvm/include/x86_64/hyperv.h b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
>> index 412eaee7884a..b66910702c0a 100644
>> --- a/tools/testing/selftests/kvm/include/x86_64/hyperv.h
>> +++ b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
>> @@ -117,7 +117,7 @@
>>  #define HV_X64_GUEST_DEBUGGING_AVAILABLE               BIT(1)
>>  #define HV_X64_PERF_MONITOR_AVAILABLE                  BIT(2)
>>  #define HV_X64_CPU_DYNAMIC_PARTITIONING_AVAILABLE      BIT(3)
>> -#define HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE          BIT(4)
>> +#define HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE           BIT(4)
>>  #define HV_X64_GUEST_IDLE_STATE_AVAILABLE              BIT(5)
>>  #define HV_FEATURE_FREQUENCY_MSRS_AVAILABLE            BIT(8)
>>  #define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE           BIT(10)
>> @@ -182,4 +182,7 @@
>>  #define HV_STATUS_INVALID_CONNECTION_ID                18
>>  #define HV_STATUS_INSUFFICIENT_BUFFERS         19
>> 
>> +/* hypercall options */
>> +#define HV_HYPERCALL_FAST_BIT          BIT(16)
>> +
>>  #endif /* !SELFTEST_KVM_HYPERV_H */
>> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
>> index af27c7e829c1..91d88aaa9899 100644
>> --- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
>> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
>> @@ -47,6 +47,7 @@ static void do_wrmsr(u32 idx, u64 val)
>>  }
>> 
>>  static int nr_gp;
>> +static int nr_ud;
>> 
>>  static inline u64 hypercall(u64 control, vm_vaddr_t input_address,
>>                             vm_vaddr_t output_address)
>> @@ -80,6 +81,12 @@ static void guest_gp_handler(struct ex_regs *regs)
>>                 regs->rip = (uint64_t)&wrmsr_end;
>>  }
>> 
>> +static void guest_ud_handler(struct ex_regs *regs)
>> +{
>> +       nr_ud++;
>> +       regs->rip += 3;
>> +}
>> +
>>  struct msr_data {
>>         uint32_t idx;
>>         bool available;
>> @@ -90,6 +97,7 @@ struct msr_data {
>>  struct hcall_data {
>>         uint64_t control;
>>         uint64_t expect;
>> +       bool ud_expected;
>>  };
>> 
>>  static void guest_msr(struct msr_data *msr)
>> @@ -117,13 +125,26 @@ static void guest_msr(struct msr_data *msr)
>>  static void guest_hcall(vm_vaddr_t pgs_gpa, struct hcall_data *hcall)
>>  {
>>         int i = 0;
>> +       u64 res, input, output;
>> 
>>         wrmsr(HV_X64_MSR_GUEST_OS_ID, LINUX_OS_ID);
>>         wrmsr(HV_X64_MSR_HYPERCALL, pgs_gpa);
>> 
>>         while (hcall->control) {
>> -               GUEST_ASSERT(hypercall(hcall->control, pgs_gpa,
>> -                                      pgs_gpa + 4096) == hcall->expect);
>> +               nr_ud = 0;
>> +               if (!(hcall->control & HV_HYPERCALL_FAST_BIT)) {
>> +                       input = pgs_gpa;
>> +                       output = pgs_gpa + 4096;
>> +               } else {
>> +                       input = output = 0;
>> +               }
>> +
>> +               res = hypercall(hcall->control, input, output);
>> +               if (hcall->ud_expected)
>> +                       GUEST_ASSERT(nr_ud == 1);
>
> Should we also do WRITE_ONCE(nr_ur, 0) here?

It could probably make sense to replace 'nr_ud = 0' above with this so
compiler doesn't screw us up one day..

> or perhaps pass the the
> expected value of nr_ud + 1 in hcall->ud_expected from caller and do,
>
>     if (hcall->ud_expected)
>         GUEST_ASSERT(nr_ud == hcall->ud_expected);
>
> This way there can be other test that can also expect a UD.

My idea was that we don't really need to count #UDs for now, just
checking the fact that it happened is OK so I reset nr_ud before doing
the hypercall and check it after. It is possible to add more tests with
'ud_expected' this way.

>
>> +               else
>> +                       GUEST_ASSERT(res == hcall->expect);
>> +
>>                 GUEST_SYNC(i++);
>>         }
>> 
>> @@ -552,8 +573,18 @@ static void guest_test_hcalls_access(struct kvm_vm *vm, struct hcall_data *hcall
>>                         recomm.ebx = 0xfff;
>>                         hcall->expect = HV_STATUS_SUCCESS;
>>                         break;
>> -
>>                 case 17:
>> +                       /* XMM fast hypercall */
>> +                       hcall->control = HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE | HV_HYPERCALL_FAST_BIT;
>> +                       hcall->ud_expected = true;
>> +                       break;
>> +               case 18:
>> +                       feat.edx |= HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE;
>> +                       hcall->ud_expected = false;
>> +                       hcall->expect = HV_STATUS_SUCCESS;
>> +                       break;
>> +
>> +               case 19:
>>                         /* END */
>>                         hcall->control = 0;
>>                         break;
>> @@ -625,6 +656,10 @@ int main(void)
>>         /* Test hypercalls */
>>         vm = vm_create_default(VCPU_ID, 0, guest_hcall);
>> 
>> +       vm_init_descriptor_tables(vm);
>> +       vcpu_init_descriptor_tables(vm, VCPU_ID);
>> +       vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
>> +
>>         /* Hypercall input/output */
>>         hcall_page = vm_vaddr_alloc_pages(vm, 2);
>>         memset(addr_gva2hva(vm, hcall_page), 0x0, 2 * getpagesize());
>> --
>> 2.31.1
>> 
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>
>

-- 
Vitaly

