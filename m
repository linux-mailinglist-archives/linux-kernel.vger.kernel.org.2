Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1EE34EE34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhC3QpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhC3QpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A24C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so10698436wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WYbiTPqSzjQP21KCxgzf3jq9Q5Hi/UH51yOsRe7KtZc=;
        b=WX8MvFkqa3GzOblA+BiWMdhESEnCAckQ4MVA5STkamJXYCFd/jbmskKWiCgtNODF8o
         Lz4R1tiRhVUhVsMAllcA0rPeyPR9n+rYdVsBIWRzxHD4NhrIrLPCYtW8BDStXI2qPHjk
         wGjcvSezo7S8UdqPix9c1IUiaRS7Upt2svyMjQrzkEotxTBgaGwW/pacSdOgvJetCntP
         agEmn4Bc0uBOZ2maiVfkwA302BeJHgCPeYWMCV6zMHu6i8z91uxxo2QjxYMgAJQo5HmE
         EQ2d3uZa1d7lYSNNQk/zEstLlEUgxeizYvuqY3eRPoTPEFzrat1zJ/PJdvewhhtAvgFj
         6q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYbiTPqSzjQP21KCxgzf3jq9Q5Hi/UH51yOsRe7KtZc=;
        b=b8/QXLiSekoNPMN9y4y8eqDH/3cb6Zh7ITyj5JmzIJBa/Z8YsMCTRuqhNVKkVkdk7i
         l5ZMB/4l8uvEkep0NxoHtXqTPNnvSNHPxVuml0ZQeZEPhwIhhb0QYnM1Prt6nxhSPrGH
         zWnAeN69xoznI/6jZYtmwYT3KWbWTvNrDnx+Es3RWp0i+j2xxaO9dkeXoSKAVdAkmW4+
         U1LvGrhlyMP1hY7KWbto/N5XHH27zDk8Brm/3oEb5jD12Y82b76PFr3aBOLQzTXG2/y/
         rlpoqpyvCSpHYmi46n84dcDWdAj6MD4133leqWy11VCpy8z682dPU9Rmyr7/knUxhjti
         SCaQ==
X-Gm-Message-State: AOAM531AlkdihCnGBztK5TYnSco9YTIIsotCq1SVPnkfrY0er60eTAJ4
        160ebBUFWQ1KxTUQo6k8Yf85Pw==
X-Google-Smtp-Source: ABdhPJw9Sc+hYg9aVI1l6BGSXqVv4RUgo60cW7nmcK/TJrZYOoLiv99sTwFNL4cg6Znq0nfKBLQzjw==
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr4817561wmh.56.1617122705341;
        Tue, 30 Mar 2021 09:45:05 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 04/31] fs: gfs2: glops: Fix a couple of kernel-doc misdemeanours demote others
Date:   Tue, 30 Mar 2021 17:44:31 +0100
Message-Id: <20210330164458.1625478-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/glops.c:58: warning: Function parameter or member 'nr_revokes' not described in '__gfs2_ail_flush'
 fs/gfs2/glops.c:490: warning: Function parameter or member 'gh' not described in 'inode_go_lock'
 fs/gfs2/glops.c:490: warning: Excess function parameter 'gl' description in 'inode_go_lock'
 fs/gfs2/glops.c:490: warning: Excess function parameter 'flags' description in 'inode_go_lock'
 fs/gfs2/glops.c:532: warning: Function parameter or member 'gl' not described in 'inode_go_dump'
 fs/gfs2/glops.c:532: warning: Excess function parameter 'ip' description in 'inode_go_dump'
 fs/gfs2/glops.c:562: warning: Excess function parameter 'state' description in 'freeze_go_sync'
 fs/gfs2/glops.c:562: warning: Excess function parameter 'flags' description in 'freeze_go_sync'
 fs/gfs2/glops.c:607: warning: Function parameter or member 'gh' not described in 'freeze_go_xmote_bh'
 fs/gfs2/glops.c:640: warning: expecting prototype for trans_go_demote_ok(). Prototype was for freeze_go_demote_ok() instead
 fs/gfs2/glops.c:651: warning: Function parameter or member 'remote' not described in 'iopen_go_callback'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/glops.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index ef0b583c3417c..5711b2c8de9e2 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -49,6 +49,7 @@ static void gfs2_ail_error(struct gfs2_glock *gl, const struct buffer_head *bh)
  * __gfs2_ail_flush - remove all buffers for a given lock from the AIL
  * @gl: the glock
  * @fsync: set when called from fsync (not all buffers will be clean)
+ * @nr_revokes: Number of buffers to revoke
  *
  * None of the buffers should be dirty, locked, or pinned.
  */
@@ -478,10 +479,8 @@ int gfs2_inode_refresh(struct gfs2_inode *ip)
 	return error;
 }
 
-/**
+/*
  * inode_go_lock - operation done after an inode lock is locked by a process
- * @gl: the glock
- * @flags:
  *
  * Returns: errno
  */
@@ -522,7 +521,7 @@ static int inode_go_lock(struct gfs2_holder *gh)
 /**
  * inode_go_dump - print information about an inode
  * @seq: The iterator
- * @ip: the inode
+ * @gl: The glock
  * @fs_id_buf: file system id (may be empty)
  *
  */
@@ -553,9 +552,6 @@ static void inode_go_dump(struct seq_file *seq, struct gfs2_glock *gl,
 /**
  * freeze_go_sync - promote/demote the freeze glock
  * @gl: the glock
- * @state: the requested state
- * @flags:
- *
  */
 
 static int freeze_go_sync(struct gfs2_glock *gl)
@@ -597,12 +593,10 @@ static int freeze_go_sync(struct gfs2_glock *gl)
 	return 0;
 }
 
-/**
+/*
  * freeze_go_xmote_bh - After promoting/demoting the freeze glock
  * @gl: the glock
- *
  */
-
 static int freeze_go_xmote_bh(struct gfs2_glock *gl, struct gfs2_holder *gh)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
@@ -630,7 +624,7 @@ static int freeze_go_xmote_bh(struct gfs2_glock *gl, struct gfs2_holder *gh)
 }
 
 /**
- * trans_go_demote_ok
+ * freeze_go_demote_ok()
  * @gl: the glock
  *
  * Always returns 0
@@ -641,7 +635,7 @@ static int freeze_go_demote_ok(const struct gfs2_glock *gl)
 	return 0;
 }
 
-/**
+/*
  * iopen_go_callback - schedule the dcache entry for the inode to be deleted
  * @gl: the glock
  *
-- 
2.27.0

