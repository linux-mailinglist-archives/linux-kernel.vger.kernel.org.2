Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B94451945
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 00:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243746AbhKOXRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 18:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345664AbhKOT3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:29:01 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B763FC06BCE3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:13 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id h63so8499551pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zkv6ZeWrkPGfVjIvNRufUFYPR8C22KKcFHXHGoQQfM=;
        b=MSZTrc/Dtkd9s+c5q2H+/1XgbMcDCQb1Q40KnZqeU+D3xdrrofIa+BbGMjIuP4vRhw
         OeahPpVcc5l8VO2q756Gc43otXgdL7XTsLTZKuVU9JzV1U8ucmFZe3T4LzW3lT5+V0n+
         oWW9UgoziUndqjeGKNRIDC5IWx7egfCV0T0pRwI95TrmdSFnroDCvbTwGVsk3M4pBLA6
         d7Mp3D/A8DOjEGzvZu4KqC9UQoe4HDkI4qNmmDp3U4bW3dx34b1UKa/1CI/CAXIrjtYE
         NBbKwRtF+fNjdAInSJ7CPQB7mqgzrwsxolktA2SpgHuCXuVDTRG773dCQSU/afRTbmk1
         qUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=3zkv6ZeWrkPGfVjIvNRufUFYPR8C22KKcFHXHGoQQfM=;
        b=GqH/Vfps1Puxsu/LpTaCdZu438AcSZ54MPQI7TSVVoclcTo2CGW7rycKVH78P2vUo7
         PfZ+Cfv5Oop6dKSUmjLOPS8MRzVstmlTNF0jggeECrKgphhzpk6cRojWjW2jyGrAjbuz
         NkheOGQgNAiGyiDcDAS9ULkeN3xgR69Fy4cBGAXmUU4/WNiQORtRcG7OIVNz8gSSyTRL
         Bc/JOM0hRm/fzJcA92PUiYqLS3sQFVtf0vlsJW4P4BOD9teMZcQpWTydvciOoB4EY2eR
         C2ydNaRwp9MS4s90Z7S2fmJfjuKxNrYXufRb6/8JaDD/T+zbiwT2URN360BmNLST1L5Z
         2C/Q==
X-Gm-Message-State: AOAM532g9zaHxBWA6RVL0FQApFdz3vPFxGHCIQ8S99yJPM+zur+iJzzY
        W5reT83uW0WzJspGS9b0hlc=
X-Google-Smtp-Source: ABdhPJwHVXcGVJjYcqzZK5zRAo662qkjBYf7rwGxAqX/7UI005HLaUL6kXsahM1Ac3rxsA0i/s6UOA==
X-Received: by 2002:a63:311:: with SMTP id 17mr687161pgd.367.1637002753173;
        Mon, 15 Nov 2021 10:59:13 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7a54:8083:4365:b23d])
        by smtp.gmail.com with ESMTPSA id c3sm11882941pfv.67.2021.11.15.10.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 10:59:12 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 0/9] zsmalloc: remove bit_spin_lock
Date:   Mon, 15 Nov 2021 10:59:00 -0800
Message-Id: <20211115185909.3949505-1-minchan@kernel.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zsmalloc has used bit_spin_lock to minimize space overhead
since it's zpage granularity lock. However, it causes zsmalloc
non-working under PREEMPT_RT as well as adding too much
complication.

This patchset tries to replace the bit_spin_lock with per-pool
rwlock. It also removes unnecessary zspage isolation logic
from class, which was the other part too much complication
added into zsmalloc.
Last patch changes the get_cpu_var to local_lock to make it
work in PREEMPT_RT.

Mike Galbraith (1):
  zsmalloc: replace get_cpu_var with local_lock

Minchan Kim (8):
  zsmalloc: introduce some helper functions
  zsmalloc: rename zs_stat_type to class_stat_type
  zsmalloc: decouple class actions from zspage works
  zsmalloc: introduce obj_allocated
  zsmalloc: move huge compressed obj from page to zspage
  zsmalloc: remove zspage isolation for migration
  locking/rwlocks: introduce write_lock_nested
  zsmalloc: replace per zpage lock with pool->migrate_lock

 include/linux/rwlock.h          |   6 +
 include/linux/rwlock_api_smp.h  |   9 +
 include/linux/rwlock_rt.h       |   6 +
 include/linux/spinlock_api_up.h |   1 +
 kernel/locking/spinlock.c       |   6 +
 kernel/locking/spinlock_rt.c    |  12 +
 mm/zsmalloc.c                   | 529 ++++++++++++--------------------
 7 files changed, 228 insertions(+), 341 deletions(-)

-- 

* from v1 - https://lore.kernel.org/linux-mm/20211110185433.1981097-1-minchan@kernel.org/
  * add write_lock_nested for rwlock
  * change fromline to "Mike Galbraith" - bigeasy@

2.34.0.rc1.387.gb447b232ab-goog

