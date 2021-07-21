Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645933D1894
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhGUUWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbhGUUVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65B8F6128C;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=G7jUtXtTZK8bR8Np9YEEsq/UnS/D4TWYXsDUgce0JbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UbkepfLzP/UmoDEJtpBirnXE+TFvpnkfNTORHFRRLZxAIqePS1XzOCooAXbxTq4+Q
         d8PoA1ndH8uLDmvw5VH6g3X6uHMfGzRzpwSgoHwY934Z54KQ1vK3zB43K1wCR3pUkM
         yDTGBdfDEc3J/UQWNjF4CL+aB8XhE0rrjWKWIZVM5soLxQl8GRPjJhzWUBqWbfLddd
         Yjz2j0PJV1Fq6eMgJD4lIwvKHgDlXviMaV2x2DdK4Nf8caL2FIB7aNsyygiB2Fgh7q
         x9FXSb2aGeE+iHzLhbsLn6iC3hQb7SmC3zZeCJt5eSar8n4yI+Z7HNGiM6dYIUzkZ/
         wCksIrF35fGww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D8E315C0E45; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/21] torture: Make kvm-recheck.sh skip kcsan.sum for build-only runs
Date:   Wed, 21 Jul 2021 14:01:28 -0700
Message-Id: <20210721210140.787717-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kvm-recheck.sh attempts to create a kcsan.sum file even for
build-only runs.  This results in false-positive bash errors due to
there being no console.log files in that case.  This commit therefore
makes kvm-recheck.sh skip creating the kcsan.sum file for build-only runs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index e01b31b870441..0a5419982ab3e 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -74,7 +74,10 @@ do
 	done
 	if test -f "$rd/kcsan.sum"
 	then
-		if grep -q CONFIG_KCSAN=y $T
+		if ! test -f $T
+		then
+			:
+		elif grep -q CONFIG_KCSAN=y $T
 		then
 			echo "Compiler or architecture does not support KCSAN!"
 			echo Did you forget to switch your compiler with '--kmake-arg CC=<cc-that-supports-kcsan>'?
-- 
2.31.1.189.g2e36527f23

