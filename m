Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F46F32C942
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387982AbhCDBGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:06:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452956AbhCDAj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7724664F39;
        Thu,  4 Mar 2021 00:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818296;
        bh=n6LhP0Y12SLSBIwlyZzUt0iEBJge2w42uCMwLkPnLj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKEubHRjs7ZXP27q45SqHOMUF7oBRkwSd5BlRhtn4AKmkNWdDBbVGi4mmmekcpBaK
         Mgrjd7MIpPkUCt+OqR3zf3EzAJPtQ4VDpjTfpNlWyCR4NTR7ZG1TnZSjbq5FKJnaLq
         j2L8ANt8FOZ7n0NvEr5hWrKbHrSMdvvCEyZfff0qVaalrn4s7mQkiNpWZC0SZh0ywa
         O3A5TIzsqGMgLihW15l/EuMZXwg6UQJ5HBhhp8gv5iReNFvbQ55HC63s0aOOLZ/cMK
         6xuM0GAgPJTbmqdk1n4jC+TOnW2cJ9xHDthj0mJJUOe72IOM6mgvsjtmjMok6DM0EC
         ggBnEUtsCKMoQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 17/28] torture: Remove no-mpstat error message
Date:   Wed,  3 Mar 2021 16:38:01 -0800
Message-Id: <20210304003812.24833-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The cpus2use.sh script complains if the mpstat command is not available,
and instead uses all available CPUs.  Unfortunately, this complaint
goes to stdout, where it confuses invokers who expect a single number.
This commit removes this error message in order to avoid this confusion.
The tendency of late has been to give rcutorture a full system, so this
should not cause issues.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/cpus2use.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/cpus2use.sh b/tools/testing/selftests/rcutorture/bin/cpus2use.sh
index 1dbfb62..6bb9930 100755
--- a/tools/testing/selftests/rcutorture/bin/cpus2use.sh
+++ b/tools/testing/selftests/rcutorture/bin/cpus2use.sh
@@ -21,7 +21,6 @@ then
 		awk -v ncpus=$ncpus '{ print ncpus * ($7 + $NF) / 100 }'`
 else
 	# No mpstat command, so use all available CPUs.
-	echo The mpstat command is not available, so greedily using all CPUs.
 	idlecpus=$ncpus
 fi
 awk -v ncpus=$ncpus -v idlecpus=$idlecpus < /dev/null '
-- 
2.9.5

