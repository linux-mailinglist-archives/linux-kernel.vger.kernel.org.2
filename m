Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398CD41C3C7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbhI2Lwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbhI2Lww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:52:52 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182A8C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:51:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so1698740pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7lAxAGUiUViEUeze6NDi0npPF5RWhw2Nj7DE+01MK9A=;
        b=o3EJYGCLVPwXaiPOrjGG9MJc/9vUJi6MmLsEAXSs+L0iRrLFwf+JxvX7dEtOV/Cmkz
         O6Rj0WRjMov80w5TyAVe9/AJXsss49Ca16COksMwEIerbEhXqgvY7Ai7g0Id+xChPWmK
         0hxflAvZqFlLkip59CFvFHxVlw+nd4Pclx89x7EsAX1Av89VvtviE3/1e1FYj+bkNDCG
         AMbUbyzQHSaPDDuVd/S3+PDWvs6gReeSoPfNsDY/a7xXDqhkYCwyTk/dYfKLIiUarSQL
         3c4rKmjtElclDIJjRXnTbTOf/JdD3wn+kFG91gr5AR3kn+ZiDhJRLBPEunYtwxrXo4iW
         DhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7lAxAGUiUViEUeze6NDi0npPF5RWhw2Nj7DE+01MK9A=;
        b=0nfSW/fOTEH8XI2oAN0pOfkfEn11K8ciiPYCWOs/tvJ49wT+Qc37yodk3bTjw0WZ7O
         8mDHmeHse0GuFAVq/qbb9PHmnFUTOlUAa/eDGTn41qRcszSWLwusTYwbq2uPFNs1SQt6
         CpNe8XxqH8drRXELoEQXUMG+B/awVeLZlnUf95lWjj9cPI9VlciGp4OalOo1q7Cxnk4D
         BW6QpJgApztAdWUhoiZ6/f8fg6McYG0YRuCiSfy4MJcZw4pyTEz1qXcoNmnXTAdfckNi
         QutpSyuJIAryoKKsHIHb22FhpBaZnUJWUVS94GcjdfN6P8kqG7p4wBxkzyxRSDijXYQm
         RFAw==
X-Gm-Message-State: AOAM530JyJ2T0gjzYvXx7qr4Lj+dFSCIsoDcXjyv0WBStyc5SMbz8s/S
        hLcDl9mdrKy6ZWOlEnl31im/gBizdilfLd3/
X-Google-Smtp-Source: ABdhPJxmS1a66qjsybl9c7ArVyhtXdODD3DeIXXU+RAJIniDhaH0FWwKpEIRKU/0LjAaypndWxMIJA==
X-Received: by 2002:a17:90a:7e90:: with SMTP id j16mr5836279pjl.139.1632916271562;
        Wed, 29 Sep 2021 04:51:11 -0700 (PDT)
Received: from localhost.localdomain ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id u12sm2403204pgi.21.2021.09.29.04.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 04:51:11 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org, pmladek@suse.com, peterz@infradead.org,
        valentin.schneider@arm.com, keescook@chromium.org,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, viro@zeniv.linux.org.uk,
        christian@brauner.io, dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 0/5] kthread: increase the size of kthread's comm
Date:   Wed, 29 Sep 2021 11:50:31 +0000
Message-Id: <20210929115036.4851-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I was implementing a new kthread cfs_migration [1], I found the
comm of it is trucated due to the limitation of TASK_COMM_LEN. After I
checked the other kthreads, I found some of them are also truncated, for
example,

    rcu_tasks_kthre
    rcu_tasks_rude_
    rcu_tasks_trace
    ecryptfs-kthrea
    vfio-irqfd-clea
    ext4-rsv-conver
    jbd2/nvme0n1p2-
    ...
    
Besides the in-tree kthreads listed above, the out-of-tree kthreads may
also be trucated, for example,
    
    rtase_work_queu
    nvidia-modeset/
    UVM global queu
    UVM deferred re
    ...
    
That motivates me to do this improvement.

This patch increases the size of ktread's comm from 16 to 24, which is
the same with workqueue's. After this change, the name of kthread can be
fully displayed in /proc/[pid]/comm, for example,
    
    rcu_tasks_kthread
    rcu_tasks_rude_kthread
    rcu_tasks_trace_kthread
    ecryptfs-kthread
    vfio-irqfd-cleanup
    ext4-rsv-conversion
    jbd2/nvme0n1p2-8
    ...
    
Because there're only a few of kthreads, so it won't increase too much
memory consumption.

After this improvement, if the comm of a kthread is still trucated, a
warning will be displayed. Below is the result of my test case -

__kthread_create_on_node:410: comm of pid 14 is truncated from "I-am-a-kthread-with-long-name" to "I-am-a-kthread-with-lon"

[1]. https://lore.kernel.org/lkml/YMmlAP%2FQhE6SWhCF@hirez.programming.kicks-ass.net/

Yafang Shao (5):
  kernel: replace sizeof(task->comm) with TASK_COMM_LEN
  kernel/fork: allocate task->comm dynamicly
  kernel/sched: improve the BUILD_BUG_ON() in get_task_comm()
  kernel: increase the size of kthread's comm
  kernel/kthread: show a warning if kthread's comm is still trucated

 arch/ia64/kernel/mca.c         |  6 +++---
 drivers/block/drbd/drbd_main.c |  2 +-
 drivers/hwtracing/stm/core.c   |  2 +-
 drivers/tty/tty_audit.c        |  2 +-
 fs/exec.c                      |  5 ++++-
 include/linux/sched.h          |  6 ++++--
 kernel/audit.c                 |  4 ++--
 kernel/auditsc.c               |  4 ++--
 kernel/capability.c            |  4 ++--
 kernel/fork.c                  | 26 ++++++++++++++++++++++++++
 kernel/futex.c                 |  2 +-
 kernel/kthread.c               |  8 ++++++--
 kernel/sys.c                   |  2 +-
 kernel/trace/blktrace.c        |  2 +-
 security/lsm_audit.c           |  4 ++--
 security/selinux/selinuxfs.c   |  2 +-
 security/yama/yama_lsm.c       |  2 +-
 sound/core/oss/pcm_oss.c       |  2 +-
 18 files changed, 60 insertions(+), 25 deletions(-)

-- 
2.17.1

