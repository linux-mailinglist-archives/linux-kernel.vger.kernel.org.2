Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080FA32BAA1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbhCCLip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352583AbhCCD4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 22:56:43 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368F3C061797
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 19:47:08 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id a23so5524832pga.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 19:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFyGg6KNGzSfRYjZ76byOcmhxoc8vO+7hPNjo35K9rQ=;
        b=KVd56+eSRCDSoGMKAfjcnD/9taVnzDzrPgvXdUvZaRvPmqNGKQ7ZpVzc6P8HsGBInY
         Hmwjk22pg8yHMG915IOi8jslPZEnFZcZq1EOdGq0dmaOQNsbtddD691QKlxC54K6kG/V
         a2ZZfQL2p5ABe+FLMXtab8y6Omx8n1L4R2UBMimaPhLmM4xtvroe6cdontcR+9yznLqm
         ffZDnEomZho3TV6ljauyUkg7C7LJw+SZXyd4JTJy3qxRmpz1jHW1efuzN58ML+TXGqbc
         74wfb42CudBDNZQECztn97ssrbzHTFqTlHrCWREOEqP2PNvnC2LdECInQ7HnrUH9yssj
         Dc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFyGg6KNGzSfRYjZ76byOcmhxoc8vO+7hPNjo35K9rQ=;
        b=CkYQbvsaGxr36txCWZvpiy1WvspjvXrYUE3NR3Tfc6jvetVgh5XP17qVIxYTNioC7a
         U3vqb/wzSX7gDQS7lfiRyrvFu3HF4yyxtYM0/d0iv2r7OdDZCW+/lGnSnDj+UAqH903a
         tBD9hNxM3ZeLKno9uzUnKkPjbSAS/u6W35ePcpa4FrBkTM7w1S9E2Nj+uKeLpNpxEsAi
         XmYKf7uuxJbGXLzqk+KED3cACdFwM0lsZL/REvbDLkz1cAmmySP3TX9pVa9vtty635kH
         XFvRMj74xuHHE44Q2UjmCmxrZ728wN4h6VBOpIr4dnPUOnpnW52sapU7saT30ExLIQds
         9KrA==
X-Gm-Message-State: AOAM533ublrusF3LhagOTw2BTPqMhAYn4UGyGbfGJtgRkA8riix374tm
        6fKhoWDUXzYvhdzVsQje/epSHw==
X-Google-Smtp-Source: ABdhPJyOhqMPZbj3lBnGpDBFc9h5xjqToYA3/nBhw1Nw1+wQ6qW7FvP28wZNfzgZfmiGkZ6BOjG0cQ==
X-Received: by 2002:aa7:8e43:0:b029:1ed:447c:f1d4 with SMTP id d3-20020aa78e430000b02901ed447cf1d4mr1361460pfr.16.1614743227772;
        Tue, 02 Mar 2021 19:47:07 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id p26sm23029703pfn.127.2021.03.02.19.47.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 19:47:07 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
Subject: [PATCH v2 0/4] psi: Add PSI_CPU_FULL state and some code optimization
Date:   Wed,  3 Mar 2021 11:46:55 +0800
Message-Id: <20210303034659.91735-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is RESEND of the previous patches on psi subsystem. A few
weeks passed since the last review, so I put them together and resend for
more convenient review and merge.

Patch 1 add PSI_CPU_FULL state means all non-idle tasks in a cgroup are delayed
on the CPU resource which used by others outside of the cgroup or throttled
by the cgroup cpu.max configuration.

Patch 2 use ONCPU state and the current in_memstall flag to detect reclaim,
remove the hook in timer tick to make code more concise and maintainable.
And patch 3 adds unlikely() annotations to move the pressure state branches
out of line to eliminate undesirable jumps during wakeup and sleeps.

Patch 4 optimize the voluntary sleep switch by remove one call of
psi_group_change() for every common cgroup ancestor of the two tasks.

Chengming Zhou (3):
  psi: Add PSI_CPU_FULL state
  psi: Use ONCPU state tracking machinery to detect reclaim
  psi: Optimize task switch inside shared cgroups

Johannes Weiner (1):
  psi: pressure states are unlikely

 include/linux/psi.h       |   1 -
 include/linux/psi_types.h |   3 +-
 kernel/sched/core.c       |   1 -
 kernel/sched/psi.c        | 122 ++++++++++++++++++++++++----------------------
 kernel/sched/stats.h      |  37 +++++---------
 5 files changed, 78 insertions(+), 86 deletions(-)

-- 
2.11.0

