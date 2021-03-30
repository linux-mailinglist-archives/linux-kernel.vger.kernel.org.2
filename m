Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C340C34DDD5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhC3Bzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:55:48 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:14780 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhC3Bzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:55:32 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id A55F4980138;
        Tue, 30 Mar 2021 09:55:27 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] linux/trace_events.h: Remove duplicate struct declaration
Date:   Tue, 30 Mar 2021 09:55:17 +0800
Message-Id: <20210330015517.2264721-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHUNLSU1DS0oYHUlJVkpNSkxLTUJISUxDTU1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRQ6Ejo*Fz8IMDAIC1YRSjk8
        SE8wCkJVSlVKTUpMS01CSElDSk1KVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKQ0JKNwY+
X-HM-Tid: 0a7880d7c5aed992kuwsa55f4980138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct trace_array is declared twice. One has been declared
at forward struct declaration. Remove the duplicate.
And sort these forward declarations alphabetically.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/trace_events.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 28e7af1406f2..29ae3ec5cab9 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -10,11 +10,11 @@
 #include <linux/perf_event.h>
 #include <linux/tracepoint.h>
 
-struct trace_array;
 struct array_buffer;
-struct tracer;
-struct dentry;
 struct bpf_prog;
+struct dentry;
+struct tracer;
+struct trace_array;
 
 const char *trace_print_flags_seq(struct trace_seq *p, const char *delim,
 				  unsigned long flags,
@@ -404,7 +404,6 @@ trace_get_fields(struct trace_event_call *event_call)
 	return event_call->class->get_fields(event_call);
 }
 
-struct trace_array;
 struct trace_subsystem_dir;
 
 enum {
-- 
2.25.1

