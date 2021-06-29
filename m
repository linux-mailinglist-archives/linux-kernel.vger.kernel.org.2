Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA623B718F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 13:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbhF2Lvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 07:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233544AbhF2LvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 07:51:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A038261D2A;
        Tue, 29 Jun 2021 11:48:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lyCEV-000SZO-MH; Tue, 29 Jun 2021 07:48:51 -0400
Message-ID: <20210629114851.531030823@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 29 Jun 2021 07:48:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [for-next][PATCH 4/6] trace/osnoise: Fix return value on osnoise_init_hotplug_support
References: <20210629114811.473560262@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@redhat.com>

kernel test robot reported:

  >> kernel/trace/trace_osnoise.c:1584:2: error: void function
  'osnoise_init_hotplug_support' should not return a
  value [-Wreturn-type]
           return 0;

When !CONFIG_HOTPLUG_CPU.

Fix it problem by removing the return value.

Link: https://lkml.kernel.org/r/c7fc67f1a117cc88bab2e508c898634872795341.1624872608.git.bristot@redhat.com

Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 79be14380581..085a83de98ad 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1586,7 +1586,7 @@ static void osnoise_init_hotplug_support(void)
 #else /* CONFIG_HOTPLUG_CPU */
 static void osnoise_init_hotplug_support(void)
 {
-	return 0;
+	return;
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-- 
2.30.2
