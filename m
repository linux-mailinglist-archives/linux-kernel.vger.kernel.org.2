Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5095538FB62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhEYHI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEYHIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:08:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9C2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=94rRe8DncEJ8thzWN8Ue22a749mm1JoE2gXK/Suv76I=; b=LXm8J+MJAO2E9OxBokUduDn+o9
        eaN62R+9BYqrcFHGciKpn4s5Ur83WArkjKGmlt0q/nPRanDYYecA4I3xH88lavr7h4cfWAvcE6rpR
        T4mCUkv1M9w7nNZJQ2X30gj0txVOlUbZh4GQzO4wyHhHtswRIKaau58Mg5TrEnamm8MICEBRjs+Vm
        fmQYicstPYK8BCCUFp78HQuAVP26iVD23UJbUmiwUuMTpM84aSAM5+aJ6Fz1+FG0B2X8s1dD5AqG9
        qIbA8+qMdbpRTLfm2NkfQKeBrT/1jJ9YvYi/4TwZ1WAI3xetdmxjWaerxcE/AGHipMWK6IJeVZ4e5
        eVjgwI+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llR89-003DLT-DO; Tue, 25 May 2021 07:05:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13055300258;
        Tue, 25 May 2021 09:05:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC55030E92289; Tue, 25 May 2021 09:05:27 +0200 (CEST)
Date:   Tue, 25 May 2021 09:05:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        joel@joelfernandes.org, Ingo Molnar <mingo@kernel.org>,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH] sched: Add CONFIG_SCHED_CORE help text
Message-ID: <YKyhtwhEgvtUDOyl@hirez.programming.kicks-ass.net>
References: <alpine.LSU.2.11.2105201954180.6100@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2105201954180.6100@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: sched: Add CONFIG_SCHED_CORE help text
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue May 25 08:53:28 CEST 2021

Hugh noted that the SCHED_CORE Kconfig option could do with a help
text.

Requested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/Kconfig.preempt |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -104,4 +104,18 @@ config SCHED_CORE
 	bool "Core Scheduling for SMT"
 	default y
 	depends on SCHED_SMT
+	help
+	  This option permits Core Scheduling, a means of coordinated task
+	  selection across SMT siblings. When enabled -- see
+	  prctl(PR_SCHED_CORE) -- task selection ensures that all SMT siblings
+	  will execute a task from the same 'core group', forcing idle when no
+	  matching task is found.
+
+	  Use of this feature includes:
+	   - mitigation of some (not all) SMT side channels;
+	   - limiting SMT interference to improve determinism and/or performance.
+
+	  SCHED_CORE is default enabled when SCHED_SMT is enabled -- when
+	  unused there should be no impact on performance.
+
 
