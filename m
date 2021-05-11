Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AB337B246
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhEKXNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhEKXNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:13:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E7E361947;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=xytC81gJmsGL9Gr9NhMWWqOZKyYewqeUWyHvyCGDZjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o54uNpq6o6gPUbYuh1BUScZPzCtqywzzrYEgK5b/yIyBbhYUf4z56ounW8J5Oi9th
         SDntnHRNCZyM7swSThnByykEv2ADjF0mXUQH2xcEV6OKXy9MX3D4cPQZf3cG2xsKpv
         OtJm6Gzu6MfNsESp31U9LZqbv1vkpngK9Xa3KopmZhUiEUtQbxWoSLgTyvk5ZVjn0Z
         Rj8bALQpHHG3HQ2OMDJcHxrDAqBX/Cuy0g3C3hAGzjLHtBsVsrkKmC9eIBK37IecdW
         cAmUuapuNFXv3oxurR7T1Es1ZMDz696oC+9d3X/Xlvr8UwzvNUkfGdR/l39GHRB2ZA
         7L7idsyqB32JA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 80FE35C0DFD; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/26] torture: Make kvm-find-errors.sh account for kvm-remote.sh
Date:   Tue, 11 May 2021 16:12:10 -0700
Message-Id: <20210511231223.2895398-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kvm-find-errors.sh assumes that if "--buildonly" appears in
the log file, then the run did builds but ran no kernels.  This breaks
with kvm-remote.sh, which uses kvm.sh to do a build, then kvm-again.sh
to run the kernels built on remote systems.  This commit therefore adds
a check for a kvm-remote.sh run.

While in the area, this commit checks for "--build-only" as well as
"--build-only".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
index 0670841122d8..daf64b507038 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -43,7 +43,7 @@ then
 else
 	echo No build errors.
 fi
-if grep -q -e "--buildonly" < ${rundir}/log
+if grep -q -e "--build-\?only" < ${rundir}/log && ! test -f "${rundir}/remote-log"
 then
 	echo Build-only run, no console logs to check.
 	exit $editorret
-- 
2.31.1.189.g2e36527f23

