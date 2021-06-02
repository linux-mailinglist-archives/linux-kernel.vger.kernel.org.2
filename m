Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BEF3983C4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhFBIDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:03:35 -0400
Received: from smtp2.axis.com ([195.60.68.18]:45283 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhFBIDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1622620901;
  x=1654156901;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aRxnb2ikeGzULhXo8gk9aFzoMTGwb4WG0MFMLqu7EUE=;
  b=BBDZPO1sRZLY5DCKe7LbC5DQ/msGzMREIK3CkO/Jj2U/JLi1YwBhAzgm
   l1AE8xdTvypBERaRNTjdg05HQCcOrgtHNnFLHxjamUjvdY1DNjMT+t/Nu
   2vLmhD0ADVp0eGCCo9IgPmSlLaQPug5rJzEls5NMdjrEY9cIeMCjjE94i
   VHNmWPi4xQ7asYfM1rc+twCGxzAyy4A+ohm+/pXFHtvu/kHeDEbeirnym
   GiJ+aOT9fi4dy898MPf02ONH1fRaotwGr/TYim32ItMwBAg3wUwwCs9jh
   vrDXxlo4IjLLiMsUN+kWd0ZWYaeOkpgpV/WfY7u0IP3b7A9ure5GdVQ83
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] tracing: Export tracing_start() and tracing_stop()
Date:   Wed, 2 Jun 2021 10:01:18 +0200
Message-ID: <20210602080118.21627-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tracing_stop() is very useful during hands-on debugging for getting the
trace to stop exactly when the problem is detected.  Export this to
modules.

Personally, I haven't yet found the need to use tracing_start() from
code since I usually start tracing via tracefs, but export that too for
symmetry since it may have its uses together with tracing_stop().

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a21ef9cd2aae..5fa36f0705b7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2301,6 +2301,7 @@ void tracing_start(void)
  out:
 	raw_spin_unlock_irqrestore(&global_trace.start_lock, flags);
 }
+EXPORT_SYMBOL_GPL(tracing_start);
 
 static void tracing_start_tr(struct trace_array *tr)
 {
@@ -2366,6 +2367,7 @@ void tracing_stop(void)
  out:
 	raw_spin_unlock_irqrestore(&global_trace.start_lock, flags);
 }
+EXPORT_SYMBOL_GPL(tracing_stop);
 
 static void tracing_stop_tr(struct trace_array *tr)
 {
-- 
2.28.0

