Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860C938E763
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhEXN1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232842AbhEXN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621862730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0kainRH42RdsY8Y3urUJhWHPRUuUeVjYP8+Uj0Uo0c=;
        b=GQxTa4wdHIyIEOSlQVSrOk6Kz406qieYtj62Wy+gUeclwGQjr1OkRyTSbxxOw0LEyi5F5G
        vo1HsKRvrJ/4h2ypd6M/giyBs2CM6r1WXpzIYp5VFzPKfzbK7ywkZE+klXWXXkv7n6KGQp
        md69XqUAIu6lbjJkaajhiPB31d7ESCI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-VIKcyGiQP7SiF7HhxAh98w-1; Mon, 24 May 2021 09:25:28 -0400
X-MC-Unique: VIKcyGiQP7SiF7HhxAh98w-1
Received: by mail-ed1-f72.google.com with SMTP id cy15-20020a0564021c8fb029038d26976787so14123789edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M0kainRH42RdsY8Y3urUJhWHPRUuUeVjYP8+Uj0Uo0c=;
        b=JZP3UyvgXwlW6BESsaLnUb4GuMS/fr8EvyohL9n9VPSRW/4qBP47Ov4XTc+VsJvkWb
         tzF8mk6/aAvLCiu/E/KGF3C//7/XEhv5FYfnFH6r8ga9i7T6pnmtf6ItH7ZhGNKihYg2
         mXwkux0qLT2FPRJ9xPe9nHoxZVtXUQTkRWD1IAb1vAh1efvxKdBFwGLEZ6aSAZpTrslX
         PqAZOm8iO2Do2I/xYn1G8BjBHcX4XSX/jBu6wnQdIkWkDsHjMXAPzj0VvoFTilh+2Lzn
         hgxO2PJ+/huNH4UYvJG2DU86tYYs/a9MlydU2pgwSi7JRWFOUvzZCLrszKAuvQcl3L8i
         7LGQ==
X-Gm-Message-State: AOAM532/uiVlbrNeuXBwNTZd8hrMc8663nd3fywMcWWi33Smyu3lF2m8
        t+Nt2p3bx1jrZTKFSaTDt95cUf7IqGh/7SMquGMBjJCxQwjZ3QlVeK15y+HgjqbFxLmPBawLWJ8
        66Kd6hKMu6nF1lrKnxyI3K6Ia
X-Received: by 2002:a17:906:eb0d:: with SMTP id mb13mr23097557ejb.261.1621862727709;
        Mon, 24 May 2021 06:25:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9QnvMOCLEMOMhpBAki5iXpY5iZp70ilUI2Tl1uFieprXzXpBLESyZxxJnCJHzmTQqktCk2A==
X-Received: by 2002:a17:906:eb0d:: with SMTP id mb13mr23097529ejb.261.1621862727542;
        Mon, 24 May 2021 06:25:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r17sm9231641edt.33.2021.05.24.06.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 06:25:26 -0700 (PDT)
Subject: Re: [PATCH v2 02/10] KVM: selftests: simplify setup_demand_paging
 error handling
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Ben Gardon <bgardon@google.com>
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
References: <20210519200339.829146-1-axelrasmussen@google.com>
 <20210519200339.829146-3-axelrasmussen@google.com>
 <CANgfPd-dF+vWafBC5DsNhf5C0M12+LxRQLhsBM=CzOKTsep+og@mail.gmail.com>
 <CAJHvVcizVoAs+-wOXeO7bc=8c2G3oEC4KSVyPm5E9Z6YMCsvaw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <824fe2de-a087-d2b4-406a-e8c6c040b37a@redhat.com>
Date:   Mon, 24 May 2021 15:25:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJHvVcizVoAs+-wOXeO7bc=8c2G3oEC4KSVyPm5E9Z6YMCsvaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/21 00:14, Axel Rasmussen wrote:
> On Wed, May 19, 2021 at 2:45 PM Ben Gardon <bgardon@google.com> wrote:
>>
>> On Wed, May 19, 2021 at 1:03 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>>>
>>> A small cleanup. Our caller writes:
>>>
>>>    r = setup_demand_paging(...);
>>>    if (r < 0) exit(-r);
>>>
>>> Since we're just going to exit anyway, instead of returning an error we
>>> can just re-use TEST_ASSERT. This makes the caller simpler, as well as
>>> the function itself - no need to write our branches, etc.
>>>
>>> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>>> ---
>>>   .../selftests/kvm/demand_paging_test.c        | 51 +++++++------------
>>>   1 file changed, 19 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
>>> index 9398ba6ef023..601a1df24dd2 100644
>>> --- a/tools/testing/selftests/kvm/demand_paging_test.c
>>> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
>>> @@ -9,6 +9,8 @@
>>>
>>>   #define _GNU_SOURCE /* for pipe2 */
>>>
>>> +#include <inttypes.h>
>>> +#include <stdint.h>
>>
>> Why do the includes need to change in this commit? Is it for the PRIu64 below?
> 
> Right, I didn't actually try compiling without these, but inttypes.h
> defines PRIu64 and stdint.h defines uint64_t. In general I tend to
> prefer including things like this because we're using their
> definitions directly, even if we might be picking them up transiently
> some other way.

inttypes.h is defined to include stdint.h (stdint.h is mostly useful in 
freestanding environments and is usually provided by the C compiler, 
while inttypes.h is provided by libc).

Paolo

