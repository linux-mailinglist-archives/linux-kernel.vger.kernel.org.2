Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4888041BA98
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243161AbhI1W6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243098AbhI1W6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:58:16 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4749EC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 15:56:36 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 66so222502pgc.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 15:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9Kh8hDlncEjZ7w5fojbMVJf8AHmCxFBkzWpNe+5wUJ0=;
        b=kC5tZQoFUle96O+WbZCHXk8ZMdHe7/xUQ/odIqMRBW3KGeSN8rQqDpj/Dmmq01CrhI
         Hub5fTbueitfwsyEUqATPN8TWVX/ugIOrscueLmI2Vn1XjubxlWEg2dO0Ig8moHGjeWK
         2O8qMszZGtTU9TemN0mgAYnq2t32Cx9BntGk2fSFLQXzhSwB+Z0+mqN72+OhW2HDypRx
         FAq08dsOGcwdgv8fqlu2uH2ljUEmwzRmpKDpMHxWQ2DaCGhib98Ib17sNiFT8TsFVQ/E
         EBAF1/nFuEV+bn9zNZ4ReDA99hM7ipcHsdzkOzMty9ftLjps6YKtPeO9vCaqofn3UkiX
         TW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9Kh8hDlncEjZ7w5fojbMVJf8AHmCxFBkzWpNe+5wUJ0=;
        b=bbhVcZeV1ECC7oQavBohTKeZJI8vg57EsNP0+rKdvE6dDe0HOZPLuyOsGDSsQ57kQi
         6AuN5miTCzB6f/4bt2+ZXIrs+4lN8Lqbf/5pg9lsYUJLh226O0M1M7jbTdG3SzQ5s9HO
         Q6gnAK8Xl3MmMJ2lkwUm6cqUmQ+1RCNrNB+fjA4Mbn6AmF8weCdAe7yw96T2JL9uuihb
         8hiva8HxRvxQYY5b2nHQElfvOL3DB59sEtH9K8ARBnp67ZzK8XBSqeBbiqSAKPbpRSA2
         i0gNNfJU+RzXrXVzctWVS59JpFPQ3j1un9CVGwc/oaDuIowro/UccMpY8LCkayLM8QrI
         0aJQ==
X-Gm-Message-State: AOAM533GvuuNd9EWATeEi1CkZSTIxDzvSrPofceqwDZ1AQ+GhSQRkZR0
        P25qF5VRa0pWd/H4Wd5m698=
X-Google-Smtp-Source: ABdhPJzAIkQIIBuOliB8iKrzZb45DENrJIRK5YyiOYkOOS8ZUm8YzMBKWfy4qVGbcWehKgNwLaIHnQ==
X-Received: by 2002:a63:e756:: with SMTP id j22mr6655784pgk.362.1632869795335;
        Tue, 28 Sep 2021 15:56:35 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id x21sm170041pfa.186.2021.09.28.15.56.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 15:56:34 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 0/8] mm/madvise: support
 process_madvise(MADV_DONTNEED)
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <9b53a85c-83f4-4548-c3b5-c65bd8737670@redhat.com>
Date:   Tue, 28 Sep 2021 15:56:33 -0700
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
Message-Id: <C533782D-9E4B-41F5-9120-A31A4782BCE5@gmail.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <7ce823c8-cfbf-cc59-9fc7-9aa3a79740c3@redhat.com>
 <6E8A03DD-175F-4A21-BCD7-383D61344521@gmail.com>
 <2753a311-4d5f-8bc5-ce6f-10063e3c6167@redhat.com>
 <AE756194-07D4-4467-92CA-9E986140D85D@gmail.com>
 <f47970f5-faa7-9d5f-f07a-9399e4626eda@redhat.com>
 <9DE833C8-515F-4427-9867-E5BF9AD380FB@gmail.com>
 <9b53a85c-83f4-4548-c3b5-c65bd8737670@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 28, 2021, at 1:53 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
>>>=20
>>> Again, thanks for the details. I guess this should basically work, =
although it involves a lot of complexity (read: all flavors of uffd on =
other processes). And I am no so sure about performance aspects. =
"Performance is not as bad as you think" doesn't sound like the words =
you would want to hear from a car dealer ;) So there has to be another =
big benefit to do such user space swapping.
>> There is some complexity, indeed. Worse, there are some quirks of =
UFFD
>> that make life hard for no reason and some uffd and iouring bugs.
>> As for my sales pitch - I agree that I am not the best car dealer=E2=80=
=A6 :(
>=20
> :)
>=20
>> When I say performance is not bad, I mean that the core operations of
>> page-fault handling, prefetch and reclaim do not induce high overhead
>> *after* the improvements I sent or mentioned.
>> The benefit of doing so from userspace is that you have full control
>> over the reclaim/prefetch policies, so you may be able to make better
>> decisions.
>> Some workloads have predictable access patterns (see for instance =
"MAGE:
>> Nearly Zero-Cost Virtual Memory for Secure Computation=E2=80=9D, =
OSDI=E2=80=9921). You may
>> be handle such access patterns without requiring intrusive changes to =
the
>> workload.
>=20
> Thanks for the pointer.
>=20
> And my question would be if something like DAMON would actually be =
what you want.

I looked into DAMON and even with the proposed future extensions it =
sounds
as a different approach with certain benefits but with many limitations.

The major limitation of DAMON is that you need to predefine the logic =
you
want for reclamation into the kernel. You can add programability through
some API or even eBPF, but it would never be as easy or as versatile as
what user manager can achieve. We already have pretty much all the
facilities to do so from userspace, and the missing parts (at least for
basic userspace manager) are almost already there. In contrast, see how
many iterations are needed for the basic DAMON implementation.

The second, also big, difference is that DAMON looks only on =
reclamation.
If you want a custom prefetch scheme or different I/O stack for backing
storage, you cannot have such one.

>=20
>>>=20
>>>> I am aware that there are some caveats, as zapping the memory does =
not
>>>> guarantee that the memory would be freed since it might be pinned =
for a
>>>> variety of reasons. That's the reason I mentioned the processes =
have "some
>>>> level of cooperation" with the manager. It is not intended to deal =
with
>>>> adversaries or uncommon corner cases (e.g., processes that use UFFD =
for
>>>> their own reasons).
>>>=20
>>> It's not only long-term pinnings. Pages could have been =
de-duplicated (COW after fork, KSM, shared zeropage). Further, you'll =
most probably lose any kind of "aging" ("accessed") information on =
pages, or how would you track that?
>> I know it=E2=80=99s not just long-term pinnings. That=E2=80=99s what =
=E2=80=9Cvariety of reasons=E2=80=9D
>> stood for. ;-)
>> Aging is a tool for certain types of reclamation policies. Some do =
not
>> require it (e.g., random). You can also have =
compiler/application-guided
>> reclamation policies. If you are really into =E2=80=9Caging=E2=80=9D, =
you may be able
>> to use PEBS or other CPU facilities to track it.
>> Anyhow, the access-bit by itself not such a great solution to track
>> aging. Setting it can induce overheads of >500 cycles from my (and
>> others) experience.
>=20
> Well, I'm certainly no expert on that; I would assume it's relevant in =
corner cases only: if you're application accesses all it's memory =
permanently a swap setup is already "broken". If you have plenty of old =
memory (VMs, databases, ...) it should work reasonably well. But yeah, =
detecting the working set size is a problematic problem, and "access"
> bits can be sub-optimal.
>=20
> After all, that's what the Linux kernel has been relying on for a long =
time ... and IIRC it might be extended by multiple "aging" queues soon.

I see your point. I do not want to waste time in our discussion by
focusing on recency-based reclamation schemes and access-bits. I was
just trying to point that such schemes and access-bit have their own
drawbacks.=20

>=20
>>>=20
>>> Although I can see that this might work, I do wonder if it's a use =
case worth supporting. As Michal correctly raised, we already have other =
infrastructure in place to trigger swapin/swapout. I recall that also =
damon wants to let you write advanced policies for that by monitoring =
actual access characteristics.
>> Hints, as those that Michal mentioned, prevent the efficient use of
>> userfaultfd. Using MADV_PAGEOUT will not trigger another uffd event
>> when the page is brought back from swap. So using
>> MADV_PAGEOUT/MADV_WILLNEED does not allow you to have a custom
>> prefetch policy, for instance. It would also require you to live
>> with the kernel reclamation/IO stack for better and worse.
>=20
> Would more uffd (or similar) events help?
>=20
>> As for DAMON, I am not very familiar with it, but from what I =
remember
>> it seemed to look on a similar direction. IMHO it is more intrusive
>> and less configurable (although it can have the advantage of better
>> integration with various kernel mechanism). I was wondering for a
>> second why you give me such a hard time for a pretty straight-forward
>> extension for process_madvise(), but then I remembered that DAMON got
>> into the kernel after >30 versions, so I=E2=80=99ll shut up about =
that. ;-)
>=20
> It took ... quite a long time, indeed :)
>=20
>>>=20
>>>> Putting aside my use-case (which I am sure people would be glad to =
criticize),
>>>> I can imagine debuggers or emulators may also find use for similar =
schemes
>>>> (although I do not have concrete use-cases for them).
>>>=20
>>> I'd be curious about use cases for debuggers/emulators. Especially =
for emulators I'd guess it makes more sense to just do it within the =
process. And for debuggers, I'm having a hard time why it would make =
sense to throw away a page instead of just overwriting it with $PATTERN =
(e.g., 0). But I'm sure people can be creative :)
>> I have some more vague ideas, but I am afraid that you will keep
>> saying that it makes more sense to handle such events from within
>> a process. I am not sure that this is true. Even for the emulators
>> that we discuss, the emulated program might run in a different
>> address space (for sandboxing). You may be able to avoid the need
>> for remote-UFFD and get away with the current non-cooperative
>> UFFD, but zapping the memory (for atomic updates) would still
>> require process_madvise(MADV_DONTNEED) [putting aside various
>> ptrace solutions].
>> Anyhow, David, I really appreciate your feedback. And you make
>> strong points about issues I encounter. Yet, eventually, I think
>> that the main question in this discussion is whether enabling
>> process_madvise(MADV_DONTNEED) is any different - from security
>> point of view - than process_vm_writev(), not to mention ptrace.
>> If not, then the same security guards should suffice, I would
>> argue.
>=20
> You raise a very excellent point (and it should have been part of your =
initial sales pitch): how does it differ to process_vm_writev().
>=20
> I can say that it differs in a way that you can break applications in =
more extreme ways. Let me give you two examples:
>=20
> 1. longterm pinnings: you raised this yourself; this can break an =
application silently and there is barely a safe way your tooling could =
handle it.
>=20
> 2. pagemap: applications can depend on the populated(present |swap) =
information in the pagemap for correctness. For example, there was =
recently a discussion to use pagemap information to speed up live =
migration of VMs, by skipping migration of !populated pages. There is =
currently no way your tooling can fake that. In comparison, ordinary =
swapping in the kernel can handle it.

I understand (1). As for (2): the scenario that you mention sound
very specific, and one can argue that ignoring UFFD-registered
regions in such a case is either (1) wrong or (2) should trigger
some UFFD event.

>=20
> Is it easy to break an application with process_vm_writev()? Yes. When =
talking about dynamic debugging, it's expected that you break the target =
already -- or the target is already broken. Is it easier to break an =
application with process_madvise(MADV_DONTNEED)? I'd say yes, especially =
when implementing something way beyond debugging as you describe.

If you do not know what you are doing, you can easily break anything.
Note that there are other APIs that can break your application even
worse, specifically ptrace().

> I'm giving you "a hard time" for the reason Michal raised: we =
discussed this in the past already at least two times IIRC and "it is a =
free ticket to all sorts of hard to debug problem" in our opinion; =
especially when we mess around in other process address spaces besides =
for debugging.
>=20
> I'm not the person to ack/nack this, I'm just asking the questions :)

I see your points and I try to look for a path of least resistance.
I thought that process_madvise() is a nice interface to hook into.

But if you are concerned it will be misused, how about adding instead
an IOCTL that will zap pages but only in UFFD-registered regions?
A separate IOCTL for this matter have an advantage of being more
tailored for UFFD, not to notify UFFD upon =E2=80=9Cremove=E2=80=9D and =
to be less
likely to be misused.

