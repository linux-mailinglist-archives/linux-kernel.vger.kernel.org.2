Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA304351F33
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbhDASzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239965AbhDASvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:51:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8966961002;
        Thu,  1 Apr 2021 18:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617303076;
        bh=fFtkA8Dsy21JzQGQdsJ49vAOC5IF+5fHEEy7tdMz18s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hO0tiQLT6zQHoO8yt3oDHF6RODIRLkKmOfR3NQnk89tfcn+Kyx7YjBLRKKNYrjSyX
         kNpdTqVOJ+C8Y39CeiD4P07p0Ss5GOhRnvf9ighXAubwzhYJi6F9wMzwQNCnSegoCW
         C1LLwWKnFYiHDJZl/h83eDij7kibUmGymeRDe4vkS6Z4YttIURTXJcOt/Ab3ZTk3aF
         K4u256JP/EXPQ3B4hi563tELvv/ngwGD9zSJJo7dht8nnqqFNg2x+X4BodsSbvr+CR
         iirGtgeP708FMngXg1SQJtPUi9XDuux2zyQtzhU/noUhxO6bXELygYwQynqdt4+sk1
         KU28An0GrwDvQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3F3C935237B2; Thu,  1 Apr 2021 11:51:16 -0700 (PDT)
Date:   Thu, 1 Apr 2021 11:51:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] torture: Correctly fetch CPUs for kvm-build.sh with all
 native language
Message-ID: <20210401185116.GH2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210401132602.116352-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401132602.116352-1-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 03:26:02PM +0200, Frederic Weisbecker wrote:
> Grepping for "CPU" on lscpu output isn't always successful, depending
> on the local language setting. As a result, the build can be aborted
> early with:
> 
> 	"make: the '-j' option requires a positive integer argument"
> 
> Prefer a more generic solution.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Good catch, applied, thank you!

There is a similar construct in kvm-remote.sh, so I added a similar
fix to your patch.

But what about this in functions.sh?

nt="`lscpu | grep '^NUMA node0' | sed -e 's/^[^,]*,\([0-9]*\),.*$/\1/'`"

I am guessing that "node0" is human-language-independent, but is "NUMA"?

							Thanx, Paul

------------------------------------------------------------------------

commit cf519a9b736cf7dcd47920065e4de8c1855b5532
Author: Frederic Weisbecker <frederic@kernel.org>
Date:   Thu Apr 1 15:26:02 2021 +0200

    torture: Correctly fetch number of CPUs for non-English languages
    
    Grepping for "CPU" on lscpu output isn't always successful, depending
    on the local language setting.  As a result, the build can be aborted
    early with:
    
            "make: the '-j' option requires a positive integer argument"
    
    This commit therefore uses the human-language-independent approach
    available via the getconf command, both in kvm-build.sh and in
    kvm-remote.sh.
    
    Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index 55f4fc1..5ad973d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -42,7 +42,7 @@ then
 fi
 
 # Tell "make" to use double the number of real CPUs on the build system.
-ncpus="`lscpu | grep '^CPU(' | awk '{ print $2 }'`"
+ncpus="`getconf _NPROCESSORS_ONLN`"
 make -j$((2 * ncpus)) $TORTURE_KMAKE_ARG > $resdir/Make.out 2>&1
 retval=$?
 if test $retval -ne 0 || grep "rcu[^/]*": < $resdir/Make.out | egrep -q "Stop|Error|error:|warning:" || egrep -q "Stop|Error|error:" < $resdir/Make.out
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 0adaf26..92dd1a3 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -136,7 +136,7 @@ chmod +x $T/bin/kvm-remote-*.sh
 # Check first to avoid the need for cleanup for system-name typos
 for i in $systems
 do
-	ncpus="`ssh $i lscpu | grep '^CPU(' | awk '{ print $2 }'`"
+	ncpus="`ssh $i getconf _NPROCESSORS_ONLN 2> /dev/null`"
 	echo $i: $ncpus CPUs " " `date` | tee -a "$oldrun/remote-log"
 	ret=$?
 	if test "$ret" -ne 0
