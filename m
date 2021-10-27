Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE5243CE79
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhJ0QRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:17:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhJ0QRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635351289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YJ1AvjILyDHE6A0xH65m+vjqkknvkqBvDuAHk95niU8=;
        b=NNZezK5I92wtIcPstDA/xymm972gQZ9WtIC5LNxfA9/cKxuo+jbIJpAKxG+WhoLmdVV01i
        NfPQgaZ9mJOfSB0HBcNLWZgEKlOhbZu9FMixihVNRp0ciu5gnbRZwRTQfUaUFD0slfDuBp
        DgWNhhGjuOT8NzyXPJVCkv+W8CekUrs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-B302cc1FNk-CVBhEuZppYA-1; Wed, 27 Oct 2021 12:14:48 -0400
X-MC-Unique: B302cc1FNk-CVBhEuZppYA-1
Received: by mail-ed1-f69.google.com with SMTP id t1-20020a056402524100b003dd9a419eb5so2827623edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 09:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YJ1AvjILyDHE6A0xH65m+vjqkknvkqBvDuAHk95niU8=;
        b=UKtHBy8HvwRGirPeFHgWJG7HEucI/0j5mXKAwLVVEQOpDrWoYzrqD6RQ82JwGK4uNX
         d3z5BYq6jaFoFCKuuYxQY4fYl5uY690hxAKu/hZ2gzWZFcqecbB4e7MFwcBU8RtvErZp
         upgzvBlE45bKSYcsuvyOGsBQE+ESbppcBDI3GTIrrzF7m4kgRVzPLgQxjHIQudmsR8RM
         MRMxr2xlRNdEYOu3zTuSKjVGDCKY2ubklOh3rOpOThllGD+vBCallIlHEuMXgo5dSsL8
         G3hspbBohulxVaGO+PWZMIbMHh7OJEQunz/xMEKbZJWjmurJmVdQaQdd6L9cbj0EkQoK
         qDwg==
X-Gm-Message-State: AOAM530N6FRE0maZjntNeLIaQvJ99KFb+qCEAIut+lK/01WuDjxzpuS2
        vhpzCbJtgPhYlxlzM4QykthLU+dyM4pZXSXhQJaPIgbqpQuA4q3Nw5/s8KPQR4XpXHiWswQbsZp
        Pj2SZtRkT2pHYjy16/a/5W73i
X-Received: by 2002:a17:907:16a7:: with SMTP id hc39mr22891310ejc.214.1635351287165;
        Wed, 27 Oct 2021 09:14:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO/QgQ5GMyh0vFS/oBYQIX6qwD3vL9k6RGrSUIXFucShmCvNWLSsmfmRBNY3o+Ac+4bg3ipQ==
X-Received: by 2002:a17:907:16a7:: with SMTP id hc39mr22891269ejc.214.1635351286915;
        Wed, 27 Oct 2021 09:14:46 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id sb30sm195562ejc.45.2021.10.27.09.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 09:14:46 -0700 (PDT)
Message-ID: <d0746ea4-06e9-f65d-6e45-72b1b0dea29b@redhat.com>
Date:   Wed, 27 Oct 2021 18:14:44 +0200
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
 <185502d7-861e-fa5c-b225-419710fe77ed@redhat.com>
 <YXl5anv0Lyjx1cws@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YXl5anv0Lyjx1cws@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/21 18:08, Sean Christopherson wrote:
>> Right, so should we drop the "if (running)" check in this patch, at the same
>> time as it's adding the IN_GUEST_MODE check?
> LOL, I think we have a Three^WTwo Stooges routine going on.  This patch does
> remove avic_vcpu_is_running() and replaces it with the vcpu->mode check.  Or am
> I completely misunderstanding what your referring to?
> 
> -       if (avic_vcpu_is_running(vcpu)) {
> +       /*
> +        * Signal the doorbell to tell hardware to inject the IRQ if the vCPU
> +        * is in the guest.  If the vCPU is not in the guest, hardware will
> +        * automatically process AVIC interrupts at VMRUN.
> +        */
> +       if (vcpu->mode == IN_GUEST_MODE) {
>                  int cpu = READ_ONCE(vcpu->cpu);

Nevermind, I confused svm_deliver_avic_intr with avic_kick_target_vcpus, 
which anyway you are handling in patch 36.

Paolo

