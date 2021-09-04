Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38004008F2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 03:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbhIDB2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 21:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240945AbhIDB2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 21:28:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4B5660E76;
        Sat,  4 Sep 2021 01:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630718849;
        bh=D2o7Hi7RNZvEjo+CGLrSu9GeeM481v3eSSagovSn6Wk=;
        h=Date:From:To:Cc:Subject:From;
        b=BKQPFE1nHHNuvMqSVcIK7Rps6Huz6VehH0Hch94zLXb6+SfPmcBFBrcVzgzdAO1sw
         HrgRlxGDobU6RKBe0mPZ2eOe6rFddFLx8nPzFqdPCr8pX2J+N0p14UAcRRT1ir1Nhq
         lsWbvEgExwSLVGCrmLv8LFclnCbQ3hDtx76xhnqvJFUOqG5BToBMLKMer5efBXxa9/
         3zBIvnY4tepECzIYjeHJRzTdxW4fq6+i7Zdu/ruB9tF754rQDiwBcrHPI7YAPIk1Bz
         3ULHQ2h2w2DK9ZIo6IyRlvnux835xd5y2ZFTutxONz7ttsfqjBw6f7LmZYu3WrCkc/
         EvOhM4KJZaGNQ==
Date:   Fri, 3 Sep 2021 18:27:28 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: [GIT PULL] f2fs update for 5.15-rc1
Message-ID: <YTLLgFTaal2+EC1c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.15-rc1

for you to fetch changes up to 9605f75cf36e0bcc0f4ada07b5be712d30107607:

  f2fs: should put a page beyond EOF when preparing a write (2021-08-31 14:39:39 -0700)

----------------------------------------------------------------
f2fs-for-5.15-rc1

In this cycle, we've addressed some performance issues such as lock contention,
misbehaving compress_cache, allowing extent_cache for compressed files, and new
sysfs to adjust ra_size for fadvise. In order to diagnose the performance issues
quickly, we also added an iostat which shows the IO latencies periodically. On
the stability side, we've found two memory leakage cases in the error path in
compression flow. And, we've also fixed various corner cases in fiemap, quota,
checkpoint=disable, zstd, and so on.

Enhancement:
 - avoid long checkpoint latency by releasing nat_tree_lock
 - collect and show iostats periodically
 - support extent_cache for compressed files
 - add a sysfs entry to manage ra_size given fadvise(POSIX_FADV_SEQUENTIAL)
 - report f2fs GC status via sysfs
 - add discard_unit=%s in mount option to handle zoned device

Bug fix:
 - fix two memory leakages when an error happens in the compressed IO flow
 - fix commpress_cache to get the right LBA
 - fix fiemap to deal with compressed case correctly
 - fix wrong EIO returns due to SBI_NEED_FSCK
 - fix missing writes when enabling checkpoint back
 - fix quota deadlock
 - fix zstd level mount option

In addition to the above major updates, we've cleaned up several code paths such
as dio, unnecessary operations, debugfs/f2fs/status, sanity check, and typos.

----------------------------------------------------------------
Chao Yu (18):
      f2fs: compress: fix to set zstd compress level correctly
      f2fs: quota: fix potential deadlock
      f2fs: fix wrong checkpoint_changed value in f2fs_remount()
      f2fs: fix to force keeping write barrier for strict fsync mode
      f2fs: introduce discard_unit mount option
      f2fs: fix to stop filesystem update once CP failed
      f2fs: extent cache: support unaligned extent
      f2fs: avoid unneeded memory allocation in __add_ino_entry()
      f2fs: fix to do sanity check for sb/cp fields correctly
      f2fs: support fault injection for f2fs_kmem_cache_alloc()
      f2fs: fix to keep compatibility of fault injection interface
      f2fs: compress: do sanity check on cluster
      f2fs: rebuild nat_bits during umount
      f2fs: adjust unlock order for cleanup
      f2fs: fix to account missing .skipped_gc_rwsem
      f2fs: fix unexpected ENOENT comes from f2fs_map_blocks()
      f2fs: fix to unmap pages from userspace process in punch_hole()
      f2fs: enable realtime discard iff device supports discard

Daeho Jeong (6):
      f2fs: add sysfs nodes to get GC info for each GC mode
      f2fs: change fiemap way in printing compression chunk
      f2fs: turn back remapped address in compressed page endio
      f2fs: add sysfs node to control ra_pages for fadvise seq file
      f2fs: separate out iostat feature
      f2fs: introduce periodic iostat io latency traces

Eric Biggers (2):
      f2fs: make f2fs_write_failed() take struct inode
      f2fs: remove allow_outplace_dio()

Fengnan Chang (4):
      f2fs: compress: remove unneeded read when rewrite whole cluster
      f2fs: compress: avoid duplicate counting of valid blocks when read compressed file
      f2fs: compress: allow write compress released file after truncate to zero
      f2fs: Don't create discard thread when device doesn't support realtime discard

Jaegeuk Kim (7):
      f2fs: let's keep writing IOs on SBI_NEED_FSCK
      f2fs: don't sleep while grabing nat_tree_lock
      f2fs: do not submit NEW_ADDR to read node block
      f2fs: show sbi status in debugfs/f2fs/status
      f2fs: guarantee to write dirty data when enabling checkpoint back
      f2fs: deallocate compressed pages when error happens
      f2fs: should put a page beyond EOF when preparing a write

Jia Yang (1):
      f2fs: Revert "f2fs: Fix indefinite loop in f2fs_gc() v1"

Laibin Qiu (1):
      f2fs: fix min_seq_blocks can not make sense in some scenes.

Tiezhu Yang (1):
      f2fs: Kconfig: clean up config options about compression

Wang Xiaojun (1):
      f2fs: avoid to create an empty string as the extension_list

Yangtao Li (5):
      f2fs: reduce the scope of setting fsck tag when de->name_len is zero
      f2fs: improve sbi status info in debugfs/f2fs/status
      f2fs: correct comment in segment.h
      f2fs: convert S_IRUGO to 0444
      f2fs: fix description about main_blkaddr node

 Documentation/ABI/testing/sysfs-fs-f2fs |  23 ++-
 Documentation/filesystems/f2fs.rst      |  17 +-
 fs/f2fs/Kconfig                         |  19 ++-
 fs/f2fs/Makefile                        |   1 +
 fs/f2fs/checkpoint.c                    |  57 +++++--
 fs/f2fs/compress.c                      |  97 ++++++++++-
 fs/f2fs/data.c                          | 198 +++++++++++++++-------
 fs/f2fs/debug.c                         |  39 ++++-
 fs/f2fs/dir.c                           |  18 +-
 fs/f2fs/extent_cache.c                  |  46 ++++-
 fs/f2fs/f2fs.h                          | 177 ++++++++++----------
 fs/f2fs/file.c                          |  66 +++++++-
 fs/f2fs/gc.c                            |  14 +-
 fs/f2fs/iostat.c                        | 287 ++++++++++++++++++++++++++++++++
 fs/f2fs/iostat.h                        |  84 ++++++++++
 fs/f2fs/node.c                          | 165 +++++++++++++-----
 fs/f2fs/recovery.c                      |   3 +-
 fs/f2fs/segment.c                       | 137 ++++++++++-----
 fs/f2fs/segment.h                       |   4 +-
 fs/f2fs/super.c                         | 242 ++++++++++++++++++++-------
 fs/f2fs/sysfs.c                         | 156 +++++++----------
 fs/f2fs/xattr.c                         |   3 +-
 include/trace/events/f2fs.h             |  97 +++++++++++
 23 files changed, 1493 insertions(+), 457 deletions(-)
 create mode 100644 fs/f2fs/iostat.c
 create mode 100644 fs/f2fs/iostat.h
