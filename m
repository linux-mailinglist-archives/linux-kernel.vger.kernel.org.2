Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77C03FCDEC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbhHaThV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 15:37:21 -0400
Received: from ms.lwn.net ([45.79.88.28]:54948 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240873AbhHaThU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 15:37:20 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::e2d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BD7B6617C;
        Tue, 31 Aug 2021 19:36:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BD7B6617C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1630438583; bh=1sOHVOe7J182GAerQzzoc1MWRamRfmNYhLZKX86gS/o=;
        h=From:To:Cc:Subject:Date:From;
        b=YGdrx/+Wp9+1HilmAWyUq2MTndOmHSDepXA8s2v8JePxGa6hf1InwbvUm5ophuki2
         97GFdrjYMGOn7XLcbm47uby6G7xWEQFC/ssCrFa7QCVVQnmE6YwbGiHRCcEJrSt1jf
         JMDg0VICZj1WGgbMSI5XxHQq3XH4VNeqWUWzWEgpo8Vk47fnWFKiBhOGdZRmlBscY6
         xDCbzOESKeE4TeALTZzcfepmIoU8QmbLI1h1WU8Ym3ojJfrDqBq7Yo7gdXsgyrMyZU
         i7NRNcawVfV88g1yhAcB4Qq4MYGnf3yTWbXkvmu9rzSLT45Ilg1xLCNlWuk7JLB/kR
         zUY72DuTtVArg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 5.15
Date:   Tue, 31 Aug 2021 13:36:22 -0600
Message-ID: <87czpt76fd.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 530c4374e21ae750c5fa5aa67b36a97635ddb379:

  docs/zh_CN: add a missing space character (2021-07-15 06:33:44 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.15

for you to fetch changes up to 37397b092e7f4b520a257aaafe83f868cd3d5e27:

  docs: sphinx-requirements: Move sphinx_rtd_theme to top (2021-08-12 09:15=
:38 -0600)

----------------------------------------------------------------
Yet another set of documentation changes:

 - A reworking of PDF generation to yield better results for documents
   using CJK fonts in particular.

 - A new set of translations into traditional Chinese, a dialect for which
   I am assured there is a community of interested readers.

 - A lot more regular Chinese translation work as well.

...plus the usual assortment of updates, fixes, typo tweaks, etc.

----------------------------------------------------------------
Akira Yokosawa (10):
      docs: pdfdocs: Refactor config for CJK document
      docs: pdfdocs: Add CJK-language-specific font settings
      docs: pdfdocs: Choose Serif font as CJK mainfont if possible
      docs: pdfdocs: Preserve inter-phrase space in Korean translations
      docs: pdfdocs: Add conf.py local to translations for ascii-art alignm=
ent
      docs: pdfdocs: One-half spacing for CJK translations
      docs: pdfdocs: Permit AutoFakeSlant for CJK fonts
      docs: pdfdocs: Teach xeCJK about character classes of quotation marks
      docs: pdfdocs: Enable language-specific font choice of zh_TW translat=
ions
      docs: sphinx-requirements: Move sphinx_rtd_theme to top

Cengiz Can (1):
      Documentation: sysrq: convert to third person

Fabio M. De Francesco (1):
      admin-guide/hw-vuln: Rephrase a section of core-scheduling.rst

Federico Vaga (1):
      doc: align Italian translation

Hannu Hartikainen (1):
      docs: submitting-patches: clarify the role of LKML

Hu Haowen (6):
      docs/zh_CN: create new translations for zh_CN/dev-tools/testing-overv=
iew
      docs/zh_CN: reformat zh_CN/dev-tools/testing-overview
      docs/zh_CN: add a translation for index
      docs: add traditional Chinese translation for kernel Documentation
      docs/zh_TW: add translations for zh_TW/process
      MAINTAINERS: add entry for traditional Chinese documentation

Hu Jialun (1):
      docs/zh_CN: Remove the Microsoft rhetoric

Ioana Ciornei (4):
      docs: printk-formats: fix build warning
      docs: kvm: fix build warnings
      docs: kvm: properly format code blocks and lists
      docs: networking: dpaa2: fix chapter title format

Jisheng Zhang (1):
      Documentation/features/vm: riscv supports THP now

Kees Cook (1):
      deprecated.rst: Include details on "no_hash_pointers"

Laurent Pinchart (1):
      scripts/kernel-doc: Override -Werror from KCFLAGS with KDOC_WERROR

Mauro Carvalho Chehab (3):
      docs: sound: kernel-api: writing-an-alsa-driver.rst: replace some cha=
racters
      docs: firmware-guide: acpi: dsd: graph.rst: replace some characters
      docs: virt: kvm: api.rst: replace some characters

Pali Roh=C3=A1r (1):
      Documentation: arm: marvell: Add few missing models and documentation=
 files

Yang Xu (1):
      admin-guide/cputopology.rst: Remove non-existed cpu-hotplug.txt

Yang Yang (1):
      docs/zh_CN: Add zh_CN/accounting/psi.rst

Yanteng Si (21):
      docs/zh_CN: add core api genericirq translation
      docs/core-api: Modify document layout
      docs/zh_CN: add core api cpu_hotplug translation
      docs/zh_CN: add core api memory_hotplug translation
      docs/zh_CN: add core api protection keys translation
      docs/zh_CN: add virt index translation
      docs/zh_CN: add virt paravirt_ops translation
      docs/zh_CN: add virt guest-halt-polling translation
      docs/zh_CN: add virt ne_overview translation
      docs/zh_CN: add virt acrn index translation
      docs/zh_CN: add virt acrn introduction translation
      docs/zh_CN: add virt acrn io-request translation
      docs/zh_CN: add virt acrn cpuid translation
      docs/zh_CN: add infiniband index translation
      docs/zh_CN: add infiniband core_locking translation
      docs/zh_CN: add infiniband ipoib translation
      docs/zh_CN: add infiniband opa_vnic translation
      docs/zh_CN: add infiniband sysfs translation
      docs/zh_CN: add infiniband tag_matching translation
      docs/zh_CN: add infiniband user_mad translation
      docs/zh_CN: add infiniband user_verbs translation

 Documentation/admin-guide/cputopology.rst          |   10 +-
 .../admin-guide/hw-vuln/core-scheduling.rst        |   10 +-
 Documentation/admin-guide/sysrq.rst                |   12 +-
 Documentation/arm/marvell.rst                      |   18 +
 Documentation/conf.py                              |  121 +-
 Documentation/core-api/cpu_hotplug.rst             |   38 +-
 Documentation/core-api/printk-formats.rst          |    1 +
 Documentation/features/vm/THP/arch-support.txt     |    2 +-
 Documentation/firmware-guide/acpi/dsd/graph.rst    |    2 +-
 .../ethernet/freescale/dpaa2/dpio-driver.rst       |    1 +
 Documentation/process/deprecated.rst               |    4 +-
 Documentation/process/submitting-patches.rst       |   10 +-
 .../sound/kernel-api/writing-an-alsa-driver.rst    |    2 +-
 Documentation/sphinx/requirements.txt              |    3 +-
 Documentation/translations/conf.py                 |   12 +
 Documentation/translations/index.rst               |    1 +
 .../it_IT/core-api/symbol-namespaces.rst           |   26 +-
 .../translations/it_IT/kernel-hacking/hacking.rst  |    4 +-
 .../translations/it_IT/process/deprecated.rst      |    8 +-
 .../it_IT/process/stable-kernel-rules.rst          |    6 -
 .../it_IT/process/submitting-patches.rst           |   57 +-
 Documentation/translations/ja_JP/howto.rst         |    8 +
 Documentation/translations/ja_JP/index.rst         |    5 +
 Documentation/translations/ko_KR/howto.rst         |    8 +
 Documentation/translations/ko_KR/index.rst         |    2 +
 .../translations/zh_CN/accounting/index.rst        |   25 +
 .../translations/zh_CN/accounting/psi.rst          |  155 +++
 .../translations/zh_CN/core-api/cpu_hotplug.rst    |  348 +++++
 .../translations/zh_CN/core-api/genericirq.rst     |  409 ++++++
 .../translations/zh_CN/core-api/index.rst          |    7 +-
 .../translations/zh_CN/core-api/memory-hotplug.rst |  126 ++
 .../zh_CN/core-api/protection-keys.rst             |   99 ++
 .../translations/zh_CN/dev-tools/index.rst         |    5 +
 .../zh_CN/dev-tools/testing-overview.rst           |  109 ++
 Documentation/translations/zh_CN/index.rst         |   16 +-
 .../translations/zh_CN/infiniband/core_locking.rst |  115 ++
 .../translations/zh_CN/infiniband/index.rst        |   40 +
 .../translations/zh_CN/infiniband/ipoib.rst        |  111 ++
 .../translations/zh_CN/infiniband/opa_vnic.rst     |  156 +++
 .../translations/zh_CN/infiniband/sysfs.rst        |   21 +
 .../translations/zh_CN/infiniband/tag_matching.rst |   63 +
 .../translations/zh_CN/infiniband/user_mad.rst     |  164 +++
 .../translations/zh_CN/infiniband/user_verbs.rst   |   72 ++
 .../translations/zh_CN/process/coding-style.rst    |    3 +-
 .../translations/zh_CN/virt/acrn/cpuid.rst         |   56 +
 .../translations/zh_CN/virt/acrn/index.rst         |   25 +
 .../translations/zh_CN/virt/acrn/introduction.rst  |   52 +
 .../translations/zh_CN/virt/acrn/io-request.rst    |   99 ++
 .../translations/zh_CN/virt/guest-halt-polling.rst |   87 ++
 Documentation/translations/zh_CN/virt/index.rst    |   38 +
 .../translations/zh_CN/virt/ne_overview.rst        |   88 ++
 .../translations/zh_CN/virt/paravirt_ops.rst       |   41 +
 Documentation/translations/zh_TW/IRQ.txt           |   41 +
 .../translations/zh_TW/admin-guide/README.rst      |  351 +++++
 .../translations/zh_TW/admin-guide/bug-bisect.rst  |   85 ++
 .../translations/zh_TW/admin-guide/bug-hunting.rst |  344 +++++
 .../zh_TW/admin-guide/clearing-warn-once.rst       |   16 +
 .../translations/zh_TW/admin-guide/cpu-load.rst    |  112 ++
 .../translations/zh_TW/admin-guide/index.rst       |  135 ++
 .../translations/zh_TW/admin-guide/init.rst        |   58 +
 .../zh_TW/admin-guide/reporting-issues.rst         | 1337 ++++++++++++++++=
++++
 .../zh_TW/admin-guide/security-bugs.rst            |   78 ++
 .../zh_TW/admin-guide/tainted-kernels.rst          |  161 +++
 .../translations/zh_TW/admin-guide/unicode.rst     |  174 +++
 .../translations/zh_TW/disclaimer-zh_TW.rst        |   11 +
 Documentation/translations/zh_TW/gpio.txt          |  651 ++++++++++
 Documentation/translations/zh_TW/index.rst         |  168 +++
 Documentation/translations/zh_TW/io_ordering.txt   |   68 +
 Documentation/translations/zh_TW/oops-tracing.txt  |  212 ++++
 .../translations/zh_TW/process/1.Intro.rst         |  199 +++
 .../translations/zh_TW/process/2.Process.rst       |  369 ++++++
 .../translations/zh_TW/process/3.Early-stage.rst   |  172 +++
 .../translations/zh_TW/process/4.Coding.rst        |  297 +++++
 .../translations/zh_TW/process/5.Posting.rst       |  251 ++++
 .../translations/zh_TW/process/6.Followthrough.rst |  156 +++
 .../zh_TW/process/7.AdvancedTopics.rst             |  137 ++
 .../translations/zh_TW/process/8.Conclusion.rst    |   74 ++
 .../process/code-of-conduct-interpretation.rst     |  112 ++
 .../translations/zh_TW/process/code-of-conduct.rst |   76 ++
 .../translations/zh_TW/process/coding-style.rst    |  958 ++++++++++++++
 .../zh_TW/process/development-process.rst          |   30 +
 .../translations/zh_TW/process/email-clients.rst   |  252 ++++
 .../zh_TW/process/embargoed-hardware-issues.rst    |  232 ++++
 Documentation/translations/zh_TW/process/howto.rst |  500 ++++++++
 Documentation/translations/zh_TW/process/index.rst |   67 +
 .../zh_TW/process/kernel-driver-statement.rst      |  203 +++
 .../zh_TW/process/kernel-enforcement-statement.rst |  155 +++
 .../translations/zh_TW/process/license-rules.rst   |  374 ++++++
 .../translations/zh_TW/process/magic-number.rst    |  148 +++
 .../zh_TW/process/management-style.rst             |  211 +++
 .../zh_TW/process/programming-language.rst         |   76 ++
 .../zh_TW/process/stable-api-nonsense.rst          |  159 +++
 .../zh_TW/process/stable-kernel-rules.rst          |   68 +
 .../zh_TW/process/submit-checklist.rst             |  109 ++
 .../zh_TW/process/submitting-drivers.rst           |  164 +++
 .../zh_TW/process/submitting-patches.rst           |  686 ++++++++++
 .../zh_TW/process/volatile-considered-harmful.rst  |  110 ++
 Documentation/translations/zh_TW/sparse.txt        |   91 ++
 Documentation/virt/kvm/api.rst                     |   60 +-
 MAINTAINERS                                        |    8 +
 scripts/kernel-doc                                 |    8 +-
 101 files changed, 13271 insertions(+), 144 deletions(-)
 create mode 100644 Documentation/translations/conf.py
 create mode 100644 Documentation/translations/zh_CN/accounting/index.rst
 create mode 100644 Documentation/translations/zh_CN/accounting/psi.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/cpu_hotplug.r=
st
 create mode 100644 Documentation/translations/zh_CN/core-api/genericirq.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/memory-hotplu=
g.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/protection-ke=
ys.rst
 create mode 100644 Documentation/translations/zh_CN/dev-tools/testing-over=
view.rst
 create mode 100644 Documentation/translations/zh_CN/infiniband/core_lockin=
g.rst
 create mode 100644 Documentation/translations/zh_CN/infiniband/index.rst
 create mode 100644 Documentation/translations/zh_CN/infiniband/ipoib.rst
 create mode 100644 Documentation/translations/zh_CN/infiniband/opa_vnic.rst
 create mode 100644 Documentation/translations/zh_CN/infiniband/sysfs.rst
 create mode 100644 Documentation/translations/zh_CN/infiniband/tag_matchin=
g.rst
 create mode 100644 Documentation/translations/zh_CN/infiniband/user_mad.rst
 create mode 100644 Documentation/translations/zh_CN/infiniband/user_verbs.=
rst
 create mode 100644 Documentation/translations/zh_CN/virt/acrn/cpuid.rst
 create mode 100644 Documentation/translations/zh_CN/virt/acrn/index.rst
 create mode 100644 Documentation/translations/zh_CN/virt/acrn/introduction=
.rst
 create mode 100644 Documentation/translations/zh_CN/virt/acrn/io-request.r=
st
 create mode 100644 Documentation/translations/zh_CN/virt/guest-halt-pollin=
g.rst
 create mode 100644 Documentation/translations/zh_CN/virt/index.rst
 create mode 100644 Documentation/translations/zh_CN/virt/ne_overview.rst
 create mode 100644 Documentation/translations/zh_CN/virt/paravirt_ops.rst
 create mode 100644 Documentation/translations/zh_TW/IRQ.txt
 create mode 100644 Documentation/translations/zh_TW/admin-guide/README.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/bug-bisect=
.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/bug-huntin=
g.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/clearing-w=
arn-once.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/cpu-load.r=
st
 create mode 100644 Documentation/translations/zh_TW/admin-guide/index.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/init.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/reporting-=
issues.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/security-b=
ugs.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/tainted-ke=
rnels.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/unicode.rst
 create mode 100644 Documentation/translations/zh_TW/disclaimer-zh_TW.rst
 create mode 100644 Documentation/translations/zh_TW/gpio.txt
 create mode 100644 Documentation/translations/zh_TW/index.rst
 create mode 100644 Documentation/translations/zh_TW/io_ordering.txt
 create mode 100644 Documentation/translations/zh_TW/oops-tracing.txt
 create mode 100644 Documentation/translations/zh_TW/process/1.Intro.rst
 create mode 100644 Documentation/translations/zh_TW/process/2.Process.rst
 create mode 100644 Documentation/translations/zh_TW/process/3.Early-stage.=
rst
 create mode 100644 Documentation/translations/zh_TW/process/4.Coding.rst
 create mode 100644 Documentation/translations/zh_TW/process/5.Posting.rst
 create mode 100644 Documentation/translations/zh_TW/process/6.Followthroug=
h.rst
 create mode 100644 Documentation/translations/zh_TW/process/7.AdvancedTopi=
cs.rst
 create mode 100644 Documentation/translations/zh_TW/process/8.Conclusion.r=
st
 create mode 100644 Documentation/translations/zh_TW/process/code-of-conduc=
t-interpretation.rst
 create mode 100644 Documentation/translations/zh_TW/process/code-of-conduc=
t.rst
 create mode 100644 Documentation/translations/zh_TW/process/coding-style.r=
st
 create mode 100644 Documentation/translations/zh_TW/process/development-pr=
ocess.rst
 create mode 100644 Documentation/translations/zh_TW/process/email-clients.=
rst
 create mode 100644 Documentation/translations/zh_TW/process/embargoed-hard=
ware-issues.rst
 create mode 100644 Documentation/translations/zh_TW/process/howto.rst
 create mode 100644 Documentation/translations/zh_TW/process/index.rst
 create mode 100644 Documentation/translations/zh_TW/process/kernel-driver-=
statement.rst
 create mode 100644 Documentation/translations/zh_TW/process/kernel-enforce=
ment-statement.rst
 create mode 100644 Documentation/translations/zh_TW/process/license-rules.=
rst
 create mode 100644 Documentation/translations/zh_TW/process/magic-number.r=
st
 create mode 100644 Documentation/translations/zh_TW/process/management-sty=
le.rst
 create mode 100644 Documentation/translations/zh_TW/process/programming-la=
nguage.rst
 create mode 100644 Documentation/translations/zh_TW/process/stable-api-non=
sense.rst
 create mode 100644 Documentation/translations/zh_TW/process/stable-kernel-=
rules.rst
 create mode 100644 Documentation/translations/zh_TW/process/submit-checkli=
st.rst
 create mode 100644 Documentation/translations/zh_TW/process/submitting-dri=
vers.rst
 create mode 100644 Documentation/translations/zh_TW/process/submitting-pat=
ches.rst
 create mode 100644 Documentation/translations/zh_TW/process/volatile-consi=
dered-harmful.rst
 create mode 100644 Documentation/translations/zh_TW/sparse.txt
