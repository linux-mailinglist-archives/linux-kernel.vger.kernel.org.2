Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D564734EE33
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhC3QpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbhC3QpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872F3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso8790209wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CK1kDFMaw5UzDowuwUYCibcsDvXfXP1I8E7qqThRaEU=;
        b=JbtBSj+t8vNnyGLnqdX8aUN8wcBpEDeUcrY5VyV9WEfOJMRGZiUeG/QM8IXraEgQ8j
         LIpRgGesIksjdMY7eGE/if+5yKxm3SXubBVV8FXWXxtcYMFv1ZTivfzfikPhLVPwg2Bu
         6hYAJUpVIwgFXvXF1q9HDKap7Are4tKkcAzxwexiVD2PAwYP8CS4mxV3eHTmqS66qnLc
         Fyo5HzdwQz7dqeHTWsbLsYd4eIqwIWf9iAlqf96a9WOK+K3cH3P7C94nIIgSk6Neo3w+
         B3akyK1O6we0OIh0HI7L3c1o5JIzWF5ItN5TmTNxwc2XvT3u8uB9c8nAdjnTqY3u/Wj4
         N4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CK1kDFMaw5UzDowuwUYCibcsDvXfXP1I8E7qqThRaEU=;
        b=sD6mHhfpFnQEovX8EAEC51GJi2tAwKGN++i839UHmrM92w9l1ZWteAcWwQUIHeVxrM
         /1gwCGBWRynJIuva4h6uaQkoNPitGYGlv2ptXBSeJ4vgk7uysx8zPOGspE4kf7KoOkVe
         XzAMq1yTSa2t7m89BEJKuk6xBvXCn0XodvAe3GZeMAmZYg7Zyr6uguWpXOSsp76iGj6R
         OPt+Y2VHEUUadU1LCK9erHYnYhRilkQ7HGRvjKMhyBjjijr6vg3FgfNeTmDbbghKxdlV
         qM8aBInA92JKZ04ioiNoyaKsmAFu+Lwk9YdJpSCaKfk/+MkEAZoS4EVphbX/eiGIurdQ
         6kBg==
X-Gm-Message-State: AOAM5337wtZASpwnkqE1EMaexAhPozcYSzGAMR1ghoRN18jnXQblcyYw
        IMqCWDDvxtwYZ9bcdO3jDPQ8fNBczz+b7w==
X-Google-Smtp-Source: ABdhPJz28j/uD7FuqUixWwq5qLpY3pHLYHj/jkVvU+7XaCJUQEcBnEoyuGHg4dDqgRCH0icBZOCY5Q==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr5131430wmc.65.1617122706228;
        Tue, 30 Mar 2021 09:45:06 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 05/31] fs: gfs2: log: Fix a couple of param descriptions and demote non-conformant headers
Date:   Tue, 30 Mar 2021 17:44:32 +0100
Message-Id: <20210330164458.1625478-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/log.c:76: warning: Excess function parameter 'mapping' description in 'gfs2_remove_from_ail'
 fs/gfs2/log.c:97: warning: Function parameter or member 'tr' not described in 'gfs2_ail1_start_one'
 fs/gfs2/log.c:97: warning: Function parameter or member 'plug' not described in 'gfs2_ail1_start_one'
 fs/gfs2/log.c:97: warning: Excess function parameter 'ai' description in 'gfs2_ail1_start_one'
 fs/gfs2/log.c:278: warning: Function parameter or member 'sdp' not described in 'gfs2_ail_empty_tr'
 fs/gfs2/log.c:278: warning: Function parameter or member 'tr' not described in 'gfs2_ail_empty_tr'
 fs/gfs2/log.c:278: warning: Function parameter or member 'head' not described in 'gfs2_ail_empty_tr'
 fs/gfs2/log.c:1174: warning: Function parameter or member 'sdp' not described in 'gfs2_merge_trans'
 fs/gfs2/log.c:1174: warning: Excess function parameter 'old' description in 'gfs2_merge_trans'
 fs/gfs2/log.c:1293: warning: Function parameter or member 'data' not described in 'gfs2_logd'
 fs/gfs2/log.c:1293: warning: Excess function parameter 'sdp' description in 'gfs2_logd'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/log.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 6410281546f92..eef33cd251e4b 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -65,7 +65,6 @@ unsigned int gfs2_struct2blk(struct gfs2_sbd *sdp, unsigned int nstruct)
 
 /**
  * gfs2_remove_from_ail - Remove an entry from the ail lists, updating counters
- * @mapping: The associated mapping (maybe NULL)
  * @bd: The gfs2_bufdata to remove
  *
  * The ail lock _must_ be held when calling this function
@@ -81,12 +80,10 @@ void gfs2_remove_from_ail(struct gfs2_bufdata *bd)
 	brelse(bd->bd_bh);
 }
 
-/**
+/*
  * gfs2_ail1_start_one - Start I/O on a part of the AIL
  * @sdp: the filesystem
  * @wbc: The writeback control structure
- * @ai: The ail structure
- *
  */
 
 static int gfs2_ail1_start_one(struct gfs2_sbd *sdp,
@@ -269,7 +266,7 @@ static void gfs2_log_update_head(struct gfs2_sbd *sdp)
 	sdp->sd_log_head = new_head;
 }
 
-/**
+/*
  * gfs2_ail_empty_tr - empty one of the ail lists of a transaction
  */
 
@@ -1166,7 +1163,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 
 /**
  * gfs2_merge_trans - Merge a new transaction into a cached transaction
- * @old: Original transaction to be expanded
+ * @sdp: the filesystem
  * @new: New transaction to be merged
  */
 
@@ -1283,7 +1280,7 @@ static inline int gfs2_ail_flush_reqd(struct gfs2_sbd *sdp)
 
 /**
  * gfs2_logd - Update log tail as Active Items get flushed to in-place blocks
- * @sdp: Pointer to GFS2 superblock
+ * @data: Pointer to GFS2 superblock
  *
  * Also, periodically check to make sure that we're using the most recent
  * journal index.
-- 
2.27.0

