Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED5D43CDBC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242803AbhJ0PjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232502AbhJ0Pi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635348991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5uRyMZIN45jCj2VKDrWR2a9G78BQWuHGJKl7OtHJZ6k=;
        b=e2dR+en+X1RDREBLLt64xZsmtbn2gJbApYWO5LX8Vut55CfpXVAk81mSZdLNxqHu/Ho85b
        ubVa4Dq6esUrtQxHn2He/jDyHvGeNyRITA+GUK+2vIMqB8clziqaw2gtKhvjWKphvPlBXg
        387CZYQIr/IItEkZlX7eLGEgp9R0xts=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-pL3ztGaHN26W6JesGyRGpg-1; Wed, 27 Oct 2021 11:36:30 -0400
X-MC-Unique: pL3ztGaHN26W6JesGyRGpg-1
Received: by mail-ed1-f70.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso2693982edj.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 08:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5uRyMZIN45jCj2VKDrWR2a9G78BQWuHGJKl7OtHJZ6k=;
        b=dWz5Ty8MirmahhY5N/NSFeoSrsht3ixqkUUCP4BduHhhZA7GqoSP6LHZtsqhLmfhaI
         Ipo6XBlnZFlCBbdixOnk94UjVLYBev+wmkVSoY16gBKOs8ENAXzaDB5TvKV+RjLOFDWR
         Ez1sdcLRqhjmjQ3ofg+ObaTUPFd50B0wKVPKEj5WwkxM0Vmb38o5P6gMG9uMUjHAXQ/R
         jDf5mMCiG/x45PTn1JKuiAbgPstm3gVKpOIbLe9fuRtMQbcI4GHMOhbmCUlTBkA3ql11
         k7s/Mhh9zQzIxf/GsBs7e0kG7oQiu7XLV1dv0yIOip5Vitf/0hemylGNi7agS53wlu9S
         5+sg==
X-Gm-Message-State: AOAM530BVyVpaEnr9FRQ35M1AulMeFakwyX4JVJq3QkOSxClh4QNEZQr
        G1VwugZG6FzqHzZlglyX8BctdZJbyS41rjB8PojbA7bAEcOotwhgnBaWWJK4cM6qmJfym+1Pwf6
        zuydZFn3F2uA98v0n4NUoDbU9
X-Received: by 2002:a17:907:72d4:: with SMTP id du20mr27123521ejc.324.1635348988843;
        Wed, 27 Oct 2021 08:36:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlnTQW53CgmXIn8to0kDTGFp7NuPe5vIqIt10aS0tdUzKBzxmlSrEKcMCaMlb8sNDTKtez8Q==
X-Received: by 2002:a17:907:72d4:: with SMTP id du20mr27123484ejc.324.1635348988605;
        Wed, 27 Oct 2021 08:36:28 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id dx2sm110885ejb.125.2021.10.27.08.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 08:36:26 -0700 (PDT)
Message-ID: <185502d7-861e-fa5c-b225-419710fe77ed@redhat.com>
Date:   Wed, 27 Oct 2021 17:36:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 35/43] KVM: SVM: Signal AVIC doorbell iff vCPU is in
 guest mode
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
 <20211009021236.4122790-36-seanjc@google.com>
 <0333be2a-76d8-657a-6c82-3bb5c9ff2e3b@redhat.com>
 <YXlrEWmBohaDXmqL@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YXlrEWmBohaDXmqL@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/21 17:06, Sean Christopherson wrote:
>> Does this still need to check the "running" flag?  That should be a strict
>> superset of vcpu->mode == IN_GUEST_MODE.
>
> No.  Signalling the doorbell when "running" is set but the vCPU is not in the
> guest is just an expensive nop.  So even if KVM were to rework its handling of
> "running" to set the flag immediately before VMRUN and clear it immediately after,
> keying off IN_GUEST_MODE and not "running" would not be wrong, just sub-optimal.
> 
> I doubt KVM will ever make the "running" flag super precise, because keeping the
> flag set when the vCPU is loaded avoids VM-Exits on other vCPUs due to undelivered
> IPIs.

Right, so should we drop the "if (running)" check in this patch, at the 
same time as it's adding the IN_GUEST_MODE check?

Paolo

