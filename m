Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B06405D62
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 21:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245585AbhIITez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 15:34:55 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:53292 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbhIITez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 15:34:55 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Sep 2021 15:34:54 EDT
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7D21E6169BC6;
        Thu,  9 Sep 2021 21:27:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JwTP0pnsNbI3; Thu,  9 Sep 2021 21:27:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1BA51616E131;
        Thu,  9 Sep 2021 21:27:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gjqhGqfmAMoJ; Thu,  9 Sep 2021 21:27:58 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id E7FC66169BC6;
        Thu,  9 Sep 2021 21:27:57 +0200 (CEST)
Date:   Thu, 9 Sep 2021 21:27:57 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <547678000.58650.1631215677820.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for v5.15
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF92 (Linux)/8.8.12_GA_3809)
Thread-Index: HCjvEwmbYcCV24Tzt2v5PymKE55a+Q==
Thread-Topic: UML changes for v5.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7c60610d476766e128cc4284bb6349732cbd6606:

  Linux 5.14-rc6 (2021-08-15 13:40:53 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.15-rc1

for you to fetch changes up to adf9ae0d159d3dc94f58d788fc4757c8749ac0df:

  um: fix stub location calculation (2021-08-26 22:28:03 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Support for VMAP_STACK
- Support for splice_write in hostfs
- Fixes for virt-pci
- Fixes for virtio_uml
- Various fixes

----------------------------------------------------------------
Johannes Berg (9):
      um: make PCI emulation driver init/exit static
      lib/logic_iomem: fix sparse warnings
      um: virtio_uml: include linux/virtio-uml.h
      um: virtio_uml: fix memory leak on init failures
      hostfs: support splice_write
      um: virt-pci: don't do DMA from stack
      um: enable VMAP_STACK
      um: virt-pci: fix uapi documentation
      um: fix stub location calculation

 arch/um/Kconfig                     |   1 +
 arch/um/drivers/virt-pci.c          | 108 ++++++++++++++++++++++++++----------
 arch/um/drivers/virtio_uml.c        |   5 +-
 arch/um/kernel/skas/clone.c         |   3 +-
 arch/x86/um/shared/sysdep/stub_32.h |  12 ++++
 arch/x86/um/shared/sysdep/stub_64.h |  12 ++++
 arch/x86/um/stub_segv.c             |   3 +-
 fs/hostfs/hostfs_kern.c             |   1 +
 include/uapi/linux/virtio_pcidev.h  |   5 +-
 lib/logic_iomem.c                   |  16 +++---
 10 files changed, 124 insertions(+), 42 deletions(-)
