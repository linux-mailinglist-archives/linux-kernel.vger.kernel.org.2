Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE033B73C3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhF2OIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhF2OIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:08:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A51C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:05:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ce18-20020a17090aff12b0290170a3e3eb07so2512749pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3UTa2eg07jfcL9W50dNKGQDfKdHemYOq9gs9MdnqBDw=;
        b=G/WJV/f6ClkjWXPMI8y+pjwjv7BRahbBuka23Z9OAwDSVHMs6+HqjriNKvUjGnxVk+
         pYP/7f9vKdi6kBrQXKv4ZecVsT0r2j6D/igp4N29WLAaPeDaeReyIRInkrqRBt8xw2eL
         jMJI99fQrOCHhJFSybptuNOjtIz3w07DYpG4A1iwpwcAvJtPCVfsiT43afl2RRcNJ/XT
         VlctjWm/yhf8tQI1PoZbVXZ5t16KhOfDAzfrj1z24wBhuZ740f59PLXLCq3O43GXGTEr
         /0ZN1PSfjCJJqKeLap/WFWJtvud+pXId168qP8CjGG7SgG1IRPvZ6KvI17Sp53rKjr+3
         6vuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3UTa2eg07jfcL9W50dNKGQDfKdHemYOq9gs9MdnqBDw=;
        b=cxGTSP8MyXJjtHVz2d+AP6Bc9+3R6m6sdHq2V57BXQHpQg7riZS797j4mlhoh4/Idp
         w8J0GHUyt6neoNGCyG4j7irK7bedVnoFH0VNFe4ei5CcLUixmjgSSieyVw95o+0Vm14W
         UUR9GhzWFpIN04/5zknKp2Y5WgOQzIi5SIPoY3SJWMGNmfvnj7Zxpc04+9QCqj6ACYpu
         E82EeR7c7YIS7HCMTpxL/k5oMBSgsI5Rcf1KsIehd6540YLNxOe845TpiRYG6O5Umum7
         02T0y6II2Dxf0pvg80zNMNFiF8LAd8FZMagfp2LkF/ZQbcaoVwcdEkB+sWEBPcEMVzNN
         CzHA==
X-Gm-Message-State: AOAM532FWnzjejJ4vcS5PkmQWhxuPDhBOAdmFNb34oy1/b5StB+JuZgU
        eNn7uj9tNWO0nIdv1S82VT3U5zG3k1JChQ==
X-Google-Smtp-Source: ABdhPJyjgXah68anHDVQlUhL4SWrsmeSvTTucDV1vRWbGa84L22eLzIDa/1BlXCb1F2GwasF4fgPqg==
X-Received: by 2002:a17:902:c789:b029:128:ce62:7d54 with SMTP id w9-20020a170902c789b0290128ce627d54mr2754671pla.22.1624975552447;
        Tue, 29 Jun 2021 07:05:52 -0700 (PDT)
Received: from raspberrypi ([125.141.84.155])
        by smtp.gmail.com with ESMTPSA id n127sm7864003pga.58.2021.06.29.07.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 07:05:52 -0700 (PDT)
Date:   Tue, 29 Jun 2021 15:05:48 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, austin.kim@lge.com,
        austindh.kim@gmail.com
Subject: [PATCH] tracing: change variable type as bool for clean-up
Message-ID: <20210629140548.GA1627@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Austin Kim <austin.kim@lge.com>

The wakeup_rt wakeup_dl, tracing_dl is only set to 0, 1.
So changing type of wakeup_rt wakeup_dl, tracing_dl as bool
makes relevant routine be more readable.

Signed-off-by: Austin Kim <austin.kim@lge.com>
---
 kernel/trace/trace_sched_wakeup.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index e5778d1d7a5b..4547acb91a10 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -26,9 +26,9 @@ static struct task_struct	*wakeup_task;
 static int			wakeup_cpu;
 static int			wakeup_current_cpu;
 static unsigned			wakeup_prio = -1;
-static int			wakeup_rt;
-static int			wakeup_dl;
-static int			tracing_dl = 0;
+static bool			wakeup_rt;
+static bool			wakeup_dl;
+static bool			tracing_dl = false;
 
 static arch_spinlock_t wakeup_lock =
 	(arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
@@ -498,7 +498,7 @@ static void __wakeup_reset(struct trace_array *tr)
 {
 	wakeup_cpu = -1;
 	wakeup_prio = -1;
-	tracing_dl = 0;
+	tracing_dl = false;
 
 	if (wakeup_task)
 		put_task_struct(wakeup_task);
@@ -572,9 +572,9 @@ probe_wakeup(void *ignore, struct task_struct *p)
 	 * another task until the first one wakes up.
 	 */
 	if (dl_task(p))
-		tracing_dl = 1;
+		tracing_dl = true;
 	else
-		tracing_dl = 0;
+		tracing_dl = false;
 
 	wakeup_task = get_task_struct(p);
 
@@ -685,8 +685,8 @@ static int wakeup_tracer_init(struct trace_array *tr)
 	if (wakeup_busy)
 		return -EBUSY;
 
-	wakeup_dl = 0;
-	wakeup_rt = 0;
+	wakeup_dl = false;
+	wakeup_rt = false;
 	return __wakeup_tracer_init(tr);
 }
 
@@ -695,8 +695,8 @@ static int wakeup_rt_tracer_init(struct trace_array *tr)
 	if (wakeup_busy)
 		return -EBUSY;
 
-	wakeup_dl = 0;
-	wakeup_rt = 1;
+	wakeup_dl = false;
+	wakeup_rt = true;
 	return __wakeup_tracer_init(tr);
 }
 
@@ -705,8 +705,8 @@ static int wakeup_dl_tracer_init(struct trace_array *tr)
 	if (wakeup_busy)
 		return -EBUSY;
 
-	wakeup_dl = 1;
-	wakeup_rt = 0;
+	wakeup_dl = true;
+	wakeup_rt = false;
 	return __wakeup_tracer_init(tr);
 }
 
-- 
2.20.1

