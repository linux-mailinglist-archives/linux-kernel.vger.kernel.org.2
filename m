Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54883B7192
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhF2Lvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 07:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233555AbhF2LvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 07:51:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01B7A61D69;
        Tue, 29 Jun 2021 11:48:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lyCEW-000SaU-2d; Tue, 29 Jun 2021 07:48:52 -0400
Message-ID: <20210629114851.910160986@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 29 Jun 2021 07:48:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: [for-next][PATCH 6/6] tracing: Fix spelling in osnoise tracer "interferences" ->
 "interference"
References: <20210629114811.473560262@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a TP_printk message, the word interferences
is not the plural of interference. Fix this.

Link: https://lkml.kernel.org/r/20210628125522.56361-1-colin.king@canonical.com

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/events/osnoise.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/osnoise.h b/include/trace/events/osnoise.h
index 28762c69f6c9..82f741ec0f57 100644
--- a/include/trace/events/osnoise.h
+++ b/include/trace/events/osnoise.h
@@ -129,7 +129,7 @@ TRACE_EVENT(sample_threshold,
 		__entry->interference = interference;
 	),
 
-	TP_printk("start %llu.%09u duration %llu ns interferences %llu",
+	TP_printk("start %llu.%09u duration %llu ns interference %llu",
 		__print_ns_to_secs(__entry->start),
 		__print_ns_without_secs(__entry->start),
 		__entry->duration,
-- 
2.30.2
