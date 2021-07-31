Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62763DC4FC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 10:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhGaI1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 04:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhGaI1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 04:27:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCD7C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 01:26:57 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso17764123pjo.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 01:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nd7PzJX7+jqe7frYn0qs43GsaGl8y9GB3YlzBIkjvSg=;
        b=In1GBHETrUvRO4qRIm5DeTr9wI4tS2t8opQEALIP1jBGe5Hu90iJag5PLov6HIl1u3
         PsaE8ivBkT4IPi1OBmBP9lkMKhJM5IySeGgBbhAmYeYBqDAXkZyOfrRbYJ7bUOCGYubO
         2h1ukuENnKKN88E5Gjv1NNTiWDiEdqPFzUIKvb0U3bB9CkChgYkQPBNSUZ2u1hMLPTpT
         EV/v/VKQe6tVFygm/++UjyeifcIF0XfeLUMQlRSCL/lDd/q2v2WMaeBqXjfSPpcN585/
         VEhCZwXYxH0vyppwdU0adJ6agqAk6Ia8+tg5zR4hoW81+xyc2Tanpp52FQZ5UPt3WC1i
         Xzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nd7PzJX7+jqe7frYn0qs43GsaGl8y9GB3YlzBIkjvSg=;
        b=HVaSP2uCzqcERcmu2MYHvb7lZCYLETekxsq8Bm/SS9UgZNvsJ5VReTzDvUz7kKhDXL
         K9CIkwPBlTbwDkPNz0MMtTwwiFMqa4HP5xYrfnXie8ZojHWorUJah2LOHpe4H2+frgw9
         6x25LIUyWbPLjL/7NRkypUsnuocQp5evSWYsam7CXnFhp0Fj9QsHu0kYyuQg13OLTd+i
         15lT+nySS7o/6bwQqN5McSnEzwkS/uTRbs0jceeFGS0lU8HvaPrWuO7aV5dsbrYh2dig
         87eWwSglt/ufpoCD+M+nFfwoGbfJVy7X3HFWY8Lg5Iv5TxedqBf048J67gteamRLsB0v
         lYcw==
X-Gm-Message-State: AOAM5313rnzdVs82zZ0fBoFfvH5XDk7VeqNiJ1tbJOShEVbMD7ELPnui
        uZsJf5nImt9aHDqVlckiRpc=
X-Google-Smtp-Source: ABdhPJzGSOgepM9aYsge5ies+HiLoHnc7FISxhflo7Hd7sFszNH59EM+CFVFwjB6wvaZmoFx1t/XFw==
X-Received: by 2002:a63:4b0a:: with SMTP id y10mr5827758pga.437.1627720016657;
        Sat, 31 Jul 2021 01:26:56 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id mq7sm3182124pjb.50.2021.07.31.01.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 01:26:56 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 1/2] locking/lockdep: Provide lockdep_assert{,_once}() helpers
Date:   Sat, 31 Jul 2021 16:24:57 +0800
Message-Id: <20210731082458.1962043-2-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210731082458.1962043-1-desmondcheongzx@gmail.com>
References: <20210731082458.1962043-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Extract lockdep_assert{,_once}() helpers to more easily write composite
assertions like, for example:

	lockdep_assert(lockdep_is_held(&drm_device.master_mutex) ||
		       lockdep_is_held(&drm_file.master_lookup_lock));

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Waiman Long <longman@redhat.com>
---
 include/linux/lockdep.h | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 5cf387813754..9fe165beb0f9 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -306,31 +306,29 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 
 #define lockdep_depth(tsk)	(debug_locks ? (tsk)->lockdep_depth : 0)
 
-#define lockdep_assert_held(l)	do {					\
-		WARN_ON(debug_locks &&					\
-			lockdep_is_held(l) == LOCK_STATE_NOT_HELD);	\
-	} while (0)
+#define lockdep_assert(cond)		\
+	do { WARN_ON(debug_locks && !(cond)); } while (0)
 
-#define lockdep_assert_not_held(l)	do {				\
-		WARN_ON(debug_locks &&					\
-			lockdep_is_held(l) == LOCK_STATE_HELD);		\
-	} while (0)
+#define lockdep_assert_once(cond)	\
+	do { WARN_ON_ONCE(debug_locks && !(cond)); } while (0)
 
-#define lockdep_assert_held_write(l)	do {			\
-		WARN_ON(debug_locks && !lockdep_is_held_type(l, 0));	\
-	} while (0)
+#define lockdep_assert_held(l)		\
+	lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
 
-#define lockdep_assert_held_read(l)	do {				\
-		WARN_ON(debug_locks && !lockdep_is_held_type(l, 1));	\
-	} while (0)
+#define lockdep_assert_not_held(l)	\
+	lockdep_assert(lockdep_is_held(l) != LOCK_STATE_HELD)
 
-#define lockdep_assert_held_once(l)	do {				\
-		WARN_ON_ONCE(debug_locks && !lockdep_is_held(l));	\
-	} while (0)
+#define lockdep_assert_held_write(l)	\
+	lockdep_assert(lockdep_is_held_type(l, 0))
 
-#define lockdep_assert_none_held_once()	do {				\
-		WARN_ON_ONCE(debug_locks && current->lockdep_depth);	\
-	} while (0)
+#define lockdep_assert_held_read(l)	\
+	lockdep_assert(lockdep_is_held_type(l, 1))
+
+#define lockdep_assert_held_once(l)		\
+	lockdep_assert_once(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
+
+#define lockdep_assert_none_held_once()		\
+	lockdep_assert_once(!current->lockdep_depth)
 
 #define lockdep_recursing(tsk)	((tsk)->lockdep_recursion)
 
@@ -407,6 +405,9 @@ extern int lock_is_held(const void *);
 extern int lockdep_is_held(const void *);
 #define lockdep_is_held_type(l, r)		(1)
 
+#define lockdep_assert(c)			do { } while (0)
+#define lockdep_assert_once(c)			do { } while (0)
+
 #define lockdep_assert_held(l)			do { (void)(l); } while (0)
 #define lockdep_assert_not_held(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held_write(l)		do { (void)(l); } while (0)
-- 
2.25.1

