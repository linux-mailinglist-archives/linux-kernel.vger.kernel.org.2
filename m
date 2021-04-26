Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE20436B759
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbhDZRAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbhDZQ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:59:59 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AA2C061574;
        Mon, 26 Apr 2021 09:59:17 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F33A82DD;
        Mon, 26 Apr 2021 16:59:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F33A82DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1619456357; bh=cg/GkQAs9SQI07fR1RKtX6LnWDCcJF1r0n5k24Mavsg=;
        h=From:To:Cc:Subject:Date:From;
        b=AV8jrafj+xF/CQtRfw7HX/4nGngKxEzR/FAQOoSiLVNfSlaXmHp9YBLFfJiV0HkMl
         ZZuBbDDRbiMFoVxnPW8LUtkxAfUzBSa3srGwtVOoz4WQOF+pPfaaA7l/hk4o060fje
         DS5umQ4HfOTDmxu3fdF34mjWazt1bpOLXAallO0D1XZyykntUwSeOFXlpQ3cU8idsL
         RUURa1rsjDUWLsvLiAaYJinIdELBxqJPIH56ZBFSLfQIHCDRUCAR26NXDZCz1NaLSU
         r+dTC87UMgTtM+P7vgliwrMRuYE/d1BCZgHPsPGVFZzsFI5ppohzHWd7tGTymLHVHF
         pP/CJdGn8jjCQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 5.13
Date:   Mon, 26 Apr 2021 10:59:16 -0600
Message-ID: <87pmyh7ziz.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.13

for you to fetch changes up to 441ca977a84dadac6173db7c07c25db110b76c1e:

  docs/zh_CN: add openrisc translation to zh_CN index (2021-04-20 16:08:15 =
-0600)

----------------------------------------------------------------
It's been a relatively busy cycle in docsland, though more than usually
well contained to Documentation/ itself.  Highlights include:

 - The Chinese translators have been busy and show no signs of stopping
   anytime soon.  Italian has also caught up.

 - Aditya Srivastava has been working on improvements to the kernel-doc
   script.

 - Thorsten continues his work on reporting-issues.rst and related
   documentation around regression reporting.

 - Lots of documentation updates, typo fixes, etc. as usual

----------------------------------------------------------------
Aditya Srivastava (4):
      scripts: kernel-doc: fix typedef support for struct/union parsing
      scripts: kernel-doc: fix attribute capture in function parsing
      scripts: kernel-doc: add warning for comment not following kernel-doc=
 syntax
      scripts: kernel-doc: improve parsing for kernel-doc comments syntax

Alex Shi (2):
      mailmap: update email address for Alex Shi
      Docs/zh_CN: update Alex Shi new email address

Barry Song (2):
      Documentation/admin-guide: kernel-parameters: correct the architectur=
es for numa_balancing
      Documentation/features: mark BATCHED_UNMAP_TLB_FLUSH doesn't apply to=
 ARM64

Bernard Zhao (1):
      docs/zh_CN: add translations in zh_CN/dev-tools/gcov

Bhaskar Chowdhury (6):
      docs: sphinx: Fix couple of spellings in the file rstFlatTable.py
      docs: livepatch: Fix a typo and remove the unnecessary gaps in a sent=
ence
      docs: admin-guide: cgroup-v1: Fix typos in the file memory.rst
      docs: rbtree.rst: Fix a typo
      docs: powerpc: Fix a typo
      docs: filesystems: Fix a mundane typo

Borislav Petkov (2):
      Documentation/submitting-patches: Extend commit message layout descri=
ption
      Documentation/submitting-patches: Document RESEND tag on patches

Bryan Brattlof (1):
      Documentation: gpio: chip should be plural

Dan Carpenter (1):
      Documentation: megaraid: fix spelling "consistend" =3D> "consistent"

David Gow (1):
      Documentation: dev-tools: Add Testing Overview

Dwaipayan Ray (3):
      docs: add documentation for checkpatch
      checkpatch: add verbose mode
      docs: document all error message types in checkpatch

Federico Vaga (1):
      doc:it_IT: align Italian documentation

Flavio Suligoi (1):
      docs: watchdog: fix obsolete include file reference in pcwd

Gao Xiang (1):
      Documentation: sysrq: update description about sysrq crash

Geert Uytterhoeven (4):
      docs: driver-model: Remove obsolete device class documentation
      docs: driver-model: device: Add DEVICE_ATTR_{RO,RW} examples
      docs: driver-model: device: Add ATTRIBUTE_GROUPS() example
      docs: dt: submitting-patches: Fix grammar in subsystem section

He Ying (1):
      docs: powerpc: Fix misspellings and grammar errors

Heinrich Schuchardt (1):
      docs: arm: /chosen node parameters

Ismael Luceno (1):
      docs: reporting-issues: Remove reference to oldnoconfig

Jiele zhao (1):
      security/loadpin: Update the changing interface in the source code.

Jonathan Corbet (3):
      docs/zh_cn: Fix a couple of reference warnings
      docs: kernel-doc: properly recognize parameter lines with colons
      docs: sphinx-pre-install: don't barf on beta Sphinx releases

Jonathan Neusch=C3=A4fer (2):
      docs: kvm: Fix a typo ("althought")
      docs: Group arch-specific documentation under "CPU Architectures"

Kees Cook (1):
      Documentation: Replace more lkml.org links with lore

Lubomir Rintel (2):
      docs: arm: marvell: replace stale links with archive links
      docs: arm: marvell: clarify some unimportant Armada 6x0 details

Lukas Bulwahn (1):
      MAINTAINERS: clarify responsibility for checkpatch documentation

Mark O'Donovan (1):
      Documentation: Add leading slash to some paths

Martin Kepplinger (1):
      Documentation: dynamic-debug-howto: fix example

Masahiro Yamada (1):
      docs: Remove make headers_check from checklist in translations

Masanari Iida (1):
      tools: Fix a typo in kernel-chktaint

Mauro Carvalho Chehab (9):
      scripts/kernel-doc: ignore identifier on anonymous enums
      docs: conf.py: adjust the LaTeX document output
      kernel-doc: better handle '::' sequences
      scripts: get_abi.pl: better handle escape chars on what:
      get_abi.pl: seek for all occurrences for Documentation/ABI
      get_abi.pl: fix xref boundaries
      scripts: get_abi.pl: extend xref match to other types
      scripts: get_abi.pl: parse description line per line
      scripts: get_abi: ignore code blocks for cross-references

Peter Xu (1):
      docs: filesystem: Update smaps vm flag list to latest

Randy Dunlap (13):
      Documentation: ioctl: add entry for nsfs.h
      fs: eventpoll: fix comments & kernel-doc notation
      Docs: add fs/eventpoll to docbooks
      input: Documentation: corrections for input.rst
      input: Documentation: corrections for event-codes.rst
      input: Documentation: update related file names in ff.rst
      input: Documentation: corrections for gameport-programming.rst
      input: Documentation: corrections for multi-touch-protocol.rst
      input: Documentation: corrections for notifier.rst
      input: Documentation: corrections for input-programming.rst
      input: Documentation: corrections for uinput.rst
      fs/namespace: correct/improve kernel-doc notation
      Documentation: filesystems api-summary: add namespace.c

SeongJae Park (1):
      docs/kokr: make sections on bug reporting match practice

St=C3=A9phane Blondon (1):
      docs: Minor spelling fix in spi documentation

Thorsten Leemhuis (12):
      docs: reporting-issues.rst: explain how to decode stack traces
      docs: reporting-issues.rst: fix small typos and style issues
      docs: reporting-issues.rst: tone down 'test vanilla mainline' a little
      docs: reporting-issues.rst: reorder some steps
      docs: reporting-issues.rst: duplicate sections for reviewing purposes
      docs: reporting-issues.rst: improved process esp. for stable regressi=
ons
      docs: make reporting-issues.rst official and delete reporting-bugs.rst
      MAINTAINERS: add entry for Documentation/admin-guide/reporting-issues=
.rst
      docs: reporting-issues.rst: reshuffle and improve TLDR
      docs: reporting-issues: reduce quoting and assorted fixes
      MAINTAINERS: add regressions mailing list
      docs: reporting-issues: make people CC the regressions list

Wang Qing (1):
      doc: admin-guide: remove explanation of "watchdog/%u"

Wu XiangCheng (29):
      docs/zh_CN: Improve zh_CN/process/index.rst
      docs/zh_CN: Improve zh_CN/process/1.Intro.rst
      docs/zh_CN: Improve zh_CN/process/2.Process.rst
      docs/zh_CN: Improve zh_CN/process/3.Early-stage.rst
      docs/zh_CN: Improve zh_CN/process/4.Coding.rst
      docs/zh_CN: Improve zh_CN/process/5.Posting.rst
      docs/zh_CN: Improve zh_CN/process/6.Followthrough
      docs/zh_CN: Improve zh_CN/process/7.AdvancedTopics
      docs/zh_CN: Improve zh_CN/process/8.Conclusion.rst
      docs/zh_CN: Add zh_CN/admin-guide/README.rst
      docs/zh_CN: Add zh_CN/admin-guide/unicode.rst
      docs/zh_CN: Add translations in zh_CN/kernel-hacking/
      docs/zh_CN: Add zh_CN/admin-guide/reporting-issues
      docs/zh_CN: Add zh_CN/admin-guide/bug-bisect.rst
      docs/zh_CN: Add zh_CN/admin-guide/bug-hunting.rst
      docs/zh_CN: Add zh_CN/admin-guide/security-bugs.rst
      docs/zh_CN: Add zh_CN/admin-guide/tainted-kernels.rst
      docs/zh_CN: Add zh_CN/admin-guide/init.rst
      docs/gcov: Convert two tags to ref in dev-tools/gov.rst
      doc/zh_CN: Clean zh_CN translation maintainer
      docs/zh_CN: Add translation zh_CN/doc-guide/sphinx.rst
      docs/zh_CN: Add translation zh_CN/doc-guide/kernel-doc.rst
      docs/zh_CN: Add translation zh_CN/doc-guide/parse-headers.rst
      docs/zh_CN: Add translation zh_CN/doc-guide/contributing.rst
      docs/zh_CN: Add translation zh_CN/doc-guide/maintainer-profile.rst
      docs/zh_CN: Add translation zh_CN/doc-guide/index.rst
      docs/zh_CN: Link zh_CN/doc-guide to zh_CN/index.rst
      docs/zh_CN: sync reporting-issues.rst
      docs/zh_CN: two minor fixes in zh_CN/doc-guide/

Yang Shi (1):
      doc: memcontrol: add description for oom_kill

Yanteng Si (23):
      docs/zh_CN:add riscv boot-image-header.rst translation
      docs/zh_CN: add riscv patch-acceptance.rst translation
      docs/zh_CN: add riscv pmu.rst translation
      docs/zh_CN: add riscv index.rst translation
      docs/zh_CN: add cpu-freq core.rst translation
      docs/zh_CN: add cpu-freq cpu-drivers.rst translation
      docs/zh_CN: add cpu-freq cpufreq-stats.rst translation
      docs/zh_CN: add cpu-freq index.rst translation
      docs/zh_CN: add cpu-freq to zh_CN index
      docs/zh_CN: add mips to zh_CN index
      docs/zh_CN: add iio to zh_CN index
      docs/zh_CN: add riscv to zh_CN index
      docs/zh_CN: add core-api irq concepts.rst translation
      docs/zh_CN: add core-api irq irq-affinity.rst translation
      docs/zh_CN: add core-api irq irq-domain.rst translation
      docs/zh_CN: add core-api irq irqflags-tracing.rst translation
      docs/zh_CN: add core-api irq index.rst translation
      docs/zh_CN: add core-api index.rst translation
      docs/zh_CN: add core api translation to zh_CN index
      docs/zh_CN: add openrisc openrisc_port.rst translation
      docs/zh_CN: add openrisc todo.rst translation
      docs/zh_CN: add openrisc index.rst translation
      docs/zh_CN: add openrisc translation to zh_CN index

hjh (1):
      PATCH Documentation translations:translate sound/hd-audio/controls to=
 chinese

 .mailmap                                           |    5 +-
 CREDITS                                            |    2 +-
 Documentation/admin-guide/LSM/LoadPin.rst          |    6 +-
 Documentation/admin-guide/cgroup-v1/memory.rst     |    7 +-
 Documentation/admin-guide/dynamic-debug-howto.rst  |    2 +-
 Documentation/admin-guide/index.rst                |    1 -
 Documentation/admin-guide/kernel-parameters.rst    |    1 +
 Documentation/admin-guide/kernel-parameters.txt    |    3 +-
 .../admin-guide/kernel-per-CPU-kthreads.rst        |   20 -
 Documentation/admin-guide/mm/numaperf.rst          |    2 +-
 Documentation/admin-guide/reporting-bugs.rst       |  187 ---
 Documentation/admin-guide/reporting-issues.rst     | 1117 ++++++++--------
 Documentation/admin-guide/sysrq.rst                |    4 +-
 Documentation/arch.rst                             |   26 +
 Documentation/arm/marvell.rst                      |  159 +--
 Documentation/arm/uefi.rst                         |    7 +
 Documentation/conf.py                              |   31 +-
 Documentation/core-api/rbtree.rst                  |    2 +-
 Documentation/dev-tools/checkpatch.rst             |  755 +++++++++++
 Documentation/dev-tools/gcov.rst                   |    8 +-
 Documentation/dev-tools/index.rst                  |    5 +
 Documentation/dev-tools/testing-overview.rst       |  117 ++
 .../devicetree/bindings/submitting-patches.rst     |    4 +-
 Documentation/driver-api/driver-model/class.rst    |  149 ---
 Documentation/driver-api/driver-model/device.rst   |   23 +-
 Documentation/driver-api/driver-model/index.rst    |    1 -
 Documentation/driver-api/gpio/intro.rst            |    2 +-
 Documentation/fb/fbcon.rst                         |    4 +-
 Documentation/features/arch-support.txt            |    1 +
 Documentation/features/vm/TLB/arch-support.txt     |    2 +-
 Documentation/filesystems/api-summary.rst          |    9 +
 Documentation/filesystems/proc.rst                 |    4 +
 Documentation/filesystems/vfat.rst                 |    2 +-
 Documentation/hid/intel-ish-hid.rst                |    2 +-
 Documentation/index.rst                            |   20 +-
 Documentation/input/event-codes.rst                |   10 +-
 Documentation/input/ff.rst                         |    6 +-
 Documentation/input/gameport-programming.rst       |   35 +-
 Documentation/input/input-programming.rst          |   20 +-
 Documentation/input/input.rst                      |    8 +-
 Documentation/input/multi-touch-protocol.rst       |    8 +-
 Documentation/input/notifier.rst                   |    3 +-
 Documentation/input/uinput.rst                     |    2 +-
 Documentation/leds/leds-lm3556.rst                 |   28 +-
 Documentation/livepatch/shadow-vars.rst            |    4 +-
 Documentation/powerpc/booting.rst                  |    2 +-
 Documentation/powerpc/dawr-power9.rst              |    2 +-
 Documentation/powerpc/eeh-pci-error-recovery.rst   |    2 +-
 Documentation/powerpc/elfnote.rst                  |    2 +-
 Documentation/powerpc/firmware-assisted-dump.rst   |    4 +-
 Documentation/powerpc/kaslr-booke32.rst            |    2 +-
 Documentation/powerpc/mpc52xx.rst                  |    2 +-
 Documentation/powerpc/papr_hcalls.rst              |    4 +-
 Documentation/powerpc/transactional_memory.rst     |    4 +-
 Documentation/process/submitting-patches.rst       |  101 +-
 Documentation/scsi/ChangeLog.megaraid              |    2 +-
 Documentation/sphinx/rstFlatTable.py               |    4 +-
 Documentation/spi/butterfly.rst                    |    2 +-
 .../translations/it_IT/doc-guide/sphinx.rst        |   47 +-
 .../translations/it_IT/kernel-hacking/hacking.rst  |    2 +-
 .../translations/it_IT/kernel-hacking/locking.rst  |   12 +-
 .../translations/it_IT/process/4.Coding.rst        |    9 +-
 .../translations/it_IT/process/adding-syscalls.rst |    2 +-
 .../translations/it_IT/process/coding-style.rst    |   22 +-
 Documentation/translations/it_IT/process/howto.rst |   25 +-
 .../translations/it_IT/process/magic-number.rst    |    2 -
 .../it_IT/process/submit-checklist.rst             |   21 +-
 .../it_IT/process/submitting-patches.rst           |   98 +-
 Documentation/translations/ja_JP/SubmitChecklist   |    8 +-
 Documentation/translations/ko_KR/howto.rst         |   18 +-
 .../translations/zh_CN/admin-guide/README.rst      |  347 +++++
 .../translations/zh_CN/admin-guide/bug-bisect.rst  |   81 ++
 .../translations/zh_CN/admin-guide/bug-hunting.rst |  340 +++++
 .../translations/zh_CN/admin-guide/index.rst       |   19 +-
 .../translations/zh_CN/admin-guide/init.rst        |   54 +
 .../zh_CN/admin-guide/reporting-issues.rst         | 1335 ++++++++++++++++=
++++
 .../zh_CN/admin-guide/security-bugs.rst            |   74 ++
 .../zh_CN/admin-guide/tainted-kernels.rst          |  157 +++
 .../translations/zh_CN/admin-guide/unicode.rst     |  170 +++
 .../translations/zh_CN/core-api/index.rst          |  126 ++
 .../translations/zh_CN/core-api/irq/concepts.rst   |   24 +
 .../translations/zh_CN/core-api/irq/index.rst      |   19 +
 .../zh_CN/core-api/irq/irq-affinity.rst            |   76 ++
 .../translations/zh_CN/core-api/irq/irq-domain.rst |  227 ++++
 .../zh_CN/core-api/irq/irqflags-tracing.rst        |   45 +
 Documentation/translations/zh_CN/cpu-freq/core.rst |  105 ++
 .../translations/zh_CN/cpu-freq/cpu-drivers.rst    |  259 ++++
 .../translations/zh_CN/cpu-freq/cpufreq-stats.rst  |  130 ++
 .../translations/zh_CN/cpu-freq/index.rst          |   45 +
 .../translations/zh_CN/dev-tools/gcov.rst          |  264 ++++
 .../translations/zh_CN/dev-tools/index.rst         |   35 +
 .../translations/zh_CN/disclaimer-zh_CN.rst        |    2 +-
 .../translations/zh_CN/doc-guide/contributing.rst  |  238 ++++
 .../translations/zh_CN/doc-guide/index.rst         |   27 +
 .../translations/zh_CN/doc-guide/kernel-doc.rst    |  499 ++++++++
 .../zh_CN/doc-guide/maintainer-profile.rst         |   43 +
 .../translations/zh_CN/doc-guide/parse-headers.rst |  187 +++
 .../translations/zh_CN/doc-guide/sphinx.rst        |  415 ++++++
 Documentation/translations/zh_CN/index.rst         |   10 +
 .../translations/zh_CN/kernel-hacking/hacking.rst  |  708 +++++++++++
 .../translations/zh_CN/kernel-hacking/index.rst    |   22 +
 .../translations/zh_CN/openrisc/index.rst          |   30 +
 .../translations/zh_CN/openrisc/openrisc_port.rst  |  124 ++
 Documentation/translations/zh_CN/openrisc/todo.rst |   20 +
 .../translations/zh_CN/process/1.Intro.rst         |  195 +--
 .../translations/zh_CN/process/2.Process.rst       |  345 ++---
 .../translations/zh_CN/process/3.Early-stage.rst   |  139 +-
 .../translations/zh_CN/process/4.Coding.rst        |  279 ++--
 .../translations/zh_CN/process/5.Posting.rst       |  243 ++--
 .../translations/zh_CN/process/6.Followthrough.rst |  165 +--
 .../zh_CN/process/7.AdvancedTopics.rst             |  141 ++-
 .../translations/zh_CN/process/8.Conclusion.rst    |   60 +-
 Documentation/translations/zh_CN/process/index.rst |   10 +-
 .../zh_CN/process/submit-checklist.rst             |   14 +-
 .../translations/zh_CN/riscv/boot-image-header.rst |   67 +
 Documentation/translations/zh_CN/riscv/index.rst   |   28 +
 .../translations/zh_CN/riscv/patch-acceptance.rst  |   31 +
 Documentation/translations/zh_CN/riscv/pmu.rst     |  233 ++++
 .../translations/zh_CN/sound/hd-audio/controls.rst |  102 ++
 .../translations/zh_CN/sound/hd-audio/index.rst    |   14 +
 Documentation/translations/zh_CN/sound/index.rst   |   22 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 Documentation/virt/kvm/api.rst                     |    2 +-
 Documentation/watchdog/pcwd-watchdog.rst           |    2 +-
 MAINTAINERS                                        |   24 +-
 fs/eventpoll.c                                     |   52 +-
 fs/namespace.c                                     |   14 +-
 scripts/checkpatch.pl                              |  133 +-
 scripts/get_abi.pl                                 |   74 +-
 scripts/kernel-doc                                 |   60 +-
 scripts/sphinx-pre-install                         |    2 +-
 tools/debugging/kernel-chktaint                    |    2 +-
 tools/scripts/Makefile.include                     |    3 +-
 133 files changed, 9868 insertions(+), 2059 deletions(-)
 delete mode 100644 Documentation/admin-guide/reporting-bugs.rst
 create mode 100644 Documentation/arch.rst
 create mode 100644 Documentation/dev-tools/checkpatch.rst
 create mode 100644 Documentation/dev-tools/testing-overview.rst
 delete mode 100644 Documentation/driver-api/driver-model/class.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/README.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/bug-bisect=
.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/bug-huntin=
g.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/init.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/reporting-=
issues.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/security-b=
ugs.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/tainted-ke=
rnels.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/unicode.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/index.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/irq/concepts.=
rst
 create mode 100644 Documentation/translations/zh_CN/core-api/irq/index.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/irq/irq-affin=
ity.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/irq/irq-domai=
n.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/irq/irqflags-=
tracing.rst
 create mode 100644 Documentation/translations/zh_CN/cpu-freq/core.rst
 create mode 100644 Documentation/translations/zh_CN/cpu-freq/cpu-drivers.r=
st
 create mode 100644 Documentation/translations/zh_CN/cpu-freq/cpufreq-stats=
.rst
 create mode 100644 Documentation/translations/zh_CN/cpu-freq/index.rst
 create mode 100644 Documentation/translations/zh_CN/dev-tools/gcov.rst
 create mode 100644 Documentation/translations/zh_CN/dev-tools/index.rst
 create mode 100644 Documentation/translations/zh_CN/doc-guide/contributing=
.rst
 create mode 100644 Documentation/translations/zh_CN/doc-guide/index.rst
 create mode 100644 Documentation/translations/zh_CN/doc-guide/kernel-doc.r=
st
 create mode 100644 Documentation/translations/zh_CN/doc-guide/maintainer-p=
rofile.rst
 create mode 100644 Documentation/translations/zh_CN/doc-guide/parse-header=
s.rst
 create mode 100644 Documentation/translations/zh_CN/doc-guide/sphinx.rst
 create mode 100644 Documentation/translations/zh_CN/kernel-hacking/hacking=
.rst
 create mode 100644 Documentation/translations/zh_CN/kernel-hacking/index.r=
st
 create mode 100644 Documentation/translations/zh_CN/openrisc/index.rst
 create mode 100644 Documentation/translations/zh_CN/openrisc/openrisc_port=
.rst
 create mode 100644 Documentation/translations/zh_CN/openrisc/todo.rst
 create mode 100644 Documentation/translations/zh_CN/riscv/boot-image-heade=
r.rst
 create mode 100644 Documentation/translations/zh_CN/riscv/index.rst
 create mode 100644 Documentation/translations/zh_CN/riscv/patch-acceptance=
.rst
 create mode 100644 Documentation/translations/zh_CN/riscv/pmu.rst
 create mode 100644 Documentation/translations/zh_CN/sound/hd-audio/control=
s.rst
 create mode 100644 Documentation/translations/zh_CN/sound/hd-audio/index.r=
st
 create mode 100644 Documentation/translations/zh_CN/sound/index.rst
