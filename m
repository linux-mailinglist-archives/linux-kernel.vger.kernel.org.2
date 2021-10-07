Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70EC425291
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbhJGMKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241151AbhJGMJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:09:55 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09E8C061762
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 05:08:01 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id a73so5528163pge.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5V/J1/aXDGVV4wyqf1r6JVjxcMSRd0cNHZIq8gu/D4I=;
        b=q1jsaFLjFvCjOHeVtRFHGwUTQR06+C2Ay/fody6XeFxE2m77CwnzN375ExkkN96df3
         /AcMSnF0r0VER3DgwOy5IG1+MiNm7vBFoA1hGkod1hym4Drz82l9Y0w2BOQeFOBXZ2pV
         NrvrtHDh3SFKKdRC3D8M0g6iBjJ9NvOAy9DLz88efuCqK9jY0xPWKOWcb/yyeWVsjjZL
         wrrNO8LtbuVpmHC4N7KimcXTwfNNO9Y3DAUIhzNRQ6O6YbQ5vbek6f5lvWGhx4tyC4ju
         lDDVmcu5zB15YLlyepUKGtEo0Foban1uMpG/o4ulTM1fNapTnxbM/tpPPc8prh/f1kdr
         Ds7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5V/J1/aXDGVV4wyqf1r6JVjxcMSRd0cNHZIq8gu/D4I=;
        b=nOU4aWYr1z/tX7NC/pAOf6rv8BiUGyQMOwzg0ZmwmZsEQ4pJbKwrXSn57GHMbl3ivH
         6FCd2GW4NVhMizLnwNXr2RW2V6Zw9uA2l5RxkoxUFCBtVcU58EHNZIJyZdXXp99EE3+R
         NvqSQeJXvDVSS/3RGZR3nlh+NqBnx8EjEryA2d1/gDhh/wCvhYh2y8kzyRXYDONuDE81
         agCEOq2iA3/7v+m3uqzKfa32ZodM0WaJVP7i2EZMBBAiLHfVWwFukUYr+u8tsaq7Ofgl
         7GPwrCtLKKGfXwICfC1Nl8At2TNeRX8Wl/tnClfbN1sy4Q+9DvWNUyuK8TWayKHpzbTm
         ndXA==
X-Gm-Message-State: AOAM532/4rWZFzdIvvrbjYcZsCaCuQVxtDIxGFe9DlsHYhBk9zOZxwkD
        bIeNLkW4MkDKWf6iYFkkCQI=
X-Google-Smtp-Source: ABdhPJz3bCEDTJnavY3w1N/mcBERy6ktAD3DlOkQlsbWTFYCM3/vbQxM7vBaNZ8Ot8U9QR3SuvnJJA==
X-Received: by 2002:aa7:8d53:0:b0:44b:fcd8:112 with SMTP id s19-20020aa78d53000000b0044bfcd80112mr4072029pfe.26.1633608481413;
        Thu, 07 Oct 2021 05:08:01 -0700 (PDT)
Received: from localhost.localdomain ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id c8sm23915582pfj.204.2021.10.07.05.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:08:01 -0700 (PDT)
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
Subject: [PATCH v2 3/4] sched.h: extend task comm from 16 to 24 for CONFIG_BASE_FULL
Date:   Thu,  7 Oct 2021 12:07:51 +0000
Message-Id: <20211007120752.5195-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211007120752.5195-1-laoar.shao@gmail.com>
References: <20211007120752.5195-1-laoar.shao@gmail.com>
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

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Petr Mladek <pmladek@suse.com>
---
 include/linux/sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 39039ce8ac4c..e0796068dee0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -275,7 +275,11 @@ struct task_group;
 #define get_current_state()	READ_ONCE(current->__state)
 
 /* Task command name length: */
+#if CONFIG_BASE_SMALL
 #define TASK_COMM_LEN			16
+#else
+#define TASK_COMM_LEN			24
+#endif
 
 extern void scheduler_tick(void);
 
-- 
2.18.2

