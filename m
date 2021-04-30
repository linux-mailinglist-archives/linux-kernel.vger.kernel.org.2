Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910423703AB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 00:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhD3Wrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 18:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhD3Wri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 18:47:38 -0400
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015B5C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 15:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619822809; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=fJc0kA3fs/qruXvzgmrKcb7wfYSj45xD72XuNv/vz0Q=;
 b=jiyXUQRBFWbSvoXE8S+89IbrFJx09VR8KGQtn6ZnMMP4vFXbVWuXATw3pbAkNq3E49ZRF
 T23FGno/pGOKlWxBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619822809; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=fJc0kA3fs/qruXvzgmrKcb7wfYSj45xD72XuNv/vz0Q=;
 b=IlHc98e/KMRtviK1tALUlBEchZj0bmYNI0aJ8ljSMxcf4EPX/LCEMCbXmdE5TqB289LE2
 /GQLFqFBUEgnkCjKqrhug+4OiOT8vfxRFCEHCI98dUWhxVoKtdHfqfHdl9uzEP8uS751DrI
 APlt2sk/ZxDkuq/+TOGeKii7CPGTvgLCG15SD/XDGKaD0P3FNtQ5I//t4lic2Y1tD7oeTD9
 MQJcI9fFpIhPq0CQMoFHIBaCPPArIo9wo4CSyf6d+sL/ax7hJY5kB1FBD5CwO7sggeuBfkR
 jSd9EDz57P7ReyGhGH+vGECjo9iRBifc1aW338tYcAuaSr62MQ9KPspto4FA==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 81D4C16030E; Fri, 30 Apr 2021 15:46:49 -0700 (PDT)
Date:   Fri, 30 Apr 2021 15:46:49 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 00/29] Speculative page faults (anon vmas only)
Message-ID: <20210430224649.GA29203@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 12:52:01PM -0700, Michel Lespinasse wrote:
> This patchset is my take on speculative page faults (spf).
> It builds on ideas that have been previously proposed by Laurent Dufour,
> Peter Zijlstra and others before. While Laurent's previous proposal
> was rejected around the time of LSF/MM 2019, I am hoping we can revisit
> this now based on what I think is a simpler and more bisectable approach,
> much improved scaling numbers in the anonymous vma case, and the Android
> use case that has since emerged. I will expand on these points towards
> the end of this message.

I want to address a few questions that I think are likely to come up,
about how this patchset relates to others currently being worked on,
and about design points for this patchset (mainly about the
per-mm sequence count).


I- Maple tree

I do not think there is any fundamental conflict between the maple
tree patches currently being considered, and this patchset.
I actually have a (very lightly tested) tree merging the two together,
which was a fairly easy merge. For those interested, I made this
available at my github, as the v5.12-maple-spf branch.

At the same time, Matthew & Liam have made it known that they would
like to build some lockless fault facilities on top of maple tree,
and even though these ideas have not been implemented yet (AFAIK),
my proposal probably falls short of what they have in mind.
From my point of view, I do not see that as a fundamental conflict
either; my take is that I like to use a more incremental approach and
that the speculative page fault ideas are worth exploring on their own;
they could be further extended in the future with some of the additional
ideas I have heard discussed in association to maple tree.

I am aware of two main areas where my proposal is more limited than
the plans I have heard from Matthew & Liam. Maybe there are more, and
I hope they will correct me of that is the case. But, the ones I know
about would be:

1- VMA lookups. This patchset has mmap writers update a sequence
counter around updates; the speculative fault path uses that counter
to detect concurrent updates when looking up and copying the VMA.
This means lookups might fail if they overlap with a concurrent mmap
writer; the alternative discussed by maple tree proponents would be to
make VMAs immutable and have the writers actually make a new copy when
they want to update. While this might impose some costs on the writers,
it would benefit the fault path in two ways: first, lookups would always
succeed, and second, the fault path wouldn't need to make a VMA copy.
I think this is worth exploring, but can be done as a separate step.

2- Validation at the end of the page fault. After taking the page
table lock but before inserting the new PTE, this patchset verifies
the per-mm sequence counter to validate that no mmap writers ran
concurrently with the fault. As people noted, this is quite
restrictive; page faults may unnecessarily abort due to writers
operating on a separate memory range. This topic is worthy discussion
independently of the maple tree stuff, so I'll get back to it later down.

Matthew & Liam, do you have other extensions in mind which I have not
covered here ?


II- Range locking

Prior to this patchset I had been working on mmap range locking
approaches, in order to allow non-overlapping memory operations to
proceed concurrently. I think this is still an interesting idea,
but the speculative page fault proposal is independent of it
and is more mature so I think it should be submitted first.


III- Thoughts about concurrency checks at the end of the page fault

As noted, the check using the per-mm counter can lead to unnecessary
speculative page fault aborts. Why do it that way then ?

The first reason I want to give is practical. The types of faults this
patchset implements speculatively tend to be fairly quick - in
particular, no I/O is involved (for the swap case, we only implement
the case of hitting into the swap cache). As a result, there is not
very much time for concurrent mmap writers to interfere. I did try
implementing a more precise check, but it did not significantly
improve the success rate in workloads I looked at, so it seemed best
to go with the simplest possible check first.

But still, could we implement a precise check that never leads to
unnecessary page fault aborts ?

The simplest way to go about this would seem to be to look up the VMA
again at the end of the page fault (after taking the page table lock
but before inserting the new PTE into the page table). If the VMA
attributes have not changed, we might be tempted to conclude it is
safe to insert the new PTE and complete the page fault. However, I am
not sure if that would always be correct.

The case I am worried about is when breaking COW:
- Page P is COW mapped into processes A and B
- Thread A1 (within process A) takes a write fault on P
- A1 allocates a new page P2
- A1 starts copying P into P2
- B unmaps P
- Thread A2 (within process A) takes a write fault on P
  P now has only one mapping, so A2 just changes P to be writable
  A2's page fault completes
- A2 writes into P
- A2 calls mprotect() to make P's mapping readonly.
  P's PTE gets its W permission bit cleared.
- A2 calls mprotect() to make P's mapping writable again.
- A1 is done copying P into P2.
  A1 takes the page table lock
  A1 verifies that P's VMA has not changed - it's still a writable mapping
  A1 verifies that P's PTE has not changed -
    it still points to P with the W permission bit cleared.
  A1 updates the pte to point to the P2 page (with the W permission bit set)

The above would be incorrect because A2's write into P may get lost.

This seems like a convoluted scenario but I am not sure how to cleanly
protect against it. Surely one could extend the validation mechanism
(Laurent's proposal used per-VMA sequence counts), but there is still
a possibility of unnecessary aborts there, so I don't think that is
fully satisfactory.

I think doing re-fetching the VMA at the end of the page fault would
be safe in at least some of the cases though, most notably if the
original PTE was pte_none. So maybe that would cover enough cases ?

To sum it up, I agree that using the per-mm sequence count to validate
page faults is imperfect, but I think it gives a decent first stab at
the issue, and that further improvements are not trivial enough to
design in a vacuum - they would be better handled by incrementally
addressing problem workloads IMO.


--
Michel "walken" Lespinasse
