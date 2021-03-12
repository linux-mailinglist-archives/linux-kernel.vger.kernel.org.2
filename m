Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19C333919C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhCLPna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:43:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59145 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231378AbhCLPn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615563806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wFAgdTMewsnYQw+ZERGa5q6Bhh7JRNwg5iyXn7hZdE=;
        b=HsJvm4C+Rm+owdN147MqK/TcB8ADVDG0Negr9thULE0fvUWZb1Yk0gqcsEK0fqKBpWtyhB
        bG871AXp6vMfaaSti4sgwYBx+2YCaMDC606qYQM+PMvfIUKKFUECbepGjAKbnws/5ir5WR
        FAk9ThAYvvbREuvKXbProo/dvJxpgg8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-Vr6MfYFMNziGKwocns9p2Q-1; Fri, 12 Mar 2021 10:43:23 -0500
X-MC-Unique: Vr6MfYFMNziGKwocns9p2Q-1
Received: by mail-wr1-f70.google.com with SMTP id p12so8743495wrn.18
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+wFAgdTMewsnYQw+ZERGa5q6Bhh7JRNwg5iyXn7hZdE=;
        b=SyflaKm1Bl2SqFdo/MSMkBkH/IBMsgDrkCTeped7J5hFZgxI5ZgUbzdjV20XyNOhLf
         h/hroFF3Kq7Pg9Yo89mBy/YwDhAHXwXq31lovz72c8uv3DaetTWPdzJhHOqDXTgMF89k
         wFlYgm2SewUvUZCB3gXzSZ/jv3w9/nAL50crx3ctBfJp3y2F2IctOvNEhFMGWPdDBI0T
         +gJzvvZwOX7zY5fOr7eqLXCZtBv/FZIKhDBlL0bk4gHFwkIqmUExWj8z34IEpbcRWipX
         WilmA+a8T1lAZ5fmAvonXog1o44I8mjFVZtiejVa+rFQ348b8CcJJdGXNzSR6H4igVte
         Cg5A==
X-Gm-Message-State: AOAM533VQ0TA8pQIdIAmNeqf0V3+BCJSK2oLkMnb1T/84zsSXC5XnIxe
        ulDrs6DPgi0fUvToQKcm0Lo3Ker1e6gz5LIQUy+xzc5gRhYya9xhx9EmKL2KBD8tWJUk6adAKqG
        cxPab5gIkBizHL5ib0yoPdtVF
X-Received: by 2002:adf:f411:: with SMTP id g17mr14347986wro.22.1615563802750;
        Fri, 12 Mar 2021 07:43:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjGJU99dXivFeb9iRMuZRQB3sCBDdlFdIMJEYxj6+jLKpF48JR+OqaVPuMnodV6Ku2khpH7g==
X-Received: by 2002:adf:f411:: with SMTP id g17mr14347973wro.22.1615563802618;
        Fri, 12 Mar 2021 07:43:22 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id w6sm8501228wrl.49.2021.03.12.07.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 07:43:22 -0800 (PST)
Subject: Re: [PATCH 1/4] KVM: x86/mmu: Fix RCU usage in
 handle_removed_tdp_mmu_page
To:     Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Peter Shier <pshier@google.com>,
        Jim Mattson <jmattson@google.com>
References: <20210311231658.1243953-1-bgardon@google.com>
 <20210311231658.1243953-2-bgardon@google.com> <YEuKx6ZveaT5RgAs@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cc472f99-f9f0-8a63-c38b-31a650b4a39c@redhat.com>
Date:   Fri, 12 Mar 2021 16:43:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YEuKx6ZveaT5RgAs@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/21 16:37, Sean Christopherson wrote:
> On Thu, Mar 11, 2021, Ben Gardon wrote:
>> The pt passed into handle_removed_tdp_mmu_page does not need RCU
>> protection, as it is not at any risk of being freed by another thread at
>> that point. However, the implicit cast from tdp_sptep_t to u64 * dropped
>> the __rcu annotation without a proper rcu_derefrence. Fix this by
>> passing the pt as a tdp_ptep_t and then rcu_dereferencing it in
>> the function.
>>
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Reported-by: kernel test robot <lkp@xxxxxxxxx>
> 
> Should be <lkp@intel.com>.  Looks like you've been taking pointers from Paolo :-)

The day someone starts confusing employers in CCs you should tell them 
"I see you have constructed a new email sending alias.  Your skills are 
now complete".

Paolo

> https://lkml.org/lkml/2019/6/17/1210
> 
> Other than that,
> 
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> 
>> Signed-off-by: Ben Gardon <bgardon@google.com>
> 

