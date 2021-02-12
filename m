Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6E331A856
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 00:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhBLX3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 18:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhBLX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 18:29:29 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74231C061786
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 15:28:49 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id w1so690013ilm.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 15:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1wSxvbwUEoDssegEiDIXApZTFvBALKvAL8rqFJ8yZX4=;
        b=DFRS+WXDEc4iZ1ShbpQsHajWLBQKVvhfTN3u7g1O6dJyUV896yDZDOQmFgj9e+KLLS
         34AzYt97lc7Q2hdk4LuOMiCliCRp9ErMbytM4JhkKn2DVY3puRy23XwIdfvFzPlnGIZw
         vCB8+jHiHVwhkDw6Zkvtt0NYFMf1SYbPk5+04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1wSxvbwUEoDssegEiDIXApZTFvBALKvAL8rqFJ8yZX4=;
        b=DFXQSszLC7KR8cOBVwXYOBFDqFFwc9TCqP3nECRcJQyT87N1adSAj07D0wb2AbSLgu
         OZtMsLmM3pfqDuT+zuEdplYYnkr+Iaz1/8ZnH/K/o1iC1luZv5hfMc2h3LVIKgm+OqRC
         gMm7jwefhowWPsTG4aIfs5BgaiATXZba3/hG4swmkIQzFxZADPIE+4HsYHbiw/cvb8pQ
         bxoijl13wcUxkmfGN55Z/hw+kus1wxYcz7tDssxQA3nzkaPDd+dkojbTgrhk1Mz40Hy1
         OnUQe8Xul9w4LNsFs/qdS16Qafe3mBUMzF59mqFb+YchDZB/IAei8wBJbTYhxgxJzXQb
         fgwQ==
X-Gm-Message-State: AOAM5329lFqcjWskLKGJnSmil/9ey/miSJElVxmpMa1ffr7gAy/K0Hbz
        O4+W1BMwJZx43t9oMWVpFw7NAQ==
X-Google-Smtp-Source: ABdhPJxRKCYNptgNLxveP5apbElOd/18CigXfgCySvTQBKH9f6qS/GXTzMlOyyP5wPkJP62xH336qw==
X-Received: by 2002:a05:6e02:4c9:: with SMTP id f9mr4232513ils.186.1613172528970;
        Fri, 12 Feb 2021 15:28:48 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i20sm5180328ilc.2.2021.02.12.15.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 15:28:48 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lockdep: add lockdep_assert_not_held()
Date:   Fri, 12 Feb 2021 16:28:42 -0700
Message-Id: <37a29c383bff2fb1605241ee6c7c9be3784fb3c6.1613171185.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1613171185.git.skhan@linuxfoundation.org>
References: <cover.1613171185.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some kernel functions must not be called holding a specific lock. Doing
so could lead to locking problems. Currently these routines call
lock_is_held() to check for lock hold followed by WARN_ON.

Adding a common lockdep interface will help reduce the duplication of this
logic in the rest of the kernel.

Add lockdep_assert_not_held() to be used in these functions to detect
incorrect calls while holding a lock.

lockdep_assert_not_held() provides the opposite functionality of
lockdep_assert_held() which is used to assert calls that require
holding a specific lock.

The need for lockdep_assert_not_held() came up in a discussion on
ath10k patch. ath10k_drain_tx() and i915_vma_pin_ww() are examples
of functions that can use lockdep_assert_not_held().

Link: https://lore.kernel.org/linux-wireless/871rdmu9z9.fsf@codeaurora.org/
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 include/linux/lockdep.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b9e9adec73e8..567e3a1a27ce 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -294,6 +294,10 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 
 #define lockdep_depth(tsk)	(debug_locks ? (tsk)->lockdep_depth : 0)
 
+#define lockdep_assert_not_held(l)	do {			\
+		WARN_ON(debug_locks && lockdep_is_held(l));	\
+	} while (0)
+
 #define lockdep_assert_held(l)	do {				\
 		WARN_ON(debug_locks && !lockdep_is_held(l));	\
 	} while (0)
@@ -383,8 +387,9 @@ extern int lock_is_held(const void *);
 extern int lockdep_is_held(const void *);
 #define lockdep_is_held_type(l, r)		(1)
 
+#define lockdep_assert_not_held(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held(l)			do { (void)(l); } while (0)
-#define lockdep_assert_held_write(l)	do { (void)(l); } while (0)
+#define lockdep_assert_held_write(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held_read(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held_once(l)		do { (void)(l); } while (0)
 
-- 
2.27.0

