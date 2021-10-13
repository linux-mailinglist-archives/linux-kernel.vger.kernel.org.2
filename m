Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8D342BCB6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhJMK0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbhJMK0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:26:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4C5C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:23:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id kk10so1853342pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cXGU1FgivtpbQOCuG+kADAWoAeGXN23a0S+JAEkjpg4=;
        b=cJZZYtf+ukMuwUhDeGIfx/8qAtStq8C9IyUqSfnwgxntj2iivjIM/0IbPolL0KaJ6A
         5dEL96Kc8/XXqRCrk2AGfxH66cNsvSVvc0cxSr9JCXr9LTnrh3TZmaT+XB/m/OyDSzwm
         /cDYmEJRehL1Fj4YFvLYYD1UL0fnS9Y3+B6lyvGG+kc4jZGrbNzab61AtchgQc775uP5
         Kuvrz02m8YVxHa391dv1LNthjcF3QXJHJY0GMlBLNIqbGJxSRUzlkM81CZcQypTQDP1/
         eua+QUDkc0aomkEGl17WyIPUpiYujUWhhB+LM40HkK+Z15wiX9LJcMrEZb0EWVOg0ZT/
         uFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cXGU1FgivtpbQOCuG+kADAWoAeGXN23a0S+JAEkjpg4=;
        b=GBFGnL61NXnKQtEYgsYN3xi+o6DDZnT+Q92SzI9hIskfM/SGJu4vQN4JYuS0+gpXDo
         rSlMsrjjvvpEZe0D+Xjd1RDbSsRLmW2/CuUpr9qNBFoBdJjZ5oCUfkoL2rFELJQrbSfY
         HfLMAVvXbm0pLTnY3J1iKNaI1Sa1QARX2W5IXVsfZoyPC6EsZl/MUSqefHrKoxPbJY0Q
         LzYwGFtGRkP8pvricNF3AK4Ho3RBw0s1MuJbJQtm7FWB8Az51OTTmeeQ/jnN6ihhz6pU
         DJfG3XQ3GApDozjhaV6QUzIsmFDvKIKjBuu3t/sTic0jr0hMYN6cvA9xzYvVTGjc1ZOL
         b4Ag==
X-Gm-Message-State: AOAM531FkvOFtK+OeWNAyEEg9puTOgFsqOZDVYUqEghgbR/f0dhRu4lV
        dLLyDPZgMRGF23iFTwk2R1Y=
X-Google-Smtp-Source: ABdhPJzGKNspjxR8A8B7b44R+2o7lZ4ENaSPHVk9rrp3R4zCLs93/pe5c56/czCE8+OXMznekQZVYw==
X-Received: by 2002:a17:902:b492:b0:13f:4f30:88de with SMTP id y18-20020a170902b49200b0013f4f3088demr9676650plr.35.1634120636892;
        Wed, 13 Oct 2021 03:23:56 -0700 (PDT)
Received: from vultr.guest ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id 184sm13900994pfw.49.2021.10.13.03.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:23:56 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     keescook@chromium.org, rostedt@goodmis.org, peterz@infradead.org,
        pmladek@suse.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, valentin.schneider@arm.com,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 1/5] elfcore: use TASK_COMM_LEN instead of 16 in prpsinfo
Date:   Wed, 13 Oct 2021 10:23:42 +0000
Message-Id: <20211013102346.179642-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211013102346.179642-1-laoar.shao@gmail.com>
References: <20211013102346.179642-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported a -Wstringop-truncation warning after I
extend task comm from 16 to 24. Below is the detailed warning:

   fs/binfmt_elf.c: In function 'fill_psinfo.isra':
>> fs/binfmt_elf.c:1575:9: warning: 'strncpy' output may be truncated copying 16 bytes from a string of length 23 [-Wstringop-truncation]
    1575 |         strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This patch can fix this warning.

struct elf_prpsinfo was moved from include/uapi/linux/elfcore.h into
include/linux/elfcore.h in commit
1e6b57d6421f ("unexport linux/elfcore.h")

As it is not UAPI code, we can replace 16 with TASK_COMM_LEN without
worrying about breaking userspace things.

struct elf_prpsinfo is used to dump the task information in userspace
coredump or kernel vmcore. So I verified what will happen to vmcore if
I extend the size of TASK_COMM_LEN to 24. The result is that the vmcore
still work fine as expected, for example:

crash> ps
   PID    PPID  CPU       TASK        ST  %MEM     VSZ    RSS  COMM
>     0      0   0  ffffffff8501a940  RU   0.0       0      0  [swapper/0]
>     0      0   1  ffff996e00f81f80  RU   0.0       0      0  [swapper/1]
>     0      0   2  ffff996e00f80000  RU   0.0       0      0  [swapper/2]
>     0      0   3  ffff996e00f85e80  RU   0.0       0      0  [swapper/3]
>     0      0   4  ffff996e00f83f00  RU   0.0       0      0  [swapper/4]
      0      0   5  ffff996e00f8de80  RU   0.0       0      0  [swapper/5]
>     0      0   6  ffff996e00f8bf00  RU   0.0       0      0  [swapper/6]
>     0      0   7  ffff996e00f89f80  RU   0.0       0      0  [swapper/7]
>     0      0   8  ffff996e00f88000  RU   0.0       0      0  [swapper/8]
>     0      0   9  ffff996e00f93f00  RU   0.0       0      0  [swapper/9]
>     0      0  10  ffff996e00f91f80  RU   0.0       0      0  [swapper/10]
>     0      0  11  ffff996e00f90000  RU   0.0       0      0  [swapper/11]
>     0      0  12  ffff996e00f95e80  RU   0.0       0      0  [swapper/12]
>     0      0  13  ffff996e00f98000  RU   0.0       0      0  [swapper/13]
>     0      0  14  ffff996e00f9de80  RU   0.0       0      0  [swapper/14]
>     0      0  15  ffff996e00f9bf00  RU   0.0       0      0  [swapper/15]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Petr Mladek <pmladek@suse.com>
---
 include/linux/elfcore-compat.h | 2 +-
 include/linux/elfcore.h        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/elfcore-compat.h b/include/linux/elfcore-compat.h
index e272c3d452ce..8a52a782161d 100644
--- a/include/linux/elfcore-compat.h
+++ b/include/linux/elfcore-compat.h
@@ -43,7 +43,7 @@ struct compat_elf_prpsinfo
 	__compat_uid_t			pr_uid;
 	__compat_gid_t			pr_gid;
 	compat_pid_t			pr_pid, pr_ppid, pr_pgrp, pr_sid;
-	char				pr_fname[16];
+	char				pr_fname[TASK_COMM_LEN];
 	char				pr_psargs[ELF_PRARGSZ];
 };
 
diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index 2aaa15779d50..ff4e4e455160 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -65,8 +65,8 @@ struct elf_prpsinfo
 	__kernel_gid_t	pr_gid;
 	pid_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
 	/* Lots missing */
-	char	pr_fname[16];	/* filename of executable */
-	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
+	char	pr_fname[TASK_COMM_LEN]; /* filename of executable */
+	char	pr_psargs[ELF_PRARGSZ];	 /* initial part of arg list */
 };
 
 static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct pt_regs *regs)
-- 
2.17.1

