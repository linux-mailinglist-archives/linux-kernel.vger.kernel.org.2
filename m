Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0078E428075
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 12:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhJJK1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 06:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhJJK1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 06:27:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EC9C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 03:25:11 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h3so7977606pgb.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 03:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/NT2HD901PQQDBH9f9gxQxXHGc0D74RQkXj8xHEp+kc=;
        b=ACJe2bmk2COCA+07Ljco4Sm9i/+tOKtiz4zBqVnjwNFK1rxiKDH0xcNh+kUKV0UTBu
         dmYKPh/MGC5s9+QYH8cvkXi0WZ1/zmM0RQVFKIOSNSWGpEwUNTrh81zQql9S3DzUwgcN
         O1zs6gVI5pF8uXvN0VfjonOPGQcm2O9qSPu64/pprk1QYwed2o6WruLz9z6851LTGxQq
         76aePx25TgELz9/VQtwJYy7vB35YEHQdZNk/oJ8t/LZztZaIyYwX/lM4YTsxSnhNw6Vh
         Oa/Mpc0Ay6DVFMslHXpphgm18/vxXgQfXTft1hQF0UP5d4ZakcMPAB9bi/NSpAdIydCi
         aZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/NT2HD901PQQDBH9f9gxQxXHGc0D74RQkXj8xHEp+kc=;
        b=28WNvPy9rThn8kU8ktLfSwS29DArhq1YYCU5u3ojkrsS3S0tkwdtzGs0Kv/R1Y5asx
         VUn5bNZPuvwB/32zc8+EtgPGaS8XeNZvRTr3bSYARGLbQKfoCJAQIvCIuAWFzJWyBoDe
         JbHTqxMhsImm74ywFitORvxx9+1Vh1x4xq7KueS9HYeH9I1evxOl8Q6T08NR+Y6iStcz
         WCBne9djwqGiHtqrYe0MH1OkJBnL9n6AwJEpFTdfd/Xeh6W1SxiUHl4V6EBb8HfnskK1
         TbG8N+vVuwerO5E8RN/7m/FUDtqSbJyJZPVMjYbuQr8iqjHfbd87eMl8E3MjhCg2Q3cm
         wigg==
X-Gm-Message-State: AOAM5339OOFnYmN1istHa81+Z3aOjgzf2z6WpgJ43fUiSH1z3dGBQe43
        CIv7yYpfnqFs7lKw0/O5UoZM3PHk+W9X0Q==
X-Google-Smtp-Source: ABdhPJzZcxbE/kRh8y4hrI1csh5lbEqUaS5sMA5MbYiLDsGRyhM5Ph0U6evKdbkVQTaLv5mynq9DWg==
X-Received: by 2002:a62:5ac6:0:b0:44c:b979:afe3 with SMTP id o189-20020a625ac6000000b0044cb979afe3mr19725249pfb.61.1633861510847;
        Sun, 10 Oct 2021 03:25:10 -0700 (PDT)
Received: from vultr.guest ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id w4sm4347494pfb.3.2021.10.10.03.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 03:25:10 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     keescook@chromium.org, rostedt@goodmis.org, peterz@infradead.org,
        pmladek@suse.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, valentin.schneider@arm.com,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 0/4] task_struct: extend task comm from 16 to 24 for CONFIG_BASE_FULL 
Date:   Sun, 10 Oct 2021 10:24:25 +0000
Message-Id: <20211010102429.99577-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I was implementing a new per-cpu kthread cfs_migration, I found the
comm of it "cfs_migration/%u" is truncated due to the limitation of
TASK_COMM_LEN. For example, the comm of the percpu thread on CPU10~19 are
all with the same name "cfs_migration/1", which will confuse the user. This
issue is not critical, because we can get the corresponding CPU from the
task's Cpus_allowed. But for kthreads correspoinding to other hardware
devices, it is not easy to get the detailed device info from task comm,
for example,

    jbd2/nvme0n1p2-
    xfs-reclaim/sdf

We can also shorten the name to work around this problem, but I find
there are so many truncated kthreads:

    rcu_tasks_kthre
    rcu_tasks_rude_
    rcu_tasks_trace
    poll_mpt3sas0_s
    ext4-rsv-conver
    xfs-reclaim/sd{a, b, c, ...}
    xfs-blockgc/sd{a, b, c, ...}
    xfs-inodegc/sd{a, b, c, ...}
    audit_send_repl
    ecryptfs-kthrea
    vfio-irqfd-clea
    jbd2/nvme0n1p2-
    ...

We should improve this problem fundamentally.

This patch extends the size of task comm to 24 bytes, which is the
same length with workqueue's, for the CONFIG_BASE_FULL case. And for the
CONFIG_BASE_SMALL case, the size of task comm is still kept as 16 bytes.

If the kthread's comm is still truncated, a warning will be printed.
Below is the result of my test case:

truncated kthread comm:I-am-a-kthread-with-lon, pid:14 by 6 characters

Changes since v2:
- avoid change UAPI code per Kees
- remove the description of out of tree code from commit log per Peter

Changes since v1:
- extend task comm to 24bytes, per Petr
- improve the warning per Petr
- make the checkpatch warning a separate patch

Yafang Shao (4):
  connector: use __get_task_comm in proc_comm_connector
  fs/exec: use strscpy instead of strlcpy in __set_task_comm
  sched.h: extend task comm from 16 to 24 for CONFIG_BASE_FULL
  kernel/kthread: show a warning if kthread's comm is truncated

 drivers/connector/cn_proc.c | 5 ++++-
 fs/exec.c                   | 2 +-
 include/linux/sched.h       | 4 ++++
 kernel/kthread.c            | 7 ++++++-
 4 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.18.2

