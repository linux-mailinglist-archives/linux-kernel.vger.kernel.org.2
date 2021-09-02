Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A883FF2D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbhIBRs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:48:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:47985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230120AbhIBRsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630604838;
        bh=IFT3FOSMetx4EKHSM1iC+ZE//nfJHP+l89JUT8Pbp6k=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=kwC6dj0mzUXth49mXlvTfvCaWB2HoGWA6cEhpSyRbuhxcV4JuI7qvwz2SrhNnH1y5
         t0p7Noobl0ZcGV9yymx/10fAa5etZPL7UG+UbgM6Wo+qTsWJO3KXdB3ney0oILIXsk
         JOu0qGAmBp7vXSUMMfG0WGpiuruUecr/Zj28N7n0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.158.38]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysVs-1n91Hg0MhG-00vt7X; Thu, 02
 Sep 2021 19:47:18 +0200
Date:   Thu, 2 Sep 2021 19:47:14 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for kernel v5.15-rc1
Message-ID: <YTEOIq86QHceYCO9@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LAKAwiWPw34e1ZGSNXNXoV9yif/Aqvd0Cmcnc00YJeztuV6o9vE
 4nPDX2guswIvGKkeOHJ95S8lI+7TpYdXV+IQhOg5MbZBeEeuE66nPP0dH/HSFrmotEL4c6K
 sj7YIM6rC6yzCNe9VoueEck+51WkXi3pfnP9bcFr2M2lqBhoXWNNwbPhW7+XJzUzNTrs7Jj
 PaWk0ci7FFYDZPGrew3bA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0JwMoBC95pM=:lzEz8g9u97kXZqBDWW/ptY
 H3HAoZd6dIIFBqRBAQLXJOyxF4LmyOgs4oekQnro0e4p2eV3uuPDyqw3OPkeawQsu7hRLpxvE
 E5WKbt/o1qyUCR/HZyxhru2Yhsk5H3lnqrejRk4SXm4Hbrvr3C51rthhCPaGEGd5pf0OWCQYB
 AbwaeHgCzDeNsnx0oLxbce5xU30leZYDeB7YUVOQuvU0wIs22mPEWpT7o+cLkC3QkOFHBI+oJ
 Bm79fQOtkE/yspfA5s81qBWgb0tMqmBb8SVroLimFU1Ie9Vj+wirr3ggLxzERoQA1GEelbyhR
 QCMy21xY8x3t2d//CzoeBUMyVLu53X95F57W6CXLPiyHCrGKX97ZAyUN8EJICioVoBRdm5lhn
 x/OU61tLFcnf2Bz/8AwLmvXtrM3SMqf4dEwczwDmnNnnYkII0unO9NZZcVhLD7QFmFClyfGIE
 Na6lONWtTCiXnT0WefQnOi5gaS52JYAzu0AVxes0vKZujJYv+xpdTsD1nQ5CpESLvIAVtFPWs
 V5mB6jj4v+ACcOkU2WFsRzjtMRhRT2QaXRtibV7TL9YwV5scF+YcPYg9CgBXgFyqL6Ucnh7nu
 KkvyW/X+61reBvVUaODPK5caxAX+11V7oISj68ayAhW7Nm2Qv+zudhGpUXV/XtFAhOI3ZGM5k
 LqfA2jtYu+dsgXe68c3wF20xXACQ7JXS5kVJ18D8/1PfspbWfl08h2Ys4NgKrtbSD7KOVU3Bf
 iij9gJgM6LCEurW1U8XfDjBXWwQnut0M3HDlr2H+Q3U7w+oBGUmiubB2wN9c0KQjoW5D44AF6
 4jI2sqCpVQk7eSsXRkPS8sCv50NLDdaf09p4gXRd8Nlp22lpv1ZfvHmrrNmUSP86I9HxX3SiS
 gX3+71zNFwI6A4jNCZIDe6NinA6x5/bxUkrsToxRsbxcE8HppimrMASaqGs5Z8Eyh2fElE1sn
 3rh3phktFAuVtIIGst430zCIsibra3xNM17wggOsv+YAd8Yti7DKORWtRHD48p29m+gS+/+/0
 3EYlqKtfTImjzmJmC2fXuvkO8hNS2PLB9UMn2IfxZ6RaB9XVVSLwxDBR84RHqgKgfqZGkmVZc
 FApcwV4GCt0ujwK6fyTZCvV41/ojln3Y6fx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the parisc architecture updates for kernel 5.15-rc1 from:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git t=
ags/for-5.15/parisc

Changes in this patchset include:
- Fix a kernel crash when a signal is delivered to bad userspace stack
- Fix fall-through warnings in math-emu code
- Increase size of gcc stack frame check
- Switch coding from 'pci_' to 'dma_' API
- Make struct parisc_driver::remove() return void
- Some parisc related Makefile changes
- Minor cleanups, e.g. change to octal permissions, fix macro collisions,
  fix PMD_ORDER collision, replace spaces with tabs

Thanks,
Helge

=2D---------------------------------------------------------------
The following changes since commit 7d2a07b769330c34b4deabeed939325c77a7ec2=
f:

  Linux 5.14 (2021-08-29 15:04:50 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git t=
ags/for-5.15/parisc

for you to fetch changes up to 6f1fce595b78b775d7fb585c15c2dc3a6994f96e:

  parisc: math-emu: Fix fall-through warnings (2021-09-01 22:18:18 +0200)

=2D---------------------------------------------------------------
parisc architecture updates for kernel 5.15:

- Fix a kernel crash when a signal is delivered to bad userspace stack
- Fix fall-through warnings in math-emu code
- Increase size of gcc stack frame check
- Switch coding from 'pci_' to 'dma_' API
- Make struct parisc_driver::remove() return void
- Some parisc related Makefile changes
- Minor cleanups, e.g. change to octal permissions, fix macro collisions,
  fix PMD_ORDER collision, replace spaces with tabs

=2D---------------------------------------------------------------
Christophe JAILLET (2):
      parisc: switch from 'pci_' to 'dma_' API
      parisc/parport_gsc: switch from 'pci_' to 'dma_' API

Helge Deller (2):
      parisc: Increase size of gcc stack frame check
      parisc: math-emu: Fix fall-through warnings

Jinchao Wang (1):
      parisc: Replace symbolic permissions with octal permissions

Kees Cook (1):
      parisc: math-emu: Avoid "fmt" macro collision

Masahiro Yamada (3):
      parisc: remove unused arch/parisc/boot/install.sh and its phony targ=
et
      parisc: move core-y in arch/parisc/Makefile to arch/parisc/Kbuild
      parisc: Fix compile failure when building 64-bit kernel natively

Matthew Wilcox (Oracle) (1):
      parisc: Rename PMD_ORDER to PMD_TABLE_ORDER

Mikulas Patocka (1):
      parisc: fix crash with signals and alloca

Shubhankar Kuranagatti (1):
      parisc: ccio-dma.c: Added tab instead of spaces

Uwe Kleine-K=F6nig (1):
      parisc: Make struct parisc_driver::remove() return void

 Makefile                                 |  5 ++
 arch/parisc/Kbuild                       |  1 +
 arch/parisc/Makefile                     |  9 +--
 arch/parisc/boot/Makefile                |  4 --
 arch/parisc/boot/install.sh              | 65 ----------------------
 arch/parisc/include/asm/parisc-device.h  |  4 +-
 arch/parisc/include/asm/pgalloc.h        |  6 +-
 arch/parisc/include/asm/pgtable.h        |  4 +-
 arch/parisc/kernel/signal.c              |  6 ++
 arch/parisc/math-emu/decode_exc.c        |  4 +-
 arch/parisc/math-emu/fpudispatch.c       | 56 ++++++++++++++++++-
 arch/parisc/mm/init.c                    |  4 +-
 drivers/char/ipmi/ipmi_si.h              |  2 +-
 drivers/char/ipmi/ipmi_si_intf.c         |  6 +-
 drivers/char/ipmi/ipmi_si_parisc.c       |  4 +-
 drivers/char/ipmi/ipmi_si_platform.c     |  4 +-
 drivers/input/keyboard/hilkbd.c          |  4 +-
 drivers/input/serio/gscps2.c             |  3 +-
 drivers/net/ethernet/i825xx/lasi_82596.c |  3 +-
 drivers/parisc/ccio-dma.c                | 94 ++++++++++++++++-----------=
-----
 drivers/parisc/led.c                     |  4 +-
 drivers/parport/parport_gsc.c            |  8 +--
 drivers/scsi/lasi700.c                   |  4 +-
 drivers/scsi/zalon.c                     |  4 +-
 drivers/tty/serial/mux.c                 |  3 +-
 lib/Kconfig.debug                        |  2 +-
 scripts/subarch.include                  |  2 +-
 sound/parisc/harmony.c                   |  3 +-
 28 files changed, 147 insertions(+), 171 deletions(-)
 delete mode 100644 arch/parisc/boot/install.sh
