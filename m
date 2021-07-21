Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9733D1895
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhGUUWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:22:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhGUUVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EFFE61358;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=ZNpLLJUU+XVJTo9NMU3b9psrlpJjbDsa0MJdt9VHteg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SjOc0wbSQRMBEk9uzRJVn8J7x2LRyvLBjRg5NE1LAAn3m1Ihy+2eERFKafPwqO0dX
         p1mSTG/yweaslRBqIc0cRxpPODFfwlLnEe8tnlUIjl/dKHxBfgDtAjhhGKoD38ZVV4
         edv/1+8r/oH5dxX1ploue+jSrYxgygJy6/IatcVgls2a78IRvQPZbIfTnuc8LbeFz5
         nf3TbhAnUuGo9AIOwG8dH+IDGCkxDh24u4y13Tba98QxMc8IBV6JQiG8yu/TQsefDP
         z/BuwooAkeIhrYxSfG9LD1eHF54v20cgKEBB4eHAUPQrSPhcdvubqdxOcPc2hwnTeJ
         1fmXVWVlPOgRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E08E55C0FA2; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 13/21] torture: Don't redirect qemu-cmd comment lines
Date:   Wed, 21 Jul 2021 14:01:32 -0700
Message-Id: <20210721210140.787717-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kvm-test-1-run-qemu.sh applies redirection to each and every
line of each qemu-cmd script.  Only the first line (the only one that
is not a bash comment) needs to be redirected.  Although redirecting
the comments is currently harmless, just adding to the comment, it is
an accident waiting to happen.  This commit therefore adjusts the "sed"
command to redirect only the qemu-system* command itself.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
index 7c6643d1f0370..2fd0868b357c4 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
@@ -40,7 +40,7 @@ grep '^#' $resdir/qemu-cmd | sed -e 's/^# //' > $T/qemu-cmd-settings
 . $T/qemu-cmd-settings
 
 # Decorate qemu-cmd with redirection, backgrounding, and PID capture
-sed -e 's/$/ 2>\&1 \&/' < $resdir/qemu-cmd > $T/qemu-cmd
+sed -e 's/^[^#].*$/& 2>\&1 \&/' < $resdir/qemu-cmd > $T/qemu-cmd
 echo 'echo $! > $resdir/qemu_pid' >> $T/qemu-cmd
 
 # In case qemu refuses to run...
-- 
2.31.1.189.g2e36527f23

