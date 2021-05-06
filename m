Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F921375D5E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 01:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhEFX0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 19:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230422AbhEFX0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 19:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620343542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/ULBbnWzA4nZLVuFHzAZkrdA4s37J6kM0ZzmRH1eA7Q=;
        b=fuiXUxuhTM0gvpFIuz6yquwxfXGVt6lYP6v95wB/SwTnV4wt7hRHzyNcz7A9zpRxVGfpj0
        PeB+A935dG3hQpAzI4vM0USM9MaaV1+ChfzPJqKhFAuAvQOQQyD3cIiOnZmT7MFfjLyv/j
        nz+stn3NtCDiKoJYaJwJbItPIOL/26A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-dGqAj9usM2O_G8IC7B5lmw-1; Thu, 06 May 2021 19:25:40 -0400
X-MC-Unique: dGqAj9usM2O_G8IC7B5lmw-1
Received: by mail-qk1-f199.google.com with SMTP id z12-20020a05620a08ccb02902ea1e4a963dso4638702qkz.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 16:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ULBbnWzA4nZLVuFHzAZkrdA4s37J6kM0ZzmRH1eA7Q=;
        b=tBl2IJvaeu8Rn2yjhyy/rxPGYRgpyiYuWgMIO6ZZ0UlD/OonQkIN4FZ8E9EZvok3gU
         lWWRNlmDcA1Jm3HstTQHyn5gJAedGtoT1/UVGBPP/n9fK/CxtB+6WnvC8HuVQ/958eYx
         IE//ZMSsF4rMDvchlucNcUQCcUjNpjb63eeifvYMo9zGohAVthYf4WpoYzOG4aCl78/x
         PhMJVX7gPONkAAmxbnhkcfYwOaLxgSX7ydhjhy3BXQk8Rw8rO23lKHwoh1M10EA1p6qR
         vEVgQJD1spenZ9Cjk0iUmCofx40AF1VKUZHS3j8A5y38jbnC53VSeac64PE7b+cVQeEO
         PHQw==
X-Gm-Message-State: AOAM533Oz9wrF+cx8c/pKgFNgNKYunNVOrFrBpBlHEPEFvK3sIGkZK0E
        aWsja/+MCcL3v/COD7MogSNtv/rFIcQWNYYlcL9zlNg14kHsSz6PSsGZUwfKvQSxxyuIkH/1J/6
        Mg6K6P0J2I3aVDCagPPHY7+Dr
X-Received: by 2002:ac8:7512:: with SMTP id u18mr6832333qtq.204.1620343539605;
        Thu, 06 May 2021 16:25:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJ8E2EpRBlSQsJ49ibReWq9J6BbHBBmWbA6e8AmNR3VLNuKeUicZWZ6smdjO7PSrUeoluZ3w==
X-Received: by 2002:ac8:7512:: with SMTP id u18mr6832300qtq.204.1620343539267;
        Thu, 06 May 2021 16:25:39 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id q13sm1605026qkn.10.2021.05.06.16.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 16:25:38 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH 0/3] mm/gup: Fix pin page write cache bouncing on has_pinned
Date:   Thu,  6 May 2021 19:25:34 -0400
Message-Id: <20210506232537.165788-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains 3 patches, the 1st one enables threading for gup_bench=
ma=3D=0D
rk=0D
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
th=3D=0D
en=0D
we can even easily verify the patchset using the existing kselftest facilit=
ies=0D
or even regress test it in the future with the repo if we want.=0D
=0D
Below numbers are extra verification tests that I did besides commit messag=
e =3D=0D
of=0D
patch 2 using the new gup_benchmark and 256 cpus.  Below test is done on 40=
=0D
cpus host with Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz, and I can get sim=
il=3D=0D
ar=0D
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
t =3D=0D
much.=0D
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
 include/linux/sched/coredump.h        |  1 +=0D
 kernel/fork.c                         |  1 -=0D
 mm/gup.c                              |  9 +--=0D
 tools/testing/selftests/vm/gup_test.c | 94 ++++++++++++++++++---------=0D
 7 files changed, 71 insertions(+), 48 deletions(-)=0D
=0D
--=3D20=0D
2.31.1=0D
=0D

