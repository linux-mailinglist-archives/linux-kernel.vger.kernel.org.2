Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C349234A3D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhCZJMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhCZJMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:12:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C7CC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:11:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hq27so7289299ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WYbiTPqSzjQP21KCxgzf3jq9Q5Hi/UH51yOsRe7KtZc=;
        b=nGZ72e9ZXaNpv090bjtHDzOxxs2UNF/rbFkmC/3ucOaPx/GRSSNUOLNkyUGYOu6tKp
         QU6oManj/xZE1XEwzg9sZaDLhLve4Mx/LVUP8lpTMgFHqVojVglmBHDg8sRu//W4wBwb
         iRhTYBBfRfY9lHcnf5t6gbQ3Ue92+filE3l8svY/VQ1Eu+Plh1p8EdS4Bhlbpm4Kqh6K
         h+7JoVIxEU4TSC/YtbFVkkrl4+EA+TQ+U6rHKI04L8XqfYACiO1EzdFPPy+qr+i+9TFA
         BnprN7cbY6s42sO+IF9aS5kHTLVdoYwPguoJCWxD16oqSNgVRkvWsKg6b3q7lOC4dpBr
         2NoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYbiTPqSzjQP21KCxgzf3jq9Q5Hi/UH51yOsRe7KtZc=;
        b=dhVFMIEJPfFhoR/6MvcAdVTwWYu4oz/W43B1d+XE0VMep8q5rWGAO2/w/2uHgYeNyd
         MJPScTFlFIj0ZjT6YfIyMxOuhiPCPVC2Gp6j7VJYInIGS1YsM8fSv7+m6sGFFVc/x1rO
         iofxu3Tk3FFYYLt7LCFoZOagQLGLxofgHo7MmrAQXAlOef+txMOCRrJaURJnBeHvIJY0
         nbuUzGUPf2NMtZ6i8FwYMCg7uI6SVdLxYHTMqoTPKLxASmNP3VuDctOD58ELIpQSrqml
         0Cv05H9gjQk0xlwPu/ABCXzgJMPH45JTREQe8LkawfcFaVV29+Dv/fbngXi/R3iwuTT5
         MQbw==
X-Gm-Message-State: AOAM530rYtEWaLdRQwl7OLnYs3CQ0WsqLZDQT++VHGXBBnA4xLFkQRM+
        MFxw0MF2TJcewr+2yVfhM87Y4Se7Q1TygQ==
X-Google-Smtp-Source: ABdhPJzhxh6bKTsc9M/4pCgP6YeoeTT+NXowWOj0u+8ROw/hkc+/4rC+y4UBNY8rPoFkU400CJvVrA==
X-Received: by 2002:a17:907:929:: with SMTP id au9mr11099308ejc.28.1616749918643;
        Fri, 26 Mar 2021 02:11:58 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:11:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 04/18] fs: gfs2: glops: Fix a couple of kernel-doc misdemeanours demote others
Date:   Fri, 26 Mar 2021 09:11:37 +0000
Message-Id: <20210326091151.311647-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
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

