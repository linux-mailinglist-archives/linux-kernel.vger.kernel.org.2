Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D2540D04D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 01:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhIOXnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 19:43:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhIOXnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:43:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E7EE60F25;
        Wed, 15 Sep 2021 23:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749304;
        bh=17U7G2GEL3MzW1OeDIp/jd1zHn2nOvyvFwT7HZDGeF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSflpG0HKHC87jCDUS7hYy8G3Npk8xbCVMIrk29yQBGMisafrvopjEik0HirDSiWO
         tXD2nIts7Xrzt/nWMwlyBej29fjjT4PWLXR3lHXztttu26XdMYeqvXkCnQnTTx/rq+
         L2S4rR7i/oTtejhwDJo9tc7pFwbYtdjUoIvoxpa4dqIinpfXrEYaqhKFI3Sks0qpYk
         aJK3e3c0R6LZgW7qRXPc/lGGP1lpf161XrIAkYNZwPndWkLNIfvhBw4X4n+c34ds4G
         CTdVgSRU+GB8boKbg/xx2xBUIFfk6bBYO2UlMLDMfxeJc3tUopHvN2pfmQF4qBxl8b
         8K0RfCF3BsH9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E78465C06B9; Wed, 15 Sep 2021 16:41:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/5] scftorture: Shut down if nonsensical arguments given
Date:   Wed, 15 Sep 2021 16:41:38 -0700
Message-Id: <20210915234141.3907301-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234117.GA3907188@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234117.GA3907188@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If (say) a 10-hour scftorture run is started, but the module parameters
are so nonsensical that the run doesn't even start, then scftorture will
wait the full ten hours when run built into a guest OS.  This commit
therefore shuts down the system in this case so that the error is reported
immediately instead of ten hours hence.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index bc3f8e26345c..31b458b3b113 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -651,6 +651,10 @@ static int __init scf_torture_init(void)
 unwind:
 	torture_init_end();
 	scf_torture_cleanup();
+	if (shutdown_secs) {
+		WARN_ON(!IS_MODULE(CONFIG_SCF_TORTURE_TEST));
+		kernel_power_off();
+	}
 	return firsterr;
 }
 
-- 
2.31.1.189.g2e36527f23

