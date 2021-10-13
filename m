Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502D642BB91
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbhJMJcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236646AbhJMJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634117405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZjFKZdAkzPM6kA0DElv7KLx9JGj1opCMkKpXv5IVjds=;
        b=ZqW9NrFQghVJeNH0zq9KHWNnOemc2LB5GrnD3ffmnldo+cwoic+noviB9a3/vQ76iHC1Ib
        LUQ8Y7RIQE0WAkksN+92NpOLLdvtMAflZ+EeJvbgzECm3puAtWjaWe4aBmLGKHscSUipio
        H+hPwUICQoojaok0waIdxyU6VO02OkI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-m6XrE0-7NNeRnfdvXYkThA-1; Wed, 13 Oct 2021 05:30:04 -0400
X-MC-Unique: m6XrE0-7NNeRnfdvXYkThA-1
Received: by mail-wr1-f72.google.com with SMTP id c4-20020a5d6cc4000000b00160edc8bb28so1490132wrc.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 02:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZjFKZdAkzPM6kA0DElv7KLx9JGj1opCMkKpXv5IVjds=;
        b=gocZI1I1ZXqNaqQRqbH385JKmyWcwoPkKyI2DhRzRMykOEfrDtulsj1HmVWeKyuFTp
         ghh0N7ow4a8JNsCOYV/xZQ38mRlDl4R1HKgFiNgtNs/0MLHReGfZG5jqlQJ8J8wCfo9q
         ZjqnwZ+4HXt8bzxUDMn0Sg96a6Qmd/dNsgY/1fscITVzSk71mfWuSprmVpiCsEN3Kp9W
         Cw/K5qJK49518Y6aPb/iBkbXKPBpVjaCQzbW9sSlywqnZMPndOCphPEa9C3eJRpiXLzU
         Nset600qH13YHi+pd+zJS31EL2qyekOX7Ynx3RtA86PxTzDp/oJefWZCgiQG3cbcSjkY
         cbaw==
X-Gm-Message-State: AOAM53332f0Oe270JOtEXVwt7TVVmEBeg9B5CekaMjZKPMA0/NFttIiP
        P/FY1PZpuDbsSmvx1gUEbmLJGb/ELzOtHR0iswbXVHT9+fzhg5vlQ/QXJH9ePQePDuSK0qzZgpy
        d6JFs9I/5xjV5ysCiRcm5uROu
X-Received: by 2002:a1c:c906:: with SMTP id f6mr11752834wmb.136.1634117402775;
        Wed, 13 Oct 2021 02:30:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9gTLzJcIp/yrU6EoIVb6qauYFuyxecxt8Qxs8z4PtL5mkOqc+Jp//TvYKtW53QKGayzslJQ==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr11752794wmb.136.1634117402420;
        Wed, 13 Oct 2021 02:30:02 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.24.54])
        by smtp.gmail.com with ESMTPSA id e16sm11103886wrw.17.2021.10.13.02.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 02:30:02 -0700 (PDT)
Message-ID: <d7f59d0e-eac2-7978-4067-9258c8b1aefe@redhat.com>
Date:   Wed, 13 Oct 2021 11:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2] KVM: PPC: Defer vtime accounting 'til after IRQ
 handling
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>, Greg Kurz <groug@kaod.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
References: <20211007142856.41205-1-lvivier@redhat.com>
 <875yu17rxk.fsf@mpe.ellerman.id.au>
From:   Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <875yu17rxk.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2021 01:18, Michael Ellerman wrote:
> Laurent Vivier <lvivier@redhat.com> writes:
>> Commit 112665286d08 moved guest_exit() in the interrupt protected
>> area to avoid wrong context warning (or worse), but the tick counter
>> cannot be updated and the guest time is accounted to the system time.
>>
>> To fix the problem port to POWER the x86 fix
>> 160457140187 ("Defer vtime accounting 'til after IRQ handling"):
>>
>> "Defer the call to account guest time until after servicing any IRQ(s)
>>   that happened in the guest or immediately after VM-Exit.  Tick-based
>>   accounting of vCPU time relies on PF_VCPU being set when the tick IRQ
>>   handler runs, and IRQs are blocked throughout the main sequence of
>>   vcpu_enter_guest(), including the call into vendor code to actually
>>   enter and exit the guest."
>>
>> Fixes: 112665286d08 ("KVM: PPC: Book3S HV: Context tracking exit guest context before enabling irqs")
>> Cc: npiggin@gmail.com
>> Cc: <stable@vger.kernel.org> # 5.12
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>
>> Notes:
>>      v2: remove reference to commit 61bd0f66ff92
>>          cc stable 5.12
>>          add the same comment in the code as for x86
>>
>>   arch/powerpc/kvm/book3s_hv.c | 24 ++++++++++++++++++++----
>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>> index 2acb1c96cfaf..a694d1a8f6ce 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
> ...
>> @@ -4506,13 +4514,21 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
>>   
>>   	srcu_read_unlock(&kvm->srcu, srcu_idx);
>>   
>> +	context_tracking_guest_exit();
>> +
>>   	set_irq_happened(trap);
>>   
>>   	kvmppc_set_host_core(pcpu);
>>   
>> -	guest_exit_irqoff();
>> -
>>   	local_irq_enable();
>> +	/*
>> +	 * Wait until after servicing IRQs to account guest time so that any
>> +	 * ticks that occurred while running the guest are properly accounted
>> +	 * to the guest.  Waiting until IRQs are enabled degrades the accuracy
>> +	 * of accounting via context tracking, but the loss of accuracy is
>> +	 * acceptable for all known use cases.
>> +	 */
>> +	vtime_account_guest_exit();
> 
> This pops a warning for me, running guest(s) on Power8:
>   
>    [  270.745303][T16661] ------------[ cut here ]------------
>    [  270.745374][T16661] WARNING: CPU: 72 PID: 16661 at arch/powerpc/kernel/time.c:311 vtime_account_kernel+0xe0/0xf0

Thank you, I missed that...

My patch is wrong, I have to add vtime_account_guest_exit() before the local_irq_enable().

arch/powerpc/kernel/time.c

  305 static unsigned long vtime_delta(struct cpu_accounting_data *acct,
  306                                  unsigned long *stime_scaled,
  307                                  unsigned long *steal_time)
  308 {
  309         unsigned long now, stime;
  310
  311         WARN_ON_ONCE(!irqs_disabled());
...

But I don't understand how ticks can be accounted now if irqs are still disabled.

Not sure it is as simple as expected...

Thanks,
Laurent

