Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72DB40D0D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhIPA33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233329AbhIPA3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:29:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2F8C61186;
        Thu, 16 Sep 2021 00:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631752081;
        bh=mnUYBMm+3PsftpPaBemVIDmSjDARpd8jr1D+t2WcXtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ms8Pywb+T6oynlAmF+Yg8T+JDB1f//QNp+O7LkUVFL/Xjk4vpCsEOUWfbEnGVEaU4
         o7EgoceUsoAbJGGpBbxghkzQLaXfx7xXdHLj+ZEi8tt931bZBm7dtXkBzi8f+t+4d8
         I6Z3IyZCbxW5nhrQe8UPeIIfqpJDVWWP9hwifn4gMkfHR4rHKzowUkFdtATHALO14y
         rYUTGGYFO9+0FVuZVeww9lYu47O80uiKQtsIxrrb9JmXl0C02yPL81T66/QZvjmNBH
         TvawgekSkSckg4m766iPiAbVuxLSUnAkHUR+v3o5MHr8AsOpPd2vO8s7fvMhKTIUGl
         nl7kFi8Heg2VA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 742315C08E8; Wed, 15 Sep 2021 17:28:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/5] torture: Allot 1G of memory for scftorture runs
Date:   Wed, 15 Sep 2021 17:27:59 -0700
Message-Id: <20210916002800.3910056-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916002710.GA3909915@paulmck-ThinkPad-P17-Gen-1>
References: <20210916002710.GA3909915@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, torture.sh allots 512M of memory for each guest OS.  However,
when running scftorture with KASAN, 1G is needed.  This commit therefore
causes torture.sh to provide the required 1G.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 8e882346d2a6..eae88aacca2a 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -351,7 +351,7 @@ fi
 if test "$do_scftorture" = "yes"
 then
 	torture_bootargs="scftorture.nthreads=$HALF_ALLOTED_CPUS torture.disable_onoff_at_boot"
-	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --configs "$configs_scftorture" --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
+	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --configs "$configs_scftorture" --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --memory 1G --trust-make
 fi
 
 if test "$do_refscale" = yes
-- 
2.31.1.189.g2e36527f23

