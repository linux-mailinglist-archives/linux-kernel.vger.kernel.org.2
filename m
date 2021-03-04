Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9550C32C932
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357105AbhCDBFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:05:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452913AbhCDAjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0500964EFE;
        Thu,  4 Mar 2021 00:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818294;
        bh=X+X5aGDSUcEXzNg8QYZiUVyEbqjaU5ZI7wxq2eG7nYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J44SxAYKMVk7ukEey5iA7XzEtssVhnq5FGOBEmm6rWbq2DCSThfqgSrnuG4qXBu1r
         rnhWZi16ZBDECg9w9DIwOKzLuXcg7XTUIusDwwMh9VuOgQbcOX0wYmxcf1alLyhp57
         1NlHEwaHPbBEJPyuD+1W+bzEHiSAupwJHzVcNYMrM+xvyta8WLMbQaqmogW9+ue+ej
         rnSAQXZXxU6yd/JBReux9qWrXwNBLDk3XwT+VHd1H1J80qdyiyrPsVup+/StnMO3te
         uxAd1Ow3k4kPQs9ibAJjoX8V7JAMl1rgPyeA0th/Ew62Jdtu/jzSRq6fmZg8gct8rZ
         MbjAf5qFBozZg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/28] torture: Improve readability of the testid.txt file
Date:   Wed,  3 Mar 2021 16:37:48 -0800
Message-Id: <20210304003812.24833-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The testid.txt file was intended for occasional in extremis use, but
now that the new "bare-metal" file references it, it might see more use.
This commit therefore labels sections of output and adds spacing to make
it easier to see what needs to be done to make a bare-metal build tree
match an rcutorture build tree.

Of course, you can avoid this whole issue by building your bare-metal
kernel in the same directory in which you ran rcutorture, but that might
not always be an option.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 35a2132..1de198d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -404,11 +404,16 @@ echo $scriptname $args
 touch $resdir/$ds/log
 echo $scriptname $args >> $resdir/$ds/log
 echo ${TORTURE_SUITE} > $resdir/$ds/TORTURE_SUITE
-pwd > $resdir/$ds/testid.txt
+echo Build directory: `pwd` > $resdir/$ds/testid.txt
 if test -d .git
 then
+	echo Current commit: `git rev-parse HEAD` >> $resdir/$ds/testid.txt
+	echo >> $resdir/$ds/testid.txt
+	echo ' ---' Output of "'"git status"'": >> $resdir/$ds/testid.txt
 	git status >> $resdir/$ds/testid.txt
-	git rev-parse HEAD >> $resdir/$ds/testid.txt
+	echo >> $resdir/$ds/testid.txt
+	echo >> $resdir/$ds/testid.txt
+	echo ' ---' Output of "'"git diff HEAD"'": >> $resdir/$ds/testid.txt
 	git diff HEAD >> $resdir/$ds/testid.txt
 fi
 ___EOF___
-- 
2.9.5

