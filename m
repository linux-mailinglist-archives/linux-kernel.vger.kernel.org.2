Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6268644CC71
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhKJWVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:21:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233643AbhKJWUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636582687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4u4hRDiofQm5KB2eBx0Cbc3ralpgf9ZY2J+pXI2oQto=;
        b=Dnxu2ojQM5WYb4pNW+kXSN8108Bts6viJSn9Yos+EmZAspYMSwUpgDvKYhbED4MpMV+PWH
        YFtElNceYOf83vFhEtmQfPPVxqKnV0dW7npjKM0KRpNndBcpHnpty9DDfbBN4yuQ7WzAht
        jYdepiGkstOL917ZebuW4VuafzK+WEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-zNBdgI-QMbuCFxywwh9SqA-1; Wed, 10 Nov 2021 17:18:03 -0500
X-MC-Unique: zNBdgI-QMbuCFxywwh9SqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17A1D1006AA0;
        Wed, 10 Nov 2021 22:18:02 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1BD95DEFA;
        Wed, 10 Nov 2021 22:18:00 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.king@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW
Date:   Wed, 10 Nov 2021 17:17:32 -0500
Message-Id: <20211110221732.272986-3-longman@redhat.com>
In-Reply-To: <20211110221732.272986-1-longman@redhat.com>
References: <20211110221732.272986-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
 kernel/time/clocksource.c | 7 ++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

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
index c503f5ab4101..2e605fc40e82 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -107,7 +107,12 @@ static u64 suspend_start;
  * This delay could be due to SMIs, NMIs, or to VCPU preemptions.  Used as
  * a lower bound for cs->uncertainty_margin values when registering clocks.
  */
-#define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
+#ifdef CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
+#define MAX_SKEW_USEC	CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
+#else
+#define MAX_SKEW_USEC	100
+#endif
+#define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
 
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
 static void clocksource_watchdog_work(struct work_struct *work);
-- 
2.27.0

