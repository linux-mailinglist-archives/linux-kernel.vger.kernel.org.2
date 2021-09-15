Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09B140D034
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 01:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhIOXfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 19:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232897AbhIOXfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:35:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F073A61131;
        Wed, 15 Sep 2021 23:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631748825;
        bh=G+c4Zp8HyyHDC/1xdbUnO8ByLENVGrEKTMyNI4qVzWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYUXyzJ/NtJzKizIQxFPc9eLRMx9wieHozd9y50kElSnHAcg1Y9zjI25+XG9/P1Y/
         RZPGDLAQqVnS3hlFUSBmTTIW7uW0/Ic5NgSLv3gJuMGRW5K/la5W2t/DqRZE6fpj1G
         p8U2lLbVRXZU6B+5VbICp6toK+mFLj68K9uUqgpLjz9QQvMjxqmO0Dh9XtA7nIco2Y
         McZOUCCIM2X8EGIEFyJeGtfSo18FB+KQss346kPab4MK8pvTncNHv9zfkurEwPdnD7
         tnbMC9huS/Xo5aRkH5YJztGePk7poQFxjRaNOB3iQmb/UxF9aMxghiqXqBBJXrNONC
         /UUqzkMhG373Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C30D15C0926; Wed, 15 Sep 2021 16:33:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/14] doc: Add another stall-warning root cause in stallwarn.rst
Date:   Wed, 15 Sep 2021 16:33:34 -0700
Message-Id: <20210915233343.3906738-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a bullet item noting that both deficiencies and surpluses
of calls to rcu_*_enter() and rcu_*_exit() can result in RCU CPU stall
warnings.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/stallwarn.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index 5036df24ae61..28f8ad16db25 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -96,6 +96,16 @@ warnings:
 	the ``rcu_.*timer wakeup didn't happen for`` console-log message,
 	which will include additional debugging information.
 
+-	A low-level kernel issue that either fails to invoke one of the
+	variants of rcu_user_enter(), rcu_user_exit(), rcu_idle_enter(),
+	rcu_idle_exit(), rcu_irq_enter(), or rcu_irq_exit() on the one
+	hand, or that invokes one of them too many times on the other.
+	Historically, the most frequent issue has been an omission
+	of either irq_enter() or irq_exit(), which in turn invoke
+	rcu_irq_enter() or rcu_irq_exit(), respectively.  Building your
+	kernel with CONFIG_RCU_EQS_DEBUG=y can help track down these types
+	of issues, which sometimes arise in architecture-specific code.
+
 -	A bug in the RCU implementation.
 
 -	A hardware failure.  This is quite unlikely, but has occurred
-- 
2.31.1.189.g2e36527f23

