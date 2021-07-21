Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC963D187F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhGUUVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhGUUVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C39B61241;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=/ESZUlYdrGjiCp+YpsjY3obpzx8F1Sp0vwmCz5ivZ84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cXhjo0BYlInVNpHGUDlSoSXrgEOlxL1sHcJEPDR4dgijxzRzcb+WBv8bhBohwPVIM
         fw587ySOVTfCX2eWZKtZ1CwUl69tWt/WMcNEUH3RMc4rYAR5QZxfUHkS4JN7EOAX87
         4dipUCwnY49gk5ECuBBXr5eu/KdwmDSxGWsAN+N8N4PK8nfZfDI+FnvEgo0dunlKr6
         eksBJ9FSYl5j/4xlV04iR/kV3zyexL8qqPXJJBDC58pUbibZerngy9b/fhaxyR+an/
         61rqK2qxsgJoICf+C7YKlPmlBdtJ0sf/mI217+xu9i2w3hrhgf9m0yXlf1V1dmFPzB
         raBNaTO8L7sHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CD2C25C0A11; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/21] torture: Enable KCSAN summaries over groups of torture-test runs
Date:   Wed, 21 Jul 2021 14:01:22 -0700
Message-Id: <20210721210140.787717-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kcsan-collapse.sh script assumes that it is being run over the output
of a single kvm.sh run, which is less than helpful for torture.sh runs.
This commit therefore changes the kcsan-collapse.sh script's "ls" pattern
with a "find" command to enable a KCSAN summary across all the -kcsan
runs in a full torture.sh run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh b/tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh
index e5cc6b2f195eb..1af5d6b86b392 100755
--- a/tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh
+++ b/tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh
@@ -14,7 +14,7 @@ if test -z "$TORTURE_KCONFIG_KCSAN_ARG"
 then
 	exit 0
 fi
-cat $1/*/console.log |
+find $1 -name console.log -exec cat {} \; |
 	grep "BUG: KCSAN: " |
 	sed -e 's/^\[[^]]*] //' |
 	sort |
-- 
2.31.1.189.g2e36527f23

