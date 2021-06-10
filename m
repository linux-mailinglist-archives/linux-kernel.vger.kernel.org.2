Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828073A21BA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 03:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhFJBEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 21:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229976AbhFJBDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 21:03:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9769361411;
        Thu, 10 Jun 2021 01:01:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lr954-002bcC-La; Wed, 09 Jun 2021 21:01:58 -0400
Message-ID: <20210610010158.505580624@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Jun 2021 21:01:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 10/11] Documentation: tracing: Add per-group/all events enablement
 desciption
References: <20210610010130.069460694@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add ftrace.event.<GROUP>.enable and ftrace.event.enable bootconfig
description in the boot-time tracing document.

Link: https://lkml.kernel.org/r/162264438901.302580.10697703336929432947.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/boottime-trace.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index 89b64334929b..8053898cfeb4 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -99,6 +99,12 @@ These options are setting per-event options.
 ftrace.[instance.INSTANCE.]event.GROUP.EVENT.enable
    Enable GROUP:EVENT tracing.
 
+ftrace.[instance.INSTANCE.]event.GROUP.enable
+   Enable all event tracing within GROUP.
+
+ftrace.[instance.INSTANCE.]event.enable
+   Enable all event tracing.
+
 ftrace.[instance.INSTANCE.]event.GROUP.EVENT.filter = FILTER
    Set FILTER rule to the GROUP:EVENT.
 
-- 
2.30.2
