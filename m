Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B48734A3E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCZJNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhCZJMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:12:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3FDC0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:12 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u5so7312461ejn.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=edOfNQI8AxXW7owzJ+vXm3rW8pIpWNBkr0sH8eSakq4=;
        b=WUZVQS22ujPD2pKEMT8Sf0sTMmtlqZMNsDJbymDVJqJI0cqGxFvvDnUyrd9anIS3B9
         FlKNKK+8nSLlLinG+FEqUPyvY5sKbycoFz7bhxgmSzHAaLZkrdrLXKXrnmgG8RfiA60q
         5d6jK+D6qUES+tkr9Kf22NiZLZHFwX/rXhcLFEDlKVGquFS3SJzh2YUAke4yOMXBJsjR
         p2/VlVLCDrySKY0DFKv9YhWBDHSw4DyHg/lH+wGK+fmNvyH8fEUIcmZQ8YALwwuMz+Rt
         2zwFQxpSgn16AWow2Ysr2YXDEzQgffHWcpWWeT459qNy/xbaev8caDIj+OS4l2uC0DZZ
         q4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=edOfNQI8AxXW7owzJ+vXm3rW8pIpWNBkr0sH8eSakq4=;
        b=BqjD5RZ6bMz/34V+KCXC7GUP3pLzjJytUSey9BugQtwXHCOPtpe87iXipnViikWjgp
         rzSXyR4bMAqZef/PIjwez6rwAouL4pXe9nDVHavGrl9oZubT31VuJQQR3r1Px9vXo5y/
         fiB3bYTM39/YGX20/gRN7oMW6o6ozQEr7+PSWr7FV8AE0MeJoiIFQ/F6UNY0riXDh08m
         /e+wcZyq2uMQzEW2BEMetZ8pqyGV4vBVbisN83qcofDpcwmHPAKZw+meSRggOPkcx3YR
         lQNZ/THJ3ck336AIFjYnSP3xb2S9DkLm9BqclkkHPiaivH0vZqCRmC422MKIaxn6zgVI
         2NcA==
X-Gm-Message-State: AOAM533eodUnZer2zwOivbpeygDWizqhBIoYESjuTxPUQMQp4dz70f5x
        3y8VEkdP2ffwKpuuMDdSymn+fA==
X-Google-Smtp-Source: ABdhPJyNk1VcncT+S23a+OMXxZJ3KIpYY8atXvP5zjHv7D/YTFFVsxitTpBQ+7cA5LMuaAYKimsLEw==
X-Received: by 2002:a17:907:2062:: with SMTP id qp2mr14071135ejb.397.1616749930755;
        Fri, 26 Mar 2021 02:12:10 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:12:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 17/18] fs: gfs2: util: Fix one conformant kernel-doc header and demote a bunch of abuses
Date:   Fri, 26 Mar 2021 09:11:50 +0000
Message-Id: <20210326091151.311647-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/util.c:52: warning: Function parameter or member 'verbose' not described in 'check_journal_clean'
 fs/gfs2/util.c:372: warning: Function parameter or member 'sdp' not described in 'gfs2_assert_withdraw_i'
 fs/gfs2/util.c:372: warning: Function parameter or member 'assertion' not described in 'gfs2_assert_withdraw_i'
 fs/gfs2/util.c:372: warning: Function parameter or member 'function' not described in 'gfs2_assert_withdraw_i'
 fs/gfs2/util.c:372: warning: Function parameter or member 'file' not described in 'gfs2_assert_withdraw_i'
 fs/gfs2/util.c:372: warning: Function parameter or member 'line' not described in 'gfs2_assert_withdraw_i'
 fs/gfs2/util.c:372: warning: Function parameter or member 'delayed' not described in 'gfs2_assert_withdraw_i'
 fs/gfs2/util.c:401: warning: Function parameter or member 'sdp' not described in 'gfs2_assert_warn_i'
 fs/gfs2/util.c:401: warning: Function parameter or member 'assertion' not described in 'gfs2_assert_warn_i'
 fs/gfs2/util.c:401: warning: Function parameter or member 'function' not described in 'gfs2_assert_warn_i'
 fs/gfs2/util.c:401: warning: Function parameter or member 'file' not described in 'gfs2_assert_warn_i'
 fs/gfs2/util.c:401: warning: Function parameter or member 'line' not described in 'gfs2_assert_warn_i'
 fs/gfs2/util.c:431: warning: Function parameter or member 'sdp' not described in 'gfs2_consist_i'
 fs/gfs2/util.c:431: warning: Function parameter or member 'function' not described in 'gfs2_consist_i'
 fs/gfs2/util.c:431: warning: Function parameter or member 'file' not described in 'gfs2_consist_i'
 fs/gfs2/util.c:431: warning: Function parameter or member 'line' not described in 'gfs2_consist_i'
 fs/gfs2/util.c:444: warning: Function parameter or member 'ip' not described in 'gfs2_consist_inode_i'
 fs/gfs2/util.c:444: warning: Function parameter or member 'function' not described in 'gfs2_consist_inode_i'
 fs/gfs2/util.c:444: warning: Function parameter or member 'file' not described in 'gfs2_consist_inode_i'
 fs/gfs2/util.c:444: warning: Function parameter or member 'line' not described in 'gfs2_consist_inode_i'
 fs/gfs2/util.c:463: warning: Function parameter or member 'rgd' not described in 'gfs2_consist_rgrpd_i'
 fs/gfs2/util.c:463: warning: Function parameter or member 'function' not described in 'gfs2_consist_rgrpd_i'
 fs/gfs2/util.c:463: warning: Function parameter or member 'file' not described in 'gfs2_consist_rgrpd_i'
 fs/gfs2/util.c:463: warning: Function parameter or member 'line' not described in 'gfs2_consist_rgrpd_i'
 fs/gfs2/util.c:487: warning: Function parameter or member 'sdp' not described in 'gfs2_meta_check_ii'
 fs/gfs2/util.c:487: warning: Function parameter or member 'bh' not described in 'gfs2_meta_check_ii'
 fs/gfs2/util.c:487: warning: Function parameter or member 'type' not described in 'gfs2_meta_check_ii'
 fs/gfs2/util.c:487: warning: Function parameter or member 'function' not described in 'gfs2_meta_check_ii'
 fs/gfs2/util.c:487: warning: Function parameter or member 'file' not described in 'gfs2_meta_check_ii'
 fs/gfs2/util.c:487: warning: Function parameter or member 'line' not described in 'gfs2_meta_check_ii'
 fs/gfs2/util.c:509: warning: Function parameter or member 'sdp' not described in 'gfs2_metatype_check_ii'
 fs/gfs2/util.c:509: warning: Function parameter or member 'bh' not described in 'gfs2_metatype_check_ii'
 fs/gfs2/util.c:509: warning: Function parameter or member 'type' not described in 'gfs2_metatype_check_ii'
 fs/gfs2/util.c:509: warning: Function parameter or member 't' not described in 'gfs2_metatype_check_ii'
 fs/gfs2/util.c:509: warning: Function parameter or member 'function' not described in 'gfs2_metatype_check_ii'
 fs/gfs2/util.c:509: warning: Function parameter or member 'file' not described in 'gfs2_metatype_check_ii'
 fs/gfs2/util.c:509: warning: Function parameter or member 'line' not described in 'gfs2_metatype_check_ii'
 fs/gfs2/util.c:530: warning: Function parameter or member 'sdp' not described in 'gfs2_io_error_i'
 fs/gfs2/util.c:530: warning: Function parameter or member 'function' not described in 'gfs2_io_error_i'
 fs/gfs2/util.c:530: warning: Function parameter or member 'file' not described in 'gfs2_io_error_i'
 fs/gfs2/util.c:530: warning: Function parameter or member 'line' not described in 'gfs2_io_error_i'
 fs/gfs2/util.c:546: warning: Function parameter or member 'sdp' not described in 'gfs2_io_error_bh_i'
 fs/gfs2/util.c:546: warning: Function parameter or member 'bh' not described in 'gfs2_io_error_bh_i'
 fs/gfs2/util.c:546: warning: Function parameter or member 'function' not described in 'gfs2_io_error_bh_i'
 fs/gfs2/util.c:546: warning: Function parameter or member 'file' not described in 'gfs2_io_error_bh_i'
 fs/gfs2/util.c:546: warning: Function parameter or member 'line' not described in 'gfs2_io_error_bh_i'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/util.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 4f034b87b4276..3e08027a6c81b 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -44,6 +44,7 @@ void gfs2_assert_i(struct gfs2_sbd *sdp)
  * check_journal_clean - Make sure a journal is clean for a spectator mount
  * @sdp: The GFS2 superblock
  * @jd: The journal descriptor
+ * @verbose: Show more prints in the log
  *
  * Returns: 0 if the journal is clean or locked, else an error
  */
@@ -362,7 +363,7 @@ int gfs2_withdraw(struct gfs2_sbd *sdp)
 	return -1;
 }
 
-/**
+/*
  * gfs2_assert_withdraw_i - Cause the machine to withdraw if @assertion is false
  */
 
@@ -392,7 +393,7 @@ void gfs2_assert_withdraw_i(struct gfs2_sbd *sdp, char *assertion,
 	dump_stack();
 }
 
-/**
+/*
  * gfs2_assert_warn_i - Print a message to the console if @assertion is false
  */
 
@@ -422,7 +423,7 @@ void gfs2_assert_warn_i(struct gfs2_sbd *sdp, char *assertion,
 	sdp->sd_last_warning = jiffies;
 }
 
-/**
+/*
  * gfs2_consist_i - Flag a filesystem consistency error and withdraw
  */
 
@@ -435,7 +436,7 @@ void gfs2_consist_i(struct gfs2_sbd *sdp, const char *function,
 	gfs2_withdraw(sdp);
 }
 
-/**
+/*
  * gfs2_consist_inode_i - Flag an inode consistency error and withdraw
  */
 
@@ -454,7 +455,7 @@ void gfs2_consist_inode_i(struct gfs2_inode *ip,
 	gfs2_withdraw(sdp);
 }
 
-/**
+/*
  * gfs2_consist_rgrpd_i - Flag a RG consistency error and withdraw
  */
 
@@ -475,7 +476,7 @@ void gfs2_consist_rgrpd_i(struct gfs2_rgrpd *rgd,
 	gfs2_withdraw(sdp);
 }
 
-/**
+/*
  * gfs2_meta_check_ii - Flag a magic number consistency error and withdraw
  * Returns: -1 if this call withdrew the machine,
  *          -2 if it was already withdrawn
@@ -497,7 +498,7 @@ int gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
 	return (me) ? -1 : -2;
 }
 
-/**
+/*
  * gfs2_metatype_check_ii - Flag a metadata type consistency error and withdraw
  * Returns: -1 if this call withdrew the machine,
  *          -2 if it was already withdrawn
@@ -519,7 +520,7 @@ int gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
 	return (me) ? -1 : -2;
 }
 
-/**
+/*
  * gfs2_io_error_i - Flag an I/O error and withdraw
  * Returns: -1 if this call withdrew the machine,
  *          0 if it was already withdrawn
@@ -535,7 +536,7 @@ int gfs2_io_error_i(struct gfs2_sbd *sdp, const char *function, char *file,
 	return gfs2_withdraw(sdp);
 }
 
-/**
+/*
  * gfs2_io_error_bh_i - Flag a buffer I/O error
  * @withdraw: withdraw the filesystem
  */
-- 
2.27.0

