Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F573D1875
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhGUUOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229841AbhGUUOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:14:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66C95611C1;
        Wed, 21 Jul 2021 20:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626900911;
        bh=lwGCCLLRxD/zF8v0rUDtLAsLAq5VfjL8yHIso29kuwI=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=tD5Gd+zfbqUoG8eqT/VlNQ+4bjhLnXnCFVZXe5agaikHPjyxb5nSWkwYRw2i/V4ji
         pI0JK7bpVlwPTT+b0BVebjYP6n8ZGwzLYcHdMX+B6cyb6d0gZBnSG04SoXYs5KnGGZ
         cVC3AgqCIJH+kirfORMflET/pMifL83hP6IONZNxO7yd2C+DO/yjPed0Anb5bBLb6E
         zhYsnS43t+RTFdN2MvfuvKr9ukRXFx+f7iLVTsh80vV+lWIRLiFkTyR/aJX9pac0/X
         V/EDH8G2NOI6W4gk2spOlN+cYgrgH29r4ewUZDbp2VA8HEtNRo7g880PeoFa4hTycV
         ppFh6Cbp+8jtQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 353D85C09A4; Wed, 21 Jul 2021 13:55:11 -0700 (PDT)
Date:   Wed, 21 Jul 2021 13:55:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/21] Torture-test scripting updates for v5.15
Message-ID: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains torture-test scripting updates:

1.	Add clocksource-watchdog testing to torture.sh.

2.	Make torture.sh accept --do-all and --donone.

3.	Enable KCSAN summaries over groups of torture-test runs.

4.	Create KCSAN summaries for torture.sh runs.

5.	Make kvm-recheck-scf.sh tolerate qemu-cmd comments.

6.	Make kvm-recheck-lock.sh tolerate qemu-cmd comments.

7.	Log more kvm-remote.sh information.

8.	Protect kvm-remote.sh directory trees from /tmp reaping.

9.	Make kvm-recheck.sh skip kcsan.sum for build-only runs.

10.	Move parse-console.sh call to PATH-aware scripts.

11.	Put kvm.sh batch-creation awk script into a temp file.

12.	Make kvm.sh select per-scenario affinity masks.

13.	Don't redirect qemu-cmd comment lines.

14.	Make kvm-test-1-run-qemu.sh apply affinity.

15.	Upgrade two-CPU scenarios to four CPUs.

16.	Use numeric taskset argument in jitter.sh.

17.	Consistently name "qemu*" test output files.

18.	Make kvm-test-1-run-batch.sh select per-scenario affinity masks.

19.	Don't use "test" command's "-a" argument.

20.	Add timestamps to kvm-test-1-run-qemu.sh output.

21.	Make kvm-test-1-run-qemu.sh check for reboot loops.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/testing/selftests/rcutorture/bin/jitter.sh               |   10 
 b/tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh       |    2 
 b/tools/testing/selftests/rcutorture/bin/kvm-again.sh            |    2 
 b/tools/testing/selftests/rcutorture/bin/kvm-assign-cpus.sh      |  105 ++++++++++
 b/tools/testing/selftests/rcutorture/bin/kvm-get-cpus-script.sh  |   87 ++++++++
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck-lock.sh     |    2 
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh      |    2 
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh          |    5 
 b/tools/testing/selftests/rcutorture/bin/kvm-remote-noreap.sh    |   30 ++
 b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh           |   15 +
 b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh |    1 
 b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh  |    2 
 b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh       |    1 
 b/tools/testing/selftests/rcutorture/bin/kvm.sh                  |   27 +-
 b/tools/testing/selftests/rcutorture/bin/torture.sh              |   29 ++
 b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01          |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS01         |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS03         |    2 
 tools/testing/selftests/rcutorture/bin/kvm-again.sh              |    2 
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh             |    7 
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh   |   23 ++
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh    |   57 +++--
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh         |    1 
 tools/testing/selftests/rcutorture/bin/kvm.sh                    |   14 +
 tools/testing/selftests/rcutorture/bin/torture.sh                |    8 
 25 files changed, 373 insertions(+), 65 deletions(-)
