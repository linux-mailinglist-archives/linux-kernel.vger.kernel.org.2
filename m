Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149ED35923D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhDICxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhDICxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:53:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D537DC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 19:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=wLtcA8QU8tT40fNUxiK1kz20IjwOZBf7QGRvSG9uyV4=; b=URG+40JpkOR1AFCpQzOrgVKgAz
        o4BHIG/CC5pyoOdxRSvhVSoRkvh17LMORHdfSzBdNE8gxCoMfffcmRgGHlxwQsNI0UpShnKO+kZGh
        VTbBZY6Y5XNFlh9pk8CZXvgLEjmLaHq7jWZ3A8Kd15/8vtAHx7b3Tr+FrNNQLOcjlB1bElv3vTnPb
        aXg8oySUIv4NsFQB4Xon3mHm+Hpiu25k9evoC1tjMnFHQQ1F7qdF3MHQC2SaPOkfE6LhT0zhgQ5Id
        0LSL4dXk+VNsVoGOYsaAWGif8clwXWfSvRfjfrpj7X4nFiiUbO/2C19D1rZE99dUxFAxcZWLrGm/R
        GUXnZLNg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhFB-00HGHV-Uh; Fri, 09 Apr 2021 02:51:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/17] Provide lockdep tracking for bit spin locks
Date:   Fri,  9 Apr 2021 03:51:14 +0100
Message-Id: <20210409025131.4114078-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since bit spin locks are only a single bit, there's nowhere to put
a lockdep map.  Fortunately, all bit spin locks in the kernel are
conceptually in only a few classes of lock, and by introducing the
split_lock as somewhere to store the lockdep_map, we can track each bit
spin lock's dependencies.

This split_lock would also give us somewhere to queue waiters, should we
choose to do that.  Or a centralised place to handle PREEMPT_RT mutexes.
But I'll leave that for someone who knows what they're doing; for now
this keeps the same implementation.

Matthew Wilcox (Oracle) (17):
  x86: Rename split_lock_init to sld_init
  locking: Add split_lock
  bit_spinlock: Prepare for split_locks
  hlist_bl: Prepare for split_locks
  dm-snap: Add dm_exceptional_lock
  dcache: Add d_hash_lock
  fscache: Add cookie_hash_lock
  gfs2: Add qd_hash_lock
  mbcache: Add mb_cache_lock
  hlist_bl: Make the split_lock parameter mandatory
  s390: Add airq_iv_lock
  zram: Add zram_table_lock
  jbd2: Add jbd2_jh_lock
  slub: Add slab_page_lock
  zsmalloc: Add zs_pin_lock
  rhashtable: Convert to split_lock
  bit_spinlock: Track bit spin locks with lockdep

 arch/s390/include/asm/airq.h  |  5 +++--
 arch/x86/kernel/cpu/intel.c   |  6 +++---
 drivers/block/zram/zram_drv.c |  8 ++++---
 drivers/md/dm-snap.c          | 10 +++++----
 drivers/s390/cio/airq.c       |  3 +++
 fs/dcache.c                   | 25 +++++++++++-----------
 fs/fscache/cookie.c           | 13 ++++++------
 fs/gfs2/quota.c               |  5 +++--
 fs/jbd2/journal.c             | 18 +++++++++-------
 fs/mbcache.c                  | 25 +++++++++++-----------
 include/linux/bit_spinlock.h  | 39 ++++++++++++++++++++++++++++++-----
 include/linux/jbd2.h          | 10 +++++----
 include/linux/list_bl.h       | 15 ++++++++++----
 include/linux/rhashtable.h    | 20 +++++++-----------
 include/linux/split_lock.h    | 37 +++++++++++++++++++++++++++++++++
 lib/rhashtable.c              |  5 +----
 mm/slub.c                     |  6 ++++--
 mm/zsmalloc.c                 | 11 +++++++---
 18 files changed, 174 insertions(+), 87 deletions(-)
 create mode 100644 include/linux/split_lock.h

-- 
2.30.2

