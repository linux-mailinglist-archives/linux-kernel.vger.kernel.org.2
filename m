Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7A839594D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 12:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhEaK6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 06:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231344AbhEaK55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 06:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622458577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XDhdJyYu9mTXSWKFBQ6lTq2vD2wtLvH820x3t8G/m0E=;
        b=B1RA0+xCQPQlv4CszrU7ziCTvUbyuJUyt/R/gEio6fu7elxOeqn94EYrKla0xE4KIMDQjE
        lwfsLI5e6Qz23qfqXyTJseZTq4TC4AagKuk8I1MezxuBdwM17PfM1fO0Gg31mY41UGbY6R
        G6grOsZmLKXB62ZYFBqSJKo9ctU1BJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-OVikhWS9PAayEpJWJj5JTQ-1; Mon, 31 May 2021 06:56:13 -0400
X-MC-Unique: OVikhWS9PAayEpJWJj5JTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAD6A107ACF5;
        Mon, 31 May 2021 10:56:12 +0000 (UTC)
Received: from max.com (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9551860C0F;
        Mon, 31 May 2021 10:56:08 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes for v5.13-rc5
Date:   Mon, 31 May 2021 12:56:06 +0200
Message-Id: <20210531105606.228314-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 fixes for v5.13-rc5.

(I'll follow up with another set of fixes that may require additional
discussion later today.)

Thanks,
Andreas

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.13-rc2-fixes

for you to fetch changes up to 1ab19c5de4c537ec0d9b21020395a5b5a6c059b2:

  gfs2: Fix use-after-free in gfs2_glock_shrink_scan (2021-05-31 12:03:28 +0200)

----------------------------------------------------------------
Various gfs2 fixes

----------------------------------------------------------------
Andreas Gruenbacher (2):
      gfs2: Prevent direct-I/O write fallback errors from getting lost
      gfs2: Fix mmap locking for write faults

Bob Peterson (4):
      gfs2: Fix I_NEW check in gfs2_dinode_in
      gfs2: fix scheduling while atomic bug in glocks
      gfs2: fix a deadlock on withdraw-during-mount
      gfs2: Clean up revokes on normal withdraws

Hillf Danton (1):
      gfs2: Fix use-after-free in gfs2_glock_shrink_scan

 fs/gfs2/file.c  |  9 +++++++--
 fs/gfs2/glock.c | 28 ++++++++++++++++++++++++----
 fs/gfs2/glops.c |  2 +-
 fs/gfs2/log.c   |  6 +++---
 fs/gfs2/log.h   |  1 +
 fs/gfs2/lops.c  |  7 ++++++-
 fs/gfs2/lops.h  |  1 +
 fs/gfs2/util.c  |  1 +
 8 files changed, 44 insertions(+), 11 deletions(-)

