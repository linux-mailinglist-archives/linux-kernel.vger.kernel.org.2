Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEED6307663
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhA1MuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:50:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229852AbhA1MuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611838113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EUPoogxEubiZKmDpms6g+giQK6dPAk2ieocombt6yus=;
        b=OP+7wry/bylsz3i+FrQVfq6k4IxTmcu1GLsy7qXk8MlwsMWWLKbALVxShr1lcQYdLaKjLc
        zPdugs4O8Autu5ue7DoNxyJrElYoyPL3ceoj2pLUBFZJ18gwaHM15NYfSoMe2m6/5+QeC1
        lkW2F+VU89pp2Qp+sAQIuSHZpZV1buk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-UazItWNgPoOdhnTwN_7ULA-1; Thu, 28 Jan 2021 07:48:30 -0500
X-MC-Unique: UazItWNgPoOdhnTwN_7ULA-1
Received: by mail-ed1-f70.google.com with SMTP id a24so3101587eda.14
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 04:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EUPoogxEubiZKmDpms6g+giQK6dPAk2ieocombt6yus=;
        b=IsZqglom8MHx0LGH8+zeOjIjEsdICukndaHwZG3dY9dhCJo4wOH6oVPAJtmxXguRXj
         RV3mogk9Ox3A64WPTaMaNVH2iERnGVfjNwwq0hnJcZ0Iwy3BdnDNcpawFdvv1/on7WAM
         cUGTf9uGddJ+FhSxsO4kwyVOgLDcXIM5rIK4brhLtKhPA2iR9KeMhAmoKpYZippVHfMp
         Bs1Are5eKvOvROXz2nyaQqgv5CO2io+65YfqxNgs+LiVdwiXVXzsxIhzzxxtBOLikTf3
         ifKQhFxo6FRjlIjsE74shMCnhiIi3SIiye/MvzpKN8SX0Pm7eGV2LKJqMv6BjPSO66iT
         491w==
X-Gm-Message-State: AOAM531zB7CpjIDohf1W6R+Qodop/9WqJCg1MBg6+1nY4jpVH1+bo3mB
        L4Ywdy9/xu7Phkx799f7Dd0261PprBFRo55+8zu2qKLPkWFieL7plR64qobZRunoghNoOsIEmGj
        d7IohQ7gymHawc79GYEaCyBsV
X-Received: by 2002:a17:906:1741:: with SMTP id d1mr11214335eje.182.1611838109706;
        Thu, 28 Jan 2021 04:48:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/JAyUJF7PPPKqjMCwpTENChv61cKhvZqdnrTgL4rLTXUDksn14ITZ3hGVKqvIogwfrKLeYA==
X-Received: by 2002:a17:906:1741:: with SMTP id d1mr11214320eje.182.1611838109554;
        Thu, 28 Jan 2021 04:48:29 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x9sm2247425ejd.99.2021.01.28.04.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 04:48:28 -0800 (PST)
Subject: Re: [PATCH v3 0/2] KVM: x86/mmu: Skip mmu_notifier changes when
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
References: <20210128060515.1732758-1-stevensd@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c01b01dc-c636-1d1b-fb42-df718e23d20a@redhat.com>
Date:   Thu, 28 Jan 2021 13:48:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210128060515.1732758-1-stevensd@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/21 07:05, David Stevens wrote:
> These patches reduce how often mmu_notifier updates block guest page
> faults. The primary benefit of this is the reduction in the likelihood
> of extreme latency when handling a page fault due to another thread
> having been preempted while modifying host virtual addresses.
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
>   arch/x86/kvm/mmu/mmu.c                 | 16 ++++++++------
>   arch/x86/kvm/mmu/paging_tmpl.h         |  7 ++++---
>   include/linux/kvm_host.h               | 25 +++++++++++++++++++++-
>   virt/kvm/kvm_main.c                    | 29 ++++++++++++++++++++++----
>   6 files changed, 65 insertions(+), 16 deletions(-)
> 

Queued, thanks.

Paolo

