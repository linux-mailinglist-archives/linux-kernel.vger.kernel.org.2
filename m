Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FCF34EE5C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhC3Qqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhC3QpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23471C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j9so15172381wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=edOfNQI8AxXW7owzJ+vXm3rW8pIpWNBkr0sH8eSakq4=;
        b=CMcej98QzNzJrJ0RKJuOeqTm0DtBiTfCBt5ttl/J//+57vz40qf300sF8WWOPLEdD+
         5ujpW1WKZZuGoO9G5Wg2BX53r3V4ebgSxOlCxOFcrD7xsMz/+JPQz+vIkxBdEytZHhP3
         MEPRuoALhogy5bJ869vt1UJe70UTJ1S4Ukuf/oX9Vgu78DO3cYWahUrabsqQ1n+DZzy5
         66xhwmrhNbgV0WDQnJ+OseuXuVRvh7rFUZ7tn5sSY9qld/2+E3GmxQJSErm1BlpchZov
         oatS8J/gJlhvor7i0KMRE4KejhqhKlz3A37gokbCB0wUKUUqGTLq8AWceppA6D3YeG+r
         0Udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=edOfNQI8AxXW7owzJ+vXm3rW8pIpWNBkr0sH8eSakq4=;
        b=rW+pOLENyvvQ323KXlbeUbRD8tVHnBnhI7ztWK29ppr5avJcFlzHIQb3bbpmRQVNdm
         cLm5HqKgYNmT3LuotNh1XbJ154VoDWQTafHLxorW98aweAYp5VSjPp9v0+kxlar6J5qR
         B9IofeoJaQY3R1n7rj2/KhNxfbGjw+9U43d/e78WQAYd9UKmE8MUeP+LAJtE/b4dn0N8
         I1N/G8zWFc/38SmRfpuF/n7sjpGdpBaMBWsHq+4RqpdlbusEXXYuMiEBIILyy6SK2ava
         0RFOU1ChUc5s9aRSAe+8t492M+JUK+8tXL0dHUGsUFLAZuAwFiGD/7YsydoteMkvrCi2
         wTvQ==
X-Gm-Message-State: AOAM533HUAxwLGjki0j9RDY+Uc4gNnZyDKHLDJPwIXhYXSHuihG71zek
        dRgVLGQggMg89PHHBsivVPG/zQ==
X-Google-Smtp-Source: ABdhPJxbrNab3mr9QP4a+su/M3GAuG6S6BSajMeGGgRh/T/rdaBUOhI+pVoSN5nJVee6y2SvbBKClw==
X-Received: by 2002:adf:c389:: with SMTP id p9mr34872246wrf.410.1617122717880;
        Tue, 30 Mar 2021 09:45:17 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 17/31] fs: gfs2: util: Fix one conformant kernel-doc header and demote a bunch of abuses
Date:   Tue, 30 Mar 2021 17:44:44 +0100
Message-Id: <20210330164458.1625478-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
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

