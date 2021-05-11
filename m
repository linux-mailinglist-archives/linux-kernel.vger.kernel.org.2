Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1811837B241
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhEKXNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:13:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhEKXNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:13:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC57A61626;
        Tue, 11 May 2021 23:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774744;
        bh=yW/bPXoZvbZ/PrEsF7iWCS6yXYGzwnJ4SP7LfbMCofk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j1mkovdI4SLqURfXWPD0dHqmMdd/ZYW0kDzFgTvVEopxmJ4ut76SlB9XSE/koJSOY
         icuusSx9tOAL6oj1FkPgZ2kFecunqZ+/cEz4fHY4XyzGdPd1baaGr0OkbNonfG2nzw
         HUWvPVGe9/f4Nus84Q+7xZXnDxOCn7s6k7cteD0UF/wNjZ7qcdyXub9fxYZXEZ4kV1
         EEJQc61IE4HwV1MSZII/7Ov374s1Qrk+tIOn4d3/Wpjbf9dElL74qfc/OAAbI1k9Wc
         g29NKpBBqyg5nZ1x3SPCx4lOlh1LoYDVzpiHhvGmdJoYDI7Gfp2SgIYhF9W/Qe2OJW
         G7Xb9pT+Usa3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 700005C0B55; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/26] refscale: Allow CPU hotplug to be enabled
Date:   Tue, 11 May 2021 16:12:01 -0700
Message-Id: <20210511231223.2895398-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is no longer possible to disable CPU hotplug in many configurations,
which means that the CONFIG_HOTPLUG_CPU=n lines in refscale's Kconfig
options are just a source of useless diagnostics.  In addition, refscale
doesn't do CPU-hotplug operations in any case.  This commit therefore
changes these lines to read CONFIG_HOTPLUG_CPU=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT | 2 +-
 tools/testing/selftests/rcutorture/configs/refscale/PREEMPT   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
index 1cd25b7314e3..ad505a887bec 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
@@ -7,7 +7,7 @@ CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_FAST_NO_HZ=n
-CONFIG_HOTPLUG_CPU=n
+CONFIG_HOTPLUG_CPU=y
 CONFIG_SUSPEND=n
 CONFIG_HIBERNATION=n
 CONFIG_RCU_NOCB_CPU=n
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT b/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
index d10bc694f42c..4f08e641bb6b 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
@@ -7,7 +7,7 @@ CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_FAST_NO_HZ=n
-CONFIG_HOTPLUG_CPU=n
+CONFIG_HOTPLUG_CPU=y
 CONFIG_SUSPEND=n
 CONFIG_HIBERNATION=n
 CONFIG_RCU_NOCB_CPU=n
-- 
2.31.1.189.g2e36527f23

