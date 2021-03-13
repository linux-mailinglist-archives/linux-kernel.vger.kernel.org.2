Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB79339EC5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 16:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhCMPE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 10:04:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233893AbhCMPEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 10:04:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E760D64F0F;
        Sat, 13 Mar 2021 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615647841;
        bh=yOg4DfBXSw6ZSz0pSVLqRAG4cHKSTazpsgD1rotjYew=;
        h=Date:From:To:Cc:Subject:From;
        b=T7f7Zi2sVWUTOOzQpV0C8Jmu3/kfb+Qv3ktfaheXrepgvfkdvTMCqHWLXOY1FiiKu
         Ze6cXGNlaRflN1EyaTgAgUjX/Q1AP68X22LpJk6hjOHAL2v+3AULLRcxz1NH7hhnfV
         3sSXy4pf7mvp4dP0FF0Ja++cI34BfPUG8bFrEpAg=
Date:   Sat, 13 Mar 2021 16:03:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.12-rc3
Message-ID: <YEzUXyQedmvwfC6n@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.12-rc3

for you to fetch changes up to 65527a51c66f4edfa28602643d7dd4fa366eb826:

  misc/pvpanic: Export module FDT device table (2021-03-10 17:07:58 +0100)

----------------------------------------------------------------
Char/misc driver fixes for 5.12-rc3

Here are some small misc/char driver fixes for 5.12-rc3 to resolve some
reported problems:
	- habanalabs driver fixes
	- Acrn build fixes (reported many times)
	- pvpanic module table export fix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dmitry Baryshkov (1):
      misc: fastrpc: restrict user apps from sending kernel RPC messages

Greg Kroah-Hartman (1):
      drivers: habanalabs: remove unused dentry pointer for debugfs files

Oded Gabbay (1):
      habanalabs: mark hl_eq_inc_ptr() as static

Shile Zhang (1):
      misc/pvpanic: Export module FDT device table

Shuo Liu (3):
      cpu/hotplug: Fix build error of using {add,remove}_cpu() with !CONFIG_SMP
      virt: acrn: Make remove_cpu sysfs invisible with !CONFIG_HOTPLUG_CPU
      virt: acrn: Correct type casting of argument of copy_from_user()

Tomer Tayar (2):
      habanalabs: Call put_pid() when releasing control device
      habanalabs: Disable file operations after device is removed

Yejune Deng (2):
      virt: acrn: Use vfs_poll() instead of f_op->poll()
      virt: acrn: Use EPOLLIN instead of POLLIN

farah kassabri (1):
      habanalabs: fix debugfs address translation

 drivers/misc/fastrpc.c                            |  5 +++
 drivers/misc/habanalabs/common/debugfs.c          |  5 +--
 drivers/misc/habanalabs/common/device.c           | 40 ++++++++++++++++++++---
 drivers/misc/habanalabs/common/habanalabs.h       |  2 --
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 12 +++++++
 drivers/misc/habanalabs/common/irq.c              |  2 +-
 drivers/misc/habanalabs/common/mmu/mmu.c          | 38 ++++++++++++++-------
 drivers/misc/pvpanic.c                            |  1 +
 drivers/virt/acrn/hsm.c                           | 11 ++++++-
 drivers/virt/acrn/irqfd.c                         |  6 ++--
 include/linux/cpu.h                               |  3 ++
 11 files changed, 97 insertions(+), 28 deletions(-)
