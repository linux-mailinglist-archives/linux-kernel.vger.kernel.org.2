Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C702B456345
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 20:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhKRTSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 14:18:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233487AbhKRTSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 14:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637262902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jD/S5EQWmX6rQ+AVzOyMcoL+fu4Joi3GhDEClhu68hM=;
        b=bsgXqDce/hryvbAFEOBo06NyUwnM8/jTbpNTcFG0IOkr5Gr8ONucOfQ17J+GpHd+RogXfz
        wxeeFo366KclRqeXgr7LHq+OAXRQmyuuTAowQ3X7y3Z3neJeduZMf46bgTMhKNsz0IbfS5
        gSxuG3n/QSK78MepMKbQ9SgsCJolMJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-nOJh7V1eNX-TP50X_0QRsA-1; Thu, 18 Nov 2021 14:14:59 -0500
X-MC-Unique: nOJh7V1eNX-TP50X_0QRsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A7F019253C0;
        Thu, 18 Nov 2021 19:14:57 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 408B79808;
        Thu, 18 Nov 2021 19:14:53 +0000 (UTC)
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
Subject: [PATCH v3 2/4] clocksource: Reduce the default clocksource_watchdog() retries to 2
Date:   Thu, 18 Nov 2021 14:14:37 -0500
Message-Id: <20211118191439.1000012-3-longman@redhat.com>
In-Reply-To: <20211118191439.1000012-1-longman@redhat.com>
References: <20211118191439.1000012-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the previous patch, there is an extra watchdog read in each retry.
Now the total number of clocksource reads is increased to 4 per iteration.
In order to avoid increasing the clock skew check overhead, the default
maximum number of retries is reduced from 3 to 2 to maintain the same 12
clocksource reads in the worst case.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++--
 kernel/time/clocksource.c                       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9725c546a0d4..3ea934b034f7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -603,8 +603,8 @@
 	clocksource.max_cswd_read_retries= [KNL]
 			Number of clocksource_watchdog() retries due to
 			external delays before the clock will be marked
-			unstable.  Defaults to three retries, that is,
-			four attempts to read the clock under test.
+			unstable.  Defaults to two retries, that is,
+			three attempts to read the clock under test.
 
 	clocksource.verify_n_cpus= [KNL]
 			Limit the number of CPUs checked for clocksources
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index bcad1a1e5dcf..b7e52a642948 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -199,7 +199,7 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
-ulong max_cswd_read_retries = 3;
+ulong max_cswd_read_retries = 2;
 module_param(max_cswd_read_retries, ulong, 0644);
 EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus = 8;
-- 
2.27.0

