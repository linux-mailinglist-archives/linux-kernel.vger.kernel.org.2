Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083C744D369
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhKKIyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhKKIyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:54:02 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA333C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:13 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id m78-20020a252651000000b005c1f44d3c7bso8254614ybm.22
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=O0LY5Tc/WwpanBFSuq1qIm1uPBqkjY5MfNQ8SsindHs=;
        b=DFkMnkflMqgVHLb8HbrlxDZag54YvyTeEfEAnIf5bqRorBUd/IPB3+X3HRFMsNTdsd
         Xwuw0+PRSSzkurnuaWbKCswNsEktgO7kDEKMhd4Nontf+Cv4h1fQAVGGWzXGP92m8q1o
         p7UuoYvtux5PkPehhCZI5IvoCR0an8f9zWV2v2ihsk7wj2hLUD454rUxeVjJe2zSwA4H
         LDHi72p+kTKtR1HIaarTmaO9CLUdI1qObC3SIHMCw8xBNmfgkutI9w3Z+jRFORuc89qK
         YL42mLDiuNbJenk1fkNJ5KPihfFpXcQANG3Rz6k1++q5c8SxdcMkTo2YIUI3wpEYBVfU
         nB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=O0LY5Tc/WwpanBFSuq1qIm1uPBqkjY5MfNQ8SsindHs=;
        b=KfwsJNJCfC+L8ftYCoGMBz8hV1pI4fcdSepTIpGOFfrzuDzrc0t2TXGPqmLPy7MYtC
         3OieX2ujfMz/Npz5U3iNtPWmihyffNGKRniAEFwPQ7iizjAkJ5z9SP8Di1IYwJfEFKXh
         1BDOcJLnqXZ7QUcZoqMgI3MFJL71vhK+lPp4rwGABV3lo05144ITV3oqEjcC3koDQ5/B
         i6dgfXIajua1n898xaCGQeLs7RDyJepDDfUzKTWK4InLdheESBGMYhOHRr7YAZNKv+8t
         9LRx0CPHBYlHTHbO4t1hAXsKAVvfw/3wOOgDk3E9l2NjgYbInCrRwDmUUwQ+ktOXw8NW
         RBoQ==
X-Gm-Message-State: AOAM5301mKZM7bTo30KxRRUGc/wRzxW5A8nIywZxbufAKCnLtZaSypdV
        bej4GldU9l1W2LS3uk1/J1nP7rlQlSuc4IoytF7NrEKezhzNxrpF96vHR4aa+1o3G1TWuCuT1D/
        BNGIhZ4Sx1vmRaHj5cDW0aTt7c2jfW1iP16vtsoPXRdMIZBRLgTxJwmEiqdkliwu1qMWasJTY
X-Google-Smtp-Source: ABdhPJzet0LNhy3sT2e8r/J+LrG9Wr2WM/vh0UkRBEp6Lyw9JQATleGhnrXSaCgm6s6R6HhA0/gdlR7SueYE
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:cdfe:134b:9d27:6cbf])
 (user=eranian job=sendgmr) by 2002:a25:b943:: with SMTP id
 s3mr6283083ybm.432.1636620673009; Thu, 11 Nov 2021 00:51:13 -0800 (PST)
Date:   Thu, 11 Nov 2021 00:44:02 -0800
Message-Id: <20211111084415.663951-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 00/13] perf/x86/amd: Add AMD Fam19h Branch Sampling support
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the AMD Fam19h 16-deep branch sampling
feature as described in the AMD PPR Fam19h Model 01h Revision B1 section
2.1.13. This is a model specific extension. It is not an architected AMD
feature.

The Branch Sampling Feature (BRS) provides the statistical taken branch
information necessary to enable autoFDO-style optimization by compilers,
i.e., basic block execution counts.

BRS operates with a 16-deep saturating buffer in MSR registers. There is no
hardware branch type filtering. All control flow changes are captured. BRS
relies on specific programming of the core PMU of Fam19h.  In particular,
the following requirements must be met:
 - the sampling period be greater than 16 (BRS depth)
 - the sampling period must use fixed and not frequency mode

BRS interacts with the NMI interrupt as well. Because enabling BRS is
expensive, it is only activated after P event occurrences, where P is the
desired sampling period. At P occurrences of the event, the counter
overflows, the CPU catches the NMI interrupt, activates BRS for 16 branches
until it saturates, and then delivers the NMI to the kernel. Between the
overflow and the time BRS activates more branches may be executed skewing the
period. All along, the sampling event keeps counting. The skid may be
attenuated by reducing the sampling period by 16.

BRS is integrated into perf_events seamlessly via the same
PERF_RECORD_BRANCH_STACK sample format. BRS generates branch
perf_branch_entry records in the sampling buffer. There is no prediction or
latency information supported. The branches are stored in reverse order of
execution.  The most recent branch is the first entry in each record.

Because BRS must be stopped when a CPU goes into low power mode, the series
includes patches to add callbacks on ACPI low power entry and exit which is
used on AMD processors.

Given that there is no privilege filterting with BRS, the kernel implements
filtering on privlege level.

This version adds a few simple modifications to perf record and report.
1. add the branch-brs event as a builtin such as it can used directly:
   perf record -e branch-brs ...
2. improve error handling for AMD IBS and is contributed by Kim Phillips.
3. use the better error handling to improve error handling for BRS.
4. add two new sort dimensions to help display the branch sampling
   information. Because there is no latency information associated with the
   branch sampling feature perf report would collapse all samples within a
   function into a single histogram entry. This is expected because the
   default sort mode for PERF_SAMPLE_BRANCH_STACK is symbol_from/symbol_to.
   This propagates to the annotation.

For more detailed view of the branch samples, the new sort dimensions
addr_from,addr_to can be used instead as follows:

$ perf report --sort=overhead,comm,dso,addr_from,addr_to 
# Overhead  Command    Shared Object     Source Address   Target Address
# ........  .......... ..............  ..............     ..............
#
     4.21%  test_prg   test_prg       [.] test_threa+0x3c [.] test_threa+0x4
     4.14%  test_prg   test_prg       [.] test_threa+0x3e [.] test_threa+0x2
     4.10%  test_prg   test_prg       [.] test_threa+0x4  [.] test_threa+0x3a
     4.07%  test_prg   test_prg       [.] test_threa+0x2  [.] test_threa+0x3c

Versus the default output:

$ perf report 
# Overhead  Command   Source Shared Object Source Symbol    Target Symbol      Basic Block Cycles
# ........  ......... .................... ................ .................  ..................
#
    99.52%  test_prg  test_prg             [.] test_thread  [.] test_thread    -                 

BRS can be used with any sampling event. However, it is recommended to use
the RETIRED_BRANCH event because it matches what the BRS captures. For
convenience, a pseudo event matching the branches captured by BRS is
exported by the kernel (branch-brs):

$ perf record -b -e cpu/branch-brs/ -c 1000037 test

$ perf report -D
56531696056126 0x193c000 [0x1a8]: PERF_RECORD_SAMPLE(IP, 0x2): 18122/18230: 0x401d24 period: 1000037 addr: 0
... branch stack: nr:16
.....  0: 0000000000401d24 -> 0000000000401d5a 0 cycles      0
.....  1: 0000000000401d5c -> 0000000000401d24 0 cycles      0
.....  2: 0000000000401d22 -> 0000000000401d5c 0 cycles      0
.....  3: 0000000000401d5e -> 0000000000401d22 0 cycles      0
.....  4: 0000000000401d20 -> 0000000000401d5e 0 cycles      0
.....  5: 0000000000401d3e -> 0000000000401d20 0 cycles      0
.....  6: 0000000000401d42 -> 0000000000401d3e 0 cycles      0
.....  7: 0000000000401d3c -> 0000000000401d42 0 cycles      0
.....  8: 0000000000401d44 -> 0000000000401d3c 0 cycles      0
.....  9: 0000000000401d3a -> 0000000000401d44 0 cycles      0
..... 10: 0000000000401d46 -> 0000000000401d3a 0 cycles      0
..... 11: 0000000000401d38 -> 0000000000401d46 0 cycles      0
..... 12: 0000000000401d48 -> 0000000000401d38 0 cycles      0
..... 13: 0000000000401d36 -> 0000000000401d48 0 cycles      0
..... 14: 0000000000401d4a -> 0000000000401d36 0 cycles      0
..... 15: 0000000000401d34 -> 0000000000401d4a 0 cycles      0
 ... thread: test:18230
 ...... dso: test

Special thanks to Kim Phillips @ AMD for the testing, reviews and
contributions.

V2 makes the following changes:
  - the low power callback code has be reworked completly. It is not
    impacting the generic perf_events code anymore. This is all handled
    via x86 code and only for ACPI low power driver which seems to be the
    default on AMD. The change in acpi_pad.c and processor_idle.c has no
    impact on non x86 architectures, on Intel x86 or AMD without BRS, a
    jump label is used to void the code unless necessary

  - BRS is an opt-in compile time option for the kernel

  - branch_stack bit clearing helper is introduced

  - As for the fact that BRS holds the NMI and that it may conflict with
    other sampling events and introduced skid, this is not really a problem
    because AMD PMI skid is already very large prompting special handling in
    amd_pmu_wait_on_overflow(), so adding a few cycles while the CPU executes
    at most 16 taken branches is not a problem.

Kim Phillips (1):
  perf tools: improve IBS error handling

Stephane Eranian (12):
  perf/core: add perf_clear_branch_entry_bitfields() helper
  x86/cpufeatures: add AMD Fam19h Branch Sampling feature
  perf/x86/amd: add AMD Fam19h Branch Sampling support
  perf/x86/amd: add branch-brs helper event for Fam19h BRS
  perf/x86/amd: enable branch sampling priv level filtering
  perf/x86/amd: add AMD branch sampling period adjustment
  perf/x86/amd: make Zen3 branch sampling opt-in
  ACPI: add perf low power callback
  perf/x86/amd: add idle hooks for branch sampling
  perf tools: add branch-brs as a new event
  perf tools: improve error handling of AMD Branch Sampling
  perf report: add addr_from/addr_to sort dimensions

 arch/x86/events/Kconfig            |   8 +                                   
 arch/x86/events/amd/Makefile       |   1 +                                   
 arch/x86/events/amd/brs.c          | 349 +++++++++++++++++++++++++++++       
 arch/x86/events/amd/core.c         | 221 +++++++++++++++++-                  
 arch/x86/events/core.c             |  22 +-                                  
 arch/x86/events/intel/lbr.c        |  36 ++-                                 
 arch/x86/events/perf_event.h       | 129 +++++++++--                         
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/msr-index.h   |   4 +
 arch/x86/include/asm/perf_event.h  |  21 ++
 drivers/acpi/acpi_pad.c            |   6 +
 drivers/acpi/processor_idle.c      |   5 +
 include/linux/perf_event.h         |  22 ++
 tools/perf/util/evsel.c            |  50 +++++
 tools/perf/util/hist.c             |   2 +
 tools/perf/util/hist.h             |   2 +
 tools/perf/util/parse-events.l     |   1 +
 tools/perf/util/sort.c             | 128 +++++++++++
 tools/perf/util/sort.h             |   2 +
 19 files changed, 970 insertions(+), 40 deletions(-)
 create mode 100644 arch/x86/events/amd/brs.c

-- 
2.34.0.rc0.344.g81b53c2807-goog

