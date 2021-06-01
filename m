Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D947F397BB1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhFAVX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234707AbhFAVXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622582530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SGACjImek1ptgXSeByQZrD4xRmOVpVtzNZYAghuZKk4=;
        b=Z22242zcTg6ue6O4EALb+HQkK3HDvxrWVNouePwnh4XLeHliwuhCqvGlYe3QJNmqznE+w2
        C9DkSNyvIMJh8wOnJLiQFx+V+57BvHFW8irBqVw++RVvNPpjPlL0QurCDF020c4M94jeVR
        sG2qKvTTZXWwPVat+ibzVjBonDwJDSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-ykzdWWcHPH-SRYaf-FKqNA-1; Tue, 01 Jun 2021 17:22:07 -0400
X-MC-Unique: ykzdWWcHPH-SRYaf-FKqNA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A15B19611A1;
        Tue,  1 Jun 2021 21:22:06 +0000 (UTC)
Received: from max.com (unknown [10.40.193.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05E9260CC5;
        Tue,  1 Jun 2021 21:22:01 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Revert "gfs2: Fix mmap locking for write faults"
Date:   Tue,  1 Jun 2021 23:22:00 +0200
Message-Id: <20210601212200.318607-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling this revert.  The commit in question is broken,
and reverting it will restore the correct behavior.  Sorry for the
confusion.

Thanks,
Andreas

The following changes since commit c2131f7e73c9e9365613e323d65c7b9e5b910f56:

  Merge tag 'gfs2-v5.13-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2021-05-31 05:57:22 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.13-rc2-fixes2

for you to fetch changes up to d5b8145455c629e7f157d2da46a9b2fba483f235:

  Revert "gfs2: Fix mmap locking for write faults" (2021-06-01 23:16:42 +0200)

----------------------------------------------------------------
Revert broken commit

----------------------------------------------------------------
Andreas Gruenbacher (1):
      Revert "gfs2: Fix mmap locking for write faults"

 fs/gfs2/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

