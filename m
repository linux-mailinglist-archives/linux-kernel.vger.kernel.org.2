Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F073D1880
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhGUUVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhGUUVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FCB561222;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=kPy6NejNU+zhKsFjtTBpT7qPm6CzwTsw91RV0KQ+WRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pgr0ofmQKrMHGl22T34l+qeSQYsKdas98X2d1YLhoUX967KIoRUCYwpD0WL02dpCj
         7g5fuXIK37+eLxN2SwYQDQ0RStLFJbE+Ke+Tx8VwBcd+zXu7xBp8SZwRY/Acj0cV/V
         cTlUiZHtAe1SsvtzkhabDb4ZB1JX/KrDHlH5nGI0FeElyuuVDBwpletmYMVH5gOOP7
         sMNAg2E5N1U+l5XN4CjLTrnw93QnQo6+cUP/ZufwLxc+f/h81sp6eY3+4oWCWNTIhU
         JiH5wpIRxh1HFqlXPOmtiE7Bu2ucaGbQB+De0Edi9jeQEnaB4TWcPhwQheQAWvIVBJ
         fuyMHGcXV/LAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D158B5C0BF4; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/21] torture: Make kvm-recheck-scf.sh tolerate qemu-cmd comments
Date:   Wed, 21 Jul 2021 14:01:24 -0700
Message-Id: <20210721210140.787717-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qemu-cmd file can contain comments that are not relevant to the
operation of kvm-recheck-scf.sh.  This commit therefore strips these
comments before looking for timing information.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh
index 671bfee4fcef4..3afa5c6eda4f7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh
@@ -25,7 +25,7 @@ if test -z "$nscfs"
 then
 	echo "$configfile ------- "
 else
-	dur="`sed -e 's/^.* scftorture.shutdown_secs=//' -e 's/ .*$//' < $i/qemu-cmd 2> /dev/null`"
+	dur="`grep -v '^#' $i/qemu-cmd | sed -e 's/^.* scftorture.shutdown_secs=//' -e 's/ .*$//' 2> /dev/null`"
 	if test -z "$dur"
 	then
 		rate=""
-- 
2.31.1.189.g2e36527f23

