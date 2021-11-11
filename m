Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8721D44D09E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 05:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhKKEOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 23:14:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhKKEOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 23:14:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCDCE60FC1;
        Thu, 11 Nov 2021 04:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636603872;
        bh=vgAxuNwViN2XHRE6zeJ/9nuvsz9bgt95XkxynKqhdfs=;
        h=Date:From:To:Cc:Subject:From;
        b=HD9TyPY0vCIjiQst1kXUgesc1HDw3vBbtZ91kKAfkEZGaEAuPnYCEDgq/WQUmUY05
         T3l5dHo6FIZnCuJEmyNzcgxOHhev/nO6kK+Jbm6MwuekdpWX4L1dP0BaygZa6NZFtn
         k4Q7W17iYihQLb0dyM9aURQaGb25XXRxhb3qBkXUfZYhKdB7lVV2WNSvtE9JaV7TPb
         //D33f3lnfqvcnqlAIpl7m4b5JO6EFJl4ZljNfXjPiXyFliOxEqNq04LhKCIUI3j2u
         OvLPB6vEJWshliGy5zqy3WlFBTxk9CSR4PX5vtMknBHREUeT8GrHp5bMIMpAMcGbAf
         d0le2hLZtaL7g==
Date:   Wed, 10 Nov 2021 20:11:10 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs update for 5.16-rc1
Message-ID: <YYyX3oZXNAjYzG0A@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit ff1ffd71d5f0612cf194f5705c671d6b64bf5f91:

  Merge tag 'hyperv-fixes-signed-20210915' of git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux (2021-09-15 17:18:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.16-rc1

for you to fetch changes up to 5429c9dbc9025f9a166f64e22e3a69c94fd5b29b:

  f2fs: fix UAF in f2fs_available_free_memory (2021-11-09 08:23:17 -0800)

----------------------------------------------------------------
f2fs-for-5.16-rc1

In this cycle, we've applied relatively small number of patches which fix subtle
corner cases mainly, while introducing a new mount option to be able to fragment
the disk intentionally for performance tests.

Enhancement:
 - add a mount option to fragmente on-disk layout to understand the performance
 - support direct IO for multi-partitions
 - add a fault injection of dquot_initialize

Bug fix:
 - address some lockdep complaints
 - fix a deadlock issue with quota
 - fix a memory tuning condition
 - fix compression condition to improve the ratio
 - fix disabling compression on the non-empty compressed file
 - invalidate cached pages before IPU/DIO writes

And, we've added some minor clean-ups as usual.

----------------------------------------------------------------
Chao Yu (7):
      f2fs: quota: fix potential deadlock
      f2fs: avoid attaching SB_ACTIVE flag during mount
      f2fs: introduce excess_dirty_threshold()
      f2fs: fix wrong condition to trigger background checkpoint correctly
      f2fs: multidevice: support direct IO
      f2fs: fix incorrect return value in f2fs_sanity_check_ckpt()
      f2fs: support fault injection for dquot_initialize()

Daeho Jeong (2):
      f2fs: include non-compressed blocks in compr_written_block
      f2fs: introduce fragment allocation mode mount option

Dongliang Mu (1):
      f2fs: fix UAF in f2fs_available_free_memory

Fengnan Chang (1):
      f2fs: compress: fix overwrite may reduce compress ratio unproperly

Gao Xiang (1):
      f2fs: fix up f2fs_lookup tracepoints

Hyeong-Jun Kim (2):
      f2fs: compress: disallow disabling compress on non-empty compressed file
      f2fs: invalidate META_MAPPING before IPU/DIO write

Jaegeuk Kim (1):
      f2fs: should use GFP_NOFS for directory inodes

Keoseong Park (1):
      f2fs: fix to use WHINT_MODE

Qing Wang (1):
      f2fs: replace snprintf in show functions with sysfs_emit

Weichao Guo (1):
      f2fs: set SBI_NEED_FSCK flag when inconsistent node block found

 Documentation/ABI/testing/sysfs-fs-f2fs | 16 ++++++
 Documentation/filesystems/f2fs.rst      | 19 +++++++
 fs/f2fs/checkpoint.c                    |  8 ++-
 fs/f2fs/compress.c                      | 20 +++++++
 fs/f2fs/data.c                          | 95 +++++++++++++++++++++++++--------
 fs/f2fs/f2fs.h                          | 54 ++++++++++++++++---
 fs/f2fs/file.c                          |  6 +--
 fs/f2fs/gc.c                            |  5 +-
 fs/f2fs/inline.c                        |  2 +-
 fs/f2fs/inode.c                         |  4 +-
 fs/f2fs/namei.c                         | 32 +++++------
 fs/f2fs/node.c                          |  1 +
 fs/f2fs/node.h                          |  5 --
 fs/f2fs/recovery.c                      | 14 ++---
 fs/f2fs/segment.c                       | 83 +++++++++++++++++++++-------
 fs/f2fs/segment.h                       |  1 +
 fs/f2fs/super.c                         | 39 +++++++++++++-
 fs/f2fs/sysfs.c                         | 24 ++++++++-
 fs/f2fs/verity.c                        |  2 +-
 fs/f2fs/xattr.c                         |  2 +-
 include/trace/events/f2fs.h             | 33 ++++++++----
 21 files changed, 359 insertions(+), 106 deletions(-)
