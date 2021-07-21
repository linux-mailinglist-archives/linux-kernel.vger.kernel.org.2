Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A486B3D187D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhGUUVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:32972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhGUUVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1579761221;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=Jby5s1zXUBXsOzmrjKCM7A/fM7oWG8Ow8WF0wUlUSys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aLSxrTMBSZStGHOrkxw8qg/KC9pJwBkS8rj0u+HSl/pbIFb8Ia1QhW2+tykOTaepN
         D0aemyuXrTvJ9K9MH4C+nP1Fe84Yt5giNDD/e6Rf0YAZpcB8m7NcVUN79EvoMpL4OV
         Mgut2JHchsgu2J3UZIzDYFh9GRAVMsJIv6mEheYL4kiIE+ktGKcQuQiy30TdWspZ3x
         3hkKSyEnDhWZ7FtiU9PFf5ZUo+m+e/wOtIZogYJFhLWSxm7xNE6hhtF5EguHIh8a+c
         Npque+PnkaCJEubXjYWlrCH/PY5+a7Osvfh5rNk5QG/3Mis04WxlGpgqdyWGjhXdwd
         AxJis65npVr/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CBAAB5C007F; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/21] torture: Make torture.sh accept --do-all and --donone
Date:   Wed, 21 Jul 2021 14:01:21 -0700
Message-Id: <20210721210140.787717-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, torture.sh accepts --doall on the one hand and --do-none
on the other, which is a bit inconsistent.  This commit therefore adds
--do-all and --donone so that a fully consistent test may be used.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 94802ddfb7a6a..f1d1dff715905 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -111,7 +111,7 @@ do
 		configs_scftorture="$configs_scftorture $2"
 		shift
 		;;
-	--doall)
+	--do-all|--doall)
 		do_allmodconfig=yes
 		do_rcutorture=yes
 		do_locktorture=yes
@@ -141,7 +141,7 @@ do
 	--do-locktorture|--do-no-locktorture)
 		do_locktorture=`doyesno "$1" --do-locktorture`
 		;;
-	--do-none)
+	--do-none|--donone)
 		do_allmodconfig=no
 		do_rcutorture=no
 		do_locktorture=no
-- 
2.31.1.189.g2e36527f23

