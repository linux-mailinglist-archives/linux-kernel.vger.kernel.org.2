Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750C841C3CC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbhI2LxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245408AbhI2LxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:53:06 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E52C061764
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:51:19 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s55so678523pfw.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CL49QUo9HYI72fDwHRYD3lUjf/75t+5Qskx/G3dBiUA=;
        b=H6EuR+xe4GuOCduiOa/30oUkjiNmor/2DPooMSeuG2VDhcFA7E2AMKr8nZfrIZeVMG
         usWziGQDjquhclUSb7mChITa2vJLfEVo5WWFNSRGA5I3T3ST2nmwRyo9CLdkMlkJfwPr
         14NnyOz84gGHeoQd1NUqHTbrZa50ZbvhrPbmoMd7/UL1qg5Ay5eKo9wdj4RvZx/NwFQe
         vKTjlV/cgqKNQ3coGYnwFr9pWGw0BjlI0M6q33PyCE/2vS+26R/Bl8hlXpd3Lv4vyCy4
         QY0MtZz+m9gzocQTqd/81z391mds5/voM5ROYlxLzXG1RzMsyUvKMxoeSDa7AKObpaHe
         DiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CL49QUo9HYI72fDwHRYD3lUjf/75t+5Qskx/G3dBiUA=;
        b=pVgOyu/J9X8CgLG2S7anypaILShtn01uaKwh6I64JPtNyQPrPBMLa/CAFmamGyOHMv
         A5Nxh8puReeppgxcbdmtig4e0+UGlo5ztHSZRd+FUGMvg+m8iCwDAm2sZ9wBbL+XFU/V
         TW+SWhNPWKwfCv9XpCUnD1cL7lXG2U0FOATGMD4hZi0vu6JEdg/D+KV+rT9B1jUwNmbV
         QMQ2OxjmtOf/dwV4ubllPqakYDGiFbAXaokYAOY64KnQtu51Mkf0v74Q9JJD+0qFTvmm
         oSYEzt9I0FSTSbyGU+cEP1f3Wx2V9t3LY88cPxbbWerPhLAIO6MpIUvjzu01PoO1wgIC
         DRCA==
X-Gm-Message-State: AOAM5336/oN9FLpASDkUpwHSq76G7jYOTEE6uP8j0/+hhu6C6YhbGWGQ
        BZZCc/ItrMq8GYo7yDDjuMY=
X-Google-Smtp-Source: ABdhPJxhG+8of1VjOuXy1QciDFB4fw4tURub1ZT97WTYA9u7d/jSMuB1db/wWwmW6wLhvKWFazbHHA==
X-Received: by 2002:a63:7542:: with SMTP id f2mr8992698pgn.64.1632916279179;
        Wed, 29 Sep 2021 04:51:19 -0700 (PDT)
Received: from localhost.localdomain ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id u12sm2403204pgi.21.2021.09.29.04.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 04:51:18 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org, pmladek@suse.com, peterz@infradead.org,
        valentin.schneider@arm.com, keescook@chromium.org,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, viro@zeniv.linux.org.uk,
        christian@brauner.io, dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 5/5] kernel/kthread: show a warning if kthread's comm is still trucated
Date:   Wed, 29 Sep 2021 11:50:36 +0000
Message-Id: <20210929115036.4851-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210929115036.4851-1-laoar.shao@gmail.com>
References: <20210929115036.4851-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show a warning if the ktrhead's comm is still trucated. Below is the
result of my test case -

__kthread_create_on_node:410: comm of pid 14 is truncated from "I-am-a-kthread-with-long-name" to "I-am-a-kthread-with-lon"

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/kthread.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 6def951c605a..aa093f1f423a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -404,7 +404,11 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 		 * task is already visible to other tasks, so updating
 		 * COMM must be protected.
 		 */
-		vsnprintf(name, sizeof(name), namefmt, args);
+		if (vsnprintf(name, KTHREAD_COMM_LEN, namefmt, args) >=
+		    KTHREAD_COMM_LEN)
+			pr_warn("%s:%d: comm of pid %d is truncated from \"%s\" to \"%s\"\n",
+				__func__, __LINE__, task->pid, namefmt, name);
+
 		set_task_comm(task, name);
 		/*
 		 * root may have changed our (kthreadd's) priority or CPU mask.
-- 
2.17.1

