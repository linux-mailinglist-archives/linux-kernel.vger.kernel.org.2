Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23ADA30DF41
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbhBCQJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:09:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234832AbhBCQH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:07:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6DBD64FAC;
        Wed,  3 Feb 2021 16:05:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1l7Kf8-009J9z-7c; Wed, 03 Feb 2021 11:05:50 -0500
Message-ID: <20210203160550.113111277@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Feb 2021 11:05:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>
Subject: [for-next][PATCH 10/15] tracing: Fix spelling mistake in Kconfig "infinit" -> "infinite"
References: <20210203160517.982448432@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig help text. Fix it.

Link: https://lkml.kernel.org/r/20201216114051.12056-1-colin.king@canonical.com

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index c1a62ae7e812..4f976f8d9a38 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -545,7 +545,7 @@ config KPROBE_EVENTS_ON_NOTRACE
 	  using kprobe events.
 
 	  If kprobes can use ftrace instead of breakpoint, ftrace related
-	  functions are protected from kprobe-events to prevent an infinit
+	  functions are protected from kprobe-events to prevent an infinite
 	  recursion or any unexpected execution path which leads to a kernel
 	  crash.
 
-- 
2.29.2


