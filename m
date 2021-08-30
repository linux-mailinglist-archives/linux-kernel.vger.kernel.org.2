Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D843FBDF5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbhH3VLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:11:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237167AbhH3VLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630357840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WHA3d8nwpZi2BxeKNZ2Ew6q2P/W2+26A7H/gSGc9/d4=;
        b=Xfy06lq7qGUMbf0bKVDjs/jOZPjlAX9H1nEgN0p2lFT74vkFl1I/3p7AhId56zG+Usfs1l
        HKRF4iDZw/LGaeUEHF85iBY8qVADWNYvfSlWkSdud+kkzuTSFG50X213mvzs4j3pm1DfgM
        Qrfpzz5NtZWY8DROABduqF/hl7myoGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-ui6cTRQ4N1mNCWqGGx21Kw-1; Mon, 30 Aug 2021 17:10:38 -0400
X-MC-Unique: ui6cTRQ4N1mNCWqGGx21Kw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D82AA101965B;
        Mon, 30 Aug 2021 21:10:36 +0000 (UTC)
Received: from max.com (unknown [10.40.194.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B71F21000186;
        Mon, 30 Aug 2021 21:10:35 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes for 5.15
Date:   Mon, 30 Aug 2021 23:10:33 +0200
Message-Id: <20210830211033.1825127-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 fixes for 5.15, which are all
unrelated to the deadlock avoidance patch queue we've been discussing.

Thanks,
Andreas

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.14-rc2-fixes

for you to fetch changes up to 08d736667185dca2751cf47eabb0830cecdeb160:

  gfs2: Remove redundant check from gfs2_glock_dq (2021-08-20 09:03:46 -0500)

----------------------------------------------------------------
Changes in gfs2:
* Various withdraw related fixes (freeze glock recursion, thread
  initialization / destruction order, journal recovery, glock cleanup,
  withdraw under journal lock).
* Some error message improvements.
* Various minor cleanups.

----------------------------------------------------------------
Bob Peterson (14):
      gfs2: Fix glock recursion in freeze_go_xmote_bh
      gfs2: be more verbose replaying invalid rgrp blocks
      gfs2: trivial clean up of gfs2_ail_error
      gfs2: tiny cleanup in gfs2_log_reserve
      gfs2: init system threads before freeze lock
      gfs2: Don't release and reacquire local statfs bh
      gfs2: Make recovery error more readable
      gfs2: Eliminate vestigial HIF_FIRST
      gfs2: nit: gfs2_drop_inode shouldn't return bool
      gfs2: Mark journal inodes as "don't cache"
      gfs2: don't stop reads while withdraw in progress
      gfs2: Don't call dlm after protocol is unmounted
      gfs2: Delay withdraw from atomic context
      gfs2: Remove redundant check from gfs2_glock_dq

Colin Ian King (1):
      gfs2: Fix memory leak of object lsi on error return path

 fs/gfs2/aops.c       |   9 +----
 fs/gfs2/glock.c      |  13 +++----
 fs/gfs2/glops.c      |  27 +++++++------
 fs/gfs2/incore.h     |   2 +-
 fs/gfs2/lock_dlm.c   |   5 +++
 fs/gfs2/log.c        |   2 +-
 fs/gfs2/lops.c       |  44 +++++++++++++--------
 fs/gfs2/meta_io.c    |   7 ++--
 fs/gfs2/ops_fstype.c |  53 +++++++++++++++++++++++++
 fs/gfs2/super.c      | 107 +++++++++------------------------------------------
 fs/gfs2/super.h      |   3 +-
 fs/gfs2/util.c       |   3 +-
 fs/gfs2/util.h       |   5 +++
 13 files changed, 139 insertions(+), 141 deletions(-)

