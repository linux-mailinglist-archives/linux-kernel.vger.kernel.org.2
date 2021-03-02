Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD9832A398
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837890AbhCBJJY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Mar 2021 04:09:24 -0500
Received: from mx1.emlix.com ([136.243.223.33]:42308 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1837775AbhCBI6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:58:39 -0500
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 13EBE5F93E;
        Tue,  2 Mar 2021 09:49:29 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Kconfig: fix help text of TRACEPOINT_BENCHMARK
Date:   Tue, 02 Mar 2021 09:49:28 +0100
Message-ID: <1863065.aFVDpXsuPd@devpool47>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 kernel/trace/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 9c266b93cbc0..7fa82778c3e6 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -694,7 +694,7 @@ config TRACEPOINT_BENCHMARK
 	help
 	 This option creates the tracepoint "benchmark:benchmark_event".
 	 When the tracepoint is enabled, it kicks off a kernel thread that
-	 goes into an infinite loop (calling cond_sched() to let other tasks
+	 goes into an infinite loop (calling cond_resched() to let other tasks
 	 run), and calls the tracepoint. Each iteration will record the time
 	 it took to write to the tracepoint and the next iteration that
 	 data will be passed to the tracepoint itself. That is, the tracepoint
-- 
2.30.1

-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



