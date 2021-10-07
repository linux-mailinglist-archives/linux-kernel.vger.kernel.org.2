Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4650C425848
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbhJGQsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242790AbhJGQsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633625215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=knvi0LpUORVHTDl2iRWayDlG6dCOhflKKRa42r69GJ4=;
        b=KZ+v9f9maww7x7mosxTp2YNAkW2xp0SBvRmWSo793UdzWApze1ga9SQhoaFjJxhU1+DE/9
        1f7/m+EllMYIKAJIBTATPPm3ZPW8KDEC9uTyT81DJ9xNpF8I3RXz2bJyVy4AMkwiHE20LF
        jhY2cy6JA19Ks2mbYnAQBsLkgHnc3aU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-EeNwbOR7NAG-AulwJ8dIMQ-1; Thu, 07 Oct 2021 12:46:54 -0400
X-MC-Unique: EeNwbOR7NAG-AulwJ8dIMQ-1
Received: by mail-wr1-f69.google.com with SMTP id r16-20020adfbb10000000b00160958ed8acso5177681wrg.16
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 09:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=knvi0LpUORVHTDl2iRWayDlG6dCOhflKKRa42r69GJ4=;
        b=6rWUsf7E05dAom4+ghcun1SirRWiF/9tWZSeXzIew2LT31mZPwYtH213UOccFnU1SM
         Wqj949NPSMW9hfyvB0JPkYSmTFkDRRMoLIctkbSiwWnGlm1oHAXshxz0TNtktCKhnsUB
         C7Hu9NtsSI+UgwHt779ezszEBcEqdQsMHKsSsbo9qbCq0pq2Am5WIJwh1jDRfXIof2TD
         YoM3fAUkFvgw2wf+CmnAfow65w1z8AntXrMNocw//EfAr/T3vOYO8eNtmdwtN6w/GkjY
         WoFZVbso2t8zpfIcq5Jh7aMGCx5ix1WytxedYkzn+Ki4EecDV1gty2dLKL1Ff0g+vAA7
         mxRQ==
X-Gm-Message-State: AOAM530vdkZ05Zxoj9qKvg77f1C+tSl0xAeYMsnQ1W7vdFyg+kV/Hk/c
        1c2m2Wg9Ey2OH6RJSd+QGf4Mrx0DuljtAfeiTiepkx2r2SAQGrBcr4dClWQxCWAqL/aAsDSq2YR
        Z+THVlqLAUe8QpWndM1fzmTIa
X-Received: by 2002:a05:6000:2c6:: with SMTP id o6mr6955662wry.292.1633625213373;
        Thu, 07 Oct 2021 09:46:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySoCN0Xa0lodfOTntiXdrCVF/isQq0EuvGiEU9iZ0RT2lcu3rHwmdZUu7EzjWbizLg1fkL5g==
X-Received: by 2002:a05:6000:2c6:: with SMTP id o6mr6955632wry.292.1633625213078;
        Thu, 07 Oct 2021 09:46:53 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6886.dip0.t-ipconnect.de. [91.12.104.134])
        by smtp.gmail.com with ESMTPSA id g1sm9867875wmk.2.2021.10.07.09.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 09:46:52 -0700 (PDT)
Subject: Re: [RFC PATCH 0/8] mm/madvise: support
 process_madvise(MADV_DONTNEED)
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <7ce823c8-cfbf-cc59-9fc7-9aa3a79740c3@redhat.com>
 <6E8A03DD-175F-4A21-BCD7-383D61344521@gmail.com>
 <2753a311-4d5f-8bc5-ce6f-10063e3c6167@redhat.com>
 <AE756194-07D4-4467-92CA-9E986140D85D@gmail.com>
 <f47970f5-faa7-9d5f-f07a-9399e4626eda@redhat.com>
 <9DE833C8-515F-4427-9867-E5BF9AD380FB@gmail.com>
 <9b53a85c-83f4-4548-c3b5-c65bd8737670@redhat.com>
 <C533782D-9E4B-41F5-9120-A31A4782BCE5@gmail.com>
 <a456a41d-c089-a639-b223-4412bad82e8d@redhat.com>
 <F41F322D-111E-4260-944C-48B7DEBF5C3E@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <5a7da918-9be4-1e92-187c-f7b6e27c4dcd@redhat.com>
Date:   Thu, 7 Oct 2021 18:46:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <F41F322D-111E-4260-944C-48B7DEBF5C3E@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.10.21 18:19, Nadav Amit wrote:
> 
> 
>> On Oct 4, 2021, at 10:58 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>>>>
>>>> Thanks for the pointer.
>>>>
>>>> And my question would be if something like DAMON would actually be what you want.
>>> I looked into DAMON and even with the proposed future extensions it sounds
>>> as a different approach with certain benefits but with many limitations.
>>> The major limitation of DAMON is that you need to predefine the logic you
>>> want for reclamation into the kernel. You can add programability through
>>> some API or even eBPF, but it would never be as easy or as versatile as
>>> what user manager can achieve. We already have pretty much all the
>>> facilities to do so from userspace, and the missing parts (at least for
>>> basic userspace manager) are almost already there. In contrast, see how
>>> many iterations are needed for the basic DAMON implementation.
>>
>> I can see what you're saying when looking at optimizing a hand full of special applications. I yet fail to see how something like that could work as a full replacement for in kernel swapping. I'm happy to learn.
> 
> I am not arguing it is a full replacement, at least at this stage.
> 
>>
>>> The second, also big, difference is that DAMON looks only on reclamation.
>>> If you want a custom prefetch scheme or different I/O stack for backing
>>> storage, you cannot have such one.
>>
>> I do wonder if it could be extended for prefetching. But I am absolutely not a DAMON expert.
>>
>> [...]
> 
> These are 2 different approaches. One, is to provide some logic
> for the kernel (DAMON). The other is to provide userspace full
> control over paging operations (with caveats). Obviously, due to
> the caveats, the kernel paging mechanism behaves as a backup.
> 
>>
>>>>
>>>> You raise a very excellent point (and it should have been part of your initial sales pitch): how does it differ to process_vm_writev().
>>>>
>>>> I can say that it differs in a way that you can break applications in more extreme ways. Let me give you two examples:
>>>>
>>>> 1. longterm pinnings: you raised this yourself; this can break an application silently and there is barely a safe way your tooling could handle it.
>>>>
>>>> 2. pagemap: applications can depend on the populated(present |swap) information in the pagemap for correctness. For example, there was recently a discussion to use pagemap information to speed up live migration of VMs, by skipping migration of !populated pages. There is currently no way your tooling can fake that. In comparison, ordinary swapping in the kernel can handle it.
>>> I understand (1). As for (2): the scenario that you mention sound
>>> very specific, and one can argue that ignoring UFFD-registered
>>> regions in such a case is either (1) wrong or (2) should trigger
>>> some UFFD event.
>>>>
>>>> Is it easy to break an application with process_vm_writev()? Yes. When talking about dynamic debugging, it's expected that you break the target already -- or the target is already broken. Is it easier to break an application with process_madvise(MADV_DONTNEED)? I'd say yes, especially when implementing something way beyond debugging as you describe.
>>> If you do not know what you are doing, you can easily break anything.
>>> Note that there are other APIs that can break your application even
>>> worse, specifically ptrace().
>>>> I'm giving you "a hard time" for the reason Michal raised: we discussed this in the past already at least two times IIRC and "it is a free ticket to all sorts of hard to debug problem" in our opinion; especially when we mess around in other process address spaces besides for debugging.
>>>>
>>>> I'm not the person to ack/nack this, I'm just asking the questions :)
>>> I see your points and I try to look for a path of least resistance.
>>> I thought that process_madvise() is a nice interface to hook into.
>>
>> It would be the right interface -- iff the operation wouldn't have a bad smell to it. We don't really want applications to mess around in the page table layout of some other process: however, that is exactly what you require. By unlocking that interface for that use case we agree that what you are proposing is a "sane use case", but  ...
>>
>>> But if you are concerned it will be misused, how about adding instead
>>> an IOCTL that will zap pages but only in UFFD-registered regions?
>>> A separate IOCTL for this matter have an advantage of being more
>>> tailored for UFFD, not to notify UFFD upon “remove” and to be less
>>> likely to be misused.
>>
>> ... that won't change the fact that with your user-space swapping approach that requires this interface we can break some applications silently, and that's really the major concern I have.
>>
>> I mean, there are more cases where you can just harm the target application I think, for example if the target application uses SOFTDIRTY tracking.
>>
>>
>> To judge if this is a sane use case we want to support, it would help a lot if there would be actual code+evaluation when actually implementing some of these advanced policies. Because you raise a lot of interesting points in your reply to Michal to back your use case, and naive me thinks "this sounds interesting but ... aren't we losing a lot of flexibility+features when doing this in user space? Does anyone actually want to do it like that?".
>>
>> Again, I'm not the person to ack/nack this, I'm just questioning if the use case that requires this interface is actually something that will get used later in real life because it has real advantages, or if it's a pure research project that will get abandoned at some point and we ended up exposing an interface we really didn't want to expose so far (especially, because all other requests so far were bogus).
> 
> I do want to release the code, but it is really
> incomplete/immature at this point. I would not that there additional
> use cases, such as workloads that have discardable cache (or memoization
> data), which want a central/another entity to discard the data when
> there is memory pressure. (You can think about it as a userspace
> shrinker).
> 
> Anyhow, as a path of least resistance, I think I would do the
> following:
> 
> 1. Wait for the other madvise related patches to be applied.
> 2. Simplify the patches, specifically removing the data structure
>     changes based on Kirill feedback.
> 3. Defer the enablement of the MADV_DONTNEED until I can show
>     code/performance numbers.

Sounds excellent, for your project to make progress at this stage I 
assume this stuff doesn't have to be upstream, but it's good to discuss 
upstream-ability.

Happy to learn more once you have more details to share.

-- 
Thanks,

David / dhildenb

