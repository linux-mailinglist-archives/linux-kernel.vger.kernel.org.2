Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B60841828B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 16:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343607AbhIYOPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 10:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233738AbhIYOPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 10:15:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9039C61279;
        Sat, 25 Sep 2021 14:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632579257;
        bh=T4Ci+yhSdaRdcLzP1LZldRIG74GFbkSiFhcpo7OQCok=;
        h=Date:From:To:Cc:Subject:From;
        b=I85bZTOGYSBNQGPmjOr56AQmNdasAoSMA2cNevUdL5Yvk5hAIefpHvvfuA7ZWNL8t
         5ifgZPK73ZZjdtsRgLnL2VisBlrVp2Cd4BSu4GHzi+5zmDhb+S8KxAvSmUkM8pymiw
         FULGrbt69KYJm1dZoc3Ygyw1knYx7I+zBKbu2z10=
Date:   Sat, 25 Sep 2021 16:14:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.15-rc3
Message-ID: <YU8utviwFXzSOYKW@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc3

for you to fetch changes up to bb509a6ffed2c8b0950f637ab5779aa818ed1596:

  comedi: Fix memory leak in compat_insnlist() (2021-09-21 17:53:54 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.15-rc3

Here are some small char and misc driver fixes for 5.15-rc3.

Nothing huge in here, just fixes for a number of small issues that have
been reported.  These include:
	- habanalabs race conditions and other bugs fixed
	- binder driver fixes
	- fpga driver fixes
	- coresight build warning fix
	- nvmem driver fix
	- comedi memory leak fix
	- bcm-vk tty race fix
	- other tiny driver fixes

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Christophe JAILLET (1):
      misc: genwqe: Fixes DMA mask setting

Colin Ian King (1):
      habanalabs: Fix spelling mistake "FEADBACK" -> "FEEDBACK"

Dan Carpenter (1):
      mcb: fix error handling in mcb_alloc_bus()

Douglas Anderson (1):
      nvmem: core: Add stubs for nvmem_cell_read_variable_le_u32/64 if !CONFIG_NVMEM

Geert Uytterhoeven (1):
      nvmem: NVMEM_NINTENDO_OTP should depend on WII

Greg Kroah-Hartman (2):
      Merge tag 'misc-habanalabs-fixes-2021-09-19' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux into char-misc-linus
      Merge tag 'fpga-fixes-5.15' of git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga into char-misc-linus

Ian Abbott (1):
      comedi: Fix memory leak in compat_insnlist()

Jian Cai (1):
      coresight: syscfg: Fix compiler warning

Jiapeng Chong (1):
      fpga: machxo2-spi: Fix missing error code in machxo2_write_complete()

Johan Hovold (1):
      misc: bcm-vk: fix tty registration race

Li Li (1):
      binder: fix freeze race

Oded Gabbay (1):
      habanalabs/gaudi: fix LBW RR configuration

Ofir Bitton (4):
      habanalabs: fix potential race in interrupt wait ioctl
      habanalabs: fail collective wait when not supported
      habanalabs: rate limit multi CS completion errors
      habanalabs: expose a single cs seq in staged submissions

Omer Shpigelman (1):
      habanalabs/gaudi: use direct MSI in single mode

Russ Weight (1):
      fpga: dfl: Avoid reads to AFU CSRs during enumeration

Todd Kjos (1):
      binder: make sure fd closes complete

Tom Rix (1):
      fpga: machxo2-spi: Return an error on failure

farah kassabri (2):
      habanalabs: fix kernel OOPs related to staged cs
      habanalabs: fix wait offset handling

 drivers/android/binder.c                           |  58 ++++++++---
 drivers/android/binder_internal.h                  |   2 +
 drivers/comedi/comedi_fops.c                       |   1 +
 drivers/fpga/dfl.c                                 |  14 +--
 drivers/fpga/machxo2-spi.c                         |   6 +-
 drivers/hwtracing/coresight/coresight-syscfg.c     |   1 +
 drivers/mcb/mcb-core.c                             |  12 +--
 drivers/misc/bcm-vk/bcm_vk_tty.c                   |   6 +-
 drivers/misc/genwqe/card_base.c                    |   2 +-
 .../misc/habanalabs/common/command_submission.c    |  71 +++++++++----
 drivers/misc/habanalabs/common/hw_queue.c          |   9 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |  11 +-
 drivers/misc/habanalabs/gaudi/gaudi_security.c     | 115 ++++++++++++---------
 .../habanalabs/include/gaudi/asic_reg/gaudi_regs.h |   2 +
 drivers/nvmem/Kconfig                              |   1 +
 include/linux/nvmem-consumer.h                     |  14 +++
 include/uapi/linux/android/binder.h                |   7 ++
 17 files changed, 229 insertions(+), 103 deletions(-)
