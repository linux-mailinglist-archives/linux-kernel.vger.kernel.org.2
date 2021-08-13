Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2008F3EBE55
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 00:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbhHMWlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 18:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbhHMWlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 18:41:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AD9C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 15:41:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l18so15222858wrv.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 15:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corelight-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=reYkrPb9IzyQkLq8C5/o3ZHeHUXILqYSBFW9CW/iaEg=;
        b=l/rmRa4TunckKoum18VPmcgU4SK6ygKML7ri1OWg37RuUWiQeYCaiXLa51d68qO2iR
         f2+vspcc7DacXOEK1KV9Q/MXYXK5KCPCoA+e2cEfQgiWYKY3x2Y185Fno7skrcnCXZ0S
         TTuh0/Zd+kbcsRMlq6rpHwStRTg2wtQGDFf5wDCef6waal8YpDgSNHApjUr+t0rPCVLR
         U7+d7tTYA7bvQDAQN57jLNKOa8LlEEyWYnNVDLj+NesRG9wye/Zzuu+8mxd9XKp+/p+0
         nxEwh7fTUNnOaX73u1CuMFTa0A5oaFzQ06uZ8pbBXK6qZGxmsZIIkm7+adPjwpi69FUp
         F1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=reYkrPb9IzyQkLq8C5/o3ZHeHUXILqYSBFW9CW/iaEg=;
        b=LFH2jy3qNpDFbjntN7uUt3J6Ad3V+62/UctUrQnAjQSY/MHdutYnSFodL/UxZEo8o/
         +hpHAYklo5Ui0An0Ae1Xhns0lPpCmnSC/6KPp7cyOBr1fVkZyMxbDp+ggqW39/8EPwm9
         AL/qNlkIr41WPBLqKyh1VjG4oNx8DjSL9Ps9dyxyimEqVM7Ym6stOiAYAvFhM8O0xJVG
         dGay5Wc4owlUNZmxcN2WE66K3jqZy8aKxHl5hl8+7aI1NNwP6JHnQfuWZyAvoCgbKX8v
         fv0js+iU9aHJ16Z3bU3BKn+1jVRReTNrkF4a7IjPxxPZIfy3XunSvM0Dwymy0g3ieoxH
         5vwQ==
X-Gm-Message-State: AOAM5323ferPYLbpjCs1fh28OW43SAbcETbbBnvTTdlbPV+hnYDBsXKC
        3h/SMx4PQMzpzgU63VjTebyH3w==
X-Google-Smtp-Source: ABdhPJzdQ1qMd/+aRlJm0dV1lNAJiSUkcBHUbpqV18ATEIgrSACwRjHZNPq+aB23b2WCAjYZbR7QOg==
X-Received: by 2002:adf:a3cb:: with SMTP id m11mr5533190wrb.268.1628894475354;
        Fri, 13 Aug 2021 15:41:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:8440:5da4:6c41:9e8b:2e76:271])
        by smtp.gmail.com with ESMTPSA id q75sm2863867wme.40.2021.08.13.15.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 15:41:14 -0700 (PDT)
From:   Arne Welzel <arne.welzel@corelight.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     linux-kernel@vger.kernel.org, DJ Gregor <dj@corelight.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v2] dm crypt: Avoid percpu_counter spinlock contention in crypt_page_alloc()
Date:   Sat, 14 Aug 2021 00:40:38 +0200
Message-Id: <20210813224038.2055684-1-arne.welzel@corelight.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with many cores using dm-crypt, heavy spinlock contention in
percpu_counter_compare() can be observed when the page allocation limit
for a given device is reached or close to be reached. This is due
to percpu_counter_compare() taking a spinlock to compute an exact
result on potentially many CPUs at the same time.

Switch to non-exact comparison of allocated and allowed pages by using
the value returned by percpu_counter_read_positive() to avoid taking
the percpu_counter spinlock.

This may over/under estimate the actual number of allocated pages by at
most (batch-1) * num_online_cpus().

Currently, batch is bounded by 32. The system on which this issue was
first observed has 256 CPUs and 512GB of RAM. With a 4k page size, this
change may over/under estimate by 31MB. With ~10G (2%) allowed dm-crypt
allocations, this seems an acceptable error. Certainly preferred over
running into the spinlock contention.

This behavior was reproduced on an EC2 c5.24xlarge instance with 96 CPUs
and 192GB RAM as follows, but can be provoked on systems with less CPUs
as well.

 * Disable swap
 * Tune vm settings to promote regular writeback
     $ echo 50 > /proc/sys/vm/dirty_expire_centisecs
     $ echo 25 > /proc/sys/vm/dirty_writeback_centisecs
     $ echo $((128 * 1024 * 1024)) > /proc/sys/vm/dirty_background_bytes

 * Create 8 dmcrypt devices based on files on a tmpfs
 * Create and mount an ext4 filesystem on each crypt devices
 * Run stress-ng --hdd 8 within one of above filesystems

Total %system usage collected from sysstat goes to ~35%. Write throughput
on the underlying loop device is ~2GB/s. perf profiling an individual
kworker kcryptd thread shows the following profile, indicating spinlock
contention in percpu_counter_compare():

    99.98%     0.00%  kworker/u193:46  [kernel.kallsyms]  [k] ret_from_fork
      |
      --ret_from_fork
        kthread
        worker_thread
        |
         --99.92%--process_one_work
            |
            |--80.52%--kcryptd_crypt
            |    |
            |    |--62.58%--mempool_alloc
            |    |  |
            |    |   --62.24%--crypt_page_alloc
            |    |     |
            |    |      --61.51%--__percpu_counter_compare
            |    |        |
            |    |         --61.34%--__percpu_counter_sum
            |    |           |
            |    |           |--58.68%--_raw_spin_lock_irqsave
            |    |           |  |
            |    |           |   --58.30%--native_queued_spin_lock_slowpath
            |    |           |
            |    |            --0.69%--cpumask_next
            |    |                |
            |    |                 --0.51%--_find_next_bit
            |    |
            |    |--10.61%--crypt_convert
            |    |          |
            |    |          |--6.05%--xts_crypt
            ...

After applying this patch and running the same test, %system usage is
lowered to ~7% and write throughput on the loop device increases
to ~2.7GB/s. perf report shows mempool_alloc() as ~8% rather than ~62%
in the profile and not hitting the percpu_counter() spinlock anymore.

    |--8.15%--mempool_alloc
    |    |
    |    |--3.93%--crypt_page_alloc
    |    |    |
    |    |     --3.75%--__alloc_pages
    |    |         |
    |    |          --3.62%--get_page_from_freelist
    |    |              |
    |    |               --3.22%--rmqueue_bulk
    |    |                   |
    |    |                    --2.59%--_raw_spin_lock
    |    |                      |
    |    |                       --2.57%--native_queued_spin_lock_slowpath
    |    |
    |     --3.05%--_raw_spin_lock_irqsave
    |               |
    |                --2.49%--native_queued_spin_lock_slowpath

Suggested-by: DJ Gregor <dj@corelight.com>
Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Arne Welzel <arne.welzel@corelight.com>
---

v2: Change condition from > to >=, update patch description

 drivers/md/dm-crypt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 50f4cbd600d5..8c0c3d1f54bb 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2661,7 +2661,12 @@ static void *crypt_page_alloc(gfp_t gfp_mask, void *pool_data)
 	struct crypt_config *cc = pool_data;
 	struct page *page;
 
-	if (unlikely(percpu_counter_compare(&cc->n_allocated_pages, dm_crypt_pages_per_client) >= 0) &&
+	/*
+	 * Note, percpu_counter_read_positive() may over (and under) estimate
+	 * the current usage by at most (batch - 1) * num_online_cpus() pages,
+	 * but avoids potential spinlock contention of an exact result.
+	 */
+	if (unlikely(percpu_counter_read_positive(&cc->n_allocated_pages) >= dm_crypt_pages_per_client) &&
 	    likely(gfp_mask & __GFP_NORETRY))
 		return NULL;
 
-- 
2.20.1

