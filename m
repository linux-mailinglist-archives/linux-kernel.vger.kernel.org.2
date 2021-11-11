Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243F544D7B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhKKOB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 09:01:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34987 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231739AbhKKOBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636639145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ESUXrCbNuii7JSa0LxmJs7Rc4Q6PMtXE/VioZv4aHGg=;
        b=Q7gx5XduY5XEgPjHyCWO6mu/B1LE/ev5GBcIQCtwB5/CPMNCKiM0HSkpKuQ/XTG4h/3mQX
        HVwaV5uuOKWfirtxJhcNbzLZMuALfzIU34VMMub6aKPPr+HKHe8Rjv8W2jb5U97C6xJZ0B
        qBwcxasWCGP/JV7TRvrAIjD2aqMs7Lw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-9rODn4MgNkurN-FcEcVcUA-1; Thu, 11 Nov 2021 08:59:04 -0500
X-MC-Unique: 9rODn4MgNkurN-FcEcVcUA-1
Received: by mail-wm1-f72.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso4817197wme.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 05:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ESUXrCbNuii7JSa0LxmJs7Rc4Q6PMtXE/VioZv4aHGg=;
        b=cP+JUJMHdI7ppjgVio8TfjpQQf0VximGE50tIMeQq0Bf8Eqlxts7xtvFvBTm17W9QJ
         nDwj1ZX4y+ghkxfV0e0uGOfJU45VM5ASpaxBPvaMYCP+Ab8hcH0ihaOw9Z3Ga0cUoyLk
         sxZqRjqEsv2aIL4x5cAYw50QjA7G0BM8iWQgIjItBgwvte5bhIiwGmi0g2kg8VBNsOx2
         8F5CrLZJnMqkBI0R3kKNDwaMf97RqZKxkllC880H2BZ9RQp3GFPsoeJZwa2tEODXcCks
         y0xh2CH/DHikBvDv6JUIPGfEOxnVKZA/n17oASnlHwEUhaQ4+kT4AJ7n4Q8qY6HzHoRM
         05nA==
X-Gm-Message-State: AOAM531IsfeUeTMBFJ+lDmEIPKif+30pb1Vq+lykagLt48efdYoQrZ1T
        4IUcVL8ezRs75LTvl62rmVEtMPHipctru06ZGfGdqFG/dSoYbdq6Sxy2ho+uiP/Pi6WHLqKmrKI
        6wBzlRZhyG/7BRnVN/JXlQF0j
X-Received: by 2002:adf:c70b:: with SMTP id k11mr8727181wrg.154.1636639142630;
        Thu, 11 Nov 2021 05:59:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNPT+SEiz5ns3CHBP3dPEYod/0tJHhdmafwryzWp3IhR0o00/k/QCTEV+3ZYi0oxKXVDMwnQ==
X-Received: by 2002:adf:c70b:: with SMTP id k11mr8727143wrg.154.1636639142358;
        Thu, 11 Nov 2021 05:59:02 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id d11sm2943517wrs.38.2021.11.11.05.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 05:59:01 -0800 (PST)
Message-ID: <ba60bedf-77e0-10e7-5857-faa1279d29ab@redhat.com>
Date:   Thu, 11 Nov 2021 14:59:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/2] KVM: x86: Sanitize writes to MSR_KVM_PV_EOI_EN
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Li RongQing <lirongqing@baidu.com>,
        linux-kernel@vger.kernel.org
References: <20211108152819.12485-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211108152819.12485-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/21 16:28, Vitaly Kuznetsov wrote:
> This is a continuation of work started by Li RongQing with
> "[PATCH] KVM: x86: disable pv eoi if guest gives a wrong address":
> https://lore.kernel.org/kvm/1636078404-48617-1-git-send-email-lirongqing@baidu.com/
> 
> Instead of resetting 'KVM_MSR_ENABLED' when a bogus address was written to
> MSR_KVM_PV_EOI_EN I suggest we refuse to update MSR at all, this aligns
> with #GP which is being injected on such writes.
> 
> Vitaly Kuznetsov (2):
>    KVM: x86: Rename kvm_lapic_enable_pv_eoi()
>    KVM: x86: Don't update vcpu->arch.pv_eoi.msr_val when a bogus value
>      was written to MSR_KVM_PV_EOI_EN
> 
>   arch/x86/kvm/hyperv.c |  4 ++--
>   arch/x86/kvm/lapic.c  | 23 ++++++++++++++---------
>   arch/x86/kvm/lapic.h  |  2 +-
>   arch/x86/kvm/x86.c    |  2 +-
>   4 files changed, 18 insertions(+), 13 deletions(-)
> 

Queued, thanks.

Paolo

