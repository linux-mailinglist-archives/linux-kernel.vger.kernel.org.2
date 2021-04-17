Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917BC363008
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbhDQMul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 08:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232844AbhDQMuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 08:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618663813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=imq7uItrr0YxU0EZEqml8s/Gsv0G1i9Sjy/8OWB/B8c=;
        b=bjqHRMUXCN/+jLQ/3b3NStxGIqz5vfG8G0A9R0m0pS5kdxz8Rp7E9lv23MRXfib30zXCfq
        jJdBb26XsNC9NnHQqmRBKMEOzHcAx0tViufVIORt3Fb2X7210bM5UF+DUGkmTejD+5q8aw
        9wlhttnkhy7Dls2kpUBfe0rFOunjdg0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-Q2pazd0wN4mpgVMjvMyhHw-1; Sat, 17 Apr 2021 08:50:11 -0400
X-MC-Unique: Q2pazd0wN4mpgVMjvMyhHw-1
Received: by mail-ed1-f70.google.com with SMTP id i25-20020a50fc190000b0290384fe0dab00so3040099edr.6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 05:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=imq7uItrr0YxU0EZEqml8s/Gsv0G1i9Sjy/8OWB/B8c=;
        b=ckav68ENXIgbmp2dtgb0+2FcI72lDzBZMIzoV53Y6eU9kyCShI9ppwZDaaA0oZeA0I
         qu1I4N+rF+VbpXpZz9BTNEIyzsoghFnibL/KWgkyBClP35OT1KB5sFTvXpo28X1MeelO
         8M0LxgcR20vd34wpDiJ4alzpF6Fm+oNx8Ef6XrPtBEax5TodTYhYQiP+GiOf1knXTEyR
         vwYNHs5CtqT5bPUnE6BY9IWDKNeW4GMGQfOqFnKC5OBlylRNGdomJ4KtCgxOcLIc+S4U
         i3ohW/RhPwZ1A2fVGikO2Ibeo+Bk7L+x1qSeFi/D9PcQi0PCpVImcyktTnV6Z8cPpeZl
         9dTg==
X-Gm-Message-State: AOAM533sLs9tM1Exc64pIzgSq/3xG4hXo2vV9MUg/R6RQWYwovQjnLUI
        du8CVRX20nDojSvHrzJcXmZqnddl3pnXjai45sIUQ+4mg+ZCGuimo2c4vtHj0fyNpKhytCZDMe2
        uLxvGgNoCI0p7nRlgZssVu4wH
X-Received: by 2002:aa7:d9ce:: with SMTP id v14mr4720233eds.110.1618663810609;
        Sat, 17 Apr 2021 05:50:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySzvWasWJZOfOzLQumKdE/3y1yRtBrfqEec5ONJbUnF72oqb9NqEXYW3z6X8nsclSvPgFefw==
X-Received: by 2002:aa7:d9ce:: with SMTP id v14mr4720227eds.110.1618663810468;
        Sat, 17 Apr 2021 05:50:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n13sm6246042ejx.27.2021.04.17.05.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 05:50:09 -0700 (PDT)
Subject: Re: [PATCH 0/4] KVM: SVM: A fix and cleanups for vmcb tracking
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cathy Avery <cavery@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20210406171811.4043363-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0444df02-48de-6ff8-5e54-7dfb841ef153@redhat.com>
Date:   Sat, 17 Apr 2021 14:50:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210406171811.4043363-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/21 19:18, Sean Christopherson wrote:
> Belated code review for the vmcb changes that are queued for 5.13.
> 
> Sean Christopherson (4):
>    KVM: SVM: Don't set current_vmcb->cpu when switching vmcb
>    KVM: SVM: Drop vcpu_svm.vmcb_pa
>    KVM: SVM: Add a comment to clarify what vcpu_svm.vmcb points at
>    KVM: SVM: Enhance and clean up the vmcb tracking comment in
>      pre_svm_run()
> 
>   arch/x86/kvm/svm/svm.c | 29 +++++++++++++----------------
>   arch/x86/kvm/svm/svm.h |  2 +-
>   2 files changed, 14 insertions(+), 17 deletions(-)
> 

Queued, thanks -- especially for the bug in patch 1, which avoided review.

Paolo

