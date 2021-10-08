Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E6A426679
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhJHJRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235969AbhJHJRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633684539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h0m6F+5zadgowouPrrExZ1kaPYuwRnHxBe9uh7+Mk/A=;
        b=Fge/KvtxQ3SGwXJ7wu7ULr8vnNxqM50cT1x+uxSwAkr0fPCBxHmchJ45mYAjJPoJxwt/av
        m9eh7xv5Eb8hKn4Z5J51XDyfTIPtW7RmCtrx79I4BpA9yrbV6eryl7/+ohCzUs8JU5cIq4
        wPToolH4eSNUbXvmNDgaIQE1wWRMfYo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-gKTym5KnOc2z5bhd9tmYRw-1; Fri, 08 Oct 2021 05:15:28 -0400
X-MC-Unique: gKTym5KnOc2z5bhd9tmYRw-1
Received: by mail-wr1-f69.google.com with SMTP id a10-20020a5d508a000000b00160723ce588so6799136wrt.23
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 02:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=h0m6F+5zadgowouPrrExZ1kaPYuwRnHxBe9uh7+Mk/A=;
        b=Hxh4qJW7+QRO2TNbTImAJOLLMy3GQxdj0tR5iWxyRH2nklHumx/e/N0/L2VQliNZT9
         45OQvvL+4e0BckaJyQYEJa+RzHjP2b0QKGXk/dbU9I2/F4oXvp+fKXYOVln3iGVM31cA
         JdbTSf2A7RX2CPBcPhUSRWDdwQz7GQUrLp7F8r0Y5cHeJMpt+ssC+AlqKZjeD7laNTXU
         WoBSYXYeY589hacI/cwhVbqpRx8iImV0Lu+ULSGnJjml2Tk8l+S8tslbD1vY9nh/aEmS
         KJasTY0O4zv4dWbxbbC/CoJf2IV9/Q5w84IkT5z454rJoOCXjSNZDlodlolDuQvD2i8e
         dc1A==
X-Gm-Message-State: AOAM532+EKTrJODoe6i7D6msJ6lHE4w0tRBAviGL8B7KOQ5+uLr4RB4B
        7vFEVfXoED94AGKcx59qsMr5aqfp1YSqm+Aq2M/EOsJjiC9hR1CoABiT1/iseNa2FidPDwLDBRI
        +l0Dcs2SiQxUVcJEnFpGxdBuk
X-Received: by 2002:adf:bb49:: with SMTP id x9mr2494945wrg.413.1633684527150;
        Fri, 08 Oct 2021 02:15:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhjA72Z1ecXLKtLAZyfPsXgHBVALcs7blHK+2or3JE8vZJ+3NQO1m7NUe/Dr5DdGK+hGCqCQ==
X-Received: by 2002:adf:bb49:: with SMTP id x9mr2494918wrg.413.1633684526901;
        Fri, 08 Oct 2021 02:15:26 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676e.dip0.t-ipconnect.de. [91.12.103.110])
        by smtp.gmail.com with ESMTPSA id u24sm10586859wmj.48.2021.10.08.02.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 02:15:26 -0700 (PDT)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <1db11d75-d2d8-ef71-471a-ddad5c90a733@redhat.com>
Date:   Fri, 8 Oct 2021 11:15:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211008105205.07d2f205@p-imbrenda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.10.21 10:52, Claudio Imbrenda wrote:
> On Fri, 8 Oct 2021 10:17:50 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 08.10.21 08:39, ultrachin@163.com wrote:
>>> From: chen xiaoguang <xiaoggchen@tencent.com>
>>>
>>> The exit time is long when program allocated big memory and
>>> the most time consuming part is free memory which takes 99.9%
>>> of the total exit time. By using async free we can save 25% of
>>> exit time.
>>>
>>> Signed-off-by: chen xiaoguang <xiaoggchen@tencent.com>
>>> Signed-off-by: zeng jingxiang <linuszeng@tencent.com>
>>> Signed-off-by: lu yihui <yihuilu@tencent.com>
>>
>> I recently discussed with Claudio if it would be possible to tear down
>> the process MM deferred, because for some use cases (secure/encrypted
>> virtualization, very large mmaps) tearing down the page tables is
>> already the much more expensive operation.
>>
>> There is mmdrop_async(), and I wondered if one could reuse that concept
>> when tearing down a process -- I didn't look into feasibility, however,
>> so it's just some very rough idea.
> 
> I have done some experiments by unconditionally replacing mmdrop with
> mmdrop_async in exit.c and nothing broke, and exit time of large
> processes was almost instant (with the actual cleanup being performed in
> background)
> 
> my approach is probably simpler/cleaner:
> 
> diff --git a/include/asm-generic/mmu_context.h b/include/asm-generic/mmu_context.h
> index 91727065bacb..900931a6a105 100644
> --- a/include/asm-generic/mmu_context.h
> +++ b/include/asm-generic/mmu_context.h
> @@ -73,4 +73,8 @@ static inline void deactivate_mm(struct task_struct *tsk,
>   }
>   #endif
>   
> +#ifndef arch_exit_mm_mmput
> +#define arch_exit_mm_mmput mmput
> +#endif
> +
>   #endif /* __ASM_GENERIC_MMU_CONTEXT_H */
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 9a89e7f36acb..604cb9c740fa 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -498,7 +498,7 @@ static void exit_mm(void)
>          task_unlock(current);
>          mmap_read_unlock(mm);
>          mm_update_next_owner(mm);
> -       mmput(mm);
> +       arch_exit_mm_mmput(mm);
>          if (test_thread_flag(TIF_MEMDIE))
>                  exit_oom_victim();
>   }
> 
> these are the minimal changes to common code, then each architecture can
> define their own arch_exit_mm_mmput as they see fit (for example, to free
> asynchronously only for certain classes of mm, like big ones, VMs, or so).
> 
> Another option is to simply always replace mmput with mmput_async, which I
> expect will raise more eyebrows.

Thanks Claudio.

I guess we'd use some heuristic to keep the eyebrows down. Having 
something like

if (should_mput_async_on_exit(mm))
	mmput_async(mm);
else
	mmput(mm);

whereby the heuristic can optionally consult the arch/config-knobs/... 
doesn't sound too wrong to me if it works.

-- 
Thanks,

David / dhildenb

