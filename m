Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A37C38E7E8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhEXNoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51960 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232903AbhEXNoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621863754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DUGrASOClCVVu+4hqHSu8VfIIMkQ9/UZu/ZQ1hqek/8=;
        b=MhufEkbuLsU/q2UUxz3q0qfgNtYZS4QaH/huXqzjS1u0IGv60q9bQY18wS0bYYTj9IFugG
        XFNz4xxQCBnDjI5s1joChw9aVO2bLgNd/8QD0stnt4hTnKCf8tk4mUpXVeayGeHfKivV71
        IKuhkMRpKpE40dIBLMFPCE9lr4h9D+4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-cSNDkjNnNH-thcDR-ePhpA-1; Mon, 24 May 2021 09:42:32 -0400
X-MC-Unique: cSNDkjNnNH-thcDR-ePhpA-1
Received: by mail-ed1-f71.google.com with SMTP id q18-20020a50cc920000b029038cf491864cso15566664edi.14
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DUGrASOClCVVu+4hqHSu8VfIIMkQ9/UZu/ZQ1hqek/8=;
        b=p7GeztU/2Syj81rXmY57PEJhCWQ8IhZBnXMuj0zCmTw1WNlv6A5HMSyAtqtPvt5yRI
         CgP/OA07h/1t3OxS5Boyv454aBeuuOhqrA0GsaDOSDEI58jN1F+aPwAHq7TOjMvxup3V
         S3qRDq6YjiYvrD/D6SS2sZAlT2DHbvcRRDq+bYhqcQFMzZtoqF0+GxhzPKM4ln2J1L02
         zsr38wx+e6lfjm9z4Sj1vt6E44yNU2/btaT64st5BXkMcuWErvSag+EuKe7mF4I17BrU
         5r1D0e3R+X9sI25i05D0SKE2LcrJqspBDz7eepYPQlRo3epWJwljR4d2WFdWUswpq5UA
         8FvQ==
X-Gm-Message-State: AOAM531AR6CFFK4VfuVB3drCsZUU9MpShj45DJ/AZV7Eego7InRcxy4c
        h8E5OZJ8DiJFQqxGYw7as9kPyAvn9Mz8Pnp+bkBuhUADA5XCr+tdrtEclkvmEZjlnE4yz6aIITZ
        fUzFRUmIWdK79T+glO6iaH32k
X-Received: by 2002:a17:906:d1d1:: with SMTP id bs17mr23600358ejb.492.1621863751795;
        Mon, 24 May 2021 06:42:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcWwMt0UzuQzlYcKpAU17jJOBCW8vfhS/ldYW7vG8tdP2J+BOzpNidMdWDqfxSu6zF1AB5Uw==
X-Received: by 2002:a17:906:d1d1:: with SMTP id bs17mr23600344ejb.492.1621863751659;
        Mon, 24 May 2021 06:42:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q16sm7960408ejm.12.2021.05.24.06.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 06:42:31 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] KVM: X86: Bail out of direct yield in case of
 under-committed scenarios
To:     Wanpeng Li <kernellwp@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1621339235-11131-1-git-send-email-wanpengli@tencent.com>
 <1621339235-11131-2-git-send-email-wanpengli@tencent.com>
 <YKQTx381CGPp7uZY@google.com>
 <CANRm+Cy_D3cBBEYQ9ApKMNC6p0dpTBQYQXs+dv5vrFedVkOy2w@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <889a0a43-0641-70ce-d2a5-ed71bd54e59c@redhat.com>
Date:   Mon, 24 May 2021 15:42:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CANRm+Cy_D3cBBEYQ9ApKMNC6p0dpTBQYQXs+dv5vrFedVkOy2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/21 04:57, Wanpeng Li wrote:
> Looks good. Hope Paolo can update the patch description when applying.:)
> 
> "In case of under-committed scenarios, vCPU can get scheduling easily,
> kvm_vcpu_yield_to add extra overhead, we can observe a lot of races
> between vcpu->ready is true and yield fails due to p->state is
> TASK_RUNNING. Let's bail out in such scenarios by checking the length
> of current cpu runqueue, it can be treated as a hint of under-committed
> instead of guaranteeing accuracy. 30%+ of directed-yield attempts can
> avoid the expensive lookups in kvm_sched_yield() in an under-committed
> scenario. "
> 

Here is what I used:

     In case of under-committed scenarios, vCPUs can be scheduled easily;
     kvm_vcpu_yield_to adds extra overhead, and it is also common to see
     when vcpu->ready is true but yield later failing due to p->state is
     TASK_RUNNING.
     
     Let's bail out in such scenarios by checking the length of current cpu
     runqueue, which can be treated as a hint of under-committed instead of
     guarantee of accuracy. 30%+ of directed-yield attempts can now avoid
     the expensive lookups in kvm_sched_yield() in an under-committed scenario.

Paolo

