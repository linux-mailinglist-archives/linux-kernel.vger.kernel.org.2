Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C6D4430D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhKBOyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:54:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233572AbhKBOx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635864683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NpnrKdth6t/i7OBtenBa8wX2/jD9oWEoj5+i+Mvx6MA=;
        b=Eu9vxun+8vbkYfH+bl/7QEeOEftmdtYj47aN0Xp7cnx1Jx3KEExrbH7aqx71sOzL5ERFfQ
        IpGIWoVtWulgIcOvM5ZVsudiXH1zM5PdaG2G6CZqAWyOMG3SyZyb1lF1NvxNtcYBPJmSxF
        cQRtfIDOoCrLcmJb/AfJOrHFGa/a9OQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-Su3fE-5xNVSkeADNX4bwxQ-1; Tue, 02 Nov 2021 10:51:20 -0400
X-MC-Unique: Su3fE-5xNVSkeADNX4bwxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0F64802682;
        Tue,  2 Nov 2021 14:51:18 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.195.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC2125D9D3;
        Tue,  2 Nov 2021 14:51:17 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes for 5.16
Date:   Tue,  2 Nov 2021 15:51:16 +0100
Message-Id: <20211102145116.123072-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 fixes for 5.16.  These are on
top of the memory map + page fault fixes from my first pull request
earlier today.

Thanks,
Andreas

The following changes since commit b01b2d72da25c000aeb124bc78daf3fb998be2b6:

  gfs2: Fix mmap + page fault deadlocks for direct I/O (2021-10-25 08:42:14 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.15-rc5-fixes

for you to fetch changes up to e34e6f8133b8c783a44c235b843e9046e55adbf0:

  gfs2: Fix unused value warning in do_gfs2_set_flags() (2021-10-25 08:42:20 +0200)

----------------------------------------------------------------
Changes in gfs2:

* Fix a locking order inversion between the inode and iopen glocks in
  gfs2_inode_lookup.

* Implement proper queuing of glock holders for glocks that require
  instantiation (like reading an inode or bitmap blocks from disk).
  Before, multiple glock holders could race with each other and
  half-initialized objects could be exposed; the GL_SKIP flag further
  exacerbated this problem.

* Fix a rare deadlock between inode lookup / creation and remote delete
  work.

* Fix a rare scheduling-while-atomic bug in dlm during glock hash table
  walks.

* Various other minor fixes and cleanups.

----------------------------------------------------------------
Alexander Aring (1):
      gfs2: check context in gfs2_glock_put

Andreas Gruenbacher (4):
      gfs2: Save ip from gfs2_glock_nq_init
      gfs2: Remove 'first' trace_gfs2_promote argument
      gfs2: Cancel remote delete work asynchronously
      gfs2: Fix glock_hash_walk bugs

Bob Peterson (15):
      gfs2: remove redundant check in gfs2_rgrp_go_lock
      gfs2: Add GL_SKIP holder flag to dump_holder
      gfs2: move GL_SKIP check from glops to do_promote
      gfs2: Switch some BUG_ON to GLOCK_BUG_ON for debug
      gfs2: Allow append and immutable bits to coexist
      gfs2: dequeue iopen holder in gfs2_inode_lookup error
      gfs2: dump glocks from gfs2_consist_OBJ_i
      gfs2: change go_lock to go_instantiate
      gfs2: re-factor function do_promote
      gfs2: further simplify do_promote
      gfs2: split glock instantiation off from do_promote
      gfs2: fix GL_SKIP node_scope problems
      gfs2: Eliminate GIF_INVALID flag
      gfs2: remove RDF_UPTODATE flag
      gfs2: set glock object after nq

Tim Gardner (1):
      gfs2: Fix unused value warning in do_gfs2_set_flags()

 fs/gfs2/file.c       |  11 +---
 fs/gfs2/glock.c      | 163 +++++++++++++++++++++++++++++++++++----------------
 fs/gfs2/glock.h      |  14 ++++-
 fs/gfs2/glops.c      |  29 ++++-----
 fs/gfs2/incore.h     |   6 +-
 fs/gfs2/inode.c      |  12 ++--
 fs/gfs2/rgrp.c       |  70 ++++++++++------------
 fs/gfs2/rgrp.h       |   2 +-
 fs/gfs2/super.c      |   4 +-
 fs/gfs2/trace_gfs2.h |   9 +--
 fs/gfs2/util.c       |   2 +
 11 files changed, 186 insertions(+), 136 deletions(-)

