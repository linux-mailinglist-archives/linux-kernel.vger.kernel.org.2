Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A02C321F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhBVSUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:20:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232272AbhBVSSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614017832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M1O2O9X5RXSfF+m5PX0DyBo6+zLejZgNhGtzl18mwLU=;
        b=FNRVHNe5CfMAVPXVFmRvIU5n9TtA7YYFEYjtQBkgOC/QcmIouTfKp1Os1gxR6Rk3cVoFcw
        OBdvccM/XxS9Ad7gD+7PwdCPL60S/diPZK6xrZVZS/sf6i+HdxYOo9LBCb/GMPuq7fFWSj
        b+1esQY5BV02h5mBuOhTRZEnnBK8RAY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-PDDcpRLYPparchKpu0hBXw-1; Mon, 22 Feb 2021 13:17:09 -0500
X-MC-Unique: PDDcpRLYPparchKpu0hBXw-1
Received: by mail-ed1-f70.google.com with SMTP id s26so2391197edq.18
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 10:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M1O2O9X5RXSfF+m5PX0DyBo6+zLejZgNhGtzl18mwLU=;
        b=ZBQ5GJ30867vsvY+psH3YiueqrHbg7akXcufaqLH5X/8odu1r1HOSpeQvcpKdk/pKN
         bFsK/J3ebch1KYZzeYJ1euY/JN641MfrsaTYBzaI7aK37kO/U57+0GudCCzJvynaw/zN
         AE+TcpBfXTOj/Nvp5dVdCs9dQ6Of9DbahnCPs+fNieZHTr0KYay46NDIyeurOOxr5PK2
         DngVyVtjDC6t2cRAPgN8VBBQYxmI3R+SCvKVdqLgvGMPvnftVomdCrNgGlFNDlsA+wuj
         t2MPoG6Jp8zdvK/FPgZ/MtvO7xuDZozP+i3LP3Ew7k8YqVdAS24NIpBoVV94vjdXJhin
         qAxA==
X-Gm-Message-State: AOAM530UVI0d0Iw0JTZUQm1g4geCBxxRaWIEy8ywOvJYx+KRQV32fx1p
        Oveg30yrAE88Fj36dBxCUqe7BTlFfx1S/PczHtIUi6znMxMo2B2MgqUJy2nFFXXZ1KEXpMui44F
        1ZmK3u6/At8NaNw+U2a9GXVV4
X-Received: by 2002:a17:906:1c4f:: with SMTP id l15mr11171179ejg.148.1614017828674;
        Mon, 22 Feb 2021 10:17:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzT03kSWOr2tXOOmqkmqccMekugd1GPN0H9nHYrXxVs3CozSxxVXGpHmYF/OdiWxYx0Hw1ilw==
X-Received: by 2002:a17:906:1c4f:: with SMTP id l15mr11171153ejg.148.1614017828484;
        Mon, 22 Feb 2021 10:17:08 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d5sm12773936edu.12.2021.02.22.10.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 10:17:07 -0800 (PST)
Subject: Re: [PATCH v4 0/2] KVM: x86/mmu: Skip mmu_notifier changes when
 possible
To:     David Stevens <stevensd@chromium.org>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        linux-mips@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Stevens <stevensd@google.com>
References: <20210222024522.1751719-1-stevensd@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7fe10f74-e183-411a-468b-93fcdf786bb6@redhat.com>
Date:   Mon, 22 Feb 2021 19:17:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210222024522.1751719-1-stevensd@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/21 03:45, David Stevens wrote:
> These patches reduce how often mmu_notifier updates block guest page
> faults. The primary benefit of this is the reduction in the likelihood
> of extreme latency when handling a page fault due to another thread
> having been preempted while modifying host virtual addresses.
> 
> v3 -> v4:
>   - Fix bug by skipping prefetch during invalidation
> 
> v2 -> v3:
>   - Added patch to skip check for MMIO page faults
>   - Style changes
> 
> David Stevens (1):
>    KVM: x86/mmu: Consider the hva in mmu_notifier retry
> 
> Sean Christopherson (1):
>    KVM: x86/mmu: Skip mmu_notifier check when handling MMIO page fault
> 
>   arch/powerpc/kvm/book3s_64_mmu_hv.c    |  2 +-
>   arch/powerpc/kvm/book3s_64_mmu_radix.c |  2 +-
>   arch/x86/kvm/mmu/mmu.c                 | 23 ++++++++++++++------
>   arch/x86/kvm/mmu/paging_tmpl.h         |  7 ++++---
>   include/linux/kvm_host.h               | 25 +++++++++++++++++++++-
>   virt/kvm/kvm_main.c                    | 29 ++++++++++++++++++++++----
>   6 files changed, 72 insertions(+), 16 deletions(-)
> 

Rebased, and queued with the fix that Sean suggested.

Paolo

