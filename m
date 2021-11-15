Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788564508E0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 16:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbhKOPtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 10:49:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236636AbhKOPs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 10:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636991125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=D0nFQRY59W2lZxagtaPjzE4TaWatEDv/DTb4Rb91EtA=;
        b=hQuLDc0WSOTQMBmbm/SAxkMIgpBungqvgmJxBEzS2Xva7RblD92k1KL3zSLT8uivcyVCPr
        bCVSvEynqMfYGNujXPj9ylDRKxYgHZenUWrZhOi9OcnDBik74WayeSruG1R5GtayNQYA3K
        HqEKo0UPdiXiFMUTIVt1t2MTEjyrZgI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-DPIPuYjiPXS2BKLdDWAJaA-1; Mon, 15 Nov 2021 10:45:23 -0500
X-MC-Unique: DPIPuYjiPXS2BKLdDWAJaA-1
Received: by mail-wr1-f71.google.com with SMTP id o4-20020adfca04000000b0018f07ad171aso3585033wrh.20
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 07:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :content-language:organization:to:subject:content-transfer-encoding;
        bh=D0nFQRY59W2lZxagtaPjzE4TaWatEDv/DTb4Rb91EtA=;
        b=Zjr4cI0dGBM/UbtNHaSvKQFdL8v4t51WMIiB6HOaWSV21pA21u5wguJ+hjqal6CIp8
         QEvz3YsOsr3Qv8bGSWhM+VHW/U3V3MHpOIzMEhZNklsDJv1gEc6cc21GTUupFw2fn+Oy
         CAl/uTsGrW/1rD2a0LfJuK3MThdcVZgKKyNq3K8A/Ax5kOn+e6v5Rr3UG/115fb7CtjD
         kqLOsFpuas1Iot/oKlvFAyYHWgB99fi1rB7zrbbEdWTE0HT4u63FyBaeOwjep88LQvf7
         YiFOvXKgjqofanFKqeB7UeOD2u4mx2c6Z7rS5OmXtZecbeZ/1vcowJqhEjBkueoEes+D
         AdwQ==
X-Gm-Message-State: AOAM532LkRUIgNtIaX74e7gQYtncFkgoE+pwt5NPkgtodmeZdMdb37XI
        BlpAdjFXeXOlyqMZ3oK3n/jAVO+7XobCdl7jKoYi/0tBQn8DiZV3fiG0oIMYfbJHoLG45bdmbxl
        N84CxADSlH5Ck6/Mlryznpe0ecIm9zp5fEQWVpAYquiChB8q4MKAEMve/dvEihtDzguxgHqvb
X-Received: by 2002:a5d:598c:: with SMTP id n12mr48253607wri.250.1636991122545;
        Mon, 15 Nov 2021 07:45:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytxYDvCwpwugIbw56d4QBbNpHFyQHw5+HFCEoY2qp0oI0W1zb8ZpJ6+zH+wGBtvNd1e51J0A==
X-Received: by 2002:a5d:598c:: with SMTP id n12mr48253538wri.250.1636991122057;
        Mon, 15 Nov 2021 07:45:22 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6101.dip0.t-ipconnect.de. [91.12.97.1])
        by smtp.gmail.com with ESMTPSA id ay21sm1411825wmb.7.2021.11.15.07.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 07:45:21 -0800 (PST)
Message-ID: <3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com>
Date:   Mon, 15 Nov 2021 16:45:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
From:   David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Summary of COW (Copy On Write) Related Issues in Upstream Linux
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

as we (Red Hat) are preparing for the next RHEL major release, we are
still struggling with some of the COW-related issues that exist in
upstream-MM.

Unfortunately, many issues only show up over time, for example, once
enterprise distributions pick up the relevant changes and poke them with
a stick.

I summarized the basic situation back in January [0], and here is an
updated summary of what is known so far about the whole COW
situation, including issues discovered just recently and links to
reproducers -- I'm trying to keep it high-level again, but add details
where helpful.

I explicitly don't CC anyone on this mail. If you stumble over this mail
and think it might be interesting to someone else, feel free to forward.

As this is fairly involved stuff: if anything in this mail is wrong or
if I'm missing important details, please speak up -- thanks!


1. Observing Memory Modifications of Private Pages From A Child Process

Long story short: process-private memory might not be as private as you
think once you fork(): successive modifications of private memory
regions in the parent process can still be observed by the child
process, for example, by smart use of vmsplice()+munmap().

The core problem is that pinning pages readable in a child process, such
as done via the vmsplice system call, can result in a child process
observing memory modifications done in the parent process the child is
not supposed to observe. [1] contains an excellent summary and [2]
contains further details. This issue was assigned CVE-2020-29374 [9].

For this to trigger, it's required to use a fork() without subsequent
exec(), for example, as used under Android zygote. Without further
details about an application that forks less-privileged child processes,
one cannot really say what's actually affected and what's not -- see the
details section the end of this mail for a short sshd/openssh analysis.

While commit 17839856fd58 ("gup: document and work around "COW can break
either way" issue") fixed this issue and resulted in other problems
(e.g., ptrace on pmem), commit 09854ba94c6a ("mm: do_wp_page()
simplification") re-introduced part of the problem unfortunately.

The original reproducer can be modified quite easily to use THP [3] and
make the issue appear again on upstream kernels. I modified it to use
hugetlb [4] and it triggers as well. The problem is certainly less
severe with hugetlb than with THP; it merely highlights that we still
have plenty of open holes we should be closing/fixing.

Regarding vmsplice(), the only known workaround is to disallow the
vmsplice() system call ... or disable THP and hugetlb. But who knows
what else is affected (RDMA? O_DIRECT?) to achieve the same goal -- in
the end, it's a more generic issue.


2. Intra Process Memory Corruptions due to Wrong COW (FOLL_GET)

It was discovered that we can create a memory corruption by reading a
file via O_DIRECT to a part (e.g., first 512 bytes) of a page,
concurrently writing to an unrelated part (e.g., last byte) of the same
page, and concurrently write-protecting the page via clear_refs
SOFTDIRTY tracking [6].

For the reproducer, the issue is that O_DIRECT grabs a reference of the
target page (via FOLL_GET) and clear_refs write-protects the relevant
page table entry. On successive write access to the page from the
process itself, we wrongly COW the page when resolving the write fault,
resulting in a loss of synchronicity and consequently a memory corruption.

While some people might think that using clear_refs in this combination
is a corner cases, it turns out to be a more generic problem unfortunately.

For example, it was just recently discovered that we can similarly
create a memory corruption without clear_refs, simply by concurrently
swapping out the buffer pages [7]. Note that we nowadays even use the
swap infrastructure in Linux without an actual swap disk/partition: the
prime example is zram which is enabled as default under Fedora [10].

The root issue is that a write-fault on a page that has additional
references results in a COW and thereby a loss of synchronicity
and consequently a memory corruption if two parties believe they are
referencing the same page.


3. Intra Process Memory Corruptions due to Wrong COW (FOLL_PIN)

page_maybe_dma_pinned() is used to check if a page may be pinned for
DMA (using FOLL_PIN instead of FOLL_GET). While false positives are
tolerable, false negatives are problematic: pages that are pinned for
DMA must not be added to the swapcache. If it happens, the (now pinned)
page could be faulted back from the swapcache into page tables
read-only. Future write-access would detect the pinning and COW the
page, losing synchronicity. For the interested reader, this is nicely
documented in feb889fb40fa ("mm: don't put pinned pages into the swap
cache").

Peter reports [8] that page_maybe_dma_pinned() as used is racy in some
cases and can result in a violation of the documented semantics:
giving false negatives because of the race.

There are cases where we call it without properly taking a per-process
sequence lock, turning the usage of page_maybe_dma_pinned() racy. While
one case (clear_refs SOFTDIRTY tracking, see below) seems to be easy to
handle, there is especially one rmap case (shrink_page_list) that's hard
to fix: in the rmap world, we're not limited to a single process.

The shrink_page_list() issue is really subtle. If we race with
someone pinning a page, we can trigger the same issue as in the FOLL_GET
case. See the detail section at the end of this mail on a discussion how
bad this can bite us with VFIO or other FOLL_PIN user.

It's harder to reproduce, but I managed to modify the O_DIRECT
reproducer to use io_uring fixed buffers [15] instead, which ends up
using FOLL_PIN | FOLL_WRITE | FOLL_LONGTERM to pin buffer pages and can
similarly trigger a loss of synchronicity and consequently a memory
corruption.

Again, the root issue is that a write-fault on a page that has
additional references results in a COW and thereby a loss of
synchronicity and consequently a memory corruption if two parties
believe they are referencing the same page.


4. Page Pinning and SOFTDIRTY Tracking

The clear_refs SOFTDIRTY tracking no longer works correctly on pinned
pages (to be precise, essentially pages for which
page_maybe_dma_pinned()==true).

Although there is still a race in the code regarding
page_maybe_dma_pinned(), once fixed we will no longer be able corrupt
memory using clear_refs. Instead, the SOFTDIRTY bit
will never get cleared for such pages, resulting in them always getting
reported as SOFTDIRTY to user space.

The basic problem is that we don't know how a page was pinned and what
the target use case is: was it pinned readable and there is absolutely
no problem in write-protecting such a page? Or was it pinned writable
and write-protecting such a page might miss actual writes performed by
the entity that pinned the page writable? [12]

For example, RDMA-based live migration of virtual machines that use
SOFTDIRTY tracking to detect which pages need migration on the migration
source would no longer work. If the whole VM memory is pinned via RDMA
readable, we will always assume all memory is dirty and essentially not
make any forward progress with migration.

While there are reports that such use cases do exist and are degraded
[12], there are valid concerns if the SOFTDIRTY feature is used at all
[16]. Doing a quick internet search, VulkanTools was one of the only
know open-source users, but removed support in 2018 [14]. If the feature
is actually unused, one thought could be to remove it altogether instead
of leaving a semi-functional feature around.


5. Performance Degradation due to Unnecessary COW

Nadav first reported [13] that a reference taken by lru_cache_add() can
result in undesired COW, degrading performance and resulting in a lot of
orphaned swapcache entries. He observes it via userfaulfd and two
pagefaults to the same page shortly after each other.

Fault #1 faults in a new anonymous page read-only (aka write-protected).
Fault #2 tries to write the page and consequently faults.

If we're quick, after #1 and until #2 the faulted-in page the LRU cache
still holds a reference to the newly added page. We will COW the page
during #2 and map the copy into the page table. Once the additional
reference from the LRU cache is dropped, the original page is freed again.

However, the issue itself is not new: for example, we can also have
speculative pagecache references, or pagevec references for bulk
operations, that can result in unnecessary COW similarly.

Nadav just recently shared a simple swap benchmark including results
[17] which highlights the issue on low-latency swap devices, such as
pmem and zram, in virtualized environments without any userfaultfd being
involved. It reveals an increased memory access latency resulting from
an increased number of remote TLB flushes to deal with unnecessary COW.

-------------------------------------------------------------------------

Some details I discovered while composing this mail:

* The description [9] of CVE-2020-29374 is not fully accurate: instead
  of "unintended write access" it should actually be "unintended read
  access".

* sshd/openssh does not seem to be affected by the CVE since it sets the
  "dumpable" attribute to 0. Without this, it might have been possible
  to make the child execute a vmsplice-based attack using ptrace to
  observe memory modifications in the parent. Fortunately it doesn't
  seem exploitable.

* In some cases the reproducers, also dependent on undefined hardware
  details, might only reliably exhibit "data loss" not literal
  "memory corruption", but IMHO the difference doesn't matter, which is
  why I generally referred to the unexpected side effects as "memory
  corruption" for simplicity.

* page_maybe_dma_pinned() never returns "true" for pages pinned via
  O_DIRECT. The root issue seems to be that O_DIRECT has to use
  "get_user_pages()" instead of "pin_user_pages()", because spotting all
  put_page() to replace with unpin_user_page() does not seem feasible.
  The documentation [11] does not spell this out, unfortunately, and
  makes one believe that FOLL_PIN would be used in that case.

* The shrink_page_list() issue, for example, also affects VFIO. In real
  life, we could:

  a) Start a VM, for example, using QEMU. As the VM boots up, it will
     start touching its memory and we'll populate fresh pages that will
     get modified by the VM.
  b) Hotplug a VFIO device, which will end up long-term pinning all
     guest memory.

  Now, if we have the following sequence (similar to the io_uring
  reproducer):

  a) shrink_page_list() checks page_maybe_dma_pinned()==false and adds
     the page to the swapcache
  b) VFIO long-term pins the page via the process page table
  c) shrink_page_list() unmaps the page from the process page table

  we can end up with pinned pages in the swapcache. If we're unlucky
  that the VM will read a problematic page first and write it next,
  we'll lose synchronicity and essentially corrupt VM memory: reading
  the page will map the page read-only into the process page tables and
  the successive write will trigger a write fault that leads to a
  wrong COW, making VFIO lose synchronicity from the actual process page
  tables.

-------------------------------------------------------------------------

[0]
https://lkml.kernel.org/r/bb071419-bf40-c5ed-4b2d-d5eb03031b0a@redhat.com
[1] https://lwn.net/Articles/849638/
[2] https://lwn.net/Articles/849876/
[3]
https://gitlab.com/aarcange/kernel-testcases-for-v5.11/-/blob/main/vmsplice-v5.11.c
[4]
https://gitlab.com/aarcange/kernel-testcases-for-v5.11/-/blob/main/vmsplice-hugetlb-v5.11.c
[5] https://lore.kernel.org/r/FFA0057D-1A17-4DF4-9550-A8CDEE9E0CE0@gmail.com
[6]
https://gitlab.com/aarcange/kernel-testcases-for-v5.11/-/blob/main/page_count_do_wp_page.c
[7]
https://gitlab.com/aarcange/kernel-testcases-for-v5.11/-/blob/main/page_count_do_wp_page-swap.c
[8] https://lkml.kernel.org/r/YVTFEAwHEZfUrSCT@t490s
[9] https://nvd.nist.gov/vuln/detail/CVE-2020-29374
[10] https://fedoraproject.org/wiki/Changes/SwapOnZRAM
[11] https://www.kernel.org/doc/Documentation/core-api/pin_user_pages.rst
[12] https://lkml.kernel.org/r/20210115183721.GG4605@ziepe.ca
[13]
https://lkml.kernel.org/r/FFA0057D-1A17-4DF4-9550-A8CDEE9E0CE0@gmail.com
[14]
https://github.com/LunarG/VulkanTools/commit/a8b5df4dc36a4b969be4e3b20ff51d96ebc634f9#diff-d658adcb226a1d34c995bd96a3c31291
[15]
https://gitlab.com/aarcange/kernel-testcases-for-v5.11/-/blob/main/io_uring_swap.c
[16]
https://lore.kernel.org/all/X/3MWWYY0FlBpH9r@hirez.programming.kicks-ass.net/?q=X%2F3MWWYY0FlBpH9r%40hirez.programming.kicks-ass.net
[17]
https://lkml.kernel.org/r/0480D692-D9B2-429A-9A88-9BBA1331AC3A@gmail.com

-- 
Thanks,

David / dhildenb



