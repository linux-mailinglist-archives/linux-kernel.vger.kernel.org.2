Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC1036E8D8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbhD2Kfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232261AbhD2Kfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619692495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Chvtu/o6tQSjr1YmXbx6Eow1icBSXGjA7cXfGJrXKvI=;
        b=Tq4Q+cBsM4OCcqoxbJ7NzQB9H+mUl/QgS3x4unLUBsYb9Z2WLhMijTcDxvYCIKV/OW61hD
        fdM23uELUzpTzhl78TsHD6HAxCkQjciyw4Vb+oaNnd9HrU6vcAF61gM0W81V1nhNmh8wpx
        S9MFEJbbl4MvyeCx9Y8c1Y7HgwuXiDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-l4ce_dJfN4mYrfOAtTFIbQ-1; Thu, 29 Apr 2021 06:34:53 -0400
X-MC-Unique: l4ce_dJfN4mYrfOAtTFIbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28EDB80402F;
        Thu, 29 Apr 2021 10:34:52 +0000 (UTC)
Received: from max.com (unknown [10.40.195.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFE756A90B;
        Thu, 29 Apr 2021 10:34:47 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] GFS2 changes for 5.13
Date:   Thu, 29 Apr 2021 12:34:45 +0200
Message-Id: <20210429103445.846975-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 changes for 5.13.

Thanks a lot,
Andreas

The following changes since commit 8e29be3468d4565dd95fbb098df0d7a79ee60d71:

  Merge tag 'gfs2-v5.12-rc2-fixes2' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2021-04-03 12:15:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.13

for you to fetch changes up to e5966cf20f0c7e40fd8c208ba1614e1a35a8deee:

  gfs2: Fix fall-through warnings for Clang (2021-04-20 22:38:21 +0200)

----------------------------------------------------------------
Changes in gfs2:

- Fix some compiler and kernel-doc warnings.

- Various minor cleanups and optimizations.

- Add a new sysfs gfs2 status file with some filesystem wide
  information.

----------------------------------------------------------------
Andreas Gruenbacher (7):
      gfs2: Remove unused variable sb_format
      gfs2: Add new gfs2_iomap_get helper
      gfs2: Turn gfs2_extent_map into gfs2_{get,alloc}_extent
      gfs2: Replace gfs2_lblk_to_dblk with gfs2_get_extent
      gfs2: Turn gfs2_meta_indirect_buffer into gfs2_meta_buffer
      gfs2: Silence possible null pointer dereference warning
      gfs2: Make gfs2_setattr_simple static

Bob Peterson (4):
      gfs2: don't create empty buffers for NO_CREATE
      gfs2: Eliminate gh parameter from go_xmote_bh func
      gfs2: Fix dir.c function parameter descriptions
      gfs2: Add new sysfs file for gfs2 status

Gustavo A. R. Silva (1):
      gfs2: Fix fall-through warnings for Clang

Lee Jones (1):
      gfs2: Fix a number of kernel-doc warnings

 fs/gfs2/aops.c       |   5 +-
 fs/gfs2/bmap.c       | 153 ++++++++++++++++++++++++++-------------------------
 fs/gfs2/bmap.h       |  13 +++--
 fs/gfs2/dir.c        |  52 +++++++++--------
 fs/gfs2/file.c       |  12 ++--
 fs/gfs2/glock.c      |  12 ++--
 fs/gfs2/glops.c      |  16 ++----
 fs/gfs2/incore.h     |   3 +-
 fs/gfs2/inode.c      |  32 +++++------
 fs/gfs2/inode.h      |   1 -
 fs/gfs2/lock_dlm.c   |  37 +++++++------
 fs/gfs2/log.c        |  23 ++++----
 fs/gfs2/lops.c       |  13 +++--
 fs/gfs2/meta_io.c    |  20 ++++---
 fs/gfs2/meta_io.h    |   6 +-
 fs/gfs2/ops_fstype.c |   8 +--
 fs/gfs2/quota.c      |   6 +-
 fs/gfs2/recovery.c   |   8 ++-
 fs/gfs2/rgrp.c       |   8 ++-
 fs/gfs2/super.c      |  12 ++--
 fs/gfs2/sys.c        |  67 ++++++++++++++++++++++
 fs/gfs2/util.c       |  19 ++++---
 fs/gfs2/xattr.c      |  29 +++-------
 23 files changed, 312 insertions(+), 243 deletions(-)

