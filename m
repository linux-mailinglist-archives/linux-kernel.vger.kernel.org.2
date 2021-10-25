Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E96439882
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhJYO2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:28:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233535AbhJYO2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635171973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bye7ObUVwxXJ2WkSXV7ATW6vdQkdYkTKPDS9mWywO4k=;
        b=VG20wsfW81XXPKqAw5GP7sPzbhA4Uz7GMRjfobhJBnMpVfvvUHWtqpsDWNV2Ht62lM784j
        pmJYBcOfQP8oznAKfuriTSHgRiFZxel+Z5PdBLZkPiya2ceE8r5gdUcHnnS6TYFTDxslEe
        4hEwvDnnw9gXIQwLAumNBYRTW6lPNLM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-huTX48CpPe-5tWAWj6CobQ-1; Mon, 25 Oct 2021 10:26:12 -0400
X-MC-Unique: huTX48CpPe-5tWAWj6CobQ-1
Received: by mail-ed1-f70.google.com with SMTP id w7-20020a056402268700b003dd46823a18so4196683edd.18
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bye7ObUVwxXJ2WkSXV7ATW6vdQkdYkTKPDS9mWywO4k=;
        b=Frw/UvfWDBvnqJF7Y3mPBKkkA48U3vV/Qz8E8UI7ei4UjLxNDns1BsMk1sEZSR2M0s
         RIisGZ8I2fBQMpjjmfXQ9wrLoNG9u/ymF0r3MR16n0gxkzYfDKFBNux9/kjiZ8uXdXOu
         khJJJAcNKkXiUgwlk6LzR2K4DCjCoya15eQxdpln/bFsVdYAbiioF2xddOWj9PfyLy0K
         +hGskY33PFWf80rJMDwsQRil23a9a6OrZ8JHh98rDiKv677mHebRRtqS5G7XA8c+z7EJ
         6rJpiJpKXMsMVhn8JuytrD7AnF94KOz5xJlMCerhXkgSnnD2GXwTwjyJlrcw/Z2BMStY
         maYw==
X-Gm-Message-State: AOAM5323a0xUZB0MnbfclEBXZiKgBLC9ojr8yRSpmWBeqL4+nolQQvbS
        3zLHNIBrK9txodQ8swF6rSywzNR8Ns4AYdH65jwDFLEuEicX9JQPf3FGB2chAIYl/3373ExDz6f
        SPWIjeyzaIFt7woOVeRrepHF2
X-Received: by 2002:a17:906:c0cf:: with SMTP id bn15mr21819122ejb.54.1635171971316;
        Mon, 25 Oct 2021 07:26:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1tQyM0wVdwMUOMrIgmjrbrmjI7F4R9FGcgAmNEuZGC3NNZA+IU7BqgOO63yxAXGZ3HmbepA==
X-Received: by 2002:a17:906:c0cf:: with SMTP id bn15mr21819096ejb.54.1635171971137;
        Mon, 25 Oct 2021 07:26:11 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g14sm5171403edp.31.2021.10.25.07.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 07:26:10 -0700 (PDT)
Message-ID: <0072221e-02e8-4d60-9b0f-80d8c423bf4e@redhat.com>
Date:   Mon, 25 Oct 2021 16:26:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 16/43] KVM: Don't redo ktime_get() when calculating
 halt-polling stop/deadline
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     James Morse <james.morse@arm.com>,
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
 <20211009021236.4122790-17-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211009021236.4122790-17-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/21 04:12, Sean Christopherson wrote:
> Calculate the halt-polling "stop" time using "cur" instead of redoing
> ktime_get().  In the happy case where hardware correctly predicts
> do_halt_poll, "cur" is only a few cycles old.  And if the branch is
> mispredicted, arguably that extra latency should count toward the
> halt-polling time.
> 
> In all likelihood, the numbers involved are in the noise and either
> approach is perfectly ok.

Using "start" makes the change even more obvious, so:

     Calculate the halt-polling "stop" time using "start" instead of redoing
     ktime_get().  In practice, the numbers involved are in the noise (e.g.,
     in the happy case where hardware correctly predicts do_halt_poll and
     there are no interrupts, "start" is probably only a few cycles old)
     and either approach is perfectly ok.  But it's more precise to count
     any extra latency toward the halt-polling time.

Paolo

