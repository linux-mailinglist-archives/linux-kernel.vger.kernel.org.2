Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA9E338779
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhCLIeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:34:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:34760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232321AbhCLIeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:34:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615538040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kpL+Xtl6biqMgc7I3UVtrZgaY5rgIReHpDQzGV19roM=;
        b=is0Vpu7wzLDbgPxrjU0azVYRPXXlKjoS7/kJNwO/QJ8BbtsTQmoNfz+jMVrAmxpcuddRUh
        FTb+YbXHma1xou0jd3NPhxw+J7Xm3fUVhtl2O2mGAbIkrI3IjZ6mopGmImMbOfpZTEb2Mx
        7RlvAUBhugZgJm2iUMLtXT1YJ7jZcRs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDA75AF33;
        Fri, 12 Mar 2021 08:34:00 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.12-rc3
Date:   Fri, 12 Mar 2021 09:34:00 +0100
Message-Id: <20210312083400.2594-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc3-tag

xen: branch for v5.12-rc3

It contains two patch series and a single patch:

- a small cleanup patch to remove unneeded symbol exports
- a series to cleanup Xen grant handling (avoiding allocations in some
  cases, and using common defines for "invalid" values)
- a series to address a race issue in Xen event channel handling


Thanks.

Juergen

 arch/arm/xen/p2m.c                   |   5 +-
 arch/x86/xen/p2m.c                   |   6 +-
 drivers/pci/xen-pcifront.c           |   4 +-
 drivers/xen/events/events_2l.c       |  22 ++++--
 drivers/xen/events/events_base.c     | 130 +++++++++++++++++++++++++++--------
 drivers/xen/events/events_fifo.c     |   7 --
 drivers/xen/events/events_internal.h |  14 ++--
 drivers/xen/gntdev.c                 |  54 +++++++++------
 include/xen/grant_table.h            |   7 ++
 include/xen/xenbus.h                 |   1 -
 10 files changed, 169 insertions(+), 81 deletions(-)

Jan Beulich (4):
      Xen: drop exports of {set,clear}_foreign_p2m_mapping()
      Xen/gntdev: don't needlessly allocate k{,un}map_ops[]
      Xen/gnttab: introduce common INVALID_GRANT_{HANDLE,REF}
      Xen/gntdev: don't needlessly use kvcalloc()

Juergen Gross (3):
      xen/events: reset affinity of 2-level event when tearing it down
      xen/events: don't unmask an event channel when an eoi is pending
      xen/events: avoid handling the same event on two cpus at the same time
