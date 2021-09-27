Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7357F419FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 21:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbhI0UBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbhI0UBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:01:23 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FF0C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:59:45 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso607650pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0uX8BxnP7RU6ObavICWgOW1Xr7/D2PuRUwXQhcbufF4=;
        b=QPQc78ytt3L74B6Xy3R/6rjTdnAnySOew79qV8CAbMu9yxRIFYvaiJwE3TfsMvqdSq
         QrwB3nWMyv1DH2urFI4SrkC1BV34PjD+VtlUERz/eYoYVUs2v2DA9ELodDfpWOhcMf0E
         dmeJLR/LraHvNVQChlR8SEfMERuLUwH5ARG65WID+49idPpRdl6fd1aOwKCQmAmEKsOr
         //zxLOIbDKa/Nzw9wcBpek2vYLhvIoJtwyWp6wGqv3yWDeC58t7P8lYu1gct7Navo18B
         R2wnVN3nA4YHKh8GepSzPJWL8q2MWqPNrrF9hTB20OllU20ofRQJwPS01LTwYyQoBrpJ
         sS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0uX8BxnP7RU6ObavICWgOW1Xr7/D2PuRUwXQhcbufF4=;
        b=IToyPG5W6HZHucbG+uativuzR2xjTzQdEWDa8gto/wpuUUxGqsR1kVb+YgxDc8iB/A
         B1t9gOZNaCI4o5zDQFxAKqgqYrPA6+oeRbMzSV/iK4ncmGrENs5P4h584mmrDNWTnuEM
         JU4ieLe0tFfC0AVowjWtCnBpmMXNvV33EOtv+1JI3nLt4BeX7B43lo3rMJ08Q6dr2I1Q
         w8WMzoj6aXM01Ojyvz+8KkXCMTv9xx/AcRfL+xRihxEV/eTKMNgZ62342DaKRsJaQFAr
         mY0cSRRBFTKGXvQZ3mKpxNSdMhvNIb6WscVzCYNiKujZaogZPrwfcjZABkB5PPmPC1tK
         2QyA==
X-Gm-Message-State: AOAM5316ya7B9S/DJM8ZQM2TBndLNEuaRYxfQiTk88Qm6XuMS3vaaA0R
        cT/34/uob1VbSHzzTxFVqns=
X-Google-Smtp-Source: ABdhPJz+jk4NxNO+t0wwEIWYn5cg/X3NlUEaT4YfFxIxbd44a5//SvceJmBGEYqXH9UAVFAoR4nxIw==
X-Received: by 2002:a17:90b:180f:: with SMTP id lw15mr989510pjb.210.1632772784740;
        Mon, 27 Sep 2021 12:59:44 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 23sm20396597pfw.97.2021.09.27.12.59.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Sep 2021 12:59:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 0/8] mm/madvise: support
 process_madvise(MADV_DONTNEED)
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <f47970f5-faa7-9d5f-f07a-9399e4626eda@redhat.com>
Date:   Mon, 27 Sep 2021 12:59:42 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9DE833C8-515F-4427-9867-E5BF9AD380FB@gmail.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <7ce823c8-cfbf-cc59-9fc7-9aa3a79740c3@redhat.com>
 <6E8A03DD-175F-4A21-BCD7-383D61344521@gmail.com>
 <2753a311-4d5f-8bc5-ce6f-10063e3c6167@redhat.com>
 <AE756194-07D4-4467-92CA-9E986140D85D@gmail.com>
 <f47970f5-faa7-9d5f-f07a-9399e4626eda@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 27, 2021, at 10:05 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 27.09.21 14:00, Nadav Amit wrote:
>>> On Sep 27, 2021, at 3:58 AM, David Hildenbrand <david@redhat.com> =
wrote:
>>>=20
>>> On 27.09.21 12:41, Nadav Amit wrote:
>>>>> On Sep 27, 2021, at 2:24 AM, David Hildenbrand <david@redhat.com> =
wrote:
>>>>>=20
>>>>> On 26.09.21 18:12, Nadav Amit wrote:
>>>>>> From: Nadav Amit <namit@vmware.com>
>>>>>> The goal of these patches is to add support for
>>>>>> process_madvise(MADV_DONTNEED). Yet, in the process some =
(arguably)
>>>>>> useful cleanups, a bug fix and performance enhancements are =
performed.
>>>>>> The patches try to consolidate the logic across different =
behaviors, and
>>>>>> to a certain extent overlap/conflict with an outstanding patch =
that does
>>>>>> something similar [1]. This consolidation however is mostly =
orthogonal
>>>>>> to the aforementioned one and done in order to clarify what is =
done in
>>>>>> respect to locks and TLB for each behavior and to batch these =
operations
>>>>>> more efficiently on process_madvise().
>>>>>> process_madvise(MADV_DONTNEED) is useful for two reasons: (a) it =
allows
>>>>>> userfaultfd monitors to unmap memory from monitored processes; =
and (b)
>>>>>> it is more efficient than madvise() since it is vectored and =
batches TLB
>>>>>> flushes more aggressively.
>>>>>=20
>>>>> MADV_DONTNEED on MAP_PRIVATE memory is a target-visible operation; =
this is very different to all the other process_madvise() calls we =
allow, which are merely hints, but the target cannot be broken . I don't =
think this is acceptable.
>>>> This is a fair point, which I expected, but did not address =
properly.
>>>> I guess an additional capability, such as CAP_SYS_PTRACE needs to =
be
>>>> required in this case. Would that ease your mind?
>>>=20
>>> I think it would be slightly better, but I'm still missing a clear =
use case that justifies messing with the page tables of other processes =
in that way, especially with MAP_PRIVATE mappings. Can you maybe =
elaborate a bit on a) and b)?
>>>=20
>>> Especially, why would a) make sense or be required? When would it be =
a good idea to zap random pages of a target process, especially with =
MAP_PRIVATE? How would the target use case make sure that the target =
process doesn't suddenly lose data? I would have assume that you can =
really only do something sane with uffd() if 1) the process decided to =
give up on some pages (madvise(DONTNEED)) b) the process hasn't touched =
these pages yet.
>>>=20
>>> Can you also comment a bit more on b)? Who cares about that? And =
would we suddenly expect users of madvise() to switch to =
process_madvise() because it's more effective? It sounds a bit weird to =
me TBH, but most probably I am missing details :)
>> Ok, ok, your criticism is fair. I tried to hold back some details in =
order to
>> prevent the discussion from digressing. I am going to focus on (a) =
which is
>> what I really have in mind.
>=20
> Thanks for the details!
>=20
>> The use-case that I explore is a userspace memory manager with some =
level of
>> cooperation of the monitored processes.
>> The manager is notified on memory regions that it should monitor
>> (through PTRACE/LD_PRELOAD/explicit-API). It then monitors these =
regions
>> using the remote-userfaultfd that you saw on the second thread. When =
it wants
>> to reclaim (anonymous) memory, it:
>> 1. Uses UFFD-WP to protect that memory (and for this matter I got a =
vectored
>>    UFFD-WP to do so efficiently, a patch which I did not send yet).
>> 2. Calls process_vm_readv() to read that memory of that process.
>> 3. Write it back to =E2=80=9Cswap=E2=80=9D.
>> 4. Calls process_madvise(MADV_DONTNEED) to zap it.
>> Once the memory is accessed again, the manager uses UFFD-COPY to =
bring it
>> back. This is really work-in-progress, but eventually performance is =
not as
>> bad as you would imagine (some patches for efficient use of uffd with
>> iouring are needed for that matter).
>=20
> Again, thanks for the details. I guess this should basically work, =
although it involves a lot of complexity (read: all flavors of uffd on =
other processes). And I am no so sure about performance aspects. =
"Performance is not as bad as you think" doesn't sound like the words =
you would want to hear from a car dealer ;) So there has to be another =
big benefit to do such user space swapping.

There is some complexity, indeed. Worse, there are some quirks of UFFD
that make life hard for no reason and some uffd and iouring bugs.

As for my sales pitch - I agree that I am not the best car dealer=E2=80=A6=
 :(
When I say performance is not bad, I mean that the core operations of
page-fault handling, prefetch and reclaim do not induce high overhead
*after* the improvements I sent or mentioned.

The benefit of doing so from userspace is that you have full control
over the reclaim/prefetch policies, so you may be able to make better
decisions.

Some workloads have predictable access patterns (see for instance "MAGE:
Nearly Zero-Cost Virtual Memory for Secure Computation=E2=80=9D, =
OSDI=E2=80=9921). You may
be handle such access patterns without requiring intrusive changes to =
the
workload.


>=20
>> I am aware that there are some caveats, as zapping the memory does =
not
>> guarantee that the memory would be freed since it might be pinned for =
a
>> variety of reasons. That's the reason I mentioned the processes have =
"some
>> level of cooperation" with the manager. It is not intended to deal =
with
>> adversaries or uncommon corner cases (e.g., processes that use UFFD =
for
>> their own reasons).
>=20
> It's not only long-term pinnings. Pages could have been de-duplicated =
(COW after fork, KSM, shared zeropage). Further, you'll most probably =
lose any kind of "aging" ("accessed") information on pages, or how would =
you track that?

I know it=E2=80=99s not just long-term pinnings. That=E2=80=99s what =
=E2=80=9Cvariety of reasons=E2=80=9D
stood for. ;-)

Aging is a tool for certain types of reclamation policies. Some do not
require it (e.g., random). You can also have compiler/application-guided
reclamation policies. If you are really into =E2=80=9Caging=E2=80=9D, =
you may be able
to use PEBS or other CPU facilities to track it.

Anyhow, the access-bit by itself not such a great solution to track
aging. Setting it can induce overheads of >500 cycles from my (and
others) experience.

>=20
> Although I can see that this might work, I do wonder if it's a use =
case worth supporting. As Michal correctly raised, we already have other =
infrastructure in place to trigger swapin/swapout. I recall that also =
damon wants to let you write advanced policies for that by monitoring =
actual access characteristics.

Hints, as those that Michal mentioned, prevent the efficient use of
userfaultfd. Using MADV_PAGEOUT will not trigger another uffd event
when the page is brought back from swap. So using
MADV_PAGEOUT/MADV_WILLNEED does not allow you to have a custom
prefetch policy, for instance. It would also require you to live
with the kernel reclamation/IO stack for better and worse.

As for DAMON, I am not very familiar with it, but from what I remember
it seemed to look on a similar direction. IMHO it is more intrusive
and less configurable (although it can have the advantage of better
integration with various kernel mechanism). I was wondering for a
second why you give me such a hard time for a pretty straight-forward
extension for process_madvise(), but then I remembered that DAMON got
into the kernel after >30 versions, so I=E2=80=99ll shut up about that. =
;-)

>=20
>> Putting aside my use-case (which I am sure people would be glad to =
criticize),
>> I can imagine debuggers or emulators may also find use for similar =
schemes
>> (although I do not have concrete use-cases for them).
>=20
> I'd be curious about use cases for debuggers/emulators. Especially for =
emulators I'd guess it makes more sense to just do it within the =
process. And for debuggers, I'm having a hard time why it would make =
sense to throw away a page instead of just overwriting it with $PATTERN =
(e.g., 0). But I'm sure people can be creative :)

I have some more vague ideas, but I am afraid that you will keep
saying that it makes more sense to handle such events from within
a process. I am not sure that this is true. Even for the emulators
that we discuss, the emulated program might run in a different
address space (for sandboxing). You may be able to avoid the need
for remote-UFFD and get away with the current non-cooperative
UFFD, but zapping the memory (for atomic updates) would still
require process_madvise(MADV_DONTNEED) [putting aside various
ptrace solutions].

Anyhow, David, I really appreciate your feedback. And you make
strong points about issues I encounter. Yet, eventually, I think
that the main question in this discussion is whether enabling
process_madvise(MADV_DONTNEED) is any different - from security
point of view - than process_vm_writev(), not to mention ptrace.
If not, then the same security guards should suffice, I would
argue.=
