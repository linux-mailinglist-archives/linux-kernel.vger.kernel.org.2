Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30710455131
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 00:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241632AbhKQXkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 18:40:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240222AbhKQXkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 18:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637192225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0HRQqF9IyHODpVuBExdtm/2V021JyHA28AYvgsTshqc=;
        b=Rp5jKhRUVYQwPMvyGS9hZnGmcBUV/wxB5di7KPfQuJsBiYg20jL9kMm3bkLos5YUnTHq+G
        aYI1nEyJxeA2XyWbDF6voXeIsHCAXp/NN4F8KT707bM42+3sG4XPj8Qxq9bm0dfdGyr/4y
        87Rf+RtZzNLGtr8/oUUSyCUkphfewac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-Zu-hnBbsO9W6q-GA1Gp9CA-1; Wed, 17 Nov 2021 18:37:04 -0500
X-MC-Unique: Zu-hnBbsO9W6q-GA1Gp9CA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DE6E948;
        Wed, 17 Nov 2021 23:37:03 +0000 (UTC)
Received: from max.com (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39CB75DAA5;
        Wed, 17 Nov 2021 23:36:58 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes for v5.16-rc2
Date:   Thu, 18 Nov 2021 00:36:56 +0100
Message-Id: <20211117233656.77861-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 fixes for -rc2.  The one thing that
stands out is this commit:

  gfs2: Prevent endless loops in gfs2_file_buffered_write

We have a choice here between the proper fix in iomap_write_iter and
generic_perform_write and this patch, which is just a workaround.  I've tried
to get your feedback on this before:

  https://lore.kernel.org/all/20211110174457.533866-1-agruenba@redhat.com/

To me, it seems to be too late for the proper fix for v5.16 now; please advise
if you think otherwise.

Thanks,
Andreas


The following changes since commit 78805cbe5d72ad27a56962a8072edbcb45ca1180:

  Merge tag 'gfs2-v5.15-rc5-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2021-11-02 12:35:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.16-rc2-fixes

for you to fetch changes up to 554c577cee95bdc1d03d9f457e57dc96eb791845:

  gfs2: Prevent endless loops in gfs2_file_buffered_write (2021-11-10 18:22:37 +0100)

----------------------------------------------------------------
Fixes in gfs2:
* The current iomap_file_buffered_write behavior of failing the entire
  write when part of the user buffer cannot be faulted in leads to an
  endless loop in gfs2.  Work around that in gfs2 for now.
* Various other bugs all over the place.

----------------------------------------------------------------
Andreas Gruenbacher (5):
      gfs2: Only dereference i->iov when iter_is_iovec(i)
      gfs2: Fix atomic bug in gfs2_instantiate
      gfs2: Fix length of holes reported at end-of-file
      gfs2: Fix "Introduce flag for glock holder auto-demotion"
      gfs2: Prevent endless loops in gfs2_file_buffered_write

Bob Peterson (1):
      gfs2: release iopen glock early in evict

 fs/gfs2/bmap.c  |  2 +-
 fs/gfs2/file.c  |  9 ++++++---
 fs/gfs2/glock.c | 12 ++++--------
 fs/gfs2/super.c | 14 +++++++-------
 4 files changed, 18 insertions(+), 19 deletions(-)

