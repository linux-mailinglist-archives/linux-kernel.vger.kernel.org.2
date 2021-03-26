Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B536034A3E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhCZJMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhCZJMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:12:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E96DC0613B2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a7so7328485ejs.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QFeclMCI/xtQpMqVpueJ2XQbLsIRltRLk/v4Dw+G+yo=;
        b=oZQ0OwtJx4o2lxzoywAMkfwrCyl5xABMqZAZJj2MevIMdLkAjlJDzFAg2sKmnIFJqH
         jPu71iBayYQBiZfnvbOu/KQaui98YgZil+VZS/S6nz6wsQODSDQRCz3JToe8oqP4IF/2
         uYhZxAi4sLpb3Yv+59ny+hgLJwr8o27RkgVlR/KT6VajgwhUD5dsGe4FvIpCJxg/0eAV
         K02joh0bnAlgvKTkDPetlBVtFeuTp6gvcSToyWl9LyF7W3ycoGUAn2wyTjXkpNoKwfW/
         rUu4sr03xPVvBtDOb5kRMEqzKClNEGlWiFofeiYzS5XwknGzVn+9KOcsnhDGA6eafrzP
         6fJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QFeclMCI/xtQpMqVpueJ2XQbLsIRltRLk/v4Dw+G+yo=;
        b=hCZMRPGz/2KxmqsPwtK6JdXfe4/4SvZo4g0uyp2rxkZazOQOYKreVCcPKKTw76+ew9
         Vbf4DfF9y0qRSnDKGHZUI67OXtiZO/xioT0aD3RDwvoVur6sGpHKz7NhGQMSigEfB6uy
         kB4JLzvlO2qU5oc+PjVFT/kKUdd3uDx8Pk/4rwWB38xYMuIiDUG9IfTQZVPsXi4LpJcg
         rjDWM4aPnHedI5xFU0+aejcYbZWJAYcOjhp5qUrhHGDzkdvm6A7pIY8M01xcC8QvD2fY
         WOUt7DxM8KmqtNhi58suxR5bn8CaBfzJixxc6fUtmdInY/u6rsOf0/O7CpDmeerge/ue
         jhuQ==
X-Gm-Message-State: AOAM533JNdLW/jysSTBiS0yOIib1dNfv7P60GpUDlHZzEXC4AHVWOKXX
        nvB1fvkf1Av2FsilWKLar8svgg==
X-Google-Smtp-Source: ABdhPJyHYO+cK+MVO4pli4rQWFvAjc9DALO8t3YsK2Jx2dR9Krq1nzoJj+06Y+93oqDFGbAMoaBrkA==
X-Received: by 2002:a17:906:ac6:: with SMTP id z6mr13869637ejf.505.1616749926034;
        Fri, 26 Mar 2021 02:12:06 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:12:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 12/18] fs: gfs2: ops_fstype: Fix a little doc-rot
Date:   Fri, 26 Mar 2021 09:11:45 +0000
Message-Id: <20210326091151.311647-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
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

