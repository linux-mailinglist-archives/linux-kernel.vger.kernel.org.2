Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75055398858
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhFBL2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232989AbhFBL2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622633183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Gylhu4c5+fQCDTPC6IImtOwya8gXx77hl43NDHaB5sE=;
        b=EFKFj06CiJNEesaPQFf6k9qTP7eX5UdPxbZEvSrbljrGmVNFwAUGWNa0zw/uNgHBjkOJA/
        /axGSZ6OiZjSL68TF6U6AurFeO2zRhfXbP9GwgMTd8Z1XjwMCLjp4ZDT+X7Le/gXztri5L
        V63eHgRaqSPehAMjQlxYndbBrvwK4+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-s6jHsLbLO1eCWIWr0pL7ww-1; Wed, 02 Jun 2021 07:26:21 -0400
X-MC-Unique: s6jHsLbLO1eCWIWr0pL7ww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D5801020C5C;
        Wed,  2 Jun 2021 11:26:12 +0000 (UTC)
Received: from max.com (unknown [10.40.193.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F1D6761EA;
        Wed,  2 Jun 2021 11:26:10 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2: Recognize mmap + page fault self-recursion to prevent deadlocks
Date:   Wed,  2 Jun 2021 13:26:09 +0200
Message-Id: <20210602112609.355793-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following fixes for partially addressing the mmap +
page fault deadlocks.  It's not clear to me if and when we'll find a better
solution, and those fixes prevent a kernel BUG in the simple self-recursion
case at least.  (This is the case that the new fstest [*] reproduces.)

[*] https://lore.kernel.org/fstests/20210531152604.240462-1-agruenba@redhat.com/

Thanks,
Andreas

The following changes since commit d5b8145455c629e7f157d2da46a9b2fba483f235:

  Revert "gfs2: Fix mmap locking for write faults" (2021-06-01 23:16:42 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.13-rc2-fixes3

for you to fetch changes up to 485805ef8389eb1caa484cbb66e815afac00879d:

  gfs2: Fix mmap + page fault deadlocks (part 1) (2021-06-02 11:44:54 +0200)

----------------------------------------------------------------
gfs2: Recognize mmap + page fault self-recursion to prevent deadlocks

----------------------------------------------------------------
Andreas Gruenbacher (4):
      gfs2: Clean up the error handling in gfs2_page_mkwrite
      gfs2: Add wrapper for iomap_file_buffered_write
      gfs2: Add gfs2_holder_is_compatible helper
      gfs2: Fix mmap + page fault deadlocks (part 1)

 fs/gfs2/file.c  | 117 +++++++++++++++++++++++++++++++++++++++-----------------
 fs/gfs2/glock.h |  14 +++++++
 2 files changed, 95 insertions(+), 36 deletions(-)

