Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F973534E3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 19:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbhDCRT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 13:19:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236364AbhDCRT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 13:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617470363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0YBqTLP+FE1SvfYMmQXsZ4qifQi+UKGZR62cXzSBsmw=;
        b=YzyQauYaN/hW0t/0G2QYsK23HdFgVbcHZFQH1vHSEn+12wE52K0je3RKTPEqRTf+aad3hi
        guLJHA2Nmp/M3J5skyvNS8/glwHfWj6vVcElu/gAu3tfxmT+pxmxULVPKM28nGpqHnFwAF
        z5XzsHo7JO+chVsH1YX6w2evb7v8PpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-5tbHSm7lO8-r3SzXoKpCVw-1; Sat, 03 Apr 2021 13:19:22 -0400
X-MC-Unique: 5tbHSm7lO8-r3SzXoKpCVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9E6187504E;
        Sat,  3 Apr 2021 17:19:20 +0000 (UTC)
Received: from max.com (unknown [10.40.192.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83E9A5C1CF;
        Sat,  3 Apr 2021 17:19:16 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes for v5.12-rc6
Date:   Sat,  3 Apr 2021 19:19:14 +0200
Message-Id: <20210403171914.18980-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following two gfs2 fixes for v5.12-rc6.

Thanks,
Andreas

The following changes since commit b77b5fdd052e7ee61b35164abb10e8433d3160e8:

  Merge tag 'gfs2-v5.12-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2021-03-12 11:46:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.12-rc2-fixes2

for you to fetch changes up to ff132c5f93c06bd4432bbab5c369e468653bdec4:

  gfs2: report "already frozen/thawed" errors (2021-03-25 18:53:38 +0100)

----------------------------------------------------------------
Two more gfs2 fixes

----------------------------------------------------------------
Andrew Price (1):
      gfs2: Flag a withdraw if init_threads() fails

Bob Peterson (1):
      gfs2: report "already frozen/thawed" errors

 fs/gfs2/super.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

