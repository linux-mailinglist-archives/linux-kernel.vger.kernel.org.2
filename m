Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608853767A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbhEGPHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235644AbhEGPHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620399961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jme+1muNnSxmiWot4aHYQfofdaH3rlfDZZkhrxiBlfE=;
        b=RFSNGSbN+jJx1mHFn5ROYW8G6wOJ4yFod5Czt+lEUQljv2kI+mEFoWKC3cMf/MPirjxsHQ
        +tFwwizOvz929xuxuFJyrlpP9F5V9nrLyO9JaBVeATJv8v0OMrNKjeqGNxNoTP/fFyenn8
        vN9uRakVL4Sg7LH+csxtVTqiPkpZ+jQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-O-kbBsReNkSCKzJd9sNTsg-1; Fri, 07 May 2021 11:05:58 -0400
X-MC-Unique: O-kbBsReNkSCKzJd9sNTsg-1
Received: by mail-qt1-f198.google.com with SMTP id 1-20020aed31010000b029019d1c685840so5949845qtg.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 08:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jme+1muNnSxmiWot4aHYQfofdaH3rlfDZZkhrxiBlfE=;
        b=hs3Ov8xbF4ZZMWg4bfDAxhe22BUUvBOnW+d8RBpi/CCjObvmRjMcY4DA4CDfTt677+
         ckSbtzCJKjmBpmWcD8azzvPOIlzAPCcDDqTCZW9lY5nkiM2ByYTbTAbeDKUX85+LolfG
         YzagCI/SZcWknESmFg36LW8l3jLayohHnLwrhThq18Cooh1Y1EbBGp1S91V/o/rNjRma
         EFANHFVBg1dRWFIu1FCDngOf/BEv6jCPbTBoGG+oMfh8Y7Tc9YZnytuHzfb1GXJ+pIOq
         aT+LCJ2UwPt++byUWuylgH10+Ea4mBv4oid3Ngv6MgTv72E0s0tM1b9BiW6Hl1UlreDY
         Xxrw==
X-Gm-Message-State: AOAM532dKw7XeA0P2rLfYKY85seLeCDwiWPnUPcV6lmIVURhn0PVFYhF
        kSM2KrIspnl/XRPHswNnDz6UEDdNEReg8VrpdPwAGuzm0xL/6Ea+2xZ4fdlOGr+xm9r9CYnuqGO
        Zf+ed4/2wNpU2N6adBxBHVHdQ
X-Received: by 2002:a0c:8521:: with SMTP id n30mr10355681qva.53.1620399958169;
        Fri, 07 May 2021 08:05:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6iNpXW8zu2lVEvglmvL2SUsll0B2uc4sU/K5mc6vFGwxy9TWhQtnJxZful8KoM1m0JooOGw==
X-Received: by 2002:a0c:8521:: with SMTP id n30mr10355618qva.53.1620399957696;
        Fri, 07 May 2021 08:05:57 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id c141sm950456qke.12.2021.05.07.08.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 08:05:54 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        peterx@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v2 0/3] mm/gup: Fix pin page write cache bouncing on has_pinned
Date:   Fri,  7 May 2021 11:05:50 -0400
Message-Id: <20210507150553.208763-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:=0D
- patch 1: rename s/threads/nthreads/; assert() on pthread create/destroy [=
John]=0D
- patch 2:=0D
  - rewrite commit message [John, Linus]=0D
  - use parentheses [Linus]=0D
- patch 3:=0D
  - define mm_set_has_pinned_flag() helper and use it [John, Linus, Matthew=
]=0D
  - keep has_pinned comment but move to MMF_HAS_PINNED [John]=0D
=0D
This series contains 3 patches, the 1st one enables threading for gup_bench=
mark=0D
in the kselftest.  The latter two patches are collected from Andrea's local=
=0D
branch which can fix write cache bouncing issue with pinning fast-gup.=0D
=0D
To be explicit on the latter two patches:=0D
=0D
  - the 2nd patch fixes the perf degrade when introducing has_pinned, then=
=0D
=0D
  - the last patch tries to remove the has_pinned with a bit in mm->flags=0D
=0D
For patch 3: originally I think we had a plan to reuse has_pinned into a=0D
counter very soon, however that's not happening at least until today, so ma=
ybe=0D
it proves that we can remove it until we really want such a counter for=0D
whatever reason.  As the commit message stated, it saves 4 bytes for each m=
m=0D
without observable regressions.=0D
=0D
Regarding testing: we can reference to the commit message of patch 2 for so=
me=0D
detailed testing with will-is-scale.  Meanwhile I did patch 1 just because =
then=0D
we can even easily verify the patchset using the existing kselftest facilit=
ies=0D
or even regress test it in the future with the repo if we want.=0D
=0D
Below numbers are extra verification tests that I did besides commit messag=
e of=0D
patch 2 using the new gup_benchmark and 256 cpus.  Below test is done on 40=
=0D
cpus host with Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz, and I can get sim=
ilar=0D
result (of course the write cache bouncing get severe with even more cores)=
.=0D
=0D
After patch 1 applied (only test patch, so using old kernel):=0D
=0D
  $ sudo chrt -f 1 ./gup_test -a  -m 512 -j 40=0D
  PIN_FAST_BENCHMARK: Time: get:459632 put:5990 us=0D
  PIN_FAST_BENCHMARK: Time: get:461967 put:5840 us=0D
  PIN_FAST_BENCHMARK: Time: get:464521 put:6140 us=0D
  PIN_FAST_BENCHMARK: Time: get:465176 put:7100 us=0D
  PIN_FAST_BENCHMARK: Time: get:465960 put:6733 us=0D
  PIN_FAST_BENCHMARK: Time: get:465324 put:6781 us=0D
  PIN_FAST_BENCHMARK: Time: get:466018 put:7130 us=0D
  PIN_FAST_BENCHMARK: Time: get:466362 put:7118 us=0D
  PIN_FAST_BENCHMARK: Time: get:465118 put:6975 us=0D
  PIN_FAST_BENCHMARK: Time: get:466422 put:6602 us=0D
  PIN_FAST_BENCHMARK: Time: get:465791 put:6818 us=0D
  PIN_FAST_BENCHMARK: Time: get:467091 put:6298 us=0D
  PIN_FAST_BENCHMARK: Time: get:467694 put:5432 us=0D
  PIN_FAST_BENCHMARK: Time: get:469575 put:5581 us=0D
  PIN_FAST_BENCHMARK: Time: get:468124 put:6055 us=0D
  PIN_FAST_BENCHMARK: Time: get:468877 put:6720 us=0D
  PIN_FAST_BENCHMARK: Time: get:467212 put:4961 us=0D
  PIN_FAST_BENCHMARK: Time: get:467834 put:6697 us=0D
  PIN_FAST_BENCHMARK: Time: get:470778 put:6398 us=0D
  PIN_FAST_BENCHMARK: Time: get:469788 put:6310 us=0D
  PIN_FAST_BENCHMARK: Time: get:488277 put:7113 us=0D
  PIN_FAST_BENCHMARK: Time: get:486613 put:7085 us=0D
  PIN_FAST_BENCHMARK: Time: get:486940 put:7202 us=0D
  PIN_FAST_BENCHMARK: Time: get:488728 put:7101 us=0D
  PIN_FAST_BENCHMARK: Time: get:487570 put:7327 us=0D
  PIN_FAST_BENCHMARK: Time: get:489260 put:7027 us=0D
  PIN_FAST_BENCHMARK: Time: get:488846 put:6866 us=0D
  PIN_FAST_BENCHMARK: Time: get:488521 put:6745 us=0D
  PIN_FAST_BENCHMARK: Time: get:489950 put:6459 us=0D
  PIN_FAST_BENCHMARK: Time: get:489777 put:6617 us=0D
  PIN_FAST_BENCHMARK: Time: get:488224 put:6591 us=0D
  PIN_FAST_BENCHMARK: Time: get:488644 put:6477 us=0D
  PIN_FAST_BENCHMARK: Time: get:488754 put:6711 us=0D
  PIN_FAST_BENCHMARK: Time: get:488875 put:6743 us=0D
  PIN_FAST_BENCHMARK: Time: get:489290 put:6657 us=0D
  PIN_FAST_BENCHMARK: Time: get:490264 put:6684 us=0D
  PIN_FAST_BENCHMARK: Time: get:489631 put:6737 us=0D
  PIN_FAST_BENCHMARK: Time: get:488434 put:6655 us=0D
  PIN_FAST_BENCHMARK: Time: get:492213 put:6297 us=0D
  PIN_FAST_BENCHMARK: Time: get:491124 put:6173 us=0D
=0D
After the whole series applied (new fixed kernel):=0D
=0D
  $ sudo chrt -f 1 ./gup_test -a  -m 512 -j 40=0D
  PIN_FAST_BENCHMARK: Time: get:82038 put:7041 us=0D
  PIN_FAST_BENCHMARK: Time: get:82144 put:6817 us=0D
  PIN_FAST_BENCHMARK: Time: get:83417 put:6674 us=0D
  PIN_FAST_BENCHMARK: Time: get:82540 put:6594 us=0D
  PIN_FAST_BENCHMARK: Time: get:83214 put:6681 us=0D
  PIN_FAST_BENCHMARK: Time: get:83444 put:6889 us=0D
  PIN_FAST_BENCHMARK: Time: get:83194 put:7499 us=0D
  PIN_FAST_BENCHMARK: Time: get:84876 put:7369 us=0D
  PIN_FAST_BENCHMARK: Time: get:86092 put:10289 us=0D
  PIN_FAST_BENCHMARK: Time: get:86153 put:10415 us=0D
  PIN_FAST_BENCHMARK: Time: get:85026 put:7751 us=0D
  PIN_FAST_BENCHMARK: Time: get:85458 put:7944 us=0D
  PIN_FAST_BENCHMARK: Time: get:85735 put:8154 us=0D
  PIN_FAST_BENCHMARK: Time: get:85851 put:8299 us=0D
  PIN_FAST_BENCHMARK: Time: get:86323 put:9617 us=0D
  PIN_FAST_BENCHMARK: Time: get:86288 put:10496 us=0D
  PIN_FAST_BENCHMARK: Time: get:87697 put:9346 us=0D
  PIN_FAST_BENCHMARK: Time: get:87980 put:8382 us=0D
  PIN_FAST_BENCHMARK: Time: get:88719 put:8400 us=0D
  PIN_FAST_BENCHMARK: Time: get:87616 put:8588 us=0D
  PIN_FAST_BENCHMARK: Time: get:86730 put:9563 us=0D
  PIN_FAST_BENCHMARK: Time: get:88167 put:8673 us=0D
  PIN_FAST_BENCHMARK: Time: get:86844 put:9777 us=0D
  PIN_FAST_BENCHMARK: Time: get:88068 put:11774 us=0D
  PIN_FAST_BENCHMARK: Time: get:86170 put:15676 us=0D
  PIN_FAST_BENCHMARK: Time: get:87967 put:12827 us=0D
  PIN_FAST_BENCHMARK: Time: get:95773 put:7652 us=0D
  PIN_FAST_BENCHMARK: Time: get:87734 put:13650 us=0D
  PIN_FAST_BENCHMARK: Time: get:89833 put:14237 us=0D
  PIN_FAST_BENCHMARK: Time: get:96186 put:8029 us=0D
  PIN_FAST_BENCHMARK: Time: get:95532 put:8886 us=0D
  PIN_FAST_BENCHMARK: Time: get:95351 put:5826 us=0D
  PIN_FAST_BENCHMARK: Time: get:96401 put:8407 us=0D
  PIN_FAST_BENCHMARK: Time: get:96473 put:8287 us=0D
  PIN_FAST_BENCHMARK: Time: get:97177 put:8430 us=0D
  PIN_FAST_BENCHMARK: Time: get:98120 put:5263 us=0D
  PIN_FAST_BENCHMARK: Time: get:96271 put:7757 us=0D
  PIN_FAST_BENCHMARK: Time: get:99628 put:10467 us=0D
  PIN_FAST_BENCHMARK: Time: get:99344 put:10045 us=0D
  PIN_FAST_BENCHMARK: Time: get:94212 put:15485 us=0D
=0D
Summary:=0D
=0D
  Old kernel: 477729.97 (+-3.79%)=0D
  New kernel:  89144.65 (+-11.76%)=0D
=0D
I'm not sure whether I should add Fixes for patch 2.  If to add it'll be:=0D
=0D
Fixes: 008cfe4418b3d ("mm: Introduce mm_struct.has_pinned")=0D
=0D
Then cc stable for 5.9+.  However I'll skip adding it if no one asks, as th=
is=0D
is a perf fix, and frequent+concurrent pinning should not really happen tha=
t much.=0D
=0D
Please review, thanks.=0D
=0D
Andrea Arcangeli (2):=0D
  mm: gup: allow FOLL_PIN to scale in SMP=0D
  mm: gup: pack has_pinned in MMF_HAS_PINNED=0D
=0D
Peter Xu (1):=0D
  mm/gup_benchmark: Support threading=0D
=0D
 fs/proc/task_mmu.c                    |  2 +-=0D
 include/linux/mm.h                    |  2 +-=0D
 include/linux/mm_types.h              | 10 ---=0D
 include/linux/sched/coredump.h        |  8 +++=0D
 kernel/fork.c                         |  1 -=0D
 mm/gup.c                              | 15 ++++-=0D
 tools/testing/selftests/vm/gup_test.c | 96 ++++++++++++++++++---------=0D
 7 files changed, 88 insertions(+), 46 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D

