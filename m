Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49499445ACB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 20:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhKDUAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 16:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhKDUAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 16:00:48 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB36C061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 12:58:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id l3so4924666pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vuCt9AADoX+KE8RwAMppULbU69yu+KMFmMlPzvldw0A=;
        b=RtBgCuisgtMAvqQuwqPxumatdbc6iy2ebCURPV+sx7JsapFwfEDpg2Crb6Pw/VRQ3d
         gz6OuCg0CPqG/GgGvwV5t0ZJkS7XHol/EK3tp1MDePVUg9iZYnYI2Wl3Dj4NY4VLNJYn
         Cp/40yEncJTi+aEetB93uwAUANHZja1+lhkkjUEg6+uGuJWn9Rm/ouGoPB83yH3k44ez
         jNpSq9iovOXLH2Yf9zU7+K5mFXw6WNG8ZokeULaPeg7Q/Y1MvQboI3kTRHJJUi7gfeZb
         AQ4jBcmpvLbOCaCQMRS0ZmgQK2tb/RwrUFSgRFUxwQNvPdSStFtezmG+EO8VOzLacmpr
         2zHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vuCt9AADoX+KE8RwAMppULbU69yu+KMFmMlPzvldw0A=;
        b=Gw4ekpvNU+mjCo4Inn4stsPf942xaT+ep8ytkoU9Lh0EAVtrD0oqhfntmLE3GEvH3Q
         xyMBJuqqsLSyxPr1rNvoeNHuLm3fVD/WL4+Ik8nZeEPP3hpU1I4x1eNOQ4h6lk0UFhA2
         3evgRgcluhSHix/MbuMFpPkRhr+Csik4UgwCtVHNeBMUlhSjqG/6Yt/wMB2X7hfb58lC
         22jly/+n+33WUPJgC/hijYHuIko4zRV2dyb91NPwKNj0RLF5A6pmSKa89jryyIKDTtd7
         ogHWaCfXbCWeF0QvyheqLZUsWv6Z4xSN32nzO+n0gvGpe5WHFa3+9UFOWHHpf8WwCfnA
         m+2A==
X-Gm-Message-State: AOAM533BWd3B4l24QzQpnXl26SoYNOVbkFEVH0nEldVwoYoMdJrWPkHX
        0HDPZY/Z/dHdfrUrB93q1t+ePA==
X-Google-Smtp-Source: ABdhPJyl57LyLIeBB16p5BTph0mr8XHpKbrQS9TmDzXCs+4x0OcRQ1aItWJBA2Z+togJ+PGlK6wUUA==
X-Received: by 2002:a63:2c8:: with SMTP id 191mr39910180pgc.293.1636055889635;
        Thu, 04 Nov 2021 12:58:09 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id w185sm5487853pfb.38.2021.11.04.12.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 12:58:09 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [PATCH v0.8 0/6] sched,mm,x86/uaccess: implement User Managed Concurrency Groups
Date:   Thu,  4 Nov 2021 12:57:58 -0700
Message-Id: <20211104195804.83240-1-posk@google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User Managed Concurrency Groups (UMCG) is an M:N threading
subsystem/toolkit that lets user space application developers implement
in-process user space schedulers.

Key changes from the previous patchset
https://lore.kernel.org/all/20211012232522.714898-1-posk@google.com/:

- added libumcg tools/lib/umcg;
- worker "wakeup" is reworked so that it is now purely a userspace op,
  instead of waking the thread in order for it to block on return
  to the userspace immediately;
- a couple of minor fixes and refactorings.

These big things remain to be addressed (in no particular order):
- support tracing/debugging
- make context switches faster (see umcg_do_context_switch in umcg.c)
- support other architectures
- cleanup and post selftests in tools/testing/selftests/umcg/
- allow cross-mm wakeups (securely)


Peter Oskolkov (6):
  sched/umcg: add WF_CURRENT_CPU and externise ttwu
  mm, x86/uaccess: add userspace atomic helpers
  sched/umcg: implement UMCG syscalls
  sched/umcg, lib/umcg: implement libumcg
  sched/umcg: add Documentation/userspace-api/umcg.txt
  sched/umcg, lib/umcg: add tools/lib/umcg/libumcg.txt

 Documentation/userspace-api/umcg.txt   |  598 ++++++++++++
 arch/x86/entry/syscalls/syscall_64.tbl |    2 +
 arch/x86/include/asm/uaccess_64.h      |   93 ++
 fs/exec.c                              |    1 +
 include/linux/sched.h                  |   71 ++
 include/linux/syscalls.h               |    3 +
 include/linux/uaccess.h                |   46 +
 include/uapi/asm-generic/unistd.h      |    6 +-
 include/uapi/linux/umcg.h              |  137 +++
 init/Kconfig                           |   10 +
 kernel/entry/common.c                  |    4 +-
 kernel/exit.c                          |    5 +
 kernel/sched/Makefile                  |    1 +
 kernel/sched/core.c                    |   12 +-
 kernel/sched/fair.c                    |    4 +
 kernel/sched/sched.h                   |   15 +-
 kernel/sched/umcg.c                    |  949 +++++++++++++++++++
 kernel/sys_ni.c                        |    4 +
 mm/maccess.c                           |  264 ++++++
 tools/lib/umcg/.gitignore              |    4 +
 tools/lib/umcg/Makefile                |   11 +
 tools/lib/umcg/libumcg.c               | 1201 ++++++++++++++++++++++++
 tools/lib/umcg/libumcg.h               |  299 ++++++
 tools/lib/umcg/libumcg.txt             |  438 +++++++++
 24 files changed, 4166 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/userspace-api/umcg.txt
 create mode 100644 include/uapi/linux/umcg.h
 create mode 100644 kernel/sched/umcg.c
 create mode 100644 tools/lib/umcg/.gitignore
 create mode 100644 tools/lib/umcg/Makefile
 create mode 100644 tools/lib/umcg/libumcg.c
 create mode 100644 tools/lib/umcg/libumcg.h
 create mode 100644 tools/lib/umcg/libumcg.txt


base-commit: 8ea9183db4ad8afbcb7089a77c23eaf965b0cacd
--
2.25.1

