Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45963E2E20
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 18:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbhHFQHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 12:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231778AbhHFQH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 12:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628266030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QDMPpNAqPC6c45pDZs2yjH7PLpb9RWebANU8kuJcJMc=;
        b=YhAl93vYm324FEnBzwDrvM2ST4GuHfXvYm7ASleSNC/wQFhlWqIONIB0NncxIS6JITX2bP
        ScSZocnFRMIMoaWNm42o08tPLdhml7MY/KVl32aXxtMELVFTDGHoMhK7D1pbhzb9sfHLTQ
        t2sMDOHDZcLsTxm7n+n+gkdSREE2K3k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-Dlj6xao0OZCfyc3Q6W-_tQ-1; Fri, 06 Aug 2021 12:07:08 -0400
X-MC-Unique: Dlj6xao0OZCfyc3Q6W-_tQ-1
Received: by mail-ed1-f72.google.com with SMTP id eg53-20020a05640228b5b02903bd6e6f620cso5176371edb.23
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 09:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QDMPpNAqPC6c45pDZs2yjH7PLpb9RWebANU8kuJcJMc=;
        b=pGiDPChOmnI1fjEN557aLZJTf281P6HJOGaY/ZQvYdvfBOHBOriSjNcYGMr/fdK3tM
         Sj1PKKEV8G1RhnDSBLOmbnsGU7EiNhoAcHDO/TUS7gFn0HJvTZztZmFljyJZRYroz5nQ
         6gUF4MXPJR4JJvKc5+6fo9VO4+JEOM5PXMgCw/Vg/fD30Q5/6ednxVrf4daCy1j9Z/US
         s9s09f7UgUMZ6OSlY7qOiK3mwDm5caqSh71Gsiksm4fqnOgOJqRF1sA82IOSLhujdsCG
         Ar//dYqQALgrwTJaWyX01AkqSlnn0yEx6Hrxhf7aNNQ9Re6G4efZ6pgbuFcGZQUhIRlH
         vx6Q==
X-Gm-Message-State: AOAM531lf0mrL9WdomG9nzZDP97SapDBzOjBULsJ5Bqu49dFV6bUTIo7
        /LfdA5z/zKCYj42+5/zIJIQdKrqF8xvFVNVTdN+kmQ2XYmvr3wNcLGwVmyYGx2IfqzYbq9Xqr7G
        9s9fpGPyQUoMbWXwQaHYMZiTu
X-Received: by 2002:aa7:d6cd:: with SMTP id x13mr13924593edr.300.1628266027560;
        Fri, 06 Aug 2021 09:07:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNut+zkF53aMyAth4YpbAYiNqCg0tB+sVJKxD8iKoH3db7FvFgJxKcgEjHFLbV48HftTBN/g==
X-Received: by 2002:aa7:d6cd:: with SMTP id x13mr13924568edr.300.1628266027375;
        Fri, 06 Aug 2021 09:07:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id ch5sm2738049edb.61.2021.08.06.09.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 09:07:06 -0700 (PDT)
Subject: Re: [RFC PATCH 00/10] KVM: x86/mmu: simplify argument to kvm page
 fault handler
To:     David Matlack <dmatlack@google.com>
Cc:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
References: <cover.1618914692.git.isaku.yamahata@intel.com>
 <YK65V++S2Kt1OLTu@google.com>
 <936b00e2-1bcc-d5cc-5ae1-59f43ab5325f@redhat.com>
 <20210610220056.GA642297@private.email.ne.jp>
 <CALzav=d2m+HffSLu5e3gz0cYk=MZ2uc1a3K+vP8VRVvLRiwd9g@mail.gmail.com>
 <92ffcffb-74c1-1876-fe86-a47553a2aa5b@redhat.com>
 <CALzav=eSrEGt9Xn99YtmHnWE1hm7ExZ4o_wjn_Rc0ZokLpizeQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <97ea1a31-4763-cefd-bfb8-8eeef46931b9@redhat.com>
Date:   Fri, 6 Aug 2021 18:07:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CALzav=eSrEGt9Xn99YtmHnWE1hm7ExZ4o_wjn_Rc0ZokLpizeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/21 19:24, David Matlack wrote:
> On Thu, Jul 29, 2021 at 10:17 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 29/07/21 18:48, David Matlack wrote:
>>> On Thu, Jun 10, 2021 at 3:05 PM Isaku Yamahata <isaku.yamahata@gmail.com> wrote:
>>>>
>>>> Thanks for feedback. Let me respin it.
>>>
>>> Hi Isaku,
>>>
>>> I'm working on a series to plumb the memslot backing the faulting gfn
>>> through the page fault handling stack to avoid redundant lookups. This
>>> would be much cleaner to implement on top of your struct
>>> kvm_page_fault series than the existing code.
>>>
>>> Are you still planning to send another version of this series? Or if
>>> you have decided to drop it or go in a different direction?
>>
>> I can work on this and post updated patches next week.
> 
> Sounds good. For the record I'm also looking at adding an per-vCPU LRU
> slot, which *may* obviate the need to pass around the slot. (Isaku's
> series is still a nice cleanup regardless.)

Backport done, but not tested very well yet (and it's scary :)).

Paolo

