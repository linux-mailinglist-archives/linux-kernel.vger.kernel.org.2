Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8BA450249
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhKOKXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:23:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237666AbhKOKX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:23:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6AF561B4D;
        Mon, 15 Nov 2021 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636971631;
        bh=gNMFLaDPz4eLwmwEI+VEsAkTyFJWbA0CdSGEAlGpoAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tH90GDLfB7loEE2nfnk01wB9Jg4ZFZeNNT25i4wd6tmqqiNZSsox233wlL66v0zg2
         b+b7CIG+X6YV4ER62/ry7TSL0zovmu8u0JRrap8jYAwPMeT76Yt8P5wT6nw/FbBJi8
         qdeUFaIrgIjiAmX2Acpz6j1vNMTIkl+ogFOiCeuOeqSJ2s+J1nTlKuHQmtuYjeVH6G
         wpL6jd+eR26iCUc08H9+I8+6+reReOmCETVsJDN1XOtAVrylt+ulg8aOxay0LWyx3M
         5Kk5DkhCLwalu/B+DywUTn8jRCgGCR+6ch0syOqI48d6ok0xqGmPqpv8svrGt7shuG
         14qsPcLGD5Hjw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 3/5] samples/trace_event: Add '__rel_loc' using sample event
Date:   Mon, 15 Nov 2021 19:20:28 +0900
Message-Id: <163697162779.131454.7557237011157136779.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163697159970.131454.2661507704362599471.stgit@devnote2>
References: <163697159970.131454.2661507704362599471.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add '__rel_loc' using sample event for testing.
User can use this for testing purpose. There is
no reason to use this macro from the kernel.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 samples/trace_events/trace-events-sample.c |    2 ++
 samples/trace_events/trace-events-sample.h |   28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index 1a72b7d95cdc..b43415c31da6 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -43,6 +43,8 @@ static void simple_thread_func(int cnt)
 	trace_foo_with_template_cond("prints other times", cnt);
 
 	trace_foo_with_template_print("I have to be different", cnt);
+
+	trace_foo_rel_loc("Hello __rel_loc", cnt);
 }
 
 static int simple_thread(void *arg)
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index e61471ab7d14..be6321d4b04a 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -506,6 +506,34 @@ DEFINE_EVENT_PRINT(foo_template, foo_with_template_print,
 	TP_ARGS(foo, bar),
 	TP_printk("bar %s %d", __get_str(foo), __entry->bar));
 
+/*
+ * There are yet another __rel_loc dynamic data attribute. If you
+ * use __rel_dynamic_array() and __rel_string() etc. macros, you
+ * can use this attribute. There is no difference from the viewpoint
+ * of functionality with/without 'rel' but the encoding is a bit
+ * different. This is expected to be used with user-space event,
+ * there is no reason that the kernel event use this, but only for
+ * testing.
+ */
+
+TRACE_EVENT(foo_rel_loc,
+
+	TP_PROTO(const char *foo, int bar),
+
+	TP_ARGS(foo, bar),
+
+	TP_STRUCT__entry(
+		__rel_string(	foo,	foo	)
+		__field(	int,	bar	)
+	),
+
+	TP_fast_assign(
+		__assign_rel_str(foo, foo);
+		__entry->bar = bar;
+	),
+
+	TP_printk("foo_rel_loc %s, %d", __get_rel_str(foo), __entry->bar)
+);
 #endif
 
 /***** NOTICE! The #if protection ends here. *****/

