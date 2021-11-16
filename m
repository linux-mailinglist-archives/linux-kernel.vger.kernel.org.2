Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D7A453CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhKPXsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 18:48:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232385AbhKPXsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637106340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJ/IAyLgZBpYGYBxk24oHQkkkW/T4OyBwHNNDKJRRwY=;
        b=c8RvPF0PXqselxGpvfTKlmIC8ORjStTAd3lJGb7MOkk1km3HVJygfQWVEXKbhdOmmGiNhY
        rqjFGDmpKjnQ39tKAoN8lm1LMDTcljoK3h4yKlOCjRrXS/kjNdBjl7QGVBFIFGV0CBUtKu
        by1Qb7nf9h9OjDaGSuzeXWjvepfBkgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-IXuU78zBOMG3JJoKimjfsQ-1; Tue, 16 Nov 2021 18:45:36 -0500
X-MC-Unique: IXuU78zBOMG3JJoKimjfsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FA251922961;
        Tue, 16 Nov 2021 23:45:35 +0000 (UTC)
Received: from llong.com (unknown [10.22.18.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 068775BB12;
        Tue, 16 Nov 2021 23:45:33 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 4/4] clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW
Date:   Tue, 16 Nov 2021 18:44:26 -0500
Message-Id: <20211116234426.837799-5-longman@redhat.com>
In-Reply-To: <20211116234426.837799-1-longman@redhat.com>
References: <20211116234426.837799-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A watchdog maximum skew of 100us may still be too small for
some systems or archs. It may also be too small when some kernel
debug config options are enabled.  So add a new Kconfig option
CLOCKSOURCE_WATCHDOG_MAX_SKEW_US to allow kernel builders to have more
control on the threshold for marking clocksource as unstable.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/time/Kconfig       | 9 +++++++++
 kernel/time/clocksource.c | 8 +++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 04bfd62f5e5c..27b7868b5c30 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -181,5 +181,14 @@ config HIGH_RES_TIMERS
 	  hardware is not capable then this option only increases
 	  the size of the kernel image.
 
+config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
+	int "Clocksource watchdog maximum allowable skew (in μs)"
+	depends on CLOCKSOURCE_WATCHDOG
+	range 50 1000
+	default 100
+	help
+	  Specify the maximum amount of allowable watchdog skew in
+	  microseconds before reporting the clocksource to be unstable.
+
 endmenu
 endif
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b1813b09fe9b..2cc8d6dc50e2 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -107,7 +107,13 @@ static u64 suspend_start;
  * This delay could be due to SMIs, NMIs, or to VCPU preemptions.  Used as
  * a lower bound for cs->uncertainty_margin values when registering clocks.
  */
-#define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
+#ifdef CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
+#define MAX_SKEW_USEC	CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
+#else
+#define MAX_SKEW_USEC	100
+#endif
+
+#define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
 static u64 watchdog_max_skew = WATCHDOG_MAX_SKEW;
 
 /*
-- 
2.27.0

