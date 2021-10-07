Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F72742528B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbhJGMKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhJGMJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:09:51 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1447C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 05:07:57 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r201so5484354pgr.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 05:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K6lt1mC6EArgKpheZppb0+evsrA+udkrMy50tagJwNs=;
        b=KVlDoOn328T+4wIgbkkefgu4gA5L6rmoxFLDmzmvSoZJ5cZi30PtBpGKRvjNM+S2aO
         TH8EPY27s3n1b7zGgcKrCGvUtRrqNKW/0zKqqyIoP+pUhmYebUXDcs8UwBJoF/ho7IV4
         GF3kIj5fksfp3vKB2Eop9o2o8/ENWNfCLjnRmy4kGJZ2yKz7tL5hrpLhPPJhfFHUzh7/
         xZad12vJywAeEqXtsbIwWOLwOpAig1W91xcrHWos1BmzTtZmF12YeRXgx07ahEhdsBAb
         f7ED8q3AyBbW1Db/rBY4/DONMZMHGgcsgvoI50XP1JMQmpY4ipvVYZqlg6S8DYKZSrk+
         X/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K6lt1mC6EArgKpheZppb0+evsrA+udkrMy50tagJwNs=;
        b=QYK9ZUSkkaLA55QE17RbKecZ3AoMQa4jv8zGGQpZ3GZPK06zKQHij8TV5yWye1M5i7
         QfR3M3gbcdQqihpe1X+TjJLEz0iXT2G912r8N76lYXLwgk+OlcKsH4nikpbfZ8Zs4NnY
         mN7J7omt74FqhUCUwivNUbXZS91XIphrNePlmBvY0nzvbkHH6FA0libGIHVeE7PhZGWT
         LGGMbVac3bZyhj/BQWiQEDMVP1DmfmfJjvIeb8ZhoSKJFa9odoMLiC+BRY6xO6i/JGcr
         AlPR4jxyH7EjgZgEGQopcGRHzYYzOrLdOLACnAfTA7ty32+jDz109pCfnVgwqPGoly7P
         zBjg==
X-Gm-Message-State: AOAM531ZFkG4pg4WSF/b00N5iHKQJzUM2kJJTHWMsT4B9TrAH8vg+zxc
        mSZcbe2gHSywBUCehIep6K8=
X-Google-Smtp-Source: ABdhPJw/EmxZtKGtc1B2jHDv7KVssfJr4PG7Q/aq7jKmj/d+i3HLtUIs5ZpewnBkuWQODvFyE7FK6g==
X-Received: by 2002:a62:6243:0:b0:44b:e10e:61b0 with SMTP id w64-20020a626243000000b0044be10e61b0mr3927102pfb.53.1633608477250;
        Thu, 07 Oct 2021 05:07:57 -0700 (PDT)
Received: from localhost.localdomain ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id c8sm23915582pfj.204.2021.10.07.05.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:07:56 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pmladek@suse.com, keescook@chromium.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, peterz@infradead.org,
        valentin.schneider@arm.com, mathieu.desnoyers@efficios.com,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, dietmar.eggemann@arm.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 0/4] task_struct: extend task comm from 16 to 24 for CONFIG_BASE_FULL 
Date:   Thu,  7 Oct 2021 12:07:48 +0000
Message-Id: <20211007120752.5195-1-laoar.shao@gmail.com>
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
    nvidia-modeset/

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

Besides the in-tree kthreads listed above, the out-of-tree kthreads may
also be truncated:

    rtase_work_queu
    nvidia-modeset/
    UVM global queu
    UVM deferred re
    ...

We should improve this problem fundamentally.

This patch extends the size of task comm to 24 bytes, which is the
same length with workqueue's, for the CONFIG_BASE_FULL case. And for the
CONFIG_BASE_SMALL case, the size of task comm is still kept as 16 bytes.

If the kthread's comm is still truncated, a warning will be printed.
Below is the result of my test case:

truncated kthread comm:I-am-a-kthread-with-lon, pid:14 by 6 characters

Changes since v1:
- extend task comm to 24bytes, per Petr
- improve the warning per Petr
- make the checkpatch warning a seperate patch

Yafang Shao (4):
  cn_proc.h: use TASK_COMM_LEN instread of 16 in struct proc_event
  fs/exec: use strscpy instead of strlcpy in __set_task_comm
  sched.h: extend task comm from 16 to 24 for CONFIG_BASE_FULL
  kernel/kthread: show a warning if kthread's comm is truncated

 fs/exec.c                    | 2 +-
 include/linux/sched.h        | 4 ++++
 include/uapi/linux/cn_proc.h | 2 +-
 kernel/kthread.c             | 7 ++++++-
 4 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.18.2

