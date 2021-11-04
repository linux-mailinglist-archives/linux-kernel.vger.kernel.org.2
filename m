Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDAC4455CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhKDPAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhKDPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:00:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67215C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 07:57:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u17so7609177plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OLcGDASkjqFAh2jkBmW+ReuKGptu7lZrBI/eCgVS/l0=;
        b=qAPEjfsyM+A/dv9FnCwRZ6j7b3t5bRWP0QKxRmqmaZoQ9oCcRMF0SiehXSNSFPaBKy
         N4s00SGKBb8Pbt2uK+5EXBVT/0IDYTE09OpE/LVacpFedTQAR4mz8EzeE20+C5fhiZsK
         wOyIShDDpJ+JtE4LPnqEteJua5SjNRN5qI36AhG+Va/J4t8TQGCfU3CJ7CMFUvaNGZqo
         mewtloZdmN9CAck5VgmrJJYjzNggo2HQ0xt7opFlymCECBZ3nYKGsshXXGcqvbt9IHec
         he7gfmAbOxKZRSqXzCsLEAFf9eW83JkCaXkJf+fk6uuiD2z4yk43ERvoLgWPDf3EsCtp
         rQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OLcGDASkjqFAh2jkBmW+ReuKGptu7lZrBI/eCgVS/l0=;
        b=PKzIDVWy1u0nIcB3ErFoqTtUwCxmWPMT7RW9Lvv5HLWuo+99IQtHNtO09G4YlOnGz/
         VcEPIIesJCsjAxKl04aSPM+SSrcbjebx2fab86A1838KMaQI/zNwMJ6HTMVkewF2H3Ez
         +B2eFvewBOpd363hJVS9xMu3whL5V7F0fABDPPY09/pmpW8pZibV9U1/GVK//nQo6o4h
         aEjEv4TnAGaWOfsmi6332ie1vOFgjGruOI+pFPU+l5AwTRZf2+3FqJhu0eNqxq3AiHLC
         PVVqUJfeny8Hg4VLjiVeRQLkkA6qGIIbrYNSxlb1yHQkO/QALQa3McaBzClB/RfaQB37
         yXqQ==
X-Gm-Message-State: AOAM530xXwhPwJuHxSv4n7JBWGxVcYkHuxqpX3HYsE4k2Uew2brGLRpy
        7a83DIqmjU7n8smAtir+Cz4=
X-Google-Smtp-Source: ABdhPJynLM6xiHWdejPh25khQxUB+kPHY90yTUv5bWXjPzgLzgUzOlYflWiCphnrDPuzJY50EJWRnA==
X-Received: by 2002:a17:90a:ae18:: with SMTP id t24mr22687446pjq.92.1636037852935;
        Thu, 04 Nov 2021 07:57:32 -0700 (PDT)
Received: from localhost.localdomain ([140.82.17.67])
        by smtp.gmail.com with ESMTPSA id t8sm4328530pgk.66.2021.11.04.07.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 07:57:32 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 0/4] sched: Introduce cfs_migration
Date:   Thu,  4 Nov 2021 14:57:09 +0000
Message-Id: <20211104145713.4419-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The active load balance has a known issue[1][2] that there is a race
window between waking up the migration thread on the busiest CPU and it
begins to preempt the current running CFS task. This race window may cause
unexpected behavior that the current running CFS task may be preempted
by a RT task first, and then the RT task will be preempted by this
waked migration thread. Per our tracing, the latency caused by this
preemption can be greater than 1ms, which is not a small latency for the
RT tasks.

We'd better set a proper priority to this balance work so that it can
preempt CFS task only. A new per-cpu thread cfs_migration is introduced
for this purpose. The cfs_migration thread has a priority FIFO-1,
which means it can preempt any cfs tasks but can't preempt other FIFO
tasks.

Besides the active load balance work, the numa balance work also applies
to CFS tasks only. So we'd better assign cfs_migraion to numa balance
work as well.

[1]. https://lore.kernel.org/lkml/CAKfTPtBygNcVewbb0GQOP5xxO96am3YeTZNP5dK9BxKHJJAL-g@mail.gmail.com/
[2]. https://lore.kernel.org/lkml/20210615121551.31138-1-laoar.shao@gmail.com/

Yafang Shao (4):
  stop_machine: Move cpu_stop_done into stop_machine.h
  sched/fair: Introduce cfs_migration
  sched/fair: Do active load balance in cfs_migration
  sched/core: Do numa balance in cfs_migration

 include/linux/stop_machine.h |  12 +++
 kernel/sched/core.c          |   2 +-
 kernel/sched/fair.c          | 143 ++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h         |   2 +
 kernel/stop_machine.c        |  14 +---
 5 files changed, 158 insertions(+), 15 deletions(-)

-- 
2.17.1

