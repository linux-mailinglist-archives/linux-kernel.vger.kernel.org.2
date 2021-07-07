Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B4C3BF08F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 21:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhGGUBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 16:01:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhGGUBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:01:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0DE261CC2;
        Wed,  7 Jul 2021 19:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625687931;
        bh=K6SJBq8axw4PnEQMuifWYXHlsiKcVtzF3zIRp1rgNiM=;
        h=Date:From:To:Cc:Subject:From;
        b=Q1Qnn5WVNaZpO3l9oefa9G1ot72DNnltpLUhpi2fdbixeTcQXeCg2XzPmWeBP75GP
         1uRGeCCdbFPa2Q0Qlst2T0g0RTyv42B+AS3Xm2v7ZDaT7J+XdX7qFFwFivmk2ZHGoN
         xhqpnbcEpnabqjt7j9aJPTtWcMs0yFv1/Gi/pwv8cw1KwtvQ9CpPO9yocflVEJyIIL
         6UZytxxVIOPirul/3pZPgKxSgYpLA/iiqHRycCZ0XyNqQ/Z8/IeuV0/wbn1tKgirvi
         fMBNDJjDR1Fn5jq/i9ZTdiCMRyqpCnkcLoCc50ink5JfJE60kE3yHhiImu2bKysq/u
         IPi4OLUpFHLZQ==
Date:   Wed, 7 Jul 2021 12:58:50 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: [GIT PULL] f2fs for 5.14-rc1
Message-ID: <YOYHejl3CgABOnhP@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit bd3c9cdb21a2674dd0db70199df884828e37abd4:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2021-05-14 10:52:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.14-rc1

for you to fetch changes up to 28607bf3aa6f9762b32dc7f1ed0488823c0651b8:

  f2fs: drop dirty node pages when cp is in error status (2021-07-06 22:05:06 -0700)

----------------------------------------------------------------
f2fs-for-5.14-rc1

In this round, we've improved the compression support especially for Android
such as allowing compression for mmap files, replacing the immutable bit with
internal bit to prohibits data writes explicitly, and adding a mount option,
"compress_cache", to improve random reads. And, we added "readonly" feature to
compact the partition w/ compression enabled, which will be useful for Android
RO partitions.

Enhancement:
 - support compression for mmap file
 - use an f2fs flag instead of IMMUTABLE bit for compression
 - support RO feature w/ extent_cache
 - fully support swapfile with file pinning
 - improve atgc tunability
 - add nocompress extensions to unselect files for compression

Bug fix:
 - fix false alaram on iget failure during GC
 - fix race condition on global pointers when there are multiple f2fs instances
 - add MODULE_SOFTDEP for initramfs

As usual, we've also cleaned up some places for better code readability.
(e.g., sysfs/feature, debugging messages, slab cache name, and docs)

----------------------------------------------------------------
Chao Yu (17):
      f2fs: compress: rename __cluster_may_compress
      f2fs: add cp_error check in f2fs_write_compressed_pages
      f2fs: restructure f2fs page.private layout
      f2fs: fix to avoid racing on fsync_entry_slab by multi filesystem instances
      f2fs: atgc: fix to set default age threshold
      f2fs: compress: remove unneeded f2fs_put_dnode()
      f2fs: compress: clean up parameter of __f2fs_cluster_blocks()
      f2fs: add MODULE_SOFTDEP to ensure crc32 is included in the initramfs
      f2fs: compress: fix to disallow temp extension
      f2fs: atgc: export entries for better tunability via sysfs
      f2fs: compress: remove unneeded preallocation
      f2fs: compress: add compress_inode to cache compressed blocks
      f2fs: swap: remove dead codes
      f2fs: swap: support migrating swapfile in aligned write mode
      f2fs: introduce f2fs_casefolded_name slab cache
      f2fs: fix to avoid adding tab before doc section
      MAINTAINERS: f2fs: update my email address

Daeho Jeong (1):
      f2fs: enable extent cache for compression files in read-only

Daniel Rosenberg (2):
      f2fs: Show casefolding support only when supported
      f2fs: Advertise encrypted casefolding in sysfs

Fengnan Chang (1):
      f2fs: compress: add nocompress extensions support

Jaegeuk Kim (8):
      f2fs: let's allow compression for mmap files
      f2fs: introduce FI_COMPRESS_RELEASED instead of using IMMUTABLE bit
      f2fs: support RO feature
      f2fs: add pin_file in feature list
      f2fs: clean up /sys/fs/f2fs/<disk>/features
      f2fs: remove false alarm on iget failure during GC
      f2fs: initialize page->private when using for our internal use
      f2fs: drop dirty node pages when cp is in error status

Joe Perches (1):
      f2fs: logging neatening

Shin'ichiro Kawasaki (1):
      f2fs: Prevent swap file in LFS mode

Tom Rix (1):
      f2fs: return success if there is no work to do

 Documentation/ABI/testing/sysfs-fs-f2fs |  57 ++++-
 Documentation/filesystems/f2fs.rst      |  50 ++++-
 MAINTAINERS                             |   2 +-
 fs/f2fs/checkpoint.c                    |   4 +-
 fs/f2fs/compress.c                      | 255 +++++++++++++++++-----
 fs/f2fs/data.c                          | 360 ++++++++++++++------------------
 fs/f2fs/debug.c                         |  13 ++
 fs/f2fs/dir.c                           |  25 ++-
 fs/f2fs/f2fs.h                          | 228 ++++++++++++++++----
 fs/f2fs/file.c                          |  37 ++--
 fs/f2fs/gc.c                            |  16 +-
 fs/f2fs/inline.c                        |   4 +-
 fs/f2fs/inode.c                         |  23 +-
 fs/f2fs/namei.c                         |  36 +++-
 fs/f2fs/node.c                          |  35 ++--
 fs/f2fs/node.h                          |  33 +--
 fs/f2fs/recovery.c                      |  29 ++-
 fs/f2fs/segment.c                       |  34 ++-
 fs/f2fs/super.c                         | 188 ++++++++++++++++-
 fs/f2fs/sysfs.c                         | 232 +++++++++++++++-----
 include/linux/f2fs_fs.h                 |   2 +
 21 files changed, 1168 insertions(+), 495 deletions(-)
