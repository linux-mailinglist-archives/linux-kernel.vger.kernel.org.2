Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4C93E32F2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 05:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhHGDZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 23:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230183AbhHGDZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 23:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628306726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pqNQRtWb5voo9Ih9+1fZ0vEef/svPNXQ6fhBQgHHkn0=;
        b=M9QZgB8uOq0MtZdCAKfmqpkHX6csuaJkn81JKiyPFoxmPPF9EJ0aiYa1AcJWognNTLI/9T
        BkAGzlXb8Vbw5NkwKdwOYtOoAauK9SYWv4AmZ5fJEK6TNXMwzoi/7lqHW6CkTOOAMTP3kw
        CC8k8yYto3W8YX2zjUJIu6zn1khk/Kw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-V3cmVtJTNIiesVHRl06S6A-1; Fri, 06 Aug 2021 23:25:25 -0400
X-MC-Unique: V3cmVtJTNIiesVHRl06S6A-1
Received: by mail-qk1-f200.google.com with SMTP id p123-20020a378d810000b02903ad5730c883so7661084qkd.22
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 20:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pqNQRtWb5voo9Ih9+1fZ0vEef/svPNXQ6fhBQgHHkn0=;
        b=n4187NnCeD9OloOP4xAJ5NpJg6liXVvqIKGOMcoY7h75sQve2RxiOVdJdWw0hUHDgF
         SY4GSoToEqgH7YwkmRT6CNE1ERjILCjQexPntUFH2MR86wV0sqUE0JpTpBlvTNRspVEz
         WXea7jaRgc0Lf7u1Xy0YIjp1s+FOsJgR6iI+M2jxnc+p/XbtEybWPQWXTwT9Hu+2wVfZ
         1J7uTbgUBu4dS2XdC7FJwTGGS4fJ0IL66b1RLw/qhN+Ivu1qd/bw+PayhvPYOmir5Zm3
         lYvMPXz4LUyyWScUfICYXYFBhn1ukSlO/smwngYnZZvLPhWElOuBlMxc76sC+prJXMjm
         F9qA==
X-Gm-Message-State: AOAM532zfeIR4k7+ht0JJ8L/GYT7NkY7N3YMsC7jylAlJjaS9g7QikCA
        FuTK7ccrd2KOnW/FbNlNfcR+dK6gWFIUjuE2oOHSWrvFjaAJt61AW50desTTafkALKQB1qkH89M
        5NVpgzBx7Fgw6sX+QX3fwuMhHUqvXsfZPlJJtoGAZ3SVDqk+Hj7nSNScGpmHwL+eD/VYLwyB+6g
        ==
X-Received: by 2002:a37:6192:: with SMTP id v140mr12901115qkb.421.1628306724349;
        Fri, 06 Aug 2021 20:25:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFExRUPi9CGa65lAjOV9lJ8vZu85E5OIHZ8AVVWFS5EDc14G6sJT0c03xGy21u57ShFC8FhQ==
X-Received: by 2002:a37:6192:: with SMTP id v140mr12901087qkb.421.1628306724011;
        Fri, 06 Aug 2021 20:25:24 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id a5sm5514875qkk.92.2021.08.06.20.25.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Aug 2021 20:25:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Alistair Popple <apopple@nvidia.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        ivan.teterevkov@nutanix.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RFC 0/4] mm: Enable PM_SWAP for shmem with PTE_MARKER
Date:   Fri,  6 Aug 2021 23:25:17 -0400
Message-Id: <20210807032521.7591-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Summary=0D
=3D=3D=3D=3D=3D=3D=3D=0D
=0D
[Based on v5.14-rc4]=0D
=0D
This patchset enables PM_SWAP of pagemap on shmem.  IOW userspace will be a=
ble=0D
to detect whether a shmem page is swapped out, just like anonymous pages.=0D
=0D
This feature can be enabled with CONFIG_PTE_MARKER_PAGEOUT. When enabled, i=
t=0D
brings 0.8% overhead on swap-in performance on a shmem page, so I didn't ma=
ke=0D
it the default yet.  However IMHO 0.8% is still in an acceptable range that=
 we=0D
can even make it the default at last.  Comments are welcomed here.=0D
=0D
There's one previous series that wanted to address the same issue but in=0D
another way by Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>, here:=0D
=0D
https://lore.kernel.org/lkml/20210730160826.63785-1-tiberiu.georgescu@nutan=
ix.com/=0D
=0D
In that series it's done by looking up page cache for all none ptes.  Howev=
er I=0D
raised concern on 4x performance degradation for all shmem pagemap users.=0D
=0D
Unlike the other approach, this series has zero overhead on pagemap read=0D
because the PM_SWAP info is consolidated into the zapped PTEs directly.=0D
=0D
Goals=0D
=3D=3D=3D=3D=3D=0D
=0D
One major goal of this series is to add the PM_SWAP support, the reason is =
as=0D
stated by Tiberiu and Ivan in the other patchset:=0D
=0D
https://lore.kernel.org/lkml/CY4PR0201MB3460E372956C0E1B8D33F904E9E39@CY4PR=
0201MB3460.namprd02.prod.outlook.com/=0D
=0D
As a summary: for some reason the userspace needs to scan the pages in the=
=0D
background, however that scanning could misguide page reclaim on which page=
 is=0D
hot and which is cold.  With correct PM_SWAP information, the userspace can=
=0D
correct the behavior of page reclaim by firstly fetching that info from=0D
pagemap, and explicit madvise(MADV_PAGEOUT).  In this case, the pages are f=
or=0D
the guest, but it can be any shmem page.=0D
=0D
Another major goal of this series is to do a proof-of-concept of the PTE ma=
rker=0D
idea, and that's also the major reason why it's RFC.  So far PTE marker can=
=0D
potentially be the solution for below three problems that I'm aware of:=0D
=0D
  (a) PM_SWAP on shmem=0D
=0D
  (b) Userfaultfd-wp on shmem/hugetlbfs=0D
=0D
  (c) PM_SOFT_DIRTY lost for shmem over swapping=0D
=0D
This series tries to resolve problem (a) which should be the simplest, idea=
lly=0D
it should solve immediate problem for the live migration issue raised by=0D
Tiberiu and Ivan on proactive paging out unused guest pages.=0D
=0D
Both (a) and (c) will be for performance-wise or statistic-wise.=0D
=0D
Scenario (b) will require pte markers as part of the function to trap write=
s to=0D
uffd-wp protected regions when the pages were e.g. swapped out or zapped fo=
r=0D
any reason.=0D
=0D
Currently, uffd-wp shmem work (still during review on the list, latest v5, =
[1])=0D
used another solution called "special swap pte".  It works similarly like P=
TE=0D
markers as both of the approachs are to persist information into zapped pte=
,=0D
but people showed concern about that idea and it's suggested to use a safer=
=0D
(swp-entry level operation, not pte level), and arch-independent approach.=
=0D
=0D
Hopefully PTE markers satifsfy these demands.=0D
=0D
Before I rework the uffd-wp series, I wanted to know whether this approach =
can=0D
be accepted upstream.  So besides the swap part, comments on PTE markers wi=
ll=0D
be extremely welcomed.=0D
=0D
What is PTE Markers?=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
=0D
PTE markers are defined as some special PTEs that works like a "marker" jus=
t=0D
like in normal life.  Firstly it uses a swap type, IOW it's not a valid/pre=
sent=0D
pte, so processor will trigger a page fault when it's accessed.  Meanwhile,=
 the=0D
format of the PTE is well-defined, so as to contain some information that w=
e=0D
would like to know before/during the page access happening.=0D
=0D
In this specific case, when the shmem page is paged out, we set a marker=0D
showing that this page was paged out, then when pagemap is read about this =
pte,=0D
we know this is a swapped-out/very-cold page.=0D
=0D
This use case is not an obvious one but the most simplest.  The uffd-wp use=
=0D
case is more obvious (wr-protect is per-pte, so we can't save into page cac=
he;=0D
meanwhile we need that info to persist across zappings e.g. thp split or pa=
ge=0D
out of shmem pages).=0D
=0D
So in the future, it can contain more information, e.g., whether this pte i=
s=0D
wr-protected by userfaultfd; whether this pte was written in this mm contex=
t=0D
for soft-dirtying.  On 64 bit systems, we have a total of 58 bits (swp_offs=
et).=0D
=0D
I'm also curious whether it can be further expanded to other mm areas.  E.g=
.,=0D
logically it can work too for non-RAM based memories outside shmem/hugetlbf=
s,=0D
e.g. a common file system like ext4 or btrfs?  As long as there will be a n=
eed=0D
to store some per-pte information across zapping of the ptes, then maybe it=
 can=0D
be considered.=0D
=0D
Known Issues/Concerns=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
=0D
About THP=0D
---------=0D
=0D
Currently we don't need to worry about THP because paged out shmem pages wi=
ll=0D
be split when shrinking, IOW we only need to consider PTE, and the markers =
will=0D
only be applied to a shmem pte not pmd or bigger.=0D
=0D
About PM_SWAP Accuracy=0D
----------------------=0D
=0D
This is not an "accurate" solution to provide PM_SWAP bit.  Two exmaples:=0D
=0D
  - When process A & B both map shmem page P somewhere, it can happen that =
only=0D
    one of these ptes got marked with the pte marker.  Imagine below sequen=
ce:=0D
=0D
    0. Process A & B both map shmem page P somewhere=0D
    1. Process A zap pte of page P for some reason (e.g. thp split)=0D
    2. System decides to recycle page P=0D
    3. System replace process B's pte (pointed to P) by PTE marker=0D
    4. System _didn't_ replace process A's pte because it was none pte, and=
=0D
       it'll continue to be none pte=0D
    5. Only process B's relevant pte has the PTE marker after P swapped out=
=0D
=0D
  - When fork, we don't copy shmem vma ptes, including the pte markers.  So=
=0D
    even if page P was swapped out, only the parent process has the pte mar=
ker=0D
    installed, in child it'll be none pte if fork() happened after pageout.=
=0D
=0D
Conclusion: just like it used to be, the PM_SWAP is best-effort.  But it sh=
ould=0D
work in 99.99% cases and it should already start to solve problems.=0D
=0D
About Performance Impact=0D
------------------------=0D
=0D
Due to the special PTE marker, page fault logic needs to understand this pt=
e=0D
and there will be some extra logic to handle that.  The overhead is merely=
=0D
non-observable with 0.82% perf drop.=0D
=0D
For more information, please see the test section below where I wrote a tes=
t=0D
for it.  When we really care about that small difference, the user can also=
=0D
disable the shmem PM_SWAP support with !CONFIG_PTE_MARKER_PAGEOUT.=0D
=0D
Tests=0D
=3D=3D=3D=3D=3D=0D
=0D
Test case I used is here:=0D
=0D
https://github.com/xzpeter/clibs/blob/master/bsd/pagemap.c=0D
=0D
Functional test=0D
---------------=0D
=0D
Run with !CONFIG_PTE_MARKER_PAGEOUT, we'll miss the PM_SWAP when paged out =
(see=0D
swap bit always being zeros):=0D
=0D
       FAULT1 (expect swap=3D=3D0): present bit 1, swap bit 0=0D
      PAGEOUT (expect swap=3D=3D1): present bit 0, swap bit 0=0D
       FAULT2 (expect swap=3D=3D0): present bit 1, swap bit 0=0D
       REMOVE (expect swap=3D=3D0): present bit 0, swap bit 0=0D
      PAGEOUT (expect swap=3D=3D1): present bit 0, swap bit 0=0D
       REMOVE (expect swap=3D=3D0): present bit 0, swap bit 0=0D
=0D
Run with CONFIG_PTE_MARKER_PAGEOUT, we'll be able to observe correct PM_SWA=
P:=0D
=0D
       FAULT1 (expect swap=3D=3D0): present bit 1, swap bit 0=0D
      PAGEOUT (expect swap=3D=3D1): present bit 0, swap bit 1=0D
       FAULT2 (expect swap=3D=3D0): present bit 1, swap bit 0=0D
       REMOVE (expect swap=3D=3D0): present bit 0, swap bit 0=0D
      PAGEOUT (expect swap=3D=3D1): present bit 0, swap bit 1=0D
       REMOVE (expect swap=3D=3D0): present bit 0, swap bit 0=0D
=0D
Performance test=0D
----------------=0D
=0D
The performance test is not about pagemap reading, because it should be the=
=0D
same as before.  Instead there's indeed extra overhead in the fault path, w=
hen=0D
the page is swapped in from the disk.  I did some sequential swap-in tests =
of=0D
1GB range (each for 5 times in a loop) to measure the difference.=0D
=0D
Hardware I used:=0D
=0D
        Processor: Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz=0D
        Memory:    32GB memory, 16GB swap (on a PERC H330 Mini 2TBi disk)=0D
        Test Size: 1GB shmem=0D
=0D
I only measured the time to fault-in the pages on the disk, so the measurem=
ent=0D
does not include pageout time, one can refer to the .c file.  Results:=0D
=0D
   |-----------------------------------+------------------+------------|=0D
   | Config                            | Time used (us)   | Change (%) |=0D
   |-----------------------------------+------------------+------------|=0D
   | !PTE_MARKER                       | 519652 (+-0.73%) |        N/A |=0D
   | PTE_MARKER && !PTE_MARKER_PAGEOUT | 519874 (+-0.40%) |     -0.04% |=0D
   | PTE_MARKER && PTE_MARKER_PAGEOUT  | 523914 (+-0.71%) |     -0.82% |=0D
   |-----------------------------------+------------------+------------|=0D
=0D
Any comment would be greatly welcomed.=0D
=0D
[1] https://lore.kernel.org/lkml/20210715201422.211004-1-peterx@redhat.com/=
=0D
=0D
Peter Xu (4):=0D
  mm: Introduce PTE_MARKER swap entry=0D
  mm: Check against orig_pte for finish_fault()=0D
  mm: Handle PTE_MARKER page faults=0D
  mm: Install marker pte when page out for shmem pages=0D
=0D
 fs/proc/task_mmu.c      |  1 +=0D
 include/linux/rmap.h    |  1 +=0D
 include/linux/swap.h    | 14 ++++++++++++-=0D
 include/linux/swapops.h | 45 +++++++++++++++++++++++++++++++++++++++++=0D
 mm/Kconfig              | 17 ++++++++++++++++=0D
 mm/memory.c             | 43 ++++++++++++++++++++++++++++++++++++++-=0D
 mm/rmap.c               | 19 +++++++++++++++++=0D
 mm/vmscan.c             |  2 +-=0D
 8 files changed, 139 insertions(+), 3 deletions(-)=0D
=0D
-- =0D
2.32.0=0D
=0D

