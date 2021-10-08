Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081854266B4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbhJHJ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:26:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236335AbhJHJ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633685058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N+kW7TpfSE1zTehVurPmFNQOjEaRU+dQabqRIwbQUzc=;
        b=WoFdTAxUTBD9ylW06GTUgQcvUwkqDfd1BEfw4gEq38Iaswkfp1FdEk1Xy/vlgojtgwsLWp
        JxLyPKW4aegGyBD6qtMibNLPhZtJBgTpbLZfIh4cDkzwhZEw1ITPA1hlKIg6Ng7PDr9jzz
        1/h4jZ2cCC/wMT3EhUOTYrNxeX0evOc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-WYJ3kBb4MeKd2X-kwgjbBw-1; Fri, 08 Oct 2021 05:24:17 -0400
X-MC-Unique: WYJ3kBb4MeKd2X-kwgjbBw-1
Received: by mail-wr1-f71.google.com with SMTP id c4-20020a5d6cc4000000b00160edc8bb28so1025640wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 02:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=N+kW7TpfSE1zTehVurPmFNQOjEaRU+dQabqRIwbQUzc=;
        b=fqEhlgs08Hl6vp8mjqpGG1wBXGXBeN8qmxZO+1fI+qh0EFt34IaEwAITST9LdwjJh8
         rlZgWvvjvcURF8aVK5tuMdAHG5qUNqIHBBfhkN8tMA5TcBkULylVZO9mYlvpSphdEdyS
         zWtnxjMqz7TXcGig4bTSou/sHIU4/E+Qg1bmIgvREI5HrsEDI7tgs6866lJLVLVRnmDY
         oBSx718xaeI2UKpnySaZYoln+BVkLkLGkz6gsZ0P84lyf15zQCtZDthq+IAraLA5Lgkv
         aK8icwKTbtJMRHke8pinuga/T/diOVoI/fYx0u623CfCObU2VVBfFE+PXj4dFe/ovZBM
         jU4w==
X-Gm-Message-State: AOAM5330BYAkqEee6WzAYtkOBlIei/OMTbvaX6O2O1BTu7R4dQRUUhul
        EkhJAt1kGZTwC2PRaJv2/Z7ITGnv9TsJnw6g57dvsbCXLzEnvfE1nPYtLPiWi/Gmp9f4W8Myv1W
        hHsc5IeRauci/RjaC1nYmfGg0
X-Received: by 2002:a1c:4d1a:: with SMTP id o26mr2298814wmh.54.1633685056597;
        Fri, 08 Oct 2021 02:24:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxTA+QFvTcIBel/SjddnSuNDNoKaQyKaFRG1G4Mady2kot1oW0ZmqSNs9wJN/r9Kfal5z+cA==
X-Received: by 2002:a1c:4d1a:: with SMTP id o26mr2298796wmh.54.1633685056414;
        Fri, 08 Oct 2021 02:24:16 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676e.dip0.t-ipconnect.de. [91.12.103.110])
        by smtp.gmail.com with ESMTPSA id n68sm11151469wmn.13.2021.10.08.02.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 02:24:16 -0700 (PDT)
Subject: Re: [PATCH] mm: Free per cpu pages async to shorten program exit time
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     ultrachin@163.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, brookxu.cn@gmail.com,
        chen xiaoguang <xiaoggchen@tencent.com>,
        zeng jingxiang <linuszeng@tencent.com>,
        lu yihui <yihuilu@tencent.com>
References: <20211008063933.331989-1-ultrachin@163.com>
 <d71e6021-777b-3ca9-b08f-64fe7ff51e08@redhat.com>
 <20211008105205.07d2f205@p-imbrenda>
 <1db11d75-d2d8-ef71-471a-ddad5c90a733@redhat.com>
 <20211008112235.1d37f2db@p-imbrenda>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <a279f2a0-7ede-88b6-f5e5-3d13699d18b4@redhat.com>
Date:   Fri, 8 Oct 2021 11:24:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211008112235.1d37f2db@p-imbrenda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.10.21 11:22, Claudio Imbrenda wrote:
> On Fri, 8 Oct 2021 11:15:25 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 08.10.21 10:52, Claudio Imbrenda wrote:
>>> On Fri, 8 Oct 2021 10:17:50 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>    
>>>> On 08.10.21 08:39, ultrachin@163.com wrote:
>>>>> From: chen xiaoguang <xiaoggchen@tencent.com>
>>>>>
>>>>> The exit time is long when program allocated big memory and
>>>>> the most time consuming part is free memory which takes 99.9%
>>>>> of the total exit time. By using async free we can save 25% of
>>>>> exit time.
>>>>>
>>>>> Signed-off-by: chen xiaoguang <xiaoggchen@tencent.com>
>>>>> Signed-off-by: zeng jingxiang <linuszeng@tencent.com>
>>>>> Signed-off-by: lu yihui <yihuilu@tencent.com>
>>>>
>>>> I recently discussed with Claudio if it would be possible to tear down
>>>> the process MM deferred, because for some use cases (secure/encrypted
>>>> virtualization, very large mmaps) tearing down the page tables is
>>>> already the much more expensive operation.
>>>>
>>>> There is mmdrop_async(), and I wondered if one could reuse that concept
>>>> when tearing down a process -- I didn't look into feasibility, however,
>>>> so it's just some very rough idea.
>>>
>>> I have done some experiments by unconditionally replacing mmdrop with
>>> mmdrop_async in exit.c and nothing broke, and exit time of large
>>> processes was almost instant (with the actual cleanup being performed in
>>> background)
>>>
>>> my approach is probably simpler/cleaner:
>>>
>>> diff --git a/include/asm-generic/mmu_context.h b/include/asm-generic/mmu_context.h
>>> index 91727065bacb..900931a6a105 100644
>>> --- a/include/asm-generic/mmu_context.h
>>> +++ b/include/asm-generic/mmu_context.h
>>> @@ -73,4 +73,8 @@ static inline void deactivate_mm(struct task_struct *tsk,
>>>    }
>>>    #endif
>>>    
>>> +#ifndef arch_exit_mm_mmput
>>> +#define arch_exit_mm_mmput mmput
>>> +#endif
>>> +
>>>    #endif /* __ASM_GENERIC_MMU_CONTEXT_H */
>>> diff --git a/kernel/exit.c b/kernel/exit.c
>>> index 9a89e7f36acb..604cb9c740fa 100644
>>> --- a/kernel/exit.c
>>> +++ b/kernel/exit.c
>>> @@ -498,7 +498,7 @@ static void exit_mm(void)
>>>           task_unlock(current);
>>>           mmap_read_unlock(mm);
>>>           mm_update_next_owner(mm);
>>> -       mmput(mm);
>>> +       arch_exit_mm_mmput(mm);
>>>           if (test_thread_flag(TIF_MEMDIE))
>>>                   exit_oom_victim();
>>>    }
>>>
>>> these are the minimal changes to common code, then each architecture can
>>> define their own arch_exit_mm_mmput as they see fit (for example, to free
>>> asynchronously only for certain classes of mm, like big ones, VMs, or so).
>>>
>>> Another option is to simply always replace mmput with mmput_async, which I
>>> expect will raise more eyebrows.
>>
>> Thanks Claudio.
>>
>> I guess we'd use some heuristic to keep the eyebrows down. Having
>> something like
>>
>> if (should_mput_async_on_exit(mm))
>> 	mmput_async(mm);
>> else
>> 	mmput(mm);
>>
>> whereby the heuristic can optionally consult the arch/config-knobs/...
>> doesn't sound too wrong to me if it works.
>>
> 
> yes, that is one of the possible solutions I had thought of.
> 
> although probably the small patch I posted above is even less intrusive
> and should hopefully raise even fewer eyebrows, while also leaving the
> door open to arch-specific code to do more than just mmput_async, if
> needed.

More flexibility might raise more eyebrows. :)

-- 
Thanks,

David / dhildenb

