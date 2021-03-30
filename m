Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD4D34EE60
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhC3Qqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbhC3QpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60363C061764
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v4so16860134wrp.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QFeclMCI/xtQpMqVpueJ2XQbLsIRltRLk/v4Dw+G+yo=;
        b=gN2JcSwvfHS6epYWIxl0k82wwzTBuDceZGeysljWekipVljx00PWP9P2aWzEkXOs0W
         hwy0KhBDGCEprmtIBhquM+VWZ36ncjfPgq+D02MUb8NKsewV9E6bKixa80wNFypTTKYp
         e2TZvHF/+L5zBEItrN6UOHBP+pNt8B7Ah8WZDE/eIC3jefAzrs1r/lhw85zPSOc+z1NA
         ouKDC+DWmkSF9Kx+gv2192KVTlgCxyxTgTnb3UvirjtX2XF5peMsKAiq1zIAhoNSLeCy
         XYTBfXoDT/wwcYteMo23JycpqjR2saT7kjI/h5rmmv2aX7gtnVWsU4hTv6SDIBmuZjwN
         RR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QFeclMCI/xtQpMqVpueJ2XQbLsIRltRLk/v4Dw+G+yo=;
        b=DyUXTGCs20SXY9d7cFWaiqQNBUmpLWD4jkJpl0gxcbK3mczwbuAIH7vU1FhX4dDk++
         HZ9bMa7/v/JKtKAlrK9gilyZCqjjLU22mtPSEnuJx12WihsgegwBHQ7NliNq0ApefJA2
         QtXf7z3lOOaeWkiRs9RGDVwSinN0RhLyxLelhNpmfjlC2sbHtiRL4QApHIO92t7Xpi7L
         83irpIbQxkF3zCmMiPEej1Yk43EMwUwAY0FXJse+6nqlpvDHkaM+l8SZUvVQEdthFsvL
         DiqESy1g4j82DScd2GR8D+UKDhguKV24qpFZD+Wn5y23jk73rIMPusU9Gx+AOGqmKt8a
         M+wA==
X-Gm-Message-State: AOAM531N2bdT5GNl9ZJQdOM8LlMCNJ0kDYuv73Vt/8cel68svM1K0d9i
        0ItGAeU2Hv8nsbySRGcjp0fif+u7dcjO+w==
X-Google-Smtp-Source: ABdhPJwc2uQxM+Erb2LxDK7IWO4tOF8OOi2qNdDGAHGN5nzU77BFryVpEM9zMLSsN2YEuOHr1eZM3w==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr35123294wru.214.1617122713134;
        Tue, 30 Mar 2021 09:45:13 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 12/31] fs: gfs2: ops_fstype: Fix a little doc-rot
Date:   Tue, 30 Mar 2021 17:44:39 +0100
Message-Id: <20210330164458.1625478-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/ops_fstype.c:162: warning: Excess function parameter 'sb' description in 'gfs2_check_sb'
 fs/gfs2/ops_fstype.c:242: warning: Function parameter or member 'silent' not described in 'gfs2_read_super'
 fs/gfs2/ops_fstype.c:242: warning: Excess function parameter 'error' description in 'gfs2_read_super'
 fs/gfs2/ops_fstype.c:993: warning: Excess function parameter 'args' description in 'gfs2_lm_mount'
 fs/gfs2/ops_fstype.c:1102: warning: Function parameter or member 'fc' not described in 'gfs2_fill_super'
 fs/gfs2/ops_fstype.c:1102: warning: Excess function parameter 'args' description in 'gfs2_fill_super'
 fs/gfs2/ops_fstype.c:1102: warning: Excess function parameter 'silent' description in 'gfs2_fill_super'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/ops_fstype.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index aa4136055a83c..b6c7a95dabf90 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -150,7 +150,6 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
 /**
  * gfs2_check_sb - Check superblock
  * @sdp: the filesystem
- * @sb: The superblock
  * @silent: Don't print a message if the check fails
  *
  * Checks the version code of the FS is one that we understand how to
@@ -223,7 +222,7 @@ static void gfs2_sb_in(struct gfs2_sbd *sdp, const void *buf)
  * gfs2_read_super - Read the gfs2 super block from disk
  * @sdp: The GFS2 super block
  * @sector: The location of the super block
- * @error: The error code to return
+ * @silent: Don't print a message if the check fails
  *
  * This uses the bio functions to read the super block from disk
  * because we want to be 100% sure that we never read cached data.
@@ -983,7 +982,6 @@ static const struct lm_lockops nolock_ops = {
 /**
  * gfs2_lm_mount - mount a locking protocol
  * @sdp: the filesystem
- * @args: mount arguments
  * @silent: if 1, don't complain if the FS isn't a GFS2 fs
  *
  * Returns: errno
@@ -1093,8 +1091,7 @@ void gfs2_online_uevent(struct gfs2_sbd *sdp)
 /**
  * gfs2_fill_super - Read in superblock
  * @sb: The VFS superblock
- * @args: Mount options
- * @silent: Don't complain if it's not a GFS2 filesystem
+ * @fc: Mount options and flags
  *
  * Returns: -errno
  */
-- 
2.27.0

