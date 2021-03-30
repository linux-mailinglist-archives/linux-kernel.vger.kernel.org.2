Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEBB34EE31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhC3QpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhC3QpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:09 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AC7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo8756763wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dDw5EBc2NIDbfXjwrfN0J0Ba7xy8ebZtYdNOOedaL18=;
        b=tB64OyfkremmQN5Lxk4mZ1ZV5XTwHIqVCy8P3EjOfHK3GW1+WRl4uzQqO4sBlRBcwe
         tZ11xEsnwaTH3n1lzXp6Jgp9eB/NVSt6dLKIwzdAznOI7O1bNJ91h+bMlkP3V+e59IxT
         Ngz1bbeXGKnV73umvPJCLx9+hZo7VME2rfM/9HlbUqhG0DsWC0R3JJOcgSEMs3t0wBLW
         zcU0pZKNZQPUF5Pzz7GKGmrHlc5RgAR5P7nR1BK2xhXneqf6jFBBkkhr8BvTO73M/cfq
         27PJvtmvrORM9pOSZfcAzNeuhvVYAIMBms6xxprokLIaRK8KC92vVUa7ICO2JKLsfb7t
         ouOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dDw5EBc2NIDbfXjwrfN0J0Ba7xy8ebZtYdNOOedaL18=;
        b=o6vaiKqFshSaV6tEcjK2qD9tYuONVbm+eXK6fGotvmoLAkGqdQ9+GDjZ2YCWNACvuk
         /nUhMjmGDL48EQ93n9seJqgrdleSz/0udhQq9QsWXBAKZIjJnHzSxeavzAdjExW3Nh+b
         uOMDHGjuNBXInWmSytG59LW4v5f0KTAodUzdftDNNe9H/Uu54Eib6CTK9R9y6IB5D8Tw
         ZTD5klTtS9GYZq+p3zL48sSTZZDAJqpcXY8VeFRI146QJ8VQljcZwC0RlQaFRgrNMk4n
         lTwZqxtsinHMrvXAnXsS0Nn5VwZsKJMZi+ceSlntL2JaqTsWDrbyPB49R04Yrnm2Bysd
         SSXA==
X-Gm-Message-State: AOAM531G2MlOROeoKvPE6SICnOnKMu34rSqGaNvYs7kAY8Kb7oPFcFun
        qvPRNrgZh6BLnKqJfoEhZeOuOCX/kjygnw==
X-Google-Smtp-Source: ABdhPJweOxPa1+8eE5m33CxyD6v1omczvxeDd+pXvbLfgAow70mN+MDiVOpC3dh3UQ3iyMrn/U0glQ==
X-Received: by 2002:a1c:4382:: with SMTP id q124mr5078916wma.16.1617122708085;
        Tue, 30 Mar 2021 09:45:08 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 07/31] fs: gfs2: glock: Fix some deficient kernel-doc headers and demote non-conformant ones
Date:   Tue, 30 Mar 2021 17:44:34 +0100
Message-Id: <20210330164458.1625478-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/glock.c:365: warning: Function parameter or member 'gl' not described in 'do_error'
 fs/gfs2/glock.c:365: warning: Function parameter or member 'ret' not described in 'do_error'
 fs/gfs2/glock.c:461: warning: Function parameter or member 'new_state' not described in 'state_change'
 fs/gfs2/glock.c:1277: warning: Function parameter or member 'delay' not described in 'handle_callback'
 fs/gfs2/glock.c:1277: warning: Function parameter or member 'remote' not described in 'handle_callback'
 fs/gfs2/glock.c:1578: warning: Function parameter or member 'p' not described in 'nq_m_sync'
 fs/gfs2/glock.c:1993: warning: Excess function parameter 'wait' description in 'gfs2_gl_hash_clear'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/glock.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 7cccc5e863a8a..c590e27aaf097 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -356,7 +356,7 @@ static void gfs2_holder_wake(struct gfs2_holder *gh)
 	}
 }
 
-/**
+/*
  * do_error - Something unexpected has happened during a lock request
  *
  */
@@ -453,8 +453,7 @@ static inline struct gfs2_holder *find_first_waiter(const struct gfs2_glock *gl)
 /**
  * state_change - record that the glock is now in a different state
  * @gl: the glock
- * @new_state the new state
- *
+ * @new_state: the new state
  */
 
 static void state_change(struct gfs2_glock *gl, unsigned int new_state)
@@ -1263,7 +1262,7 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs)
 	return ret;
 }
 
-/**
+/*
  * handle_callback - process a demote request
  * @gl: the glock
  * @state: the state the caller wants us to change to
@@ -1568,6 +1567,7 @@ static int glock_compare(const void *arg_a, const void *arg_b)
  * nq_m_sync - synchonously acquire more than one glock in deadlock free order
  * @num_gh: the number of structures
  * @ghs: an array of struct gfs2_holder structures
+ * @p: placeholder for the holder structure to pass back
  *
  * Returns: 0 on success (all glocks acquired),
  *          errno on failure (no glocks acquired)
@@ -1984,7 +1984,6 @@ static void dump_glock_func(struct gfs2_glock *gl)
 /**
  * gfs2_gl_hash_clear - Empty out the glock hash table
  * @sdp: the filesystem
- * @wait: wait until it's all gone
  *
  * Called when unmounting the filesystem.
  */
-- 
2.27.0

