Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A87F40401A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 22:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352130AbhIHUPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 16:15:07 -0400
Received: from ms.lwn.net ([45.79.88.28]:38650 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233179AbhIHUPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 16:15:06 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 42B986173;
        Wed,  8 Sep 2021 20:13:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 42B986173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1631132038; bh=1i/9rlpqoBrStc2V73h10zvqo04vsDO8asoz6GY9RI4=;
        h=From:To:Cc:Subject:Date:From;
        b=GLNnsLSBrfpZeb8ky/BwLxgnZlhs8610clxc/3qjOvH4db1NWkYaGM6BJYgD9MrF4
         iAsMK06tSNiCFpmviiNHc1LMHDY5jiNYk4U5cGjtqn/z0oRwGyRlOtv0GdD8FtiFTY
         z5PqQ+UgouO4ql204PfDfAIbqlo1lExm9lJI9Rpapt4Yh48AzKc0x3OKdIEJAWzFQN
         e6S2tsZswUIh8MhBuEmyWL4eWRrwuTsVIni/IKv2ImNcWJVj7Q4J6ljxUL88Q9Y6Uv
         v+8BXORrl/vBCrQcw4eki48g48P2Ocs3v15TYmbgYu/g8dUKaFy0QvQ+quDagp++1D
         kZ+kNxF/D/CMA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] More documentation changes for 5.15
Date:   Wed, 08 Sep 2021 14:13:57 -0600
Message-ID: <87ilzaq0ze.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 37397b092e7f4b520a257aaafe83f868cd3d5e27:

  docs: sphinx-requirements: Move sphinx_rtd_theme to top (2021-08-12 09:15=
:38 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.15-2

for you to fetch changes up to 7c5c18bdb656057cb76fabfa1a74b793ac49da35:

  docs: pdfdocs: Fix typo in CJK-language specific font settings (2021-09-0=
6 16:53:39 -0600)

----------------------------------------------------------------
Another collection of documentation patches, mostly fixes but also includes
another set of traditional Chinese translations.

Note that most of these changes were supposed to be in the first pull
request.  I'm not really sure how that didn't happen; I blame switching
between computers while an army of trained gorillas was loudly replacing
all of the windows in my house.
----------------------------------------------------------------
Akira Yokosawa (1):
      docs: pdfdocs: Fix typo in CJK-language specific font settings

Alexander Aring (1):
      Documentation: locking: fix references

Alyssa Rosenzweig (1):
      docs: kernel-hacking: Remove inappropriate text

Changbin Du (1):
      Documentation: in_irq() cleanup

Chun-Hung Tseng (1):
      Documentation: Update details of The Linux Kernel Module Programming =
Guide

Hu Haowen (3):
      docs/zh_TW: add translations for zh_TW/arm64
      docs/zh_TW: add translations for zh_TW/cpu-freq
      docs/zh_TW: add translations for zh_TW/filesystems

Jinay Jain (1):
      Documentation: block: blk-mq: Fix small typo in multi-queue docs

Mark Rutland (1):
      Documentation/features/vm: correct huge-vmap APIs

Pali Roh=C3=A1r (1):
      Documentation: arm: marvell: Add 88F6825 model into list

Peilin Ye (1):
      docs: x86: Remove obsolete information about x86_64 vmalloc() faulting

SeongJae Park (2):
      Documentation/process/applying-patches: Activate linux-next man hyper=
link
      Documentation/process/maintainer-pgp-guide: Replace broken link to PG=
P path finder

Yanteng Si (1):
      docs/zh_CN: Modify the translator tag and fix the wrong word

 Documentation/arm/marvell.rst                      |   1 +
 Documentation/block/blk-mq.rst                     |   2 +-
 Documentation/conf.py                              |   4 +-
 .../features/vm/huge-vmap/arch-support.txt         |   2 +-
 Documentation/kernel-hacking/hacking.rst           |   4 +-
 Documentation/kernel-hacking/locking.rst           |  12 +-
 Documentation/locking/futex-requeue-pi.rst         |   2 +-
 Documentation/locking/ww-mutex-design.rst          |   2 +-
 Documentation/process/applying-patches.rst         |   2 +-
 Documentation/process/kernel-docs.rst              |  14 +-
 Documentation/process/maintainer-pgp-guide.rst     |  14 +-
 .../translations/it_IT/kernel-hacking/hacking.rst  |   2 +-
 .../translations/it_IT/kernel-hacking/locking.rst  |   4 +-
 .../translations/zh_CN/core-api/cachetlb.rst       |   2 +-
 .../translations/zh_CN/core-api/index.rst          |   8 +-
 .../translations/zh_CN/core-api/irq/concepts.rst   |   8 +-
 .../translations/zh_CN/core-api/irq/index.rst      |   7 +-
 .../zh_CN/core-api/irq/irq-affinity.rst            |   8 +-
 .../translations/zh_CN/core-api/irq/irq-domain.rst |   8 +-
 .../zh_CN/core-api/irq/irqflags-tracing.rst        |   8 +-
 .../translations/zh_CN/core-api/kernel-api.rst     |   6 +-
 .../translations/zh_CN/core-api/kobject.rst        |   5 +-
 .../translations/zh_CN/core-api/local_ops.rst      |   6 +-
 .../translations/zh_CN/core-api/padata.rst         |   5 +-
 .../translations/zh_CN/core-api/printk-basics.rst  |   6 +-
 .../translations/zh_CN/core-api/printk-formats.rst |   6 +-
 .../zh_CN/core-api/refcount-vs-atomic.rst          |   6 +-
 .../zh_CN/core-api/symbol-namespaces.rst           |   6 +-
 .../translations/zh_CN/core-api/workqueue.rst      |   6 +-
 Documentation/translations/zh_CN/cpu-freq/core.rst |   8 +-
 .../translations/zh_CN/cpu-freq/cpu-drivers.rst    |   8 +-
 .../translations/zh_CN/cpu-freq/cpufreq-stats.rst  |   8 +-
 .../translations/zh_CN/cpu-freq/index.rst          |   8 +-
 .../translations/zh_CN/filesystems/debugfs.rst     |   2 +-
 .../translations/zh_CN/iio/ep93xx_adc.rst          |   8 +-
 .../translations/zh_CN/iio/iio_configfs.rst        |   8 +-
 Documentation/translations/zh_CN/iio/index.rst     |   8 +-
 .../translations/zh_CN/kernel-hacking/hacking.rst  |   2 +-
 Documentation/translations/zh_CN/mips/booting.rst  |   7 +-
 Documentation/translations/zh_CN/mips/features.rst |   7 +-
 Documentation/translations/zh_CN/mips/index.rst    |   7 +-
 .../translations/zh_CN/mips/ingenic-tcu.rst        |   7 +-
 .../translations/zh_CN/openrisc/index.rst          |   8 +-
 .../translations/zh_CN/openrisc/openrisc_port.rst  |   7 +-
 Documentation/translations/zh_CN/openrisc/todo.rst |   7 +-
 .../translations/zh_CN/parisc/debugging.rst        |   5 +-
 Documentation/translations/zh_CN/parisc/index.rst  |   5 +-
 .../translations/zh_CN/parisc/registers.rst        |   5 +-
 .../translations/zh_CN/riscv/boot-image-header.rst |   8 +-
 Documentation/translations/zh_CN/riscv/index.rst   |   8 +-
 .../translations/zh_CN/riscv/patch-acceptance.rst  |   8 +-
 Documentation/translations/zh_CN/riscv/pmu.rst     |   8 +-
 Documentation/translations/zh_TW/arm64/amu.rst     | 104 ++++++
 Documentation/translations/zh_TW/arm64/booting.txt | 251 ++++++++++++++
 .../translations/zh_TW/arm64/elf_hwcaps.rst        | 244 +++++++++++++
 .../translations/zh_TW/arm64/hugetlbpage.rst       |  49 +++
 Documentation/translations/zh_TW/arm64/index.rst   |  23 ++
 .../zh_TW/arm64/legacy_instructions.txt            |  77 +++++
 Documentation/translations/zh_TW/arm64/memory.txt  | 119 +++++++
 Documentation/translations/zh_TW/arm64/perf.rst    |  88 +++++
 .../translations/zh_TW/arm64/silicon-errata.txt    |  79 +++++
 .../translations/zh_TW/arm64/tagged-pointers.txt   |  57 ++++
 Documentation/translations/zh_TW/cpu-freq/core.rst | 108 ++++++
 .../translations/zh_TW/cpu-freq/cpu-drivers.rst    | 256 ++++++++++++++
 .../translations/zh_TW/cpu-freq/cpufreq-stats.rst  | 132 ++++++++
 .../translations/zh_TW/cpu-freq/index.rst          |  47 +++
 .../translations/zh_TW/filesystems/debugfs.rst     | 224 ++++++++++++
 .../translations/zh_TW/filesystems/index.rst       |  31 ++
 .../translations/zh_TW/filesystems/sysfs.txt       | 377 +++++++++++++++++=
++++
 .../translations/zh_TW/filesystems/tmpfs.rst       | 148 ++++++++
 .../translations/zh_TW/filesystems/virtiofs.rst    |  61 ++++
 Documentation/translations/zh_TW/index.rst         |  13 +-
 Documentation/x86/x86_64/mm.rst                    |   4 -
 73 files changed, 2686 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/translations/zh_TW/arm64/amu.rst
 create mode 100644 Documentation/translations/zh_TW/arm64/booting.txt
 create mode 100644 Documentation/translations/zh_TW/arm64/elf_hwcaps.rst
 create mode 100644 Documentation/translations/zh_TW/arm64/hugetlbpage.rst
 create mode 100644 Documentation/translations/zh_TW/arm64/index.rst
 create mode 100644 Documentation/translations/zh_TW/arm64/legacy_instructi=
ons.txt
 create mode 100644 Documentation/translations/zh_TW/arm64/memory.txt
 create mode 100644 Documentation/translations/zh_TW/arm64/perf.rst
 create mode 100644 Documentation/translations/zh_TW/arm64/silicon-errata.t=
xt
 create mode 100644 Documentation/translations/zh_TW/arm64/tagged-pointers.=
txt
 create mode 100644 Documentation/translations/zh_TW/cpu-freq/core.rst
 create mode 100644 Documentation/translations/zh_TW/cpu-freq/cpu-drivers.r=
st
 create mode 100644 Documentation/translations/zh_TW/cpu-freq/cpufreq-stats=
.rst
 create mode 100644 Documentation/translations/zh_TW/cpu-freq/index.rst
 create mode 100644 Documentation/translations/zh_TW/filesystems/debugfs.rst
 create mode 100644 Documentation/translations/zh_TW/filesystems/index.rst
 create mode 100644 Documentation/translations/zh_TW/filesystems/sysfs.txt
 create mode 100644 Documentation/translations/zh_TW/filesystems/tmpfs.rst
 create mode 100644 Documentation/translations/zh_TW/filesystems/virtiofs.r=
st
