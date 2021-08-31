Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A3F3FC202
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 06:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhHaEqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 00:46:01 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:34036 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhHaEqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 00:46:00 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 494D2340B29
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 04:37:29 +0000 (UTC)
Received: (qmail 6996 invoked by uid 129); 31 Aug 2021 04:37:28 -0000
X-HELO: thorne.orbis-terrarum.net
Authentication-Results: orbis-terrarum.net; auth=pass (cram-md5) smtp.auth=robbat2-thorne@orbis-terrarum.net; iprev=pass
Received: from d108-172-209-11.bchsia.telus.net (HELO thorne.orbis-terrarum.net) (108.172.209.11)
 by orbis-terrarum.net (qpsmtpd/0.95) with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted); Tue, 31 Aug 2021 04:37:28 +0000
Received: by thorne.orbis-terrarum.net (Postfix, from userid 0)
        id 18B681982AD; Tue, 31 Aug 2021 04:37:26 +0000 (UTC)
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com, rjohnson@digitalocean.com,
        "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 1/2] tracing: show size of requested buffer
Date:   Mon, 30 Aug 2021 21:37:22 -0700
Message-Id: <20210831043723.13481-1-robbat2@gentoo.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Checked: Checked by ClamAV on orbis-terrarum.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the perf buffer isn't large enough, provide a hint about how large it
needs to be for whatever is running.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 kernel/trace/trace_event_perf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 03be4435d103..26eed4b89100 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -400,7 +400,8 @@ void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp)
 	BUILD_BUG_ON(PERF_MAX_TRACE_SIZE % sizeof(unsigned long));
 
 	if (WARN_ONCE(size > PERF_MAX_TRACE_SIZE,
-		      "perf buffer not large enough"))
+		      "perf buffer not large enough, wanted %d, have %d",
+		      size, PERF_MAX_TRACE_SIZE))
 		return NULL;
 
 	*rctxp = rctx = perf_swevent_get_recursion_context();
-- 
2.33.0

