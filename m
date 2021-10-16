Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECC2430252
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 13:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbhJPLNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 07:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240148AbhJPLNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 07:13:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABB8C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 04:11:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c29so10652668pfp.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 04:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x0vWRzgiWACwH353KgAyIN1/PD+WRG4Iv6Om8IzybD0=;
        b=c0ib3z8xefMiEmiPcm5PoNwzhIQf33HDFNVe3QQBgkjXCZkPODj4KJiiUim3AcFe/9
         xFcUsQf4tb/fPWlhmGq8EdNe6p5I4B8/3/ZjMxKCuE1vrQ7YgahqOtUXc+WGG+iA9BLO
         9vD8/CPqLiSgc5j+tBxdDzlBuusvr8rbYqxsNZdGybrlEOXoDcIVCxD9h3r3dhaOWmUt
         dc6kEC4Z2cx4yWRrY5CuCm1arkyNgRJ8PJJc24D1yazEmDnI679PUReeoaCGRGjEzVin
         HmGHJsXLg5RsMzO0dPkLD9gTbt7q+KX0edBZucxnkCA8WAqI+3+S7ZxfIYufd2RkV0t/
         YvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x0vWRzgiWACwH353KgAyIN1/PD+WRG4Iv6Om8IzybD0=;
        b=6H3gTJ6FqViDVQZJM4Ergt109d7AcS6glpfQ4WsnDGi+o7axMocwGOnfQUi1UjGbK/
         3ZTHzVrNnc1nhOIAZJ4OhgCflFg0dObpj7T6bmUwkl7Wdk60imx6B1JPc7I+0HX0lLV4
         UNSEC3QP+AXtYCZK506hZEmrcynw7XP1YPX8jGTyt1Hxqrt+ukoBhuxEkz9DxxDp3AjA
         AMydL7c/gXesQVabe74G8aJ/LKONNC3ZyxoIElWXb4FCz61IcomN4mABgnWIiWmZG3ce
         fWAVG0X++8t8r0Wsa08Tq1vdn1KqjvdY5SvPfhF68g+bL/BCQDT1nMGeNEJLPxSZ0DSf
         uL8Q==
X-Gm-Message-State: AOAM53053v66vwOnGKskapeQeLEwHMVjv01JJwl0W/rtLpQGwemGFQKQ
        XNfB0eBsLBa2uOXLIWnlR6M=
X-Google-Smtp-Source: ABdhPJw67lDQDxfFbB6L2jDdPf2UNYS3gBHFShotIDGRoUF4dFgYWmQ47t04g1MswQ3mfKx38z6CvA==
X-Received: by 2002:aa7:9f8f:0:b0:44c:cf63:ec7c with SMTP id z15-20020aa79f8f000000b0044ccf63ec7cmr17224152pfr.77.1634382685826;
        Sat, 16 Oct 2021 04:11:25 -0700 (PDT)
Received: from baohua-VirtualBox.localdomain (203-173-222-16.dialup.ihug.co.nz. [203.173.222.16])
        by smtp.gmail.com with ESMTPSA id p20sm7751231pfw.124.2021.10.16.04.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 04:11:25 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, mgorman@suse.de, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        yangyicong@hisilicon.com, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v2] sched/fair: Document the slow path and fast path in select_task_rq_fair
Date:   Sat, 16 Oct 2021 19:11:09 +0800
Message-Id: <20211016111109.5559-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

All People I know including myself took a long time to figure out
that typical wakeup will always go to fast path and never go to
slow path except WF_FORK and WF_EXEC.
Vincent reminded me once in a linaro meeting and made me understand
slow path won't happen for WF_TTWU. But my other friends repeatedly
wasted a lot of time on testing this path like me before I reminded
them.
So obviously the code needs some document.

Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v2: refine according to Steven's comments, thanks!

 kernel/sched/fair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f6a05d9b5443..816c8ddf1b6d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6951,6 +6951,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 			break;
 		}
 
+		/*
+		 * Usually only true for WF_EXEC and WF_FORK, as sched_domains
+		 * usually do not have SD_BALANCE_WAKE set. That means wakeup
+		 * will usually go to the fast path.
+		 */
 		if (tmp->flags & sd_flag)
 			sd = tmp;
 		else if (!want_affine)
-- 
2.25.1

