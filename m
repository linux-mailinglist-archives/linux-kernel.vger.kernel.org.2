Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3656A419FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhI0UNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:13:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236865AbhI0UNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632773490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pj/EUfIghA08vvhVZK2MUBzA9iLVxgFUTk/F+NTTbH4=;
        b=GyGCqeUp6lgQru5uW4T0pWWtoKjf8oeGle+Qzg0bTl0sLDcRaK5xvU/fnPnwwE+HvNF1Tx
        rv1Kv0eOZXrkeSDuNxmAvvBop7puKSlBG1lh+lEt10N5vfUd+m0Kyn3cJ1glPjYNeFRpU7
        HeTURWakVFpP9WOIvB/6fOMpVoQfrNM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-olW8GbOtOcakQ7Nkzn0NAg-1; Mon, 27 Sep 2021 16:11:27 -0400
X-MC-Unique: olW8GbOtOcakQ7Nkzn0NAg-1
Received: by mail-wm1-f69.google.com with SMTP id n30-20020a05600c3b9e00b002fbbaada5d7so22908wms.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pj/EUfIghA08vvhVZK2MUBzA9iLVxgFUTk/F+NTTbH4=;
        b=aGHFsShUOjVbrc4jQx32KdGn+QQcvpAiBe7THn85/JaYuCK7bFfz5mzyGX5pes0qMO
         t8KI9pYtVEw7PMu4VLjeXxNBL8tLq1hrA71Nev3QQWYsMhEcGbmvdP4S9UMJzYbmuhhq
         UdHELijIKocjLDc91HwC993sjOnEUIBzFDbeWr8ML2SVRwiH/TlYzPBBeZHBbeIUgdN5
         o71ww+9SN96IkS1pjoRdYAZNYymW20Z3ZtestaCmGoSqceBS+/3StY7wNMdUCtzPrLSB
         JfQvLr4p7aFE7P20Tl7CGQ+cxmwkXWeLQaw08BKR0xky0o3kKMaJhh03UBvr+HSawxDs
         hTKg==
X-Gm-Message-State: AOAM530dQH/ywwTaMRsy8HvibEDMFewlJ/ogRBQexwb/nLZJqIVAXZml
        u8wAlUDHqc6j4Io78t4AhAuuRZC0lEQLAjmtOrr9AMVz08Th9wYpeyGqWDdHoiuyV4eZIYxv0IZ
        L/U6RpHMjJYunTwtaYRZDr+nC
X-Received: by 2002:a5d:664f:: with SMTP id f15mr851842wrw.143.1632773485895;
        Mon, 27 Sep 2021 13:11:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoWvQUJqxRNlHP8f8DrBT7m8as2FOZ2XM1YS2Y0rWerq8c02XB8yG4qH8aOZoEGqYDpXufyw==
X-Received: by 2002:a5d:664f:: with SMTP id f15mr851828wrw.143.1632773485671;
        Mon, 27 Sep 2021 13:11:25 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c654d.dip0.t-ipconnect.de. [91.12.101.77])
        by smtp.gmail.com with ESMTPSA id i203sm544747wma.7.2021.09.27.13.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 13:11:25 -0700 (PDT)
Subject: Re: [RFC PATCH] userfaultfd: support control over mm of remote PIDs
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>
References: <20210926170637.245699-1-namit@vmware.com>
 <83827672-0996-4c25-9991-697ad443b6b3@redhat.com>
 <A7E15D2B-FFED-4F21-88F4-227E7228782D@gmail.com>
 <21c6a41d-3f65-6a49-f604-b75ef53d2910@redhat.com>
 <75ECD9E1-4696-42CB-BD84-FF9C350BB227@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <6ab883e5-e49e-73ca-9f48-6251d57622e9@redhat.com>
Date:   Mon, 27 Sep 2021 22:11:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <75ECD9E1-4696-42CB-BD84-FF9C350BB227@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.21 22:08, Nadav Amit wrote:
> 
> 
>> On Sep 27, 2021, at 10:06 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 27.09.21 12:19, Nadav Amit wrote:
>>>> On Sep 27, 2021, at 2:29 AM, David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 26.09.21 19:06, Nadav Amit wrote:
>>>>> From: Nadav Amit <namit@vmware.com>
>>>>> Non-cooperative mode is useful but only for forked processes.
>>>>> Userfaultfd can be useful to monitor, debug and manage memory of remote
>>>>> processes.
>>>>> To support this mode, add a new flag, UFFD_REMOTE_PID, and an optional
>>>>> second argument to the userfaultfd syscall. When the flag is set, the
>>>>> second argument is assumed to be the PID of the process that is to be
>>>>> monitored. Otherwise the flag is ignored.
>>>>> The syscall enforces that the caller has CAP_SYS_PTRACE to prevent
>>>>> misuse of this feature.
>>>>
>>>> What supposed to happen if the target process intents to use uffd itself?
>>> Thanks for the quick response.
>>> First, sorry that I mistakenly dropped the changes to userfaultfd.h
>>> that define UFFD_REMOTE_PID.
>>
>> Didn't even notice it :)
>>
>>> As for your question: there are standard ways to deal with such cases,
>>> similarly to when a debugged program wants to use PTRACE. One way is
>>> to block the userfaultfd syscall, using seccomp. Another way is to do
>>> chaining using ptrace (although using ptrace for anything is
>>> challenging).
>>> It is also possible to add tailor something specific to userfaultfd,
>>> but I think seccomp is a good enough solution. I am open to suggestions.
>>
>> If we have something already in place to handle PTRACE, we'd better reuse what's already there. Thanks!
> 
> Just to ensure we are on the same page: I meant that this is usually
> left for the user application to handle. The 2 basic solutions are to
> not expose userfaultfd to the monitored process (easy using seccomp)
> or to chain the two monitors (hard using ptrace).

Yes, and I agree that the first approach then makes sense. Chaining 
might be way to complicated to support.

As long as the kernel will continue working when a second one tries to 
register (which I think is the case), that should be good enough.

> 
> Since ptrace is hard, in theory we can have facilities to “hijack”
> a context and “inject” uffd event to another monitor. I just think
> it is a total overkill at this stage.

Agreed


-- 
Thanks,

David / dhildenb

