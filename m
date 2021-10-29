Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7935D43FDD3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhJ2OF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 10:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231684AbhJ2OFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:05:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC3646115C;
        Fri, 29 Oct 2021 14:03:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mgSTX-001AqN-S6;
        Fri, 29 Oct 2021 10:03:19 -0400
Message-ID: <20211029140319.711267001@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 29 Oct 2021 10:02:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 2/2] tracing: Fix misspelling of "missing"
References: <20211029140208.987338181@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

My snake instinct was on and I wrote "misssing" instead of "missing".

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_eprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 5c5f208c15d3..928867f527e7 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -904,7 +904,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 
 	if (IS_ERR(ep)) {
 		ret = PTR_ERR(ep);
-		/* This must return -ENOMEM or misssing event, else there is a bug */
+		/* This must return -ENOMEM or missing event, else there is a bug */
 		WARN_ON_ONCE(ret != -ENOMEM && ret != -ENODEV);
 		ep = NULL;
 		goto error;
-- 
2.33.0
