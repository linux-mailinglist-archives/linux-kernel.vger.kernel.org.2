Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6AF4193C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhI0MBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbhI0MBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:01:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCF8C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:00:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m26so15652694pff.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bw0oRxKf3JFM9EeUXYvDRBPNH5GnO41KoUgDGV8RG1I=;
        b=oE63S/xPVqjabQZ6QGQMrjiB351K03/h01HVFPiII7EbrEhQHFYpKIbU5XZAlijqg5
         0VAOitmfcMIUiS3kWanFSWgVZlawcSDcXsjKzVK3OkstGZgc4YbxKU10r/8+1E9keeva
         KMt/ecZNa1RBoltO5DtUblLdzEPu6MBYrt9HmhXASLg91L18p34IQWVPXe7NC7IYVCH3
         LJrpSR4JUUt+51gfpqAhior3pGCuekKyldJCBEScwOTOLI4EMHRUntFl74Cv5gVVuJ4U
         Y+B8COfN5nBy2nL/soM7GOYYGi4yL84JcpE07VdeSuHiM78CsjH6+eXMM7KdzY5WVBzh
         wQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bw0oRxKf3JFM9EeUXYvDRBPNH5GnO41KoUgDGV8RG1I=;
        b=qNqOMzBNQPOFhPWgF/KYem1zSmicrxAkqfZjMbWe4Ap1+BZ5P43aOIZ9P7FkLpEWkE
         CdZDhPQfewKaUQ+dZiXpBlEjPLDeAvt1rYpMdU8Mi51xV62axg82Ot4LlEwosxvbgFUx
         +4BgsGeXCKji0c2TJhSddoxOTcM90J0EVYYgIxVOwWYZDrg8wKrj/B5B95goOJj/f3ok
         Oc32BjF7ApG5uXKS1Ez/iYDvgvWXNrWZA9Zf4BrAYhnpwck+bcctHXeCOUKAVTDmXKRO
         dBk5ENLJ0xELty//RsiMsHsHetMctTPIDhehVAPnzd9mRd0DfIygbBkny8PgO0fX21hD
         X+KQ==
X-Gm-Message-State: AOAM5331MMoYmWFHrXcjodJON1nmRVEnfBV2gvUH8cFAWTzq5IC2mAYO
        0BEYG7Vwmg7ZDoLsD13s8WfXyD7aqME=
X-Google-Smtp-Source: ABdhPJwp2tN3e6iOVTPHNSKmY4uRC0cRN2RNE+4sxxGhbCcYYyK26Twb77jiZJiMFQIGh8FoGxcH1g==
X-Received: by 2002:aa7:9d02:0:b0:43d:ea96:5882 with SMTP id k2-20020aa79d02000000b0043dea965882mr22835813pfp.23.1632744013449;
        Mon, 27 Sep 2021 05:00:13 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id u24sm18403484pfm.81.2021.09.27.05.00.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Sep 2021 05:00:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 0/8] mm/madvise: support
 process_madvise(MADV_DONTNEED)
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <2753a311-4d5f-8bc5-ce6f-10063e3c6167@redhat.com>
Date:   Mon, 27 Sep 2021 05:00:11 -0700
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
Message-Id: <AE756194-07D4-4467-92CA-9E986140D85D@gmail.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <7ce823c8-cfbf-cc59-9fc7-9aa3a79740c3@redhat.com>
 <6E8A03DD-175F-4A21-BCD7-383D61344521@gmail.com>
 <2753a311-4d5f-8bc5-ce6f-10063e3c6167@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 27, 2021, at 3:58 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 27.09.21 12:41, Nadav Amit wrote:
>>> On Sep 27, 2021, at 2:24 AM, David Hildenbrand <david@redhat.com> =
wrote:
>>>=20
>>> On 26.09.21 18:12, Nadav Amit wrote:
>>>> From: Nadav Amit <namit@vmware.com>
>>>> The goal of these patches is to add support for
>>>> process_madvise(MADV_DONTNEED). Yet, in the process some (arguably)
>>>> useful cleanups, a bug fix and performance enhancements are =
performed.
>>>> The patches try to consolidate the logic across different =
behaviors, and
>>>> to a certain extent overlap/conflict with an outstanding patch that =
does
>>>> something similar [1]. This consolidation however is mostly =
orthogonal
>>>> to the aforementioned one and done in order to clarify what is done =
in
>>>> respect to locks and TLB for each behavior and to batch these =
operations
>>>> more efficiently on process_madvise().
>>>> process_madvise(MADV_DONTNEED) is useful for two reasons: (a) it =
allows
>>>> userfaultfd monitors to unmap memory from monitored processes; and =
(b)
>>>> it is more efficient than madvise() since it is vectored and =
batches TLB
>>>> flushes more aggressively.
>>>=20
>>> MADV_DONTNEED on MAP_PRIVATE memory is a target-visible operation; =
this is very different to all the other process_madvise() calls we =
allow, which are merely hints, but the target cannot be broken . I don't =
think this is acceptable.
>> This is a fair point, which I expected, but did not address properly.
>> I guess an additional capability, such as CAP_SYS_PTRACE needs to be
>> required in this case. Would that ease your mind?
>=20
> I think it would be slightly better, but I'm still missing a clear use =
case that justifies messing with the page tables of other processes in =
that way, especially with MAP_PRIVATE mappings. Can you maybe elaborate =
a bit on a) and b)?
>=20
> Especially, why would a) make sense or be required? When would it be a =
good idea to zap random pages of a target process, especially with =
MAP_PRIVATE? How would the target use case make sure that the target =
process doesn't suddenly lose data? I would have assume that you can =
really only do something sane with uffd() if 1) the process decided to =
give up on some pages (madvise(DONTNEED)) b) the process hasn't touched =
these pages yet.
>=20
> Can you also comment a bit more on b)? Who cares about that? And would =
we suddenly expect users of madvise() to switch to process_madvise() =
because it's more effective? It sounds a bit weird to me TBH, but most =
probably I am missing details :)

Ok, ok, your criticism is fair. I tried to hold back some details in =
order to
prevent the discussion from digressing. I am going to focus on (a) which =
is
what I really have in mind.

The use-case that I explore is a userspace memory manager with some =
level of
cooperation of the monitored processes.

The manager is notified on memory regions that it should monitor
(through PTRACE/LD_PRELOAD/explicit-API). It then monitors these regions
using the remote-userfaultfd that you saw on the second thread. When it =
wants
to reclaim (anonymous) memory, it:

1. Uses UFFD-WP to protect that memory (and for this matter I got a =
vectored
   UFFD-WP to do so efficiently, a patch which I did not send yet).
2. Calls process_vm_readv() to read that memory of that process.
3. Write it back to =E2=80=9Cswap=E2=80=9D.
4. Calls process_madvise(MADV_DONTNEED) to zap it.

Once the memory is accessed again, the manager uses UFFD-COPY to bring =
it
back. This is really work-in-progress, but eventually performance is not =
as
bad as you would imagine (some patches for efficient use of uffd with
iouring are needed for that matter).

I am aware that there are some caveats, as zapping the memory does not
guarantee that the memory would be freed since it might be pinned for a
variety of reasons. That's the reason I mentioned the processes have =
"some
level of cooperation" with the manager. It is not intended to deal with
adversaries or uncommon corner cases (e.g., processes that use UFFD for
their own reasons).

Putting aside my use-case (which I am sure people would be glad to =
criticize),
I can imagine debuggers or emulators may also find use for similar =
schemes
(although I do not have concrete use-cases for them).

