Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F9934A3E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhCZJNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCZJMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:12:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5A4C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l4so7279722ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M/vaOgHlDpdBkFH1eBGQCtGldkda6ama7Jn2eE3qoYU=;
        b=PYYOPrEE/wON4trep7awV+/huj+kfc2Us0NwTR25OL7qGyw+49TnWtvnhSc6rVybY7
         Dcv6JQaRsY+S73nrFq3bVEtY56WupTqUzRSalQiXzErtdCiLcMpKx5F1fecsMaai5/k7
         FN1flUcfyfJjycdiwkJZdPby90cUcaVOObxPQVEBW3IWd02TBW9voZlokld6spJASr4z
         L4tx8D+sYVZWVUafTPpUpXwcHEb7jV0MlM5z1nVNuumpwlV9VzIRylOwAN9uogSw6LpL
         d7xSrrNgpm2yklvadefuoneuG8H7koqrkgHtIdFZL884v9NlZll2dtXQ8DanRxbBwUAc
         ftlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/vaOgHlDpdBkFH1eBGQCtGldkda6ama7Jn2eE3qoYU=;
        b=Gler63VNhNEyTf9CWfVXpOn2lPITSQck5gUnx7bfq6WID3fMX8wdrKYbpZH8IEyh/v
         hVA60nR/YSvflwxiEBEslNvXOVUBvRlZk3I1blunejr3EkqQzav2SzCA90hrG/GVxaKg
         5JCQ7e+RY3QPQIk8OqS1Nie4uYVvIvBcgoVQf2EyQYtfXYf5E9nawMZjp7me65bTmVkD
         THYk4MLcl8pgltMdITMsi5YobjbRLx0eISKODihRYdFNg4ZJ2G4D8oIudxHMzT5dOQN7
         5iK1OHn8WV9owc310lLzjIx4ttjBSTK7XVSsALtawXhyE99mVMPo+/LpoMTwZ+azTHzE
         bSfg==
X-Gm-Message-State: AOAM5332AuqOLQkBdI2Z75ChojAML2UqyV3GDAsiZTfEzdBCOB8tPc0t
        sW/YsVPui4mZVkJUtv3fVKbt+Q==
X-Google-Smtp-Source: ABdhPJyNApa1vm+Q2kcRE7jDYS+jAOwcz0/Wlwb7B++fATv3AFb38BvUUMMsAnFxe7Nej+eqpnrJVA==
X-Received: by 2002:a17:906:68c5:: with SMTP id y5mr14366826ejr.371.1616749929828;
        Fri, 26 Mar 2021 02:12:09 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:12:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 16/18] fs: gfs2: super: Fix kernel-doc issues where feasible demote one other
Date:   Fri, 26 Mar 2021 09:11:49 +0000
Message-Id: <20210326091151.311647-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/super.c:397: warning: Excess function parameter 'state' description in 'gfs2_lock_fs_check_clean'
 fs/gfs2/super.c:397: warning: Excess function parameter 't_gh' description in 'gfs2_lock_fs_check_clean'
 fs/gfs2/super.c:709: warning: Function parameter or member 'wait' not described in 'gfs2_sync_fs'
 fs/gfs2/super.c:821: warning: expecting prototype for statfs_fill(). Prototype was for statfs_slow_fill() instead
 fs/gfs2/super.c:916: warning: Function parameter or member 'sc' not described in 'gfs2_statfs_i'
 fs/gfs2/super.c:916: warning: Excess function parameter 'sg' description in 'gfs2_statfs_i'
 fs/gfs2/super.c:948: warning: Function parameter or member 'dentry' not described in 'gfs2_statfs'
 fs/gfs2/super.c:948: warning: Function parameter or member 'buf' not described in 'gfs2_statfs'
 fs/gfs2/super.c:948: warning: Excess function parameter 'sb' description in 'gfs2_statfs'
 fs/gfs2/super.c:948: warning: Excess function parameter 'statfsbuf' description in 'gfs2_statfs'
 fs/gfs2/super.c:1281: warning: Function parameter or member 'gh' not described in 'evict_should_delete'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/super.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 9e91c9d92bd65..aba117aa433dc 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -387,8 +387,6 @@ struct lfcc {
  * gfs2_lock_fs_check_clean - Stop all writes to the FS and check that all
  *                            journals are clean
  * @sdp: the file system
- * @state: the state to put the transaction lock into
- * @t_gh: the hold on the transaction lock
  *
  * Returns: errno
  */
@@ -698,7 +696,7 @@ static void gfs2_put_super(struct super_block *sb)
 	free_sbd(sdp);
 }
 
-/**
+/*
  * gfs2_sync_fs - sync the filesystem
  * @sb: the superblock
  *
@@ -809,7 +807,7 @@ static int gfs2_unfreeze(struct super_block *sb)
 }
 
 /**
- * statfs_fill - fill in the sg for a given RG
+ * statfs_slow_fill - fill in the sg for a given RG
  * @rgd: the RG
  * @sc: the sc structure
  *
@@ -907,7 +905,7 @@ static int gfs2_statfs_slow(struct gfs2_sbd *sdp, struct gfs2_statfs_change_host
 /**
  * gfs2_statfs_i - Do a statfs
  * @sdp: the filesystem
- * @sg: the sg structure
+ * @sc: the sc structure
  *
  * Returns: errno
  */
@@ -938,8 +936,8 @@ static int gfs2_statfs_i(struct gfs2_sbd *sdp, struct gfs2_statfs_change_host *s
 
 /**
  * gfs2_statfs - Gather and return stats about the filesystem
- * @sb: The superblock
- * @statfsbuf: The buffer
+ * @dentry: The name of the link
+ * @buf: The buffer
  *
  * Returns: 0 on success or error code
  */
@@ -1270,6 +1268,7 @@ static bool gfs2_upgrade_iopen_glock(struct inode *inode)
 /**
  * evict_should_delete - determine whether the inode is eligible for deletion
  * @inode: The inode to evict
+ * @gh: the holder structure
  *
  * This function determines whether the evicted inode is eligible to be deleted
  * and locks the inode glock.
-- 
2.27.0

