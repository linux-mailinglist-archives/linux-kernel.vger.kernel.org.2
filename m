Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780833C2716
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 17:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhGIPy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 11:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232248AbhGIPy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 11:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625845933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VK85CjDgO7q1lh2C8SeovkJ7Y5QqbUrbsSNOKI14K4=;
        b=L+9i85MpAowxXjkB72UeqrS2wFUGTGLwIfuPahefUjda+E1pUZKnmo8lwUFhkr68W/bR+j
        zt8F1RVBxSmHjM9qAjo6FeLOoZPcYX2cCInLhSIvWe9R+/j/t46EKqLpc0ygqzxOy6txIR
        6cFortZbUcDauZRca/S3jXaBnVA5Qvs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-dMPqIeeCP1mqw7X3tkpeAQ-1; Fri, 09 Jul 2021 11:52:12 -0400
X-MC-Unique: dMPqIeeCP1mqw7X3tkpeAQ-1
Received: by mail-ej1-f70.google.com with SMTP id e23-20020a1709062497b0290504bafdd58dso1028137ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 08:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1VK85CjDgO7q1lh2C8SeovkJ7Y5QqbUrbsSNOKI14K4=;
        b=dCuYf4nSqiKR7waM/J5HWnz7EVFZexpy/1J52eo62zuN/Zs32Grxjpj53U/2MzOQUP
         OJcIxZrPF1GuhiQzXaYnm3R9MvSWgEFkrEdTmC4LZP71r8dx0Pc+UKMdtKLbTCAeLBDy
         pkkyAEueIwD4laYdrftz95RArRWLGzuy9nTyvqsFzvvLOgujFiq41kH6gVhFCgxRwXv/
         8z/IluiW+hrXnyR92W7Y0APJYBG2RimcsOS1CgoCH2x68rrybY3umLJ/AFEz1mRF1rV/
         s47Hzh7pCBZIhIZpqS0XDyVO0jG4fW36VcucDFmgQ0VF35664/0shqP9DQQqkskoCK7d
         bsAA==
X-Gm-Message-State: AOAM531xYEpbtbgsq4L1c/CDhO2AOM4KoduNoIZFm+LtqSInY6EzursV
        ChGqifJG4RwsshnZeHKDEp6NkN6Z9fBmh5r7JbDq9UzbVM6FMbQuy+qmKYWHKo53MX/qL05xIyh
        qYDSW4SwkXxql5KpzSYDDDAi+
X-Received: by 2002:a17:906:5d05:: with SMTP id g5mr36851526ejt.201.1625845931289;
        Fri, 09 Jul 2021 08:52:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoktX1Vnw/+FIXOZZuYI62Nh9l9V615NMqOPA3F2cp8ApW8p32uWSHT+X6K94dBjQ12SP5oA==
X-Received: by 2002:a17:906:5d05:: with SMTP id g5mr36851517ejt.201.1625845931147;
        Fri, 09 Jul 2021 08:52:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x1sm3060934edd.25.2021.07.09.08.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 08:52:10 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Also reload the debug registers before
 kvm_x86->run() when the host is using them
To:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org
References: <20210628172632.81029-1-jiangshanlai@gmail.com>
 <46e0aaf1-b7cd-288f-e4be-ac59aa04908f@redhat.com>
 <c79d0167-7034-ebe2-97b7-58354d81323d@linux.alibaba.com>
 <397a448e-ffa7-3bea-af86-e92fbb273a07@redhat.com>
 <a4e07fb1-1f36-1078-0695-ff4b72016d48@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <01946b5a-9912-3dfb-36f0-031f425432d2@redhat.com>
Date:   Fri, 9 Jul 2021 17:52:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a4e07fb1-1f36-1078-0695-ff4b72016d48@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/21 12:05, Lai Jiangshan wrote:
> 
> 
> On 2021/7/9 17:49, Paolo Bonzini wrote:
>> On 09/07/21 05:09, Lai Jiangshan wrote:
>>> I just noticed that emulation.c fails to emulate with DBn.
>>> Is there any problem around it?
>>
>> Just what you said, it's not easy and the needs are limited.  I 
>> implemented kvm_vcpu_check_breakpoint because I was interested in 
>> using hardware breakpoints from gdb, even with unrestricted_guest=0 
>> and invalid guest state, but that's it.
> 
> It seems kvm_vcpu_check_breakpoint() handles only for code breakpoint
> and doesn't handle for data breakpoints.

Correct, there's a comment above the call.  But data breakpoint are much 
harder and relatively less useful.

> And no code handles DR7_GD bit when the emulation is not resulted from
> vm-exit. (for example, the non-first instruction when kvm emulates
> instructions back to back and the instruction accesses to DBn).

Good point, that should be fixed too.

Paolo

