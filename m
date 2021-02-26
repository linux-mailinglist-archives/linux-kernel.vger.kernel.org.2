Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8C5326723
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 19:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhBZSyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 13:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhBZSyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:54:46 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FC8C061574;
        Fri, 26 Feb 2021 10:54:05 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5BAA32ED;
        Fri, 26 Feb 2021 18:54:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5BAA32ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614365645; bh=07qo+f5FyVdCDPdARO4iRb+hdwhOO6h7yOzWMm94L40=;
        h=From:To:Cc:Subject:Date:From;
        b=fw74H5J7vNcSuTJYxnmY4/wbzEyCw2GBKS8psk8Grnngdc+74L7CUGVRaVe9KDNrO
         lw3i43GsogvHHye8hHq3/UYZAtHCjKv7YjlyrqCWtSh8HZFqAewrF8+r8623NV/ivU
         5z5QnUtE5nqj6iiSmURy47X8I6HbjuQ11Sq7h+NwPd7FvYT6/AiqU80NOCUqVoAmOk
         6lvXi+/jFOQWqHw0gpadikkfk9ihfOdT68hNhUyEQowkyt+iZlF352sGJOJptvjtJT
         CQL60CJA4KHCi6rD+9gKmduILzwp6nRpDCkQVqK7zTmcXLneTnrFq4D7Zth5ulwLqJ
         irNJJ7H4FedXg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 5.12
Date:   Fri, 26 Feb 2021 11:54:04 -0700
Message-ID: <87blc68xtf.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3c2e0a489da6a7c48ad67a246c7a287fcb4a4607:

  docs: kernel-hacking: be more civil (2021-02-11 10:00:40 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.12-2

for you to fetch changes up to f37a15ea8db022373a2cb6d1a6004c65c2b7f17e:

  docs: proc.rst: fix indentation warning (2021-02-25 13:11:00 -0700)

----------------------------------------------------------------
A handful of late-arriving documentation fixes, nothing all that notable.

----------------------------------------------------------------
Aditya Srivastava (1):
      scripts: kernel-doc: fix array element capture in pointer-to-func par=
sing

Andrew Donnellan (1):
      docs: powerpc: Fix tables in syscall64-abi.rst

Antonio Terceiro (1):
      Documentation: cgroup-v2: fix path to example BPF program

Arnd Bergmann (2):
      Documentation: features: remove c6x references
      Documentation: features: refresh feature list

Masahiro Yamada (1):
      doc: use KCFLAGS instead of EXTRA_CFLAGS to pass flags from command l=
ine

Matthew Wilcox (1):
      Fix unaesthetic indentation

Michael Wei=C3=9F (1):
      docs: ABI: testing: ima_policy: Fixed missing bracket

Randy Dunlap (2):
      Documentation: proc.rst: add more about the 6 fields in loadavg
      docs: proc.rst: fix indentation warning

 Documentation/ABI/testing/ima_policy               |  2 +-
 Documentation/admin-guide/cgroup-v2.rst            |  2 +-
 Documentation/conf.py                              |  3 +-
 .../features/core/cBPF-JIT/arch-support.txt        |  1 -
 .../features/core/eBPF-JIT/arch-support.txt        |  1 -
 .../core/generic-idle-thread/arch-support.txt      |  1 -
 .../features/core/jump-labels/arch-support.txt     |  1 -
 .../features/core/tracehook/arch-support.txt       |  1 -
 .../features/debug/KASAN/arch-support.txt          |  1 -
 .../debug/debug-vm-pgtable/arch-support.txt        |  1 -
 .../debug/gcov-profile-all/arch-support.txt        |  3 +-
 Documentation/features/debug/kcov/arch-support.txt |  1 -
 Documentation/features/debug/kgdb/arch-support.txt |  1 -
 .../features/debug/kmemleak/arch-support.txt       |  3 +-
 .../debug/kprobes-on-ftrace/arch-support.txt       |  3 +-
 .../features/debug/kprobes/arch-support.txt        |  3 +-
 .../features/debug/kretprobes/arch-support.txt     |  3 +-
 .../features/debug/optprobes/arch-support.txt      |  1 -
 .../features/debug/stackprotector/arch-support.txt |  1 -
 .../features/debug/uprobes/arch-support.txt        |  3 +-
 .../debug/user-ret-profiler/arch-support.txt       |  1 -
 .../features/io/dma-contiguous/arch-support.txt    |  1 -
 .../locking/cmpxchg-local/arch-support.txt         |  1 -
 .../features/locking/lockdep/arch-support.txt      |  1 -
 .../locking/queued-rwlocks/arch-support.txt        |  1 -
 .../locking/queued-spinlocks/arch-support.txt      |  1 -
 .../features/perf/kprobes-event/arch-support.txt   |  3 +-
 .../features/perf/perf-regs/arch-support.txt       |  3 +-
 .../features/perf/perf-stackdump/arch-support.txt  |  3 +-
 .../sched/membarrier-sync-core/arch-support.txt    |  1 -
 .../features/sched/numa-balancing/arch-support.txt |  3 +-
 .../seccomp/seccomp-filter/arch-support.txt        |  1 -
 .../time/arch-tick-broadcast/arch-support.txt      |  1 -
 .../features/time/clockevents/arch-support.txt     |  1 -
 .../time/context-tracking/arch-support.txt         |  1 -
 .../features/time/irq-time-acct/arch-support.txt   |  1 -
 .../features/time/virt-cpuacct/arch-support.txt    |  1 -
 .../features/vm/ELF-ASLR/arch-support.txt          |  1 -
 .../features/vm/PG_uncached/arch-support.txt       |  1 -
 Documentation/features/vm/THP/arch-support.txt     |  1 -
 Documentation/features/vm/TLB/arch-support.txt     |  1 -
 .../features/vm/huge-vmap/arch-support.txt         |  1 -
 .../features/vm/ioremap_prot/arch-support.txt      |  1 -
 .../features/vm/pte_special/arch-support.txt       |  1 -
 Documentation/filesystems/proc.rst                 |  4 ++
 Documentation/powerpc/syscall64-abi.rst            | 51 ++++++++++++++----=
----
 Documentation/process/4.Coding.rst                 |  2 +-
 Documentation/process/submit-checklist.rst         |  2 +-
 .../translations/it_IT/process/4.Coding.rst        |  2 +-
 .../it_IT/process/submit-checklist.rst             |  2 +-
 .../translations/zh_CN/process/4.Coding.rst        |  2 +-
 drivers/gpu/drm/tilcdc/Makefile                    |  2 +-
 scripts/kernel-doc                                 |  2 +-
 53 files changed, 56 insertions(+), 81 deletions(-)
