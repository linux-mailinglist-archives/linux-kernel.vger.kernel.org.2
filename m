Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2DB43B70B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhJZQ0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233574AbhJZQ0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:26:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 323F460200;
        Tue, 26 Oct 2021 16:23:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mfPEp-000qOM-RM;
        Tue, 26 Oct 2021 12:23:47 -0400
Message-ID: <20211026162347.689057408@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 26 Oct 2021 12:23:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zeal Robot <zealci@zte.com.cn>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Subject: [for-next][PATCH 02/12] tools/latency-collector: Use correct size when writing
 queue_full_warning
References: <20211026162315.297389528@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viktor Rosendahl <Viktor.Rosendahl@bmw.de>

queue_full_warning is a pointer, so it is wrong to use sizeof to calculate
the number of characters of the string it points to. The effect is that we
only print out the first few characters of the warning string.

The correct way is to use strlen(). We don't need to add 1 to the strlen()
because we don't want to write the terminating null character to stdout.

Link: https://lkml.kernel.org/r/20211019160701.15587-1-Viktor.Rosendahl@bmw.de

Link: https://lore.kernel.org/r/8fd4bb65ef3da67feac9ce3258cdbe9824752cf1.1629198502.git.jing.yangyang@zte.com.cn
Link: https://lore.kernel.org/r/20211012025424.180781-1-davidcomponentone@gmail.com
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/tracing/latency/latency-collector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
index 3a2e6bb781a8..59a7f2346eab 100644
--- a/tools/tracing/latency/latency-collector.c
+++ b/tools/tracing/latency/latency-collector.c
@@ -1538,7 +1538,7 @@ static void tracing_loop(void)
 				mutex_lock(&print_mtx);
 				check_signals();
 				write_or_die(fd_stdout, queue_full_warning,
-					     sizeof(queue_full_warning));
+					     strlen(queue_full_warning));
 				mutex_unlock(&print_mtx);
 			}
 			modified--;
-- 
2.33.0
