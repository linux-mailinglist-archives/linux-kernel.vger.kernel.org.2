Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E93A410724
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 16:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbhIROzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 10:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbhIROzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 10:55:21 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C96C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 07:53:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g19-20020a1c9d13000000b003075062d4daso8881063wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 07:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JYtFTZKcQ7uh0hxmWAhAvNGos08OYmAhjxdYJaTKWzc=;
        b=eoHFfGzuJCCGI1qFw6lfdxH3RNQb93zk52zndvO+peAeaHlzcHrBZlIggZWdFBbZEH
         4XPDlA40muuTe6sb8CvBg25UEEXriZeKGcwJUvDvB1cA6tj8Y/smHR3/xBkDjfnaN0hv
         bOcfYsbc6HUt40xy8ViUoy+OHCm4Nn+Aakr6X9uFyeEKL8+tPq/S8r1C2ULV+xEzHpua
         8/kX0TAumibAmyuckY+r0NKw1DxRzf/E+ziUY+XbKufOTbIBEghvzw9pajcyI7aTis5y
         fFtNT0jQ3hz/X/ErDvZYWaj6iSges5tNrmlhXl80WLbmBAF3HUTifOiNfckGUvA3nKBE
         BOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JYtFTZKcQ7uh0hxmWAhAvNGos08OYmAhjxdYJaTKWzc=;
        b=HbloQaxnEC/1PIDMaB4OyY9eqRFYt2DE4dPDPuRhe+ZqyVWgSBIQsDzsGfQd/iInoe
         TNi/WdBpu9DDrC7Y277g4Btc6fyiyGhAeYYXRSvSGJk4Q3a8GLm2nX5sisY6pfen/sQV
         4JD4Em+43Anllj5L9hYvxklKISoprIirHOdgaY2hYWWuDUInuNXsr1RF8q7oNfYOnIz6
         n061K5lFaQ48EuhnYg3tlLv0ViMUG1W5zYkI8A/tyoVh0LyfxgCzGa9YfFAoI8ITOqnJ
         fI1L8SekNIXmPH2EahpA0HQF8E3ZTnRoR3VIhs6iLyXyioh10d6lwumcPcZVXiKylo5u
         8YhA==
X-Gm-Message-State: AOAM5339g9StrvFzAb2jKYINbyhBjZ8MOhvhrKoSXiHctzNRPxaB/fI5
        +xqCmbA/rjeN3CoxN3lwM2EoAKV6tRjujHfT
X-Google-Smtp-Source: ABdhPJx5EyQVE+TQpRYAQIepb1Djvi+L1scSGNHlu4XF+3HOfS5Mmi/ttd6OFyv4VUUyGvgDc5mjvQ==
X-Received: by 2002:a1c:a713:: with SMTP id q19mr20592052wme.42.1631976836219;
        Sat, 18 Sep 2021 07:53:56 -0700 (PDT)
Received: from localhost.localdomain (p200300d9973962007086c7f795e39cc9.dip0.t-ipconnect.de. [2003:d9:9739:6200:7086:c7f7:95e3:9cc9])
        by smtp.googlemail.com with ESMTPSA id o19sm870209wrg.60.2021.09.18.07.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 07:53:55 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Clapinski <mclapinski@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>, 1vier1@web.de,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH] ipc/ipc_sysctl.c: Remove fallback for !CONFIG_PROC_SYSCTL
Date:   Sat, 18 Sep 2021 16:53:37 +0200
Message-Id: <20210918145337.3369-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compilation of ipc/ipc_sysctl.c is controlled by
obj-$(CONFIG_SYSVIPC_SYSCTL)
[see ipc/Makefile]

And CONFIG_SYSVIPC_SYSCTL depends on SYSCTL
[see init/Kconfig]

An SYSCTL is selected by PROC_SYSCTL.
[see fs/proc/Kconfig]

Thus: #ifndef CONFIG_PROC_SYSCTL in ipc/ipc_sysctl.c is impossible, the
fallback can be removed.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/ipc_sysctl.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 345e4d673e61..f101c171753f 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -23,7 +23,6 @@ static void *get_ipc(struct ctl_table *table)
 	return which;
 }
 
-#ifdef CONFIG_PROC_SYSCTL
 static int proc_ipc_dointvec(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -118,18 +117,6 @@ static int proc_ipc_dointvec_minmax_checkpoint_restore(struct ctl_table *table,
 }
 #endif
 
-#else
-#define proc_ipc_doulongvec_minmax NULL
-#define proc_ipc_dointvec	   NULL
-#define proc_ipc_dointvec_minmax   NULL
-#define proc_ipc_dointvec_minmax_orphans   NULL
-#define proc_ipc_auto_msgmni	   NULL
-#define proc_ipc_sem_dointvec	   NULL
-#ifdef CONFIG_CHECKPOINT_RESTORE
-#define proc_ipc_dointvec_minmax_checkpoint_restore	NULL
-#endif	/* CONFIG_CHECKPOINT_RESTORE */
-#endif
-
 int ipc_mni = IPCMNI;
 int ipc_mni_shift = IPCMNI_SHIFT;
 int ipc_min_cycle = RADIX_TREE_MAP_SIZE;
-- 
2.31.1

