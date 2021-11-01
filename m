Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026F3441D87
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhKAPqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232390AbhKAPqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635781407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vf0Cs6N7Pa4XntUZWCsE/d3YAQkbCA+PKPFZjGD9Jiw=;
        b=bMZtTDfnSfMSfmzRuHWAFI8gUnHdY0X6vOvN7YmDktD5Jd5oKLsR1KvuPWM/y0fVPUs9FX
        doSpaaxgY91GTPSvTyDQIXzhVZY3x3eE8qejbE8bbxDOoEnXoMjcxi3L/cQOqLdc0KBHa1
        i5Afa5vAfTqKtE8rbpkttjLIJDHAFSU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-8H8EVw6EO4exox5DCR-T2Q-1; Mon, 01 Nov 2021 11:43:26 -0400
X-MC-Unique: 8H8EVw6EO4exox5DCR-T2Q-1
Received: by mail-wm1-f69.google.com with SMTP id k6-20020a7bc306000000b0030d92a6bdc7so86867wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 08:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Vf0Cs6N7Pa4XntUZWCsE/d3YAQkbCA+PKPFZjGD9Jiw=;
        b=sav2SqMUmOsIA+gruddtBVB0lsfC4D2Se5TQuovIqaWZoRQm2UImbPSgzYpqt1yRGc
         0Xxv0cXGEPedfrPrpa4aoqkwkj+h6o045RonLDCRA5DurySjVsDZEvCrd9hgHkVU27Nm
         rTZRXrCio3YoRY0k07ABBStX5VY2ofg0V+dtUz1xeX9l28Sslky11CAv7xz4drQv3wx1
         dbgHDKoXEF0ceGaaQOhdMw84RDBKgf3/4BUfU/OA22jXQnndz1N3Qw8+KnCx8FMHCACy
         mbhxrYCjgwR1GQmujcYV7SZt+I6zKR43ccCUvdug5S5iskUK6YOmr5mkFLc9irRenqAw
         sS2w==
X-Gm-Message-State: AOAM53131na9+son5yR2lJyeTr85n3dkSJvNjShLdfsmOjmPxmmG7TuX
        LpUYLUsb/vcOEmFyB7YZ2PTWnHECirHQ2pO4llbHE6NtI26xhguPTCmu25om6a8gupz5HN4bR8H
        M4qJBsZADSnIVN8qkO9y2qEFd
X-Received: by 2002:a7b:c4c4:: with SMTP id g4mr31563527wmk.93.1635781404957;
        Mon, 01 Nov 2021 08:43:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSeh6daw2bhGbReyl885dQ8YPARmOaQ7zMGMRl9Y+Umpr8dcEk3zfK06a2SnPJ3BaVFX2SBw==
X-Received: by 2002:a7b:c4c4:: with SMTP id g4mr31563505wmk.93.1635781404657;
        Mon, 01 Nov 2021 08:43:24 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z12sm9584608wrv.78.2021.11.01.08.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 08:43:24 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 6/6] KVM: selftests: test KVM_GUESTDBG_BLOCKIRQ
In-Reply-To: <137f2dcc-75d2-9d71-e259-dd66d43ad377@redhat.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
 <20210811122927.900604-7-mlevitsk@redhat.com>
 <137f2dcc-75d2-9d71-e259-dd66d43ad377@redhat.com>
Date:   Mon, 01 Nov 2021 16:43:22 +0100
Message-ID: <87sfwfkhk5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 11/08/21 14:29, Maxim Levitsky wrote:
>> Modify debug_regs test to create a pending interrupt
>> and see that it is blocked when single stepping is done
>> with KVM_GUESTDBG_BLOCKIRQ
>> 
>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>> ---
>>   .../testing/selftests/kvm/x86_64/debug_regs.c | 24 ++++++++++++++++---
>>   1 file changed, 21 insertions(+), 3 deletions(-)
>
> I haven't looked very much at this, but the test fails.
>

Same here,

the test passes on AMD but fails consistently on Intel:

# ./x86_64/debug_regs 
==== Test Assertion Failure ====
  x86_64/debug_regs.c:179: run->exit_reason == KVM_EXIT_DEBUG && run->debug.arch.exception == DB_VECTOR && run->debug.arch.pc == target_rip && run->debug.arch.dr6 == target_dr6
  pid=13434 tid=13434 errno=0 - Success
     1	0x00000000004027c6: main at debug_regs.c:179
     2	0x00007f65344cf554: ?? ??:0
     3	0x000000000040294a: _start at ??:?
  SINGLE_STEP[1]: exit 8 exception 1 rip 0x402a25 (should be 0x402a27) dr6 0xffff4ff0 (should be 0xffff4ff0)

(I know I'm late to the party).

> Paolo
>
>> diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
>> index 6097a8283377..5f078db1bcba 100644
>> --- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
>> +++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
>> @@ -8,12 +8,15 @@
>>   #include <string.h>
>>   #include "kvm_util.h"
>>   #include "processor.h"
>> +#include "apic.h"
>>   
>>   #define VCPU_ID 0
>>   
>>   #define DR6_BD		(1 << 13)
>>   #define DR7_GD		(1 << 13)
>>   
>> +#define IRQ_VECTOR 0xAA
>> +
>>   /* For testing data access debug BP */
>>   uint32_t guest_value;
>>   
>> @@ -21,6 +24,11 @@ extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
>>   
>>   static void guest_code(void)
>>   {
>> +	/* Create a pending interrupt on current vCPU */
>> +	x2apic_enable();
>> +	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
>> +			 APIC_DM_FIXED | IRQ_VECTOR);
>> +
>>   	/*
>>   	 * Software BP tests.
>>   	 *
>> @@ -38,12 +46,19 @@ static void guest_code(void)
>>   		     "mov %%rax,%0;\n\t write_data:"
>>   		     : "=m" (guest_value) : : "rax");
>>   
>> -	/* Single step test, covers 2 basic instructions and 2 emulated */
>> +	/*
>> +	 * Single step test, covers 2 basic instructions and 2 emulated
>> +	 *
>> +	 * Enable interrupts during the single stepping to see that
>> +	 * pending interrupt we raised is not handled due to KVM_GUESTDBG_BLOCKIRQ
>> +	 */
>>   	asm volatile("ss_start: "
>> +		     "sti\n\t"
>>   		     "xor %%eax,%%eax\n\t"
>>   		     "cpuid\n\t"
>>   		     "movl $0x1a0,%%ecx\n\t"
>>   		     "rdmsr\n\t"
>> +		     "cli\n\t"
>>   		     : : : "eax", "ebx", "ecx", "edx");
>>   
>>   	/* DR6.BD test */
>> @@ -72,11 +87,13 @@ int main(void)
>>   	uint64_t cmd;
>>   	int i;
>>   	/* Instruction lengths starting at ss_start */
>> -	int ss_size[4] = {
>> +	int ss_size[6] = {
>> +		1,		/* sti*/
>>   		2,		/* xor */
>>   		2,		/* cpuid */
>>   		5,		/* mov */
>>   		2,		/* rdmsr */
>> +		1,		/* cli */
>>   	};
>>   
>>   	if (!kvm_check_cap(KVM_CAP_SET_GUEST_DEBUG)) {
>> @@ -154,7 +171,8 @@ int main(void)
>>   	for (i = 0; i < (sizeof(ss_size) / sizeof(ss_size[0])); i++) {
>>   		target_rip += ss_size[i];
>>   		CLEAR_DEBUG();
>> -		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP;
>> +		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP |
>> +				KVM_GUESTDBG_BLOCKIRQ;
>>   		debug.arch.debugreg[7] = 0x00000400;
>>   		APPLY_DEBUG();
>>   		vcpu_run(vm, VCPU_ID);
>> 
>

-- 
Vitaly

