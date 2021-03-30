Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EA834EE5D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhC3Qqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbhC3QpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB22C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:18 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p19so8761818wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zJd8mXXYqEzxi+Ta+kTFG2L+mB09Pvob5bInoEtWOJs=;
        b=PS5NgEFgbTE9hrTik9rt503bbzHuZx8o0GN+3GgRIE4+CPG4MbPeuchLppbKUeXk/o
         CBwGyRlQV0ZeDQodcGicSse+Tqadam3W1TTZlFDsYe6IFbYmUUSfUIjYwq/mgAPDJ8sG
         jImUxRYr5Uov2xjVO6m9epWxrctJYUX8KdTtsNKuGc7QRFYN0NzEM/HW5PuUp9Q16vJF
         HK7QKCwetp4IQ83IsLHFlp3m0wsCG9ZvIaHGZOWNdqDyHRZ1Geycgz3iSxX61Ft6FYz0
         eZ/z4H983xeFuT4WoZ2z8THKWVpY5LETiOXrVz1e/1+NbWNg+s2yMkuxYB7OanWrfWcf
         fJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zJd8mXXYqEzxi+Ta+kTFG2L+mB09Pvob5bInoEtWOJs=;
        b=GnRoIyb7kTw0EtISdfVmOAP9azCK0lYP8QUunot/B/QM2/BG8es6WMobZsp5Tn1vz4
         DQY+MLjz7ryJezN4g5oPwq6aIXnbk7t2Zx3ybCcSECQYr6DwJnxSXCz4GD31nMGJUY1x
         pNCJaYIsH0michnmX+UeTFpz7+1RvUSrPl0bZDAvEEoON8vT4cjqRkFBG2tIYtz5VhrG
         yv1CTnbLmFEvqjfGUql5e1bXf5tLeQuQK6F+VS8rIM0Z491i15cTwLG2JaO9gQr1p2J3
         SvVJoP1jY0j+Kto3J1gtZmIvx5fEONKWhhuWscDx9kmHcIXw0AloA6VMSI6YOs0HAW7b
         4XRQ==
X-Gm-Message-State: AOAM532aGqnpm5IbRULYRXkQKj1E+HYT4kulDqjgm71GqPjm2TSyx6Fw
        V/no52JKJsvnuS72WTH0+RsoBA==
X-Google-Smtp-Source: ABdhPJy7x+893j7xrlcHpLBGkGCyLPyYwjJIiUPlSoLFR8ppUyFsX66UUEf901V2mos9wK16DUvsCQ==
X-Received: by 2002:a7b:cb99:: with SMTP id m25mr5082442wmi.64.1617122717141;
        Tue, 30 Mar 2021 09:45:17 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 16/31] fs: gfs2: super: Fix kernel-doc issues where feasible demote one other
Date:   Tue, 30 Mar 2021 17:44:43 +0100
Message-Id: <20210330164458.1625478-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
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
index 669ce921d0096..841b430d532cd 100644
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
@@ -811,7 +809,7 @@ static int gfs2_unfreeze(struct super_block *sb)
 }
 
 /**
- * statfs_fill - fill in the sg for a given RG
+ * statfs_slow_fill - fill in the sg for a given RG
  * @rgd: the RG
  * @sc: the sc structure
  *
@@ -909,7 +907,7 @@ static int gfs2_statfs_slow(struct gfs2_sbd *sdp, struct gfs2_statfs_change_host
 /**
  * gfs2_statfs_i - Do a statfs
  * @sdp: the filesystem
- * @sg: the sg structure
+ * @sc: the sc structure
  *
  * Returns: errno
  */
@@ -940,8 +938,8 @@ static int gfs2_statfs_i(struct gfs2_sbd *sdp, struct gfs2_statfs_change_host *s
 
 /**
  * gfs2_statfs - Gather and return stats about the filesystem
- * @sb: The superblock
- * @statfsbuf: The buffer
+ * @dentry: The name of the link
+ * @buf: The buffer
  *
  * Returns: 0 on success or error code
  */
@@ -1272,6 +1270,7 @@ static bool gfs2_upgrade_iopen_glock(struct inode *inode)
 /**
  * evict_should_delete - determine whether the inode is eligible for deletion
  * @inode: The inode to evict
+ * @gh: the holder structure
  *
  * This function determines whether the evicted inode is eligible to be deleted
  * and locks the inode glock.
-- 
2.27.0

