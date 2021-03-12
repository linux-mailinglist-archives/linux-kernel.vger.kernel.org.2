Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8953392FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhCLQUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:20:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232238AbhCLQTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615565995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hd1Y8g/doR4JSStSaaWFs5iy4SzfG2qNO7QbxUyq6xg=;
        b=NPI4j38jzZbNZXEi29r/tT1WBddRIBN6hzlCzrU2GuZ26x/yT6Gxjrk0y+q0cCrDsKbYGK
        t6zz5pNo2YTK1K0yBrsRlsuqG7s5QoBcM7BYvaQlImqkHTfW6vwpgJHnWlcYuBP6/K/MN2
        5Is+sjpUSpdB1Up7TElL1suYlVz8Zdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-lJGnsQGVNuSEXFS92Wp0hA-1; Fri, 12 Mar 2021 11:19:53 -0500
X-MC-Unique: lJGnsQGVNuSEXFS92Wp0hA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D12D0100CA9E;
        Fri, 12 Mar 2021 16:19:40 +0000 (UTC)
Received: from max.com (unknown [10.40.192.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D67CA5D760;
        Fri, 12 Mar 2021 16:19:20 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes for 5.12-rc3
Date:   Fri, 12 Mar 2021 17:19:19 +0100
Message-Id: <20210312161919.1595228-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 fixes.

Thanks,
Andreas

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.12-rc2-fixes

for you to fetch changes up to 0efc4976e3da40b09c592b21f722022d8f12a16b:

  gfs2: bypass log flush if the journal is not live (2021-03-12 15:52:48 +0100)

----------------------------------------------------------------
Various gfs2 fixes

----------------------------------------------------------------
Bob Peterson (3):
      gfs2: fix use-after-free in trans_drain
      gfs2: bypass signal_our_withdraw if no journal
      gfs2: bypass log flush if the journal is not live

Yang Li (1):
      gfs2: make function gfs2_make_fs_ro() to void type

 fs/gfs2/log.c        |  6 +++++-
 fs/gfs2/ops_fstype.c |  4 +---
 fs/gfs2/super.c      | 10 ++--------
 fs/gfs2/super.h      |  2 +-
 fs/gfs2/trans.c      |  2 ++
 fs/gfs2/util.c       | 17 +++++++++++------
 6 files changed, 22 insertions(+), 19 deletions(-)

