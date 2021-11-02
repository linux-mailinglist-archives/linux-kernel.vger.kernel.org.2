Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4680A442BCD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 11:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhKBKtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 06:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229931AbhKBKte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 06:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635850018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XFQHbIlafDzJEHgYX2vpeRXhMsdqgY8QKpgrZUogIu4=;
        b=RzXimXP4vcU1SyFnsRwoZ3joxAjHjIupQhd5Vw0LNnNDbq2JYybPDoi3+U29Mi+VaKOaUT
        QrBdycED55t+fnEiUUHyeByX3YOuI0Cwt+sJgSjuNIoMhyQU0fpw899cv/FuLF/aQk79KQ
        /biB5tSYUtTHgxSv3rlpGThVLmnSkGs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-yFJQ8SLrNtmxHwVbsqg1Ug-1; Tue, 02 Nov 2021 06:46:57 -0400
X-MC-Unique: yFJQ8SLrNtmxHwVbsqg1Ug-1
Received: by mail-wr1-f72.google.com with SMTP id j12-20020adf910c000000b0015e4260febdso7299956wrj.20
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 03:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XFQHbIlafDzJEHgYX2vpeRXhMsdqgY8QKpgrZUogIu4=;
        b=PtF4aK3iG1X7lxmwiHjTZDJ+M/vpUzg4b0xoE24roweV7FGNHpJ1Jm8AcipmH5w+H7
         XT59dfwc0sQguwy7UF1gjGjmLe9N7FLFhxKY6ruBtRVIZxJbNyhTR5y4CtmK8PY8dbh1
         yCEQthZ24LEhSIfe4/J7iNgqYdkPV6nomxnsCTbOCAfqsKvVko/Qa8yEwNVb0QtOkGHJ
         YF+2TqJ6CL5Fv+TFzoSbLc2ZTWHHVuL60le6iO89jNXSxLbmltmNDDtvmMg2I2ke3I5M
         DnXOayCquNVmMAuDGU+tFL5FViWi3RruXQasnqggrb71nQK9hyqbDaYSjEWJc4wMnwo0
         Fosg==
X-Gm-Message-State: AOAM532aX9gE7VMC55UmCPuERngYVcIWnwBZiYZYn5yLqo7w9AIX+m1W
        8/JDzM8whV6l2gFE5r/+iI++DMJAf60sJfwjq7gyZJUGV537ORlnOjEn+NXMd3IEHhonKX9QfIG
        /QfzXcY/oEuu2rl2Do2DZrMty
X-Received: by 2002:a1c:c91a:: with SMTP id f26mr6013761wmb.89.1635850016683;
        Tue, 02 Nov 2021 03:46:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze0huHSIEw1nkLBwxtB5ocsTOvhFwt3G116/y2bZnfLuM0x5klgPLxC7Q+PMIFw0Gw4wG3lA==
X-Received: by 2002:a1c:c91a:: with SMTP id f26mr6013730wmb.89.1635850016453;
        Tue, 02 Nov 2021 03:46:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p2sm110903wmq.23.2021.11.02.03.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 03:46:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
In-Reply-To: <YYB2l9bzFhKzobZB@google.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
 <20210811122927.900604-7-mlevitsk@redhat.com>
 <137f2dcc-75d2-9d71-e259-dd66d43ad377@redhat.com>
 <87sfwfkhk5.fsf@vitty.brq.redhat.com>
 <b48210a35b3bc6d63beeb33c19b609b3014191dd.camel@redhat.com>
 <YYB2l9bzFhKzobZB@google.com>
Date:   Tue, 02 Nov 2021 11:46:54 +0100
Message-ID: <87k0hqkf6p.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Nov 01, 2021, Maxim Levitsky wrote:
>> On Mon, 2021-11-01 at 16:43 +0100, Vitaly Kuznetsov wrote:
>> > Paolo Bonzini <pbonzini@redhat.com> writes:
>> > 
>> > > On 11/08/21 14:29, Maxim Levitsky wrote:
>> > > > Modify debug_regs test to create a pending interrupt
>> > > > and see that it is blocked when single stepping is done
>> > > > with KVM_GUESTDBG_BLOCKIRQ
>> > > > 
>> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>> > > > ---
>> > > >   .../testing/selftests/kvm/x86_64/debug_regs.c | 24 ++++++++++++++++---
>> > > >   1 file changed, 21 insertions(+), 3 deletions(-)
>> > > 
>> > > I haven't looked very much at this, but the test fails.
>> > > 
>> > 
>> > Same here,
>> > 
>> > the test passes on AMD but fails consistently on Intel:
>> > 
>> > # ./x86_64/debug_regs 
>> > ==== Test Assertion Failure ====
>> >   x86_64/debug_regs.c:179: run->exit_reason == KVM_EXIT_DEBUG && run->debug.arch.exception == DB_VECTOR && run->debug.arch.pc == target_rip && run->debug.arch.dr6 == target_dr6
>> >   pid=13434 tid=13434 errno=0 - Success
>> >      1	0x00000000004027c6: main at debug_regs.c:179
>> >      2	0x00007f65344cf554: ?? ??:0
>> >      3	0x000000000040294a: _start at ??:?
>> >   SINGLE_STEP[1]: exit 8 exception 1 rip 0x402a25 (should be 0x402a27) dr6 0xffff4ff0 (should be 0xffff4ff0)
>> > 
>> > (I know I'm late to the party).
>> 
>> Well that is strange. It passes on my intel laptop. Just tested 
>> (kvm/queue + qemu master, compiled today) :-(
>> 
>> It fails on iteration 1 (and there is iteration 0) which I think means that we
>> start with RIP on sti, and get #DB on start of xor instruction first (correctly), 
>> and then we get #DB again on start of xor instruction again?
>> 
>> Something very strange. My laptop has i7-7600U.
>
> I haven't verified on hardware, but my guess is that this code in vmx_vcpu_run()
>
> 	/* When single-stepping over STI and MOV SS, we must clear the
> 	 * corresponding interruptibility bits in the guest state. Otherwise
> 	 * vmentry fails as it then expects bit 14 (BS) in pending debug
> 	 * exceptions being set, but that's not correct for the guest debugging
> 	 * case. */
> 	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)
> 		vmx_set_interrupt_shadow(vcpu, 0);
>
> interacts badly with APICv=1.  It will kill the STI shadow and cause the IRQ in
> vmcs.GUEST_RVI to be recognized when it (micro-)architecturally should not.  My
> head is going in circles trying to sort out what would actually happen.  Maybe
> comment out that and/or disable APICv to see if either one makes the test pass?
>

Interestingly,

loading 'kvm-intel' with 'enable_apicv=0' makes the test pass, however,
commenting out "vmx_set_interrupt_shadow()" as suggested gives a
different result (with enable_apicv=1):

# ./x86_64/debug_regs 
==== Test Assertion Failure ====
  x86_64/debug_regs.c:179: run->exit_reason == KVM_EXIT_DEBUG && run->debug.arch.exception == DB_VECTOR && run->debug.arch.pc == target_rip && run->debug.arch.dr6 == target_dr6
  pid=16352 tid=16352 errno=0 - Success
     1	0x0000000000402b33: main at debug_regs.c:179 (discriminator 10)
     2	0x00007f36401bd554: ?? ??:0
     3	0x00000000004023a9: _start at ??:?
  SINGLE_STEP[1]: exit 9 exception -2147483615 rip 0x1 (should be 0x4024d9) dr6 0xffff4ff0 (should be 0xffff4ff0)

this is a fairly old "Intel(R) Xeon(R) CPU E5-2603 v3".

-- 
Vitaly

