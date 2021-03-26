Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E346C34A3DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhCZJMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhCZJMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:12:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0789C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u9so7302262ejj.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dDw5EBc2NIDbfXjwrfN0J0Ba7xy8ebZtYdNOOedaL18=;
        b=X7P57wMT5MPqd7rZcUDZZw11LlSTszg7oXbimuWgdioKk9nkUchT2WxL9L66x4n234
         H/t3g4mb6MPJF+EujjYtm6nFJYMc9TtLqcGUVmbVirDBXYXCTYGDICPHqbN6R45pGihx
         +jVF8HQALgqwDfBbj0FuHfXppoRWpUr/hDmEXlxCDvlBHb/vWCO2zyzjVXrbQoRXyhfQ
         i0Lr4KT8rRjzDC1mcrmP2dqRBJFfTqch49OByvZTpjw2Wh30yDhEoWpL1xIpgQ6lSf7v
         XGyvlP+fsPK4ENjEUYr7goHqjFcHpU+suc4sL5eNSupU42eDm8zIkTfeXJkDv4oaHcUy
         xrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dDw5EBc2NIDbfXjwrfN0J0Ba7xy8ebZtYdNOOedaL18=;
        b=UiKdgmuSv9Zkr9/nItMikFs/KtTdT3Xz0zBcSG/Fxolr1kedlEwa76zuf42HOeZEwr
         HlpwJfwVybxZDav6eh/xHm4wNkoMQR/1suJaPfiUEUcHyHB2qq1On+h7jxEnXMG9jt7w
         JD5D4zlhkRilLqD/c66hI6sJKhoWxiHbZ2WGlZX77iZzNjV4SrzyF42gMZRJdNLgBUjI
         4q/Q5WdMdCozFRPTwsrazrHY96lk3LDztXMDW7PCAoHZ5YbO94Z/HjOLMsT2r/YCDROs
         T6Va/HW+Oht77GgZvMT1QrlmoOTEDcgOggX1KfBdrkfZKd8UD/EDFC9msC/GyEUu+vBI
         kIOQ==
X-Gm-Message-State: AOAM5311RiR4y9cro3jfmkFVnOBMW11jL/PVJajkTlE9q6fLTYyNk8bI
        pZ2NdaBuWz/Zz3Sd4dNPeBdXng==
X-Google-Smtp-Source: ABdhPJwkM6j9lU8imYlDo/vSfQp9mpMjEVbgfo99VUa6BnQG8RsyEmnHiKf6leg8wDggLrqKVgWyzQ==
X-Received: by 2002:a17:906:c08f:: with SMTP id f15mr14171512ejz.318.1616749921488;
        Fri, 26 Mar 2021 02:12:01 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:12:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 07/18] fs: gfs2: glock: Fix some deficient kernel-doc headers and demote non-conformant ones
Date:   Fri, 26 Mar 2021 09:11:40 +0000
Message-Id: <20210326091151.311647-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
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

