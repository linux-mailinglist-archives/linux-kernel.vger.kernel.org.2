Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C606C3A1B69
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 19:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhFIRDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 13:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhFIRDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 13:03:51 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCCFC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 10:01:42 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id v16-20020ae9e3100000b02903aafadba721so3162487qkf.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 10:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gAbjQDa4mdyt9r3TiygW/Y5fvIkKdDZmSQ6iH3e9KQo=;
        b=AR15xOpXijrZlC+c2iEcsAbXH10KEM6N2ueQ43N0MCtf8S/2A5QqZTa+l/BJDTUbaw
         coIuCxrlmI2pF0jmyQyQyLBkDWQZujKVsAZokuMlHF1/mSIynI9GdRYKVG/jT4V6Y27w
         CyIPAVshaLvozMCZbNUh/+nu0Cmt6bB4lUDZHulh90ZyONiZHOk4YVtxAwDjnnDsWqJi
         m82VrvnKNB8xAFyp9L2td/ihf6GQ/gKPuCMElL/ISU0YPCtcZzZ1FAA8hOLirQtvd4b+
         282d6FTcMbKnuty24zf2G4w1uZKI1cPyI8BC+IsneKRDLZgeuF04SBbPBuCIorBuaxC+
         DG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gAbjQDa4mdyt9r3TiygW/Y5fvIkKdDZmSQ6iH3e9KQo=;
        b=JnaX9bl1nkRIO6MLsdp8eR69cmzA1ZYa7/AyGw4dl8GLR1YnlfzC/hMV31juVrHAVI
         cERhQZA240ZbFUVOinitxyZhvsyeEYXUOS1BK6r0LM3zhQ8wNb4cEhtt4StjkCZK0bjw
         CeIR4IcVu4zieczcx6Sv8+k3U718FdI07XfffLuhimPgejFshaqa26s6PXJWFiIDtDua
         uiex5gsB5GGD6xw1qpA+2yYztrk06K10Xw79/tVeyRgSmLofDBxpoiH5V8cLtzCsWx3U
         WBVxzG4yE81Zn9H9uoVDcHhHyviqWi8MxfGllyysMwQ4WPc9zZU6Blhpk5P8weQFKIM3
         SWYg==
X-Gm-Message-State: AOAM531F5tyqhB8hEYxMFh8Y0Jp8Ql0mv7nO+dBNICoP/XuRQFyJGxCZ
        UANi6mDVG8t+Du0pbceddOPV7CejNzZH
X-Google-Smtp-Source: ABdhPJzhoDycsMjVdG7s77f+IZJc4KpyXjCfwpstT94w027uVkgUGgOCf3T+E5yumY9edeGN9kvqhxS6Zxqh
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:fa91:: with SMTP id
 o17mr764372qvn.59.1623258101904; Wed, 09 Jun 2021 10:01:41 -0700 (PDT)
Date:   Wed,  9 Jun 2021 17:01:32 +0000
Message-Id: <20210609170132.1386495-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH] sched: Skip priority checks with SCHED_FLAG_KEEP_PARAMS
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCHED_FLAG_KEEP_PARAMS can be passed to sched_setattr to specify that
the call must not touch scheduling parameters (nice or priority). This
is particularly handy for uclamp when used in conjunction with
SCHED_FLAG_KEEP_POLICY as that allows to issue a syscall that only
impacts uclamp values.

However, sched_setattr always checks whether the priorities and nice
values passed in sched_attr are valid first, even if those never get
used down the line. This is useless at best since userspace can
trivially bypass this check to set the uclamp values by specifying low
priorities. However, it is cumbersome to do so as there is no single
expression of this that skips both RT and CFS checks at once. As such,
userspace needs to query the task policy first with e.g. sched_getattr
and then set the clamp values accordingly, which is racy, and slower
than a single call.

As the priority and nice checks are useless when SCHED_FLAG_KEEP_PARAMS
is specified, simply inherit them in this case to match the policy
inheritance of SCHED_FLAG_KEEP_POLICY.

Reported-by: Wei Wang <wvw@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3b213402798e..1d4aedbbcf96 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6585,6 +6585,10 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 	rcu_read_unlock();
 
 	if (likely(p)) {
+		if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS) {
+			attr.sched_priority = p->rt_priority;
+			attr.sched_nice = task_nice(p);
+		}
 		retval = sched_setattr(p, &attr);
 		put_task_struct(p);
 	}
-- 
2.32.0.272.g935e593368-goog

