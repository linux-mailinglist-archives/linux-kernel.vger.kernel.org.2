Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CA23F60C6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbhHXOnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40684 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237926AbhHXOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629816150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uPIwnz8JPNR4S2lMPdo6ynnsvRqH2A3Uk8ZKCRmBBjo=;
        b=SGklq2ezStKEjsatJXv8ZBFB/DSEInxJn62RztktC4k1YXlDogINIIohaZVzLzBIOvU3OA
        QliquqiD2zGlu9lEbFrbq2tJB8ukz8gxBgLw6DwXktnM0VGe1O51GEdKM5zeU9hSyiLYok
        wy+uM85ibDQk5dCSmaR2ISB1GvVnlWc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-McTxevTAPDaHYI5RV8wf2Q-1; Tue, 24 Aug 2021 10:42:29 -0400
X-MC-Unique: McTxevTAPDaHYI5RV8wf2Q-1
Received: by mail-wr1-f70.google.com with SMTP id a9-20020a0560000509b029015485b95d0cso5830338wrf.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uPIwnz8JPNR4S2lMPdo6ynnsvRqH2A3Uk8ZKCRmBBjo=;
        b=rQrM/Gs1Ucd7zDDlrVVS7ZT7ZNVXX5Q2WvrayyarLY7xa1HRU1QjVEzoUNUQ/MjhTd
         +qs1RMyxyrjYPbGdRRPXLz33U22rX2j33wcMdhaWw8HOSpqx7w4/UE3eEjOKfZ/lIjif
         o6Imz+5TAFtTVZe5XKQ9do+Oj9wikqrsAeQSSjllLZUw2ZHQmnpn63tJBt8L0sznTl3a
         qoBi+TjOx/B4zYO7F3Sp0CfPBbXdaMJq3atPG+OwMKg4AHQCezwKXp/1mUk1ISMWeAE3
         eDw56g5O/iwIC9JXXoLQnoNyMHaLUlAg5PudrUpF3xPuPxSHWdOH1npcs9DC6sBD73QW
         lSWQ==
X-Gm-Message-State: AOAM531TNGkLCDXteX5uLSDhBA273+inGH90DkFZbR/Ffq8zZIoFgISb
        LV+Vb+h64M6OWDHthIExTqjCEsedrS0ZUMCL5KpsmmHeRJIItSLI08UNYXIu2Hv+JHd+0pUw/T1
        XxybUexf0VkZIWEpqjT1k7ulfwwjOi+DTgFysXXXxSWN5V4fSa+3Ukxl+CZ8UvPhaiaK1GiXiAJ
        H2
X-Received: by 2002:a5d:54c3:: with SMTP id x3mr19422720wrv.208.1629816148495;
        Tue, 24 Aug 2021 07:42:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxm7wSePFmqdsVRd8VaF2Vv+lpCKCcnjzpl+MOcS4fG6LUqTlTRXaSPUaQbB7m6m88V1bPCoQ==
X-Received: by 2002:a5d:54c3:: with SMTP id x3mr19422693wrv.208.1629816148269;
        Tue, 24 Aug 2021 07:42:28 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l18sm2849042wmc.30.2021.08.24.07.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:42:27 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] KVM: x86: Fix stack-out-of-bounds memory access
 from ioapic_write_indirect()
In-Reply-To: <CAOpTY_ot8teH5x5vVS2HvuMx5LSKLPtyen_ZUM1p7ncci4LFbA@mail.gmail.com>
References: <20210823143028.649818-1-vkuznets@redhat.com>
 <20210823143028.649818-5-vkuznets@redhat.com>
 <20210823185841.ov7ejn2thwebcwqk@habkost.net>
 <87mtp7jowv.fsf@vitty.brq.redhat.com>
 <CAOpTY_ot8teH5x5vVS2HvuMx5LSKLPtyen_ZUM1p7ncci4LFbA@mail.gmail.com>
Date:   Tue, 24 Aug 2021 16:42:26 +0200
Message-ID: <87k0kakip9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Tue, Aug 24, 2021 at 3:13 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>
>> > On Mon, Aug 23, 2021 at 04:30:28PM +0200, Vitaly Kuznetsov wrote:
>> >> KASAN reports the following issue:
>> >>
>> >>  BUG: KASAN: stack-out-of-bounds in kvm_make_vcpus_request_mask+0x174/0x440 [kvm]
>> >>  Read of size 8 at addr ffffc9001364f638 by task qemu-kvm/4798
>> >>
>> >>  CPU: 0 PID: 4798 Comm: qemu-kvm Tainted: G               X --------- ---
>> >>  Hardware name: AMD Corporation DAYTONA_X/DAYTONA_X, BIOS RYM0081C 07/13/2020
>> >>  Call Trace:
>> >>   dump_stack+0xa5/0xe6
>> >>   print_address_description.constprop.0+0x18/0x130
>> >>   ? kvm_make_vcpus_request_mask+0x174/0x440 [kvm]
>> >>   __kasan_report.cold+0x7f/0x114
>> >>   ? kvm_make_vcpus_request_mask+0x174/0x440 [kvm]
>> >>   kasan_report+0x38/0x50
>> >>   kasan_check_range+0xf5/0x1d0
>> >>   kvm_make_vcpus_request_mask+0x174/0x440 [kvm]
>> >>   kvm_make_scan_ioapic_request_mask+0x84/0xc0 [kvm]
>> >>   ? kvm_arch_exit+0x110/0x110 [kvm]
>> >>   ? sched_clock+0x5/0x10
>> >>   ioapic_write_indirect+0x59f/0x9e0 [kvm]
>> >>   ? static_obj+0xc0/0xc0
>> >>   ? __lock_acquired+0x1d2/0x8c0
>> >>   ? kvm_ioapic_eoi_inject_work+0x120/0x120 [kvm]
>> >>
>> >> The problem appears to be that 'vcpu_bitmap' is allocated as a single long
>> >> on stack and it should really be KVM_MAX_VCPUS long. We also seem to clear
>> >> the lower 16 bits of it with bitmap_zero() for no particular reason (my
>> >> guess would be that 'bitmap' and 'vcpu_bitmap' variables in
>> >> kvm_bitmap_or_dest_vcpus() caused the confusion: while the later is indeed
>> >> 16-bit long, the later should accommodate all possible vCPUs).
>> >>
>> >> Fixes: 7ee30bc132c6 ("KVM: x86: deliver KVM IOAPIC scan request to target vCPUs")
>> >> Fixes: 9a2ae9f6b6bb ("KVM: x86: Zero the IOAPIC scan request dest vCPUs bitmap")
>> >> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> >> ---
>> >>  arch/x86/kvm/ioapic.c | 10 +++++-----
>> >>  1 file changed, 5 insertions(+), 5 deletions(-)
>> >>
>> >> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
>> >> index ff005fe738a4..92cd4b02e9ba 100644
>> >> --- a/arch/x86/kvm/ioapic.c
>> >> +++ b/arch/x86/kvm/ioapic.c
>> >> @@ -319,7 +319,7 @@ static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
>> >>      unsigned index;
>> >>      bool mask_before, mask_after;
>> >>      union kvm_ioapic_redirect_entry *e;
>> >> -    unsigned long vcpu_bitmap;
>> >> +    unsigned long vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)];
>> >
>> > Is there a way to avoid this KVM_MAX_VCPUS-sized variable on the
>> > stack?  This might hit us back when we increase KVM_MAX_VCPUS to
>> > a few thousand VCPUs (I was planning to submit a patch for that
>> > soon).
>>
>> What's the short- or mid-term target?
>
> Short term target is 2048 (which was already tested). Mid-term target
> (not tested yet) is 4096, maybe 8192.
>
>>
>> Note, we're allocating KVM_MAX_VCPUS bits (not bytes!) here, this means
>> that for e.g. 2048 vCPUs we need 256 bytes of the stack only. In case
>> the target much higher than that, we will need to either switch to
>> dynamic allocation or e.g. use pre-allocated per-CPU variables and make
>> this a preempt-disabled region. I, however, would like to understand if
>> the problem with allocating this from stack is real or not first.
>
> Is 256 bytes too much here, or would that be OK?
>

AFAIR, on x86_64 stack size (both reqular and irq) is 16k, eating 256
bytes of it is probably OK. I'd start worrying when we go to 1024 (8k
vCPUs) and above (but this is subjective of course).

-- 
Vitaly

