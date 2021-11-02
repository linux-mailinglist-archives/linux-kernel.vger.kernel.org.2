Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCE54437B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhKBVTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhKBVTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:19:13 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A3CC061714;
        Tue,  2 Nov 2021 14:16:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8179F5EBE;
        Tue,  2 Nov 2021 21:16:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8179F5EBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635887797; bh=TkFXxQ/hILkvYx8LzuYRu9bpCaQgZJjOrmdevsuzlYg=;
        h=From:To:Cc:Subject:Date:From;
        b=DnEsvBw+1zRGs9XxtAn1FPKK6sMxSH0CUykRDTbbM2FmsPQVf3f82taHGbLSwRHqx
         VxDIH8Uf9Xye6fZFH463CKr+vmp7zC3FKweDylblbIt1h7K0gOImWptKA8DcrFfBy7
         B2Gsalo7OhSHDConfaZ/pXsTBDVWlcGYPUzh1h27RV7gHbySvI1ggYFAVRDYZndCLx
         SztobcDfAnQzEjWqMd7HGa3rlv0mj6b1UotTCeCXsxCSsj0ESDuGTDjpqEQdX6xqOD
         prQtj9GNqoMFZ+cXVAm4dd/MsI82RlWqwFITtkXmdWH/yitscHZYZkd7lDQk8Xr9r7
         7N4HyDvNP7fcA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 5.16
Date:   Tue, 02 Nov 2021 15:16:36 -0600
Message-ID: <87wnlq2r7v.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.16

for you to fetch changes up to 603bdf5d6c092eb05666decd84288dfda71eee90:

  kernel-doc: support DECLARE_PHY_INTERFACE_MASK() (2021-11-01 11:28:35 -06=
00)

----------------------------------------------------------------
This is a relatively unexciting cycle for documentation.

 - Some small scripts/kerneldoc fixes

 - More Chinese translation work, but at a much reduced rate.

 - The tip-tree maintainer's handbook

...plus the usual array of build fixes, typo fixes, etc.

----------------------------------------------------------------
Akira Yokosawa (2):
      docs: zh_TW/index: Move arm64/index to arch-specific section
      docs: pdfdocs: Adjust \headheight for fancyhdr

Borislav Petkov (1):
      Documentation/no_hz: Introduce "dyntick-idle mode" before using it

Christoph Anton Mitterer (2):
      docs: proc.rst: mountinfo: improved field numbering
      docs: proc.rst: mountinfo: align columns

Colin Ian King (1):
      speakup: Fix typo in documentation "boo" -> "boot"

Fengnan Chang (1):
      docs: f2fs: fix text alignment

Jonathan Corbet (4):
      Merge tag 'v5.15-rc4' into docs-next
      Revert "docs: checkpatch: add UNNECESSARY/UNSPECIFIED_INT and UNNECES=
SARY_ELSE"
      ext4: docs: switch away from list-table
      ext4: docs: Take out unneeded escaping

Junhua Huang (1):
      docs/zh_CN: Add zh_CN/admin-guide/sysrq.rst

Kees Cook (2):
      docs: Explain the desired position of function attributes
      scripts: kernel-doc: Ignore __alloc_size() attribute

Len Baker (1):
      docs: deprecated.rst: Clarify open-coded arithmetic with literals

Li Xinhai (1):
      Doc: page_migration: fix numbering for non-LRU movable flags

Mauro Carvalho Chehab (4):
      docs: translations: zn_CN: irq-affinity.rst: add a missing extension
      docs: translations: zh_CN: memory-hotplug.rst: fix a typo
      scripts: documentation-file-ref-check: ignore hidden files
      scripts: documentation-file-ref-check: fix bpf selftests path

Pali Roh=C3=A1r (3):
      Documentation: arm: marvell: Add 88F6040 model into list
      Documentation: arm: marvell: Add Octeon TX2 CN913x Flavors
      Documentation: arm: marvell: Add link to Orion Functional Errata docu=
ment

Randy Dunlap (2):
      docs: UML: user_mode_linux_howto_v2 edits
      kernel-doc: support DECLARE_PHY_INTERFACE_MASK()

SeongJae Park (1):
      Documentation: Update SeongJae's email address

Steffen Maier (1):
      block: add documentation for inflight

Stephen Kitt (1):
      docs: block: fix discard_max_bytes references

Thomas Gleixner (2):
      Documentation/process: Add maintainer handbooks section
      Documentation/process: Add tip tree handbook

Thorsten Leemhuis (2):
      docs: use the lore redirector everywhere
      docs: submitting-patches: make section about the Link: tag more expli=
cit

Tiberiu A Georgescu (1):
      Documentation: update pagemap with shmem exceptions

Tommaso Merciai (1):
      docs: update file link location

Trevor Woerner (1):
      coding-style.rst: trivial: fix location of driver model macros

Utkarsh Verma (5):
      Documentation: checkpatch: Add SPLIT_STRING message
      Documentation: checkpatch: Add TRAILING_SEMICOLON message
      Documentation: checkpatch: Add SYMBOLIC_PERMS message
      docs: checkpatch: add UNNECESSARY/UNSPECIFIED_INT and UNNECESSARY_ELSE
      docs: checkpatch: add multiline, do/while, and multiple-assignment me=
ssages

Yanteng Si (14):
      docs/zh_CN: add core api kref translation
      docs/zh_CN: Improve zh_CN/process/howto.rst
      docs/zh_CN: typo fix and improve translation
      docs/zh_CN: modify some words
      docs/zh_CN: add core-api memory-allocation translation
      docs/zh_CN: add core-api unaligned-memory-access translation
      docs/zh_CN: add core-api mm-api translation
      docs/zh_CN: add core-api genalloc translation
      docs/zh_CN: add core-api boot-time-mm translation
      docs/zh_CN: add core-api gfp_mask-from-fs-io translation
      docs/zh_CN add PCI index.rst translation
      docs/zh_CN add PCI pci.rst translation
      docs/zh_CN: add core-api assoc_array translation
      docs/zh_CN: add core-api xarray translation

 Documentation/ABI/testing/sysfs-block              |  16 +
 Documentation/ABI/testing/sysfs-driver-xen-blkback |   4 +-
 .../ABI/testing/sysfs-driver-xen-blkfront          |   2 +-
 Documentation/admin-guide/mm/pagemap.rst           |  22 +
 Documentation/admin-guide/spkguide.txt             |   2 +-
 Documentation/arm/marvell.rst                      |  19 +
 Documentation/asm-annotations.rst                  |   2 +-
 Documentation/block/queue-sysfs.rst                |   9 +-
 Documentation/conf.py                              |   3 +
 Documentation/dev-tools/checkpatch.rst             |  81 +++
 Documentation/filesystems/ext4/orphan.rst          |  44 +-
 Documentation/filesystems/f2fs.rst                 |   2 +-
 Documentation/filesystems/proc.rst                 |  26 +-
 Documentation/kbuild/Kconfig.recursion-issue-02    |   2 +-
 Documentation/maintainer/pull-requests.rst         |   2 +-
 Documentation/networking/msg_zerocopy.rst          |   2 +-
 Documentation/process/coding-style.rst             |  39 +-
 Documentation/process/deprecated.rst               |   5 +-
 Documentation/process/index.rst                    |   1 +
 Documentation/process/maintainer-handbooks.rst     |  18 +
 Documentation/process/maintainer-tip.rst           | 785 +++++++++++++++++=
++++
 Documentation/process/submitting-drivers.rst       |   2 +-
 Documentation/process/submitting-patches.rst       |  42 +-
 Documentation/timers/no_hz.rst                     |   8 +-
 .../it_IT/process/submitting-patches.rst           |   4 +-
 .../translations/ko_KR/memory-barriers.txt         |   8 +-
 Documentation/translations/zh_CN/PCI/index.rst     |  36 +
 Documentation/translations/zh_CN/PCI/pci.rst       | 514 ++++++++++++++
 .../translations/zh_CN/admin-guide/index.rst       |   2 +-
 .../translations/zh_CN/admin-guide/sysrq.rst       | 280 ++++++++
 .../translations/zh_CN/core-api/assoc_array.rst    | 473 +++++++++++++
 .../translations/zh_CN/core-api/boot-time-mm.rst   |  49 ++
 .../translations/zh_CN/core-api/genalloc.rst       | 109 +++
 .../zh_CN/core-api/gfp_mask-from-fs-io.rst         |  66 ++
 .../translations/zh_CN/core-api/index.rst          |  22 +-
 .../zh_CN/core-api/irq/irq-affinity.rst            |   2 +-
 Documentation/translations/zh_CN/core-api/kref.rst | 311 ++++++++
 .../zh_CN/core-api/memory-allocation.rst           | 138 ++++
 .../translations/zh_CN/core-api/memory-hotplug.rst |   2 +-
 .../translations/zh_CN/core-api/mm-api.rst         | 110 +++
 .../zh_CN/core-api/unaligned-memory-access.rst     | 229 ++++++
 .../translations/zh_CN/core-api/xarray.rst         | 371 ++++++++++
 .../zh_CN/maintainer/pull-requests.rst             |   2 +-
 .../translations/zh_CN/process/5.Posting.rst       |   8 +-
 Documentation/translations/zh_CN/process/howto.rst |  10 +-
 .../zh_CN/process/submitting-patches.rst           |   8 +-
 Documentation/translations/zh_TW/index.rst         |  10 +-
 .../zh_TW/process/submitting-patches.rst           |   4 +-
 .../virt/uml/user_mode_linux_howto_v2.rst          | 119 ++--
 Documentation/vm/page_migration.rst                |   2 +-
 Documentation/x86/entry_64.rst                     |   2 +-
 Documentation/x86/orc-unwinder.rst                 |   4 +-
 scripts/documentation-file-ref-check               |   4 +
 scripts/kernel-doc                                 |   2 +
 54 files changed, 3866 insertions(+), 173 deletions(-)
 create mode 100644 Documentation/process/maintainer-handbooks.rst
 create mode 100644 Documentation/process/maintainer-tip.rst
 create mode 100644 Documentation/translations/zh_CN/PCI/index.rst
 create mode 100644 Documentation/translations/zh_CN/PCI/pci.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/sysrq.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/assoc_array.r=
st
 create mode 100644 Documentation/translations/zh_CN/core-api/boot-time-mm.=
rst
 create mode 100644 Documentation/translations/zh_CN/core-api/genalloc.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/gfp_mask-from=
-fs-io.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/kref.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/memory-alloca=
tion.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/mm-api.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/unaligned-mem=
ory-access.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/xarray.rst
