Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE5945024B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbhKOKX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:23:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237573AbhKOKXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:23:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 913CA61B4D;
        Mon, 15 Nov 2021 10:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636971648;
        bh=h5Y+Cl7geJ3kS+mdcgkTK6G0bSxBqSCq2Dqfb5CMSl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMorD7id4jZlA49IFE+zrQnaJB1j43wHOFsuOlOHj11zkODXxDEeaW79ZQqVEPzfl
         8Z0QM/ywnd/Ouzp2elzDqra471icbpW1eQUDUJlCZzGU6V0y2QdS+8wJdjPeSfSR11
         1gRTAJa4Rsd3i6pjx/pksX4I4A6iARECx1NjfO/5dRjef6gNDEtO6RHquVQNEcxpTn
         cTYH6XGu1mpssB0z11H8EUnZLwm7kGbFjOi+NgLE8HyBigh6vrR7T9fxFc+337Hn1f
         B2isp1pRlt0K+AAM04dza2FGfj4+eJzVxlDWwMc1ruffxPNl/1o7pSqXZAvvyfT4Bv
         XnvZS0t/5zabA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 5/5] tools/perf: Add __rel_loc support
Date:   Mon, 15 Nov 2021 19:20:45 +0900
Message-Id: <163697164517.131454.6873374426830650165.stgit@devnote2>
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

Add new __rel_loc dynamic data location attribute support.
This type attribute is similar to the __data_loc but records
the offset from the field itself.
The libtraceevent adds TEP_FIELD_IS_REL_DYNAMIC to the
field->flags with TEP_FIELD_IS_DYNAMIC for __rel_loc.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/builtin-trace.c                         |    2 ++
 tools/perf/util/data-convert-bt.c                  |    2 ++
 tools/perf/util/evsel.c                            |    2 ++
 tools/perf/util/python.c                           |    2 ++
 .../perf/util/scripting-engines/trace-event-perl.c |    2 ++
 .../util/scripting-engines/trace-event-python.c    |    2 ++
 tools/perf/util/sort.c                             |    2 ++
 7 files changed, 14 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2bf21194c7b3..79f76eea0fcc 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2722,6 +2722,8 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 				offset = format_field__intval(field, sample, evsel->needs_swap);
 				syscall_arg.len = offset >> 16;
 				offset &= 0xffff;
+				if (field->flags & TEP_FIELD_IS_REL_DYNAMIC)
+					offset += field->offset + field->size;
 			}
 
 			val = (uintptr_t)(sample->raw_data + offset);
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index aa862a26d95c..4406f82abb64 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -318,6 +318,8 @@ static int add_tracepoint_field_value(struct ctf_writer *cw,
 		offset = tmp_val;
 		len = offset >> 16;
 		offset &= 0xffff;
+		if (flags & TEP_FIELD_IS_REL_DYNAMIC)
+			offset += fmtf->offset + fmtf->size;
 	}
 
 	if (flags & TEP_FIELD_IS_ARRAY) {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbfeceb2546c..0dca46cf41a8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2597,6 +2597,8 @@ void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char
 	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 		offset = *(int *)(sample->raw_data + field->offset);
 		offset &= 0xffff;
+		if (field->flags & TEP_FIELD_IS_REL_DYNAMIC)
+			offset += field->offset + field->size;
 	}
 
 	return sample->raw_data + offset;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 8feef3a05af7..f0dea973b395 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -416,6 +416,8 @@ tracepoint_field(struct pyrf_event *pe, struct tep_format_field *field)
 			offset  = val;
 			len     = offset >> 16;
 			offset &= 0xffff;
+			if (field->flags & TEP_FIELD_IS_REL_DYNAMIC)
+				offset += field->offset + field->size;
 		}
 		if (field->flags & TEP_FIELD_IS_STRING &&
 		    is_printable_array(data + offset, len)) {
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 32a721b3e9a5..c535ed3b224e 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -392,6 +392,8 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 				offset = *(int *)(data + field->offset);
 				offset &= 0xffff;
+				if (field->flags & TEP_FIELD_IS_REL_DYNAMIC)
+					offset += field->offset + field->size;
 			} else
 				offset = field->offset;
 			XPUSHs(sv_2mortal(newSVpv((char *)data + offset, 0)));
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index c0c010350bc2..46344446f61c 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -942,6 +942,8 @@ static void python_process_tracepoint(struct perf_sample *sample,
 				offset  = val;
 				len     = offset >> 16;
 				offset &= 0xffff;
+				if (field->flags & TEP_FIELD_IS_REL_DYNAMIC)
+					offset += field->offset + field->size;
 			}
 			if (field->flags & TEP_FIELD_IS_STRING &&
 			    is_printable_array(data + offset, len)) {
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 568a88c001c6..cffe2c484923 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2385,6 +2385,8 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt *fmt,
 		tep_read_number_field(field, a->raw_data, &dyn);
 		offset = dyn & 0xffff;
 		size = (dyn >> 16) & 0xffff;
+		if (field->flags & TEP_FIELD_IS_REL_DYNAMIC)
+			offset += field->offset + field->size;
 
 		/* record max width for output */
 		if (size > hde->dynamic_len)

