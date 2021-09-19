Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6275C410BB8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 15:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhISNOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 09:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhISNOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 09:14:18 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B724C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 06:12:53 -0700 (PDT)
Received: from localhost (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 252B2BF2677;
        Sun, 19 Sep 2021 15:12:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1632057170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aCl+VghzyEiyjUoK2790KFGP0asW0O8HexpK5Dl0aDY=;
        b=UMgO/lyGpAm5aWHQkE7Cx3jA4PYYN7nOLCUsyxMwBPQVVTAv/Xy0aHhzCJ6PAXfN5wIiZ4
        PR3NfiCZW3ydjZTOUJQc8/6qonJz0hl5gNyZtRZFQUdvIj1eLGUreOuDq2a2gpgAujuxmu
        wHqn8jfXkhTXahOuJQhEBjxTwzYAveY=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [RFC v2 PATCH 0/3] mm: common PAGE_SIZE shift macros
Date:   Sun, 19 Sep 2021 15:12:45 +0200
Message-Id: <20210919131248.489798-1-oleksandr@natalenko.name>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are various places where the K(x) macro (or its alternative and/or
counterpart) is defined. This submission gets rid of multiple definitions
and provides common ones.

Based on discussion with Miaohe Lin [1].

The patch is based on top of next-20210910 and is compile-tested using
allyesconfig.

RFC v1: [2].

Changes since RFC v1:

* change name from K(x) to PG2KB(x)
* also provide KB2PG(x)
* replace open-coded variants
* do not use separate header file for macro definitions

[1] https://lore.kernel.org/linux-mm/9161665.bUqNH3lxUD@natalenko.name/
[2] https://lore.kernel.org/lkml/20210901092149.994791-1-oleksandr@natalenko.name/

Oleksandr Natalenko (3):
  mm: add PG2KB/KB2PG helper macros
  mm: replace custom PG2KB/KB2PG macros with common ones
  mm: replace open-coded PG2KB/KB2PG variants with macros

 arch/alpha/kernel/setup.c                     |  3 +-
 arch/arc/include/asm/arcregs.h                |  4 +-
 arch/mips/mm/init.c                           |  2 +-
 arch/powerpc/platforms/pseries/cmm.c          | 17 ++--
 arch/s390/appldata/appldata_mem.c             | 19 ++--
 arch/x86/kernel/cpu/mtrr/cleanup.c            | 17 ++--
 block/blk-sysfs.c                             |  9 +-
 drivers/base/node.c                           | 69 ++++++++-------
 drivers/gpu/drm/v3d/v3d_debugfs.c             |  3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c |  5 +-
 drivers/md/md-bitmap.c                        |  4 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c           |  5 +-
 drivers/xen/xen-balloon.c                     | 11 ++-
 fs/ceph/addr.c                                |  2 +-
 fs/ceph/super.h                               |  3 +-
 fs/fs-writeback.c                             |  2 +-
 fs/nfs/write.c                                |  4 +-
 fs/nfsd/nfscache.c                            |  3 +-
 fs/proc/meminfo.c                             |  4 +-
 fs/proc/task_mmu.c                            |  3 +-
 include/linux/mm.h                            |  3 +
 include/trace/events/writeback.h              | 19 ++--
 kernel/debug/kdb/kdb_main.c                   |  3 +-
 kernel/events/core.c                          |  2 +-
 kernel/fork.c                                 |  2 +-
 mm/backing-dev.c                              | 22 +++--
 mm/hugetlb.c                                  |  2 +-
 mm/memcontrol.c                               | 18 ++--
 mm/mmap.c                                     |  6 +-
 mm/nommu.c                                    |  4 +-
 mm/oom_kill.c                                 | 16 ++--
 mm/page-writeback.c                           |  4 +-
 mm/page_alloc.c                               | 86 +++++++++----------
 mm/shmem.c                                    |  3 +-
 mm/swap_state.c                               |  5 +-
 mm/swapfile.c                                 | 11 ++-
 mm/util.c                                     |  6 +-
 37 files changed, 197 insertions(+), 204 deletions(-)

-- 
2.33.0

