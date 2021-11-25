Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE71745E19F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357139AbhKYUeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:34:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233937AbhKYUcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637872136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kaFkFJhlQt54sqolDJOMVBjHMKjdPtNBa+f74SVCoTU=;
        b=Zdlhq8Zg0YaTY5UaZpMl9PoeResOo/BxSrcnvG0xgJ5jYOBK7mr/X/6fv1w69OmETsoZGM
        vZEG+/cdiWh/4mp+V84HfGpbst8wAjd1aKMqB7L9aKDG2FPHzSzCNzE9srLjnCo6k+GlW0
        p5ge9+GKgMS8cpYOvTrlRT/neZBd/RM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-4FLuKMOiPoSp9kn4PU_fQw-1; Thu, 25 Nov 2021 15:28:55 -0500
X-MC-Unique: 4FLuKMOiPoSp9kn4PU_fQw-1
Received: by mail-ed1-f72.google.com with SMTP id b15-20020aa7c6cf000000b003e7cf0f73daso6167233eds.22
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 12:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kaFkFJhlQt54sqolDJOMVBjHMKjdPtNBa+f74SVCoTU=;
        b=ZKPitkP4mFmbyG1etdSNgkn3Vyhq/4laWo1Dg7IZe01AWtrWbW/egxuRWo7uCBz1xd
         +qaAYH7w3gB7fARMMGp1prt9uPc9AFG6hofM3wgoLHJ05NcomvXlvbn8ttpGLm0wfrro
         otfnTEG0Aif/VM3cPBuvB01LvQWrT4PDjF9nanxdPztoLk31dZXaNU1p+lNYhpCiS09o
         g5X0kFfR4OqhIft9KcrmqXB23xBX9lwiBoXTLMkAILSqnWUK7GTZLIERjSAFjzd4obzK
         /6BvOkTPAm5+CtmYl7jUdo8nrfFAjQJEnOzX1eqEE/wnmeG1nPskFYqNax+MZeruRmzi
         OE/g==
X-Gm-Message-State: AOAM5303oveJCwQWVdHqbxhFEkr3OBcImSyGZy7kFBCjExJHY07itQAy
        wy4afyoQsVztCW9vgGcdbi5WuDcFB2z60rXJyrzKtFRCtibPh/i043qhU02tPOgbLLjRgymohWP
        OBzDA7T+3msOHDegwbdIS5rlx
X-Received: by 2002:aa7:d546:: with SMTP id u6mr43598808edr.311.1637872134155;
        Thu, 25 Nov 2021 12:28:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFZafI+O2MXnfP5k6Jf9iTyI0vV1jfTKYH579Wwi7ieAjuj+y35KsRkbAPWxf0c6E4jRDNzQ==
X-Received: by 2002:aa7:d546:: with SMTP id u6mr43598774edr.311.1637872133993;
        Thu, 25 Nov 2021 12:28:53 -0800 (PST)
Received: from krava.redhat.com ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id f7sm2504742edw.44.2021.11.25.12.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 12:28:53 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] tracing: Iterate trace_[ku]probe objects directly
Date:   Thu, 25 Nov 2021 21:28:52 +0100
Message-Id: <20211125202852.406405-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Linus [1] using list_for_each_entry to iterate
directly trace_[ku]probe objects so we can skip another call to
container_of in these loops.

[1] https://lore.kernel.org/r/CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/trace_kprobe.c | 13 ++++---------
 kernel/trace/trace_uprobe.c | 23 ++++++++---------------
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 33272a7b6912..1cddb42af20c 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -327,11 +327,9 @@ static inline int __enable_trace_kprobe(struct trace_kprobe *tk)
 
 static void __disable_trace_kprobe(struct trace_probe *tp)
 {
-	struct trace_probe *pos;
 	struct trace_kprobe *tk;
 
-	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-		tk = container_of(pos, struct trace_kprobe, tp);
+	list_for_each_entry(tk, trace_probe_probe_list(tp), tp.list) {
 		if (!trace_kprobe_is_registered(tk))
 			continue;
 		if (trace_kprobe_is_return(tk))
@@ -348,7 +346,7 @@ static void __disable_trace_kprobe(struct trace_probe *tp)
 static int enable_trace_kprobe(struct trace_event_call *call,
 				struct trace_event_file *file)
 {
-	struct trace_probe *pos, *tp;
+	struct trace_probe *tp;
 	struct trace_kprobe *tk;
 	bool enabled;
 	int ret = 0;
@@ -369,8 +367,7 @@ static int enable_trace_kprobe(struct trace_event_call *call,
 	if (enabled)
 		return 0;
 
-	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-		tk = container_of(pos, struct trace_kprobe, tp);
+	list_for_each_entry(tk, trace_probe_probe_list(tp), tp.list) {
 		if (trace_kprobe_has_gone(tk))
 			continue;
 		ret = __enable_trace_kprobe(tk);
@@ -559,11 +556,9 @@ static bool trace_kprobe_has_same_kprobe(struct trace_kprobe *orig,
 					 struct trace_kprobe *comp)
 {
 	struct trace_probe_event *tpe = orig->tp.event;
-	struct trace_probe *pos;
 	int i;
 
-	list_for_each_entry(pos, &tpe->probes, list) {
-		orig = container_of(pos, struct trace_kprobe, tp);
+	list_for_each_entry(orig, &tpe->probes, tp.list) {
 		if (strcmp(trace_kprobe_symbol(orig),
 			   trace_kprobe_symbol(comp)) ||
 		    trace_kprobe_offset(orig) != trace_kprobe_offset(comp))
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f5f0039d31e5..a9a294e6b183 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -409,12 +409,10 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
 					 struct trace_uprobe *comp)
 {
 	struct trace_probe_event *tpe = orig->tp.event;
-	struct trace_probe *pos;
 	struct inode *comp_inode = d_real_inode(comp->path.dentry);
 	int i;
 
-	list_for_each_entry(pos, &tpe->probes, list) {
-		orig = container_of(pos, struct trace_uprobe, tp);
+	list_for_each_entry(orig, &tpe->probes, tp.list) {
 		if (comp_inode != d_real_inode(orig->path.dentry) ||
 		    comp->offset != orig->offset)
 			continue;
@@ -1075,14 +1073,12 @@ static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
 
 static void __probe_event_disable(struct trace_probe *tp)
 {
-	struct trace_probe *pos;
 	struct trace_uprobe *tu;
 
 	tu = container_of(tp, struct trace_uprobe, tp);
 	WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
 
-	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-		tu = container_of(pos, struct trace_uprobe, tp);
+	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
 		if (!tu->inode)
 			continue;
 
@@ -1094,7 +1090,7 @@ static void __probe_event_disable(struct trace_probe *tp)
 static int probe_event_enable(struct trace_event_call *call,
 			struct trace_event_file *file, filter_func_t filter)
 {
-	struct trace_probe *pos, *tp;
+	struct trace_probe *tp;
 	struct trace_uprobe *tu;
 	bool enabled;
 	int ret;
@@ -1129,8 +1125,7 @@ static int probe_event_enable(struct trace_event_call *call,
 	if (ret)
 		goto err_flags;
 
-	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-		tu = container_of(pos, struct trace_uprobe, tp);
+	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
 		ret = trace_uprobe_enable(tu, filter);
 		if (ret) {
 			__probe_event_disable(tp);
@@ -1275,7 +1270,7 @@ static bool trace_uprobe_filter_add(struct trace_uprobe_filter *filter,
 static int uprobe_perf_close(struct trace_event_call *call,
 			     struct perf_event *event)
 {
-	struct trace_probe *pos, *tp;
+	struct trace_probe *tp;
 	struct trace_uprobe *tu;
 	int ret = 0;
 
@@ -1287,8 +1282,7 @@ static int uprobe_perf_close(struct trace_event_call *call,
 	if (trace_uprobe_filter_remove(tu->tp.event->filter, event))
 		return 0;
 
-	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-		tu = container_of(pos, struct trace_uprobe, tp);
+	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
 		ret = uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
 		if (ret)
 			break;
@@ -1300,7 +1294,7 @@ static int uprobe_perf_close(struct trace_event_call *call,
 static int uprobe_perf_open(struct trace_event_call *call,
 			    struct perf_event *event)
 {
-	struct trace_probe *pos, *tp;
+	struct trace_probe *tp;
 	struct trace_uprobe *tu;
 	int err = 0;
 
@@ -1312,8 +1306,7 @@ static int uprobe_perf_open(struct trace_event_call *call,
 	if (trace_uprobe_filter_add(tu->tp.event->filter, event))
 		return 0;
 
-	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-		tu = container_of(pos, struct trace_uprobe, tp);
+	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
 		err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
 		if (err) {
 			uprobe_perf_close(call, event);
-- 
2.33.1

