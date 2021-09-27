Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984C9419A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbhI0RHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235729AbhI0RGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632762315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OceQJGplaRuhOhJC6xlNCBMIhl52paO/MQX3xAWc2qg=;
        b=imrtangPFQ3r1rN5mcTPe9nK1pbo6ZJhvwsdHS2aPsO7V6iPy0BvxWXuZfe1VDuawwsR9Z
        B5d2OlDyx32hED7zNI/TVx+gQ9vwo25o5xPrHzSE/KNZVFqpmXrxKZsAN2cMkrM+xRxA3w
        Z4MJbhWYYSF5EtHvXD1cxyXRRgiotRg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-MXYhx1WDPgy7mvpNGDkcMg-1; Mon, 27 Sep 2021 13:05:14 -0400
X-MC-Unique: MXYhx1WDPgy7mvpNGDkcMg-1
Received: by mail-wm1-f71.google.com with SMTP id 70-20020a1c0149000000b0030b7dd84d81so509751wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 10:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OceQJGplaRuhOhJC6xlNCBMIhl52paO/MQX3xAWc2qg=;
        b=jWnBakM5hrFpqPB7qTLBsETJx2Y/6on8tD6PKXawewqn3B2o6lQBkgAQuz7pIGqolE
         RBDRRP4j1fB+DuGWYGjhwsVYb7PHiXW/t60/4wbjOMoKPMKkFV9DgGWk6TgcNXcepGjQ
         EGlAzXDH1bubS6Ryd8V/nNbvQXuJHJ2nevvXsHVtHWU6GP4qgX5yfW9ecpLQ88q1Xsh7
         K2ZHY96jkcEmnTcwMXnexJs9ATFwHGdY1sfhBSSyA64ILi6H5NEsWPWEH4lx6CcXDPf+
         VwBIsQSfnTnaXeLtV7cvhaxDxJnobFmCGrpjfb3vqKecQDePXRVSoxKhJhuXHA6eBsiK
         iOcA==
X-Gm-Message-State: AOAM531CIuximaIUqHJXckM43szIQEd4qJi+dbFMgo7O1b94BRSCBg+w
        5fJqg3diGGks6AESyCniQjmbSLAaTlhD8b+fPBx8DFpZKMy7T95egtfxskGoZOWdMWBQ0TA4l80
        DCVaKEYk9nxRMHtpyqoPOPZMz
X-Received: by 2002:a05:600c:4c05:: with SMTP id d5mr172627wmp.2.1632762312712;
        Mon, 27 Sep 2021 10:05:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKDtyzWxoHjALiR62Xodk8Hky8hrOWja8rHGF9SfvFUqBOH/xqqTAFnMIa6/BzHZRMVRn7LA==
X-Received: by 2002:a05:600c:4c05:: with SMTP id d5mr172555wmp.2.1632762311999;
        Mon, 27 Sep 2021 10:05:11 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c654d.dip0.t-ipconnect.de. [91.12.101.77])
        by smtp.gmail.com with ESMTPSA id t16sm83386wmi.33.2021.09.27.10.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 10:05:11 -0700 (PDT)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/8] mm/madvise: support
 process_madvise(MADV_DONTNEED)
Message-ID: <f47970f5-faa7-9d5f-f07a-9399e4626eda@redhat.com>
Date:   Mon, 27 Sep 2021 19:05:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <AE756194-07D4-4467-92CA-9E986140D85D@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.21 14:00, Nadav Amit wrote:
> 
> 
>> On Sep 27, 2021, at 3:58 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 27.09.21 12:41, Nadav Amit wrote:
>>>> On Sep 27, 2021, at 2:24 AM, David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 26.09.21 18:12, Nadav Amit wrote:
>>>>> From: Nadav Amit <namit@vmware.com>
>>>>> The goal of these patches is to add support for
>>>>> process_madvise(MADV_DONTNEED). Yet, in the process some (arguably)
>>>>> useful cleanups, a bug fix and performance enhancements are performed.
>>>>> The patches try to consolidate the logic across different behaviors, and
>>>>> to a certain extent overlap/conflict with an outstanding patch that does
>>>>> something similar [1]. This consolidation however is mostly orthogonal
>>>>> to the aforementioned one and done in order to clarify what is done in
>>>>> respect to locks and TLB for each behavior and to batch these operations
>>>>> more efficiently on process_madvise().
>>>>> process_madvise(MADV_DONTNEED) is useful for two reasons: (a) it allows
>>>>> userfaultfd monitors to unmap memory from monitored processes; and (b)
>>>>> it is more efficient than madvise() since it is vectored and batches TLB
>>>>> flushes more aggressively.
>>>>
>>>> MADV_DONTNEED on MAP_PRIVATE memory is a target-visible operation; this is very different to all the other process_madvise() calls we allow, which are merely hints, but the target cannot be broken . I don't think this is acceptable.
>>> This is a fair point, which I expected, but did not address properly.
>>> I guess an additional capability, such as CAP_SYS_PTRACE needs to be
>>> required in this case. Would that ease your mind?
>>
>> I think it would be slightly better, but I'm still missing a clear use case that justifies messing with the page tables of other processes in that way, especially with MAP_PRIVATE mappings. Can you maybe elaborate a bit on a) and b)?
>>
>> Especially, why would a) make sense or be required? When would it be a good idea to zap random pages of a target process, especially with MAP_PRIVATE? How would the target use case make sure that the target process doesn't suddenly lose data? I would have assume that you can really only do something sane with uffd() if 1) the process decided to give up on some pages (madvise(DONTNEED)) b) the process hasn't touched these pages yet.
>>
>> Can you also comment a bit more on b)? Who cares about that? And would we suddenly expect users of madvise() to switch to process_madvise() because it's more effective? It sounds a bit weird to me TBH, but most probably I am missing details :)
> 
> Ok, ok, your criticism is fair. I tried to hold back some details in order to
> prevent the discussion from digressing. I am going to focus on (a) which is
> what I really have in mind.

Thanks for the details!

> 
> The use-case that I explore is a userspace memory manager with some level of
> cooperation of the monitored processes.
> 
> The manager is notified on memory regions that it should monitor
> (through PTRACE/LD_PRELOAD/explicit-API). It then monitors these regions
> using the remote-userfaultfd that you saw on the second thread. When it wants
> to reclaim (anonymous) memory, it:
> 
> 1. Uses UFFD-WP to protect that memory (and for this matter I got a vectored
>     UFFD-WP to do so efficiently, a patch which I did not send yet).
> 2. Calls process_vm_readv() to read that memory of that process.
> 3. Write it back to “swap”.
> 4. Calls process_madvise(MADV_DONTNEED) to zap it.
> 
> Once the memory is accessed again, the manager uses UFFD-COPY to bring it
> back. This is really work-in-progress, but eventually performance is not as
> bad as you would imagine (some patches for efficient use of uffd with
> iouring are needed for that matter).

Again, thanks for the details. I guess this should basically work, 
although it involves a lot of complexity (read: all flavors of uffd on 
other processes). And I am no so sure about performance aspects. 
"Performance is not as bad as you think" doesn't sound like the words 
you would want to hear from a car dealer ;) So there has to be another 
big benefit to do such user space swapping.

> 
> I am aware that there are some caveats, as zapping the memory does not
> guarantee that the memory would be freed since it might be pinned for a
> variety of reasons. That's the reason I mentioned the processes have "some
> level of cooperation" with the manager. It is not intended to deal with
> adversaries or uncommon corner cases (e.g., processes that use UFFD for
> their own reasons).

It's not only long-term pinnings. Pages could have been de-duplicated 
(COW after fork, KSM, shared zeropage). Further, you'll most probably 
lose any kind of "aging" ("accessed") information on pages, or how would 
you track that?

Although I can see that this might work, I do wonder if it's a use case 
worth supporting. As Michal correctly raised, we already have other 
infrastructure in place to trigger swapin/swapout. I recall that also 
damon wants to let you write advanced policies for that by monitoring 
actual access characteristics.

> 
> Putting aside my use-case (which I am sure people would be glad to criticize),
> I can imagine debuggers or emulators may also find use for similar schemes
> (although I do not have concrete use-cases for them).

I'd be curious about use cases for debuggers/emulators. Especially for 
emulators I'd guess it makes more sense to just do it within the 
process. And for debuggers, I'm having a hard time why it would make 
sense to throw away a page instead of just overwriting it with $PATTERN 
(e.g., 0). But I'm sure people can be creative :)

-- 
Thanks,

David / dhildenb

