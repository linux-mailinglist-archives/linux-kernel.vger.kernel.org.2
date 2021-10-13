Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE86142BCB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbhJMK0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbhJMKZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:25:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EF9C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:23:56 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y1so1475697plk.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yeogB2AYFfBDA00N8fw7JZEqJQQ4JOrzNq4vEhNhdKI=;
        b=cTxn0W0ZN0b4aR155FhrxxN/lFAuURdBK3UOdMSO90Qng+47m2xeprZa05v4+9k36W
         KSrFY9fdca4gcLWVxPmpned+she1rbC+go9L2wBWWtNhQJHXTHiYdiCRm95MaKfRFVq9
         VSVx0A/C8HgBRkBjaBmARTe05XdgZrhAAPObMSaWrF5oBVHRIWxPfCUaZYlwtIshgX7r
         Cr+T1J9w/wbZWuXkklz15lE4maJjGlaxJxOjIt1JVAIXPMSz6vkLY+MMQrEbTUmjizMm
         HPBt30ajV6XBdZuBliVbhSqvdnnQidi3y8icRPFev2htIYqSMR9cvLwOqjr1kUm6eYKz
         gPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yeogB2AYFfBDA00N8fw7JZEqJQQ4JOrzNq4vEhNhdKI=;
        b=yD+qm5S/fJ2NKxFNYmErM0ZUtSbIGyrKQQ2m9Oq+hRCoB/zLsIeM4z+66CcrjuCXGf
         mMQKplDP3Bh/B4qsIreFVuhNFKet7aTDzjL0otQBXmAb9W8yKXvdGJhSoCPRXkmSz4P3
         2RjX5wZWjU5ZCF5ZjAb3yX61Z1tw3TJV9y28d+gH4OPBGAsP4x59NEVchS6ttiIAdRbW
         6KHjq1Pb3ggGB4Pnr0p04IqoXgkPFmiWHhiznJg/YeTBrmp6FoLZZIECdaacQqknmLD5
         nclwLJUN41ukxfahEGPxSSx029vnhD9d5aGAsIIWbNRxUKqynUwNPxhbCONr/GqXk+za
         fx8Q==
X-Gm-Message-State: AOAM532Yxo0xDsxl1aLPdugXGl3dJyQ59srKQZmRaNQ5TCsmA5y5eD5Z
        3/SOB+9MuQaMSb4e4bWTn4Y=
X-Google-Smtp-Source: ABdhPJxz3JhQiftbAFzuZiR3Mi5yuz31Isk9z5XCgb/8pIEuvWYYlgRtuSZuePEDcO3weyNh0OtmAA==
X-Received: by 2002:a17:90a:ac14:: with SMTP id o20mr12452813pjq.219.1634120635464;
        Wed, 13 Oct 2021 03:23:55 -0700 (PDT)
Received: from vultr.guest ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id 184sm13900994pfw.49.2021.10.13.03.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:23:54 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     keescook@chromium.org, rostedt@goodmis.org, peterz@infradead.org,
        pmladek@suse.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, valentin.schneider@arm.com,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 0/5] task_struct: extend task comm from 16 to 24 for CONFIG_BASE_FULL
Date:   Wed, 13 Oct 2021 10:23:41 +0000
Message-Id: <20211013102346.179642-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset changes files among many subsystems. I don't know which
tree it should be applied to, so I just base it on Linus's tree.

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

After this patchset, the truncated kthreads listed above will be
displayed as:

    rcu_tasks_kthread
    rcu_tasks_rude_kthread
    rcu_tasks_trace_kthread
    poll_mpt3sas0_statu
    ext4-rsv-conversion
    xfs-reclaim/sdf1
    xfs-blockgc/sdf1
    xfs-inodegc/sdf1
    audit_send_reply
    ecryptfs-kthread
    vfio-irqfd-cleanup
    jbd2/nvme0n1p2-8

If the kthread's comm is still truncated, a warning will be printed.
Below is the result of my test case:

truncated kthread comm:I-am-a-kthread-with-lon, pid:14 by 6 characters

Changes since v3:
- fixes -Wstringop-truncation warning reported by kernel test robot

Changes since v2:
- avoid change UAPI code per Kees
- remove the description of out of tree code from commit log per Peter

Changes since v1:
- extend task comm to 24bytes, per Petr
- improve the warning per Petr
- make the checkpatch warning a separate patch

Yafang Shao (5):
  elfcore: use TASK_COMM_LEN instead of 16 in prpsinfo
  connector: use __get_task_comm in proc_comm_connector
  fs/exec: use strscpy instead of strlcpy in __set_task_comm
  sched.h: extend task comm from 16 to 24 for CONFIG_BASE_FULL
  kernel/kthread: show a warning if kthread's comm is truncated

 drivers/connector/cn_proc.c    | 5 ++++-
 fs/exec.c                      | 2 +-
 include/linux/elfcore-compat.h | 2 +-
 include/linux/elfcore.h        | 4 ++--
 include/linux/sched.h          | 4 ++++
 kernel/kthread.c               | 7 ++++++-
 6 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.17.1

