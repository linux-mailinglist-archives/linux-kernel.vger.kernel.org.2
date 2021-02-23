Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73207323186
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhBWTiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:38:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26891 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231335AbhBWTiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614109001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xSXNjPrPxyU8r7SGW7Uz84R+t/dQp8t1lbvbHRPa4JI=;
        b=WQRrR6tpfQdIoINn8NK64L6S6libVgV3K64dk1q4UY+qiL6ZXRxaHTgpeoDirrthMsvxca
        MJjegdESOIKJvR8OXZsyyuiV5eXRouV7SWWGMBE0P9HeTa5AYvlnpD/Gpr4bvbsq/eXt2e
        n6rw+nziUVKpNeqHmEYUBaF39oWRM24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-b_vF2DaIPomcQk2Yfza6IA-1; Tue, 23 Feb 2021 14:36:09 -0500
X-MC-Unique: b_vF2DaIPomcQk2Yfza6IA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EDF78015AD;
        Tue, 23 Feb 2021 19:34:35 +0000 (UTC)
Received: from max.com (unknown [10.40.192.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDBB667CC0;
        Tue, 23 Feb 2021 19:34:30 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] GFS2 changes for 5.12
Date:   Tue, 23 Feb 2021 20:34:29 +0100
Message-Id: <20210223193429.873467-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 changes for 5.12.  My apologies for
the late request; we ended up getting stuck with two broken patches that have
now both been removed.

Thanks a lot,
Andreas

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.12

for you to fetch changes up to 17d77684088510df84ff8285982d0eed52cd5890:

  gfs2: Don't get stuck with I/O plugged in gfs2_ail1_flush (2021-02-23 19:01:42 +0100)

----------------------------------------------------------------
Changes in gfs2:
* Log space and revoke accounting rework to fix some failed asserts.
* Local resource group glock sharing for better local performance.
* Add support for version 1802 filesystems: trusted xattr support and
  '-o rgrplvb' mounts by default.
* Actually synchronize on the inode glock's FREEING bit during withdraw
  ("gfs2: fix glock confusion in function signal_our_withdraw").
* Fix parallel recovery of multiple journals ("gfs2: keep bios separate
  for each journal").
* Various other bug fixes.

----------------------------------------------------------------
Andreas Gruenbacher (37):
      gfs2: Turn gfs2_rbm_incr into gfs2_rbm_add
      gfs2: Only use struct gfs2_rbm for bitmap manipulations
      gfs2: Get rid of unnecessary variable in gfs2_alloc_blocks
      gfs2: Minor gfs2_inplace_reserve cleanup
      Revert "gfs2: Don't reject a supposedly full bitmap if we have blocks reserved"
      gfs2: Don't clear GBF_FULL flags in rs_deltree
      gfs2: Set GBF_FULL flags when reading resource group
      gfs2: Un-obfuscate function jdesc_find_i
      gfs2: Simplify the buf_limit and databuf_limit definitions
      gfs2: Minor gfs2_write_revokes cleanups
      gfs2: Some documentation updates
      gfs2: Minor debugging improvement
      gfs2: Rename gfs2_{write => flush}_revokes
      gfs2: Clean up ail2_empty
      gfs2: Use sb_start_intwrite in gfs2_ail_empty_gl
      gfs2: Clean up on-stack transactions
      gfs2: Get rid of sd_reserving_log
      gfs2: Move lock flush locking to gfs2_trans_{begin,end}
      gfs2: Don't wait for journal flush in clean_journal
      gfs2: Clean up gfs2_log_reserve
      gfs2: Use a tighter bound in gfs2_trans_begin
      gfs2: Get rid of current_tail()
      gfs2: Move function gfs2_ail_empty_tr
      gfs2: Lock imbalance on error path in gfs2_recover_one
      gfs2: Add trusted xattr support
      gfs2: Recursive gfs2_quota_hold in gfs2_iomap_end
      gfs2: Also reflect single-block allocations in rgd->rd_extfail_pt
      gfs2: Only pass reservation down to gfs2_rbm_find
      gfs2: Don't search for unreserved space twice
      gfs2: Check for active reservation in gfs2_release
      gfs2: Rename rs_{free -> requested} and rd_{reserved -> requested}
      gfs2: Add per-reservation reserved block accounting
      gfs2: Add local resource group locking
      gfs2: Minor calc_reserved cleanup
      gfs2: Rework the log space allocation logic
      gfs2: Per-revoke accounting in transactions
      Merge branches 'rgrp-glock-sharing' and 'gfs2-revoke' from https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git

Andrew Price (2):
      gfs2: Fix invalid block size message
      gfs2: Enable rgrplvb for sb_fs_format 1802

Bob Peterson (10):
      gfs2: Add common helper for holding and releasing the freeze glock
      gfs2: move freeze glock outside the make_fs_rw and _ro functions
      gfs2: make gfs2_log_write_page static
      Revert "GFS2: Re-add a call to log_flush_wait when flushing the journal"
      gfs2: fix glock confusion in function signal_our_withdraw
      gfs2: keep bios separate for each journal
      gfs2: Don't skip dlm unlock if glock has an lvb
      gfs2: Allow node-wide exclusive glock sharing
      gfs2: Use resource group glock sharing
      gfs2: Don't get stuck with I/O plugged in gfs2_ail1_flush

Zhaoyang Huang (1):
      gfs2: amend SLAB_RECLAIM_ACCOUNT on gfs2 related slab cache

 fs/gfs2/bmap.c                   |  10 +-
 fs/gfs2/file.c                   |   8 +-
 fs/gfs2/glock.c                  |  22 +-
 fs/gfs2/glock.h                  |   6 +
 fs/gfs2/glops.c                  |  38 +--
 fs/gfs2/incore.h                 |  54 ++--
 fs/gfs2/inode.c                  |   6 +-
 fs/gfs2/lock_dlm.c               |   8 +-
 fs/gfs2/log.c                    | 525 ++++++++++++++++++++++-----------------
 fs/gfs2/log.h                    |  20 +-
 fs/gfs2/lops.c                   |  26 +-
 fs/gfs2/lops.h                   |  23 +-
 fs/gfs2/main.c                   |   4 +-
 fs/gfs2/ops_fstype.c             |  71 ++++--
 fs/gfs2/recovery.c               |  14 +-
 fs/gfs2/rgrp.c                   | 442 ++++++++++++++++++++------------
 fs/gfs2/rgrp.h                   |   6 +-
 fs/gfs2/super.c                  |  73 ++----
 fs/gfs2/super.h                  |   8 +-
 fs/gfs2/trace_gfs2.h             |  37 ++-
 fs/gfs2/trans.c                  | 102 +++++---
 fs/gfs2/trans.h                  |   5 +-
 fs/gfs2/util.c                   |  59 ++++-
 fs/gfs2/util.h                   |   3 +
 fs/gfs2/xattr.c                  |  54 +++-
 include/uapi/linux/gfs2_ondisk.h |   5 +-
 26 files changed, 967 insertions(+), 662 deletions(-)

