Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2477035C3A8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbhDLKVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbhDLKVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:21:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45409C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4FZ7mSk+jdT38j1pSNwsY+DQyckGwuS5OzdXXzcwtqA=; b=XWjiHUj3LH9LXHu7YAGbOyDaxx
        /72VgVa6BqfK3EgX2Do69oqrhbQYsGmR7W38MhYm4RkmAgJQXlKfA8RCi7rsJ7vOBs3MxE68p8Iie
        0k/i6MtxpLGEmPl8s/cWWmTydWJZWCkqWzmc75SIivOdDM0CZ3faKZQZNblbiRMPIM0VJnK7/7MOi
        UlhsTauqMbNRBkJihdVeJyUqPD6WxJIes89Ih76MKCEqBYZA6wLVYBOOcvTaJkpIWln8Fh2SmxMky
        MQR2U3+OmYrNtDPRXz5QC/NULBbJVIgfDc3Opqj91c3pcRXxSOk/q3IlhHsE7romfysNVrD/HHmTr
        Kr5sEdog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVtgi-006QVA-II; Mon, 12 Apr 2021 10:21:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F83B30022D;
        Mon, 12 Apr 2021 12:20:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BEF6C29D8B770; Mon, 12 Apr 2021 12:20:58 +0200 (CEST)
Message-ID: <20210412102001.224578981@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Apr 2021 12:14:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com,
        linux@rasmusvillemoes.dk
Subject: [PATCH v2 3/9] sched: Dont make LATENCYTOP select SCHED_DEBUG
References: <20210412101421.609526370@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCHED_DEBUG is not in fact required for LATENCYTOP, don't select it.

Suggested-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/Kconfig.debug |    1 -
 1 file changed, 1 deletion(-)

--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1670,7 +1670,6 @@ config LATENCYTOP
 	select KALLSYMS_ALL
 	select STACKTRACE
 	select SCHEDSTATS
-	select SCHED_DEBUG
 	help
 	  Enable this option if you want to use the LatencyTOP tool
 	  to find out which userspace is blocking on what kernel operations.


