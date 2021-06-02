Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD553987FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhFBLXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbhFBLW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:22:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1865FC0613CE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 04:21:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g18so1939289pfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 04:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7dosWzwtv7DPTXoHTi0bqiHjQa1x/uAPkSegQiIScX4=;
        b=jPNB8JczwwUlkiUr8SpgRXPg49bR17vb6LZ8lu+rqrpJgzzKDgn+LMyNYB9pIeYYgc
         xnS5r4mJu8cIX9N7l2zz/DRnCeCYmJbY4aySNF/5plACp5k28bejupN1uUS+BdUqI59J
         /SfPdzAzSX3sWKqOyJqpFtU4lbvodpZG43LSzrJtqlvCpUK03zxpQwSxWw7NHpZJSXhs
         ay1iSubddB9VNX0PDZwkbaQiAUz+LeVo/oXufH+xwIEPgZ9fd12A0FXRnuyB7fSvE+v5
         qAVcEc2lfFGy0LRm6u2TbubR9kWZhEtSjlgotPt1uSKoPxe679t1oQLgNZZMHiC6w5RY
         /Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7dosWzwtv7DPTXoHTi0bqiHjQa1x/uAPkSegQiIScX4=;
        b=INAZQ7bvE2ESUk+3Pye00KnGXR1a8wIF8AX5u6JmENdptvk7gxQz7fVVbkkA/0DVLz
         hkQhJw57cAHDz4gyX0Cd+JUBKeBp00eOIhRioL4XabRQP6yzE+euQY5vZeUJTAP7jEDZ
         TktET0V+38kXbzXIn66kKomLjQzeRKMZ0BhtLXfc8xbz6SSf2OC0R31Pt5GFipL/TspK
         6jeQdNhILp4ThKG8ArXa8uTS9VHKTPnwOYwFuFxBYDfuRtHYxlqDnMH6OQB2GVuaMcaU
         R7hN+s6gstyk4buFEs3a3W5EfmZGXbHMfZfaU0yn6+WEgC+V5HFjzuIiHM18MhxhDSff
         iuWg==
X-Gm-Message-State: AOAM533GB6d3SJ4pwwskVaa6q03i3EcjVUHpAMCZCnaeDUKQZ5IzInHb
        OjrSTSo6mylFu/DBLnchv50=
X-Google-Smtp-Source: ABdhPJy/gtb/idpV2jS4/8XPI7EXt6DorO4p9T5QrbZl5Ksl3eCDvHp2gu+93zFu/zaazBSeUXZoeg==
X-Received: by 2002:a62:a10a:0:b029:2e9:b9b9:3e8a with SMTP id b10-20020a62a10a0000b02902e9b9b93e8amr19019068pff.50.1622632872593;
        Wed, 02 Jun 2021 04:21:12 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:e1cd:3d8c:8632:da1b])
        by smtp.gmail.com with ESMTPSA id p26sm4260663pfw.178.2021.06.02.04.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 04:21:11 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Guenter Roeck <groeck@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] sched/debug: remove obsolete init_schedstats()
Date:   Wed,  2 Jun 2021 04:21:08 -0700
Message-Id: <20210602112108.1709635-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

Revert "sched/debug: Fix 'schedstats=enable' cmdline option"

This reverts commit 4698f88c06b893f2acc0b443004a53bf490fde7c.

After commit 6041186a3258 ("init: initialize jump labels before command
line option parsing") we can rely on jump label infra being ready for use
when setup_schedstats() is called.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Guenter Roeck <groeck@google.com>
Cc: Kees Cook <keescook@chromium.org>
---
 kernel/sched/core.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5226cc26a095f427dafa864ff37d39d529e2ba85..105fa6c73e7d9ded05683ee43a11e3b4461932d5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3648,7 +3648,6 @@ int sysctl_numa_balancing(struct ctl_table *table, int write,
 #ifdef CONFIG_SCHEDSTATS
 
 DEFINE_STATIC_KEY_FALSE(sched_schedstats);
-static bool __initdata __sched_schedstats = false;
 
 static void set_schedstats(bool enabled)
 {
@@ -3672,16 +3671,11 @@ static int __init setup_schedstats(char *str)
 	if (!str)
 		goto out;
 
-	/*
-	 * This code is called before jump labels have been set up, so we can't
-	 * change the static branch directly just yet.  Instead set a temporary
-	 * variable so init_schedstats() can do it later.
-	 */
 	if (!strcmp(str, "enable")) {
-		__sched_schedstats = true;
+		set_schedstats(true);
 		ret = 1;
 	} else if (!strcmp(str, "disable")) {
-		__sched_schedstats = false;
+		set_schedstats(false);
 		ret = 1;
 	}
 out:
@@ -3692,11 +3686,6 @@ static int __init setup_schedstats(char *str)
 }
 __setup("schedstats=", setup_schedstats);
 
-static void __init init_schedstats(void)
-{
-	set_schedstats(__sched_schedstats);
-}
-
 #ifdef CONFIG_PROC_SYSCTL
 int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
@@ -3718,8 +3707,6 @@ int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 	return err;
 }
 #endif /* CONFIG_PROC_SYSCTL */
-#else  /* !CONFIG_SCHEDSTATS */
-static inline void init_schedstats(void) {}
 #endif /* CONFIG_SCHEDSTATS */
 
 /*
@@ -8258,8 +8245,6 @@ void __init sched_init(void)
 #endif
 	init_sched_fair_class();
 
-	init_schedstats();
-
 	psi_init();
 
 	init_uclamp();
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

