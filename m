Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750F33D18B9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhGUU1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhGUU1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:27:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9DA66141D;
        Wed, 21 Jul 2021 21:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901695;
        bh=y6J5vXLUwlegUeg+p1pDdX4EkKZ8K47WGIlMuycdlDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFJvoaHl1zg4qRIswqa7avhOlMcpYhLg7tmZ6WDJAlYtI1vWELzXZ0HTU1PewbaR+
         scKga1aVuKjxsKWpTZmUi2d/qOhlmOFx9B7h5tVLS9NcWddHt3KfZ2yJ4oYtMm/XDA
         kfaosGcO4OZcRDMjrwUL7tXbltlKPcWIRHmnpCN+6z+/4WHVNbyr8Dv+DLFwHje7Xw
         AGeQ4aRR1rRdydCHKSTRIdAEJcwd6OiL1nXD7C8IyzgvrhJV0ftX3ejyLfat+WzCgo
         vA1iLFEeWRUT6gNPcsRKMTa7gOxNBCj7Uwcs/ECVRT00XofCR/LenA42ikfC69VKBm
         U7hx0YBabB8PQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7285E5C0D47; Wed, 21 Jul 2021 14:08:14 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 8/8] kcsan: Make strict mode imply interruptible watchers
Date:   Wed, 21 Jul 2021 14:08:12 -0700
Message-Id: <20210721210812.844740-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

If CONFIG_KCSAN_STRICT=y, select CONFIG_KCSAN_INTERRUPT_WATCHER as well.

With interruptible watchers, we'll also report same-CPU data races; if
we requested strict mode, we might as well show these, too.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/Kconfig.kcsan | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 26f03c754d39b..e0a93ffdef30e 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -150,7 +150,8 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
 	  KCSAN_WATCH_SKIP.
 
 config KCSAN_INTERRUPT_WATCHER
-	bool "Interruptible watchers"
+	bool "Interruptible watchers" if !KCSAN_STRICT
+	default KCSAN_STRICT
 	help
 	  If enabled, a task that set up a watchpoint may be interrupted while
 	  delayed. This option will allow KCSAN to detect races between
-- 
2.31.1.189.g2e36527f23

