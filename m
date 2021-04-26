Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B3336B085
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhDZJ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232116AbhDZJ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619429215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vH6PHPNVgW+soUmxRszQomSaWOt8Rjil2he/aOQ/Phk=;
        b=A/e+QtvEu4zCGx87iPyNtCpN6ayPprVj3bPruU3YiX1pSARn6KTTPnS3XVgDjbYTEIwKcT
        940nQun/I+WyTWScfltHJiaKbhDD7Xtm4xEPFZ/Yo3XD4879S022crwDy+xZSpZmQ2l7Uo
        o7o/W4wg2zILBUH6BDi/x5i907+2V+o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-rn6Y0QXeMCufPSx-R6N9ww-1; Mon, 26 Apr 2021 05:26:53 -0400
X-MC-Unique: rn6Y0QXeMCufPSx-R6N9ww-1
Received: by mail-ej1-f71.google.com with SMTP id e18-20020a17090681d2b0290384d9ff1359so1009809ejx.16
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 02:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vH6PHPNVgW+soUmxRszQomSaWOt8Rjil2he/aOQ/Phk=;
        b=kt80s8AlMDrA9MTLTw4jWTUGxsodYz3SHkM9ASvTqQvU6QJ6kh8EMfM7zsMuYnaApv
         90l5qAEZWn+XOiBgn2I23h1i+9on+w8GhZzHNDoJU3Gc2XIGfBsQTUuhakWxWCQIelQZ
         GHtGnt09a7NOHB6mE7935ZNYeIFBwvZ5Z0GXRIe7uulII1OpcHmg7UXtdv3O93AMd6se
         pVkpovDcpJYrtJJbFZrr+nrqs2mYkpXbW2MEUaPolsUz5lQOw1B4vF7Wz4RTR17sP8D6
         asT1zIqVt4OS0xk6zcTWCdazJj6iUcaXQDCujQGzENCyhKpX7qmBdDaDMnz+1o1rT4Ar
         7Mmg==
X-Gm-Message-State: AOAM530RmtCFBYEKElcEo4UApXN87txAbFJAOHb8ETnBYPFouwMAzCv0
        19C4S2suyQdPR4xpypQhjQqoOK29WqKcvMjTp/kLCPx6ZJVlLzW7pQiB/Z5BWrCfpmHAFS9lEmI
        xTKFHPLxsv4ahfYtStVAw7OpK
X-Received: by 2002:a17:906:a20c:: with SMTP id r12mr17172413ejy.554.1619429211736;
        Mon, 26 Apr 2021 02:26:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIG7lPi5sdNtiMpin1qypwCFkStCx7GpzPsoj3D7lTuaFljiDF8g9+X8i2u+/SseKLlBOPhg==
X-Received: by 2002:a17:906:a20c:: with SMTP id r12mr17172399ejy.554.1619429211540;
        Mon, 26 Apr 2021 02:26:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id q10sm7410951eds.36.2021.04.26.02.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 02:26:51 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] KVM: x86: MSR_TSC_AUX fixes and improvements
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
References: <20210423223404.3860547-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cfeffc2d-b529-a573-2816-c8ae487041ac@redhat.com>
Date:   Mon, 26 Apr 2021 11:26:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210423223404.3860547-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/21 00:34, Sean Christopherson wrote:
> Fix potential cross-vendor landmines due to Intel and AMD having different
> behavior for MSR_TSC_AUX[63:32], unify the logic across SVM and VMX, and
> switch MSR_TSC_AUX via user return MSRs on SVM (the original goal).
> 
> v3:
>    - Fix a comment typo. [Reiji]
>    - Add patches to add missing guest_cpuid_has() check, drop bits 63:32 on
>      AMD, and unify VMX and SVM emulation.
>    - Rebase to kvm/next, commit c4f71901d53b ("Merge tag 'kvmarm-5.13' ... )
> 
> v2:
>    - Rebase to kvm/queue (ish), commit 0e91d1992235 ("KVM: SVM: Allocate SEV
>      command structures on local stack")
>    - https://lkml.kernel.org/r/20210422001736.3255735-1-seanjc@google.com
> 
> v1: https://lkml.kernel.org/r/20210206003224.302728-1-seanjc@google.com
> 
> 
> Sean Christopherson (4):
>    KVM: SVM: Inject #GP on guest MSR_TSC_AUX accesses if RDTSCP
>      unsupported
>    KVM: SVM: Clear MSR_TSC_AUX[63:32] on write
>    KVM: x86: Tie Intel and AMD behavior for MSR_TSC_AUX to guest CPU
>      model
>    KVM: SVM: Delay restoration of host MSR_TSC_AUX until return to
>      userspace
> 
>   arch/x86/kvm/svm/svm.c | 58 +++++++++++++++++-------------------------
>   arch/x86/kvm/svm/svm.h |  7 -----
>   arch/x86/kvm/vmx/vmx.c | 13 ----------
>   arch/x86/kvm/x86.c     | 34 +++++++++++++++++++++++++
>   4 files changed, 58 insertions(+), 54 deletions(-)
> 

Queued 1-2-4 (with fix for patch 2).

Paolo

