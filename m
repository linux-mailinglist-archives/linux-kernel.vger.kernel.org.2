Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33AA43D651
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 00:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhJ0WMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 18:12:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229792AbhJ0WMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 18:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635372587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vPTDsq9RY16fTCCoMhEcqKhkYxR/hT5AGgzHMhJ6ojY=;
        b=GW84Vw7pza+og6AlQkSStDCr+1P5nspQ7TtvSEueKXYKAkG62c75otaTSgTDcHmZeCWVfT
        uwTNQTOGQCU7TvhtCZdIIeGUW18IXf5YInxnS1/X/q/y1v6tUSxRouck3/RjgSajycTUij
        gK+XzfOD7Ppyo2nzL6zjKY+Izr8o0ZI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-4klXvBO4NxeINm1YwrfHNA-1; Wed, 27 Oct 2021 18:09:45 -0400
X-MC-Unique: 4klXvBO4NxeINm1YwrfHNA-1
Received: by mail-ed1-f70.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso3609657edj.20
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vPTDsq9RY16fTCCoMhEcqKhkYxR/hT5AGgzHMhJ6ojY=;
        b=DHcVY1YQzLtziC4hDuV9vnEuuTqtwxUKLvtgAq5rXJ1r5tgaBhU2heXVwQmrEgLm15
         p4SihdYIYBUsJ3ImMuIgppJ4DZpNQoeWsPTjQCftkKT8mvR3PofG0Oi6rWsD9QjGwGL/
         ZFUYTPCw/75b9WdrL+JS35YD66oPGO97zeg8Jv0T0fvuA56F8kOkgexgVC2AlM8Dh2E4
         4f43CYm2IqIupYJmD+FUie37DMfxvAEpVGV0Qxu/1gbmrc2Z1VLVEYQ6JtaKa3R1+Bxn
         GCvg6Fh780vUi12KCcB21qOj61qHCX2H5Oh5TJ2ghZsrtzFkTQUixERbYC7YjL5r7UL5
         /TbA==
X-Gm-Message-State: AOAM533ItJYvde2gS1xoYmSX/K4LePKgGNwAOrU4BScsMjbjjHUwFcUE
        k/4NQIaiHg67p+lFvL2Sz/uPRl7umHkz3tEU8mmlJwVmX/EKOAFJal++Z6PHcJ1rJf7ELrClOnG
        +k+GCBzEaACdt2YPWux018/po
X-Received: by 2002:a17:906:3f95:: with SMTP id b21mr341849ejj.368.1635372584297;
        Wed, 27 Oct 2021 15:09:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoBx4vKjR30o+Kgjfdb4KsDUE6yjTUINxxdU8F5+6sRGk01DyvRy4bEl13EnJPgWSCV29mNQ==
X-Received: by 2002:a17:906:3f95:: with SMTP id b21mr341810ejj.368.1635372584078;
        Wed, 27 Oct 2021 15:09:44 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id a9sm675279edm.31.2021.10.27.15.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 15:09:43 -0700 (PDT)
Message-ID: <fdf90c2f-81c8-513b-2e06-a90959f4cd89@redhat.com>
Date:   Thu, 28 Oct 2021 00:09:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 39/43] KVM: VMX: Don't do full kick when triggering
 posted interrupt "fails"
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Oliver Upton <oupton@google.com>,
        Jing Zhang <jingzhangos@google.com>
References: <20211009021236.4122790-1-seanjc@google.com>
 <20211009021236.4122790-40-seanjc@google.com>
 <335822ac-b98b-1eec-4911-34e4d0e99907@redhat.com>
 <YXl4mK7CyUBnPaQV@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YXl4mK7CyUBnPaQV@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/21 18:04, Sean Christopherson wrote:
>>> +		/*
>>> +		 * The smp_wmb() in kvm_make_request() pairs with the smp_mb_*()
>>> +		 * after setting vcpu->mode in vcpu_enter_guest(), thus the vCPU
>>> +		 * is guaranteed to see the event request if triggering a posted
>>> +		 * interrupt "fails" because vcpu->mode != IN_GUEST_MODE.
>>
>> What this smp_wmb() pair with, is the smp_mb__after_atomic in
>> kvm_check_request(KVM_REQ_EVENT, vcpu).
>
> I don't think that's correct.  There is no kvm_check_request() in the relevant path.
> kvm_vcpu_exit_request() uses kvm_request_pending(), which is just a READ_ONCE()
> without a barrier.

Ok, we are talking about two different set of barriers.  This is mine:

- smp_wmb() in kvm_make_request() pairs with the smp_mb__after_atomic() in
kvm_check_request(); it ensures that everything before the request
(in this case, pi_pending = true) is seen by inject_pending_event.

- pi_test_and_set_on() orders the write to ON after the write to PIR,
pairing with vmx_sync_pir_to_irr and ensuring that the bit in the PIR is
seen.

And this is yours:

- pi_test_and_set_on() _also_ orders the write to ON before the read of
vcpu->mode, pairing with vcpu_enter_guest()

- kvm_make_request() however does _not_ order the write to
vcpu->requests before the read of vcpu->mode, even though it's needed.
Usually that's handled by kvm_vcpu_exiting_guest_mode(), but in this case
vcpu->mode is read in kvm_vcpu_trigger_posted_interrupt.

So vmx_deliver_nested_posted_interrupt() is missing a smp_mb__after_atomic().
It's documentation only for x86, but still easily done in v3.

Paolo

