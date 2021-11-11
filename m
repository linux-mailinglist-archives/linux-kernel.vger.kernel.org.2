Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E0C44DA9D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 17:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhKKQpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 11:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234270AbhKKQpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 11:45:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B93260F55;
        Thu, 11 Nov 2021 16:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636648932;
        bh=VAJx5FtRw5JMOtudIHDtqzjCcKDE2fqcR5A03pd3zc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMMWeEHBY33hoQypiH16TnF4SK5FjRRq3nFPItey7/zwaOkIqRIm8a5ybnKCbwYmh
         Uad3Bd/28ZBWDQtz6Qhoo7s5ZSGPv4KNNwdkgbj9GKWvDw9xxcUtKS49fj6K7xlxvt
         cJ0t6o3ljOLC5ELo1rzYGf0eUk4FQsPscs/nnnhhUEzhndkr6yqItmXLA/V4GtSe1P
         F2KJexnLX6Rz/ZKzZiaAlNXJEs1fTqdrp6iyiceoEJX2wtLYiTLbCuXu6fvsLimUZM
         tVMfm4YpcvoT+DB4T63r/jUYKBdAdh0bMpIkoIFoyt72WRDkTXaKjCfg8E/Wrosyp2
         gkNk0NWFIvAPA==
Date:   Thu, 11 Nov 2021 08:42:11 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] f2fs update for 5.16-rc1
Message-ID: <YY1H41DSM2Pl7nmT@google.com>
References: <YYyX3oZXNAjYzG0A@google.com>
 <YYzZA7UHY6p5x3Or@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYzZA7UHY6p5x3Or@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11, Christoph Hellwig wrote:
> So question on the direct I/O code.  The perfectly fine iomap code
> wasn't merged because of the pre-existing stale data exposure issuewith
> f2fs direct I/O low-level implementation.  This doesn't seem to be fixed
> or even worked around, but instead we do get new direct I/O features?

No worries. I'm working on the fix and will apply the Eric's patches on top of
this change.

> 
> On Wed, Nov 10, 2021 at 08:11:10PM -0800, Jaegeuk Kim wrote:
> > Hi Linus,
> > 
> > Could you please consider this pull request?
> > 
> > Thanks,
> > 
> > The following changes since commit ff1ffd71d5f0612cf194f5705c671d6b64bf5f91:
> > 
> >   Merge tag 'hyperv-fixes-signed-20210915' of git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux (2021-09-15 17:18:56 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.16-rc1
> > 
> > for you to fetch changes up to 5429c9dbc9025f9a166f64e22e3a69c94fd5b29b:
> > 
> >   f2fs: fix UAF in f2fs_available_free_memory (2021-11-09 08:23:17 -0800)
> > 
> > ----------------------------------------------------------------
> > f2fs-for-5.16-rc1
> > 
> > In this cycle, we've applied relatively small number of patches which fix subtle
> > corner cases mainly, while introducing a new mount option to be able to fragment
> > the disk intentionally for performance tests.
> > 
> > Enhancement:
> >  - add a mount option to fragmente on-disk layout to understand the performance
> >  - support direct IO for multi-partitions
> >  - add a fault injection of dquot_initialize
> > 
> > Bug fix:
> >  - address some lockdep complaints
> >  - fix a deadlock issue with quota
> >  - fix a memory tuning condition
> >  - fix compression condition to improve the ratio
> >  - fix disabling compression on the non-empty compressed file
> >  - invalidate cached pages before IPU/DIO writes
> > 
> > And, we've added some minor clean-ups as usual.
> > 
> > ----------------------------------------------------------------
> > Chao Yu (7):
> >       f2fs: quota: fix potential deadlock
> >       f2fs: avoid attaching SB_ACTIVE flag during mount
> >       f2fs: introduce excess_dirty_threshold()
> >       f2fs: fix wrong condition to trigger background checkpoint correctly
> >       f2fs: multidevice: support direct IO
> >       f2fs: fix incorrect return value in f2fs_sanity_check_ckpt()
> >       f2fs: support fault injection for dquot_initialize()
> > 
> > Daeho Jeong (2):
> >       f2fs: include non-compressed blocks in compr_written_block
> >       f2fs: introduce fragment allocation mode mount option
> > 
> > Dongliang Mu (1):
> >       f2fs: fix UAF in f2fs_available_free_memory
> > 
> > Fengnan Chang (1):
> >       f2fs: compress: fix overwrite may reduce compress ratio unproperly
> > 
> > Gao Xiang (1):
> >       f2fs: fix up f2fs_lookup tracepoints
> > 
> > Hyeong-Jun Kim (2):
> >       f2fs: compress: disallow disabling compress on non-empty compressed file
> >       f2fs: invalidate META_MAPPING before IPU/DIO write
> > 
> > Jaegeuk Kim (1):
> >       f2fs: should use GFP_NOFS for directory inodes
> > 
> > Keoseong Park (1):
> >       f2fs: fix to use WHINT_MODE
> > 
> > Qing Wang (1):
> >       f2fs: replace snprintf in show functions with sysfs_emit
> > 
> > Weichao Guo (1):
> >       f2fs: set SBI_NEED_FSCK flag when inconsistent node block found
> > 
> >  Documentation/ABI/testing/sysfs-fs-f2fs | 16 ++++++
> >  Documentation/filesystems/f2fs.rst      | 19 +++++++
> >  fs/f2fs/checkpoint.c                    |  8 ++-
> >  fs/f2fs/compress.c                      | 20 +++++++
> >  fs/f2fs/data.c                          | 95 +++++++++++++++++++++++++--------
> >  fs/f2fs/f2fs.h                          | 54 ++++++++++++++++---
> >  fs/f2fs/file.c                          |  6 +--
> >  fs/f2fs/gc.c                            |  5 +-
> >  fs/f2fs/inline.c                        |  2 +-
> >  fs/f2fs/inode.c                         |  4 +-
> >  fs/f2fs/namei.c                         | 32 +++++------
> >  fs/f2fs/node.c                          |  1 +
> >  fs/f2fs/node.h                          |  5 --
> >  fs/f2fs/recovery.c                      | 14 ++---
> >  fs/f2fs/segment.c                       | 83 +++++++++++++++++++++-------
> >  fs/f2fs/segment.h                       |  1 +
> >  fs/f2fs/super.c                         | 39 +++++++++++++-
> >  fs/f2fs/sysfs.c                         | 24 ++++++++-
> >  fs/f2fs/verity.c                        |  2 +-
> >  fs/f2fs/xattr.c                         |  2 +-
> >  include/trace/events/f2fs.h             | 33 ++++++++----
> >  21 files changed, 359 insertions(+), 106 deletions(-)
> ---end quoted text---
