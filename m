Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75D9450248
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbhKOKXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:23:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237636AbhKOKXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:23:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9312461B39;
        Mon, 15 Nov 2021 10:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636971622;
        bh=Fl8yAXL3vlIjRfrcgKW4CbT+haiq+Jqa2Iw6FyBXi4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KdCBM/M1jSGZDVBlHVqhWUyxMR0BQLD5eYmg9QF7/i6iWL1MH/zh5DEhJl1PrfWm4
         CFg8D+Z7zuCsSuzuDNhK0wBk2aBTtOVWWHFcEsGGxUF8sAg27DVVD8OQ4Ww5eL3LR3
         10i4Fg6FNxoBWWrIIctEPoR6U6wsOSLn+aIP5xhQs7h74Zv0gLDl8nCzhqSLnguDzu
         VUTsn15I907LoblvA38qkK6JZrG8NR4JoHy8f82ibpNlUfkXTODyY9kaRN86x+EFkn
         501XYAsHE4JcaATKPepmfATSRufoWbrJ3DhHnnofqsW2XLPONyB7MIhXP4k8WpWeWE
         10Oz15LJESVTw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 2/5] tracing: Add '__rel_loc' using trace event macros
Date:   Mon, 15 Nov 2021 19:20:18 +0900
Message-Id: <163697161857.131454.12959552034913725926.stgit@devnote2>
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

Add '__rel_loc' using trace event macros. These macros
are usually not used in the kernel, except for testing
purpose.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/trace/bpf_probe.h    |   13 +++++++
 include/trace/perf.h         |   13 +++++++
 include/trace/trace_events.h |   83 ++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.h         |    3 ++
 4 files changed, 112 insertions(+)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index a23be89119aa..ff40ec0c887d 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -18,6 +18,19 @@
 #undef __get_str
 #define __get_str(field) ((char *)__get_dynamic_array(field))
 
+#undef __get_rel_dynamic_array
+#define __get_rel_dynamic_array(field)	\
+		((void *)(&__entry->__rel_loc_##field) +	\
+		 sizeof(__entry->__rel_loc_##field) +		\
+		 (__entry->__rel_loc_##field & 0xffff))
+
+#undef __get_rel_dynamic_array_len
+#define __get_rel_dynamic_array_len(field)	\
+		((__entry->__rel_loc_##field >> 16) & 0xffff)
+
+#undef __get_rel_str
+#define __get_rel_str(field) ((char *)__get_rel_dynamic_array(field))
+
 #undef __get_bitmask
 #define __get_bitmask(field) (char *)__get_dynamic_array(field)
 
diff --git a/include/trace/perf.h b/include/trace/perf.h
index dbc6c74defc3..06cee508bdfa 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -18,6 +18,19 @@
 #undef __get_str
 #define __get_str(field) ((char *)__get_dynamic_array(field))
 
+#undef __get_rel_dynamic_array
+#define __get_rel_dynamic_array(field)	\
+		((void *)(&__entry->__rel_loc_##field) +	\
+		 sizeof(__entry->__rel_loc_##field) +		\
+		 (__entry->__rel_loc_##field & 0xffff))
+
+#undef __get_rel_dynamic_array_len
+#define __get_rel_dynamic_array_len(field)	\
+		((__entry->__rel_loc_##field >> 16) & 0xffff)
+
+#undef __get_rel_str
+#define __get_rel_str(field) ((char *)__get_rel_dynamic_array(field))
+
 #undef __get_bitmask
 #define __get_bitmask(field) (char *)__get_dynamic_array(field)
 
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 08810a463880..6a730164479f 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -105,6 +105,15 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __string_len
 #define __string_len(item, src, len) __dynamic_array(char, item, -1)
 
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(type, item, len) u32 __rel_loc_##item;
+
+#undef __rel_string
+#define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_string_len
+#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
 
@@ -203,6 +212,15 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __string_len
 #define __string_len(item, src, len) __dynamic_array(char, item, -1)
 
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(type, item, len)	u32 item;
+
+#undef __rel_string
+#define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_string_len
+#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
@@ -293,6 +311,19 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __get_str
 #define __get_str(field) ((char *)__get_dynamic_array(field))
 
+#undef __get_rel_dynamic_array
+#define __get_rel_dynamic_array(field)	\
+		((void *)(&__entry->__rel_loc_##field) +	\
+		 sizeof(__entry->__rel_loc_##field) +		\
+		 (__entry->__rel_loc_##field & 0xffff))
+
+#undef __get_rel_dynamic_array_len
+#define __get_rel_dynamic_array_len(field)	\
+		((__entry->__rel_loc_##field >> 16) & 0xffff)
+
+#undef __get_rel_str
+#define __get_rel_str(field) ((char *)__get_rel_dynamic_array(field))
+
 #undef __get_bitmask
 #define __get_bitmask(field)						\
 	({								\
@@ -468,6 +499,18 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 #undef __string_len
 #define __string_len(item, src, len) __dynamic_array(char, item, -1)
 
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(_type, _item, _len) {			\
+	.type = "__rel_loc " #_type "[]", .name = #_item,		\
+	.size = 4, .align = 4,						\
+	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER },
+
+#undef __rel_string
+#define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_string_len
+#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
@@ -519,6 +562,22 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 #undef __string_len
 #define __string_len(item, src, len) __dynamic_array(char, item, (len) + 1)
 
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(type, item, len)				\
+	__item_length = (len) * sizeof(type);				\
+	__data_offsets->item = __data_size +				\
+			       offsetof(typeof(*entry), __data) -	\
+			       offsetof(typeof(*entry), __rel_loc_##item) -	\
+			       sizeof(u32);				\
+	__data_offsets->item |= __item_length << 16;			\
+	__data_size += __item_length;
+
+#undef __rel_string
+#define __rel_string(item, src) __rel_dynamic_array(char, item,			\
+		    strlen((src) ? (const char *)(src) : "(null)") + 1)
+
+#undef __rel_string_len
+#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, (len) + 1)
 /*
  * __bitmask_size_in_bytes_raw is the number of bytes needed to hold
  * num_possible_cpus().
@@ -696,6 +755,27 @@ static inline notrace int trace_event_get_offsets_##call(		\
 		__get_str(dst)[len] = '\0';				\
 	} while(0)
 
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(type, item, len)				\
+	__entry->__rel_loc_##item = __data_offsets.item;
+
+#undef __rel_string
+#define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_string_len
+#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
+
+#undef __assign_rel_str
+#define __assign_rel_str(dst, src)					\
+	strcpy(__get_rel_str(dst), (src) ? (const char *)(src) : "(null)");
+
+#undef __assign_rel_str_len
+#define __assign_rel_str_len(dst, src, len)				\
+	do {								\
+		memcpy(__get_rel_str(dst), (src), (len));		\
+		__get_rel_str(dst)[len] = '\0';				\
+	} while (0)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
@@ -769,6 +849,9 @@ static inline void ftrace_test_probe_##call(void)			\
 #undef __get_dynamic_array
 #undef __get_dynamic_array_len
 #undef __get_str
+#undef __get_rel_dynamic_array
+#undef __get_rel_dynamic_array_len
+#undef __get_rel_str
 #undef __get_bitmask
 #undef __print_array
 #undef __print_hex_dump
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 4fd292c3a062..f80d5612701e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -83,6 +83,9 @@ enum trace_type {
 #undef __dynamic_array
 #define __dynamic_array(type, item)	type	item[];
 
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(type, item)	type	item[];
+
 #undef F_STRUCT
 #define F_STRUCT(args...)		args
 

