Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EF639955B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 23:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFBVYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 17:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhFBVYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 17:24:43 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9137C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 14:22:45 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id n12so3333950pgs.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U7reD9u47mRI+ECxQBQGh7c4SIywTee0Qgq9YYbIxIQ=;
        b=lNQhMj4QsoltIXB8oo3HLBIiSQcvwVbNllKnIr8d7emN33sYQ7Zgpleg2UvK2hTZ0D
         1LfDYIU+a2jdW7ERAp93u8S7wNDdo0n9OYy0Ue7LNG5lCnDh5U02Kx1QzZFsuF2WLvjU
         ZdoCHdmpPK+zAcQlVw9Uisf5EfKvdvvLM3AFU5uGg5yPqsUNir9QdwnWz4DoWa71Lr87
         V2TgD/tw4tzDrmZmWTZqG3wsXRCB7k1TvxJ+6VyK1r96t11bYJFvr3dO2QQgsswmoRyv
         2dSR9XAZicMme6Ienn2ki/t4oQKQ62iK2bHuu5Ao5UgY8QVK943tlAo1Ki1cFmRKBYk8
         HtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=U7reD9u47mRI+ECxQBQGh7c4SIywTee0Qgq9YYbIxIQ=;
        b=Ed0Z3P86wtBF/nrykD4wK32KJZMHVOYVScFJk1USQWhW65OnGHPT/oMfDygIe476AO
         mdBpOke5UEDWSBh8Vkft0ImiS5ntbA76VV2VMxStWh0vs7yF97VavCHN9gwoGbxZHvhL
         zijkHcOMKqvWTGojkREREufoRNgPDzSJjFC3lQgc1T0Q//IhA+oCPbt+1vSAeKjeiRTa
         lIIfOiZtc0n4HQYgKewQzpIW40k+5luz0/JUaz1YZbrcyErTuQgQTKaSM4BjWyMKHlOe
         dYBa7iuv0sJtE48f2fzhfbPXk3Xuc91q27ZlZJoDPrzNklxF/s2MY6hFO+bfH8UFES/N
         6Qig==
X-Gm-Message-State: AOAM532+gy4NK66Gyqv3cUJqDqs8i4UDTtD4yxOOVWtRQTd62ES2PsS6
        j4DQeTI3vPX+h8YyNHkZshY=
X-Google-Smtp-Source: ABdhPJx48IVBbZlqzhMz4wiafujdyUjTgNjG2eHqmpe9eij4xzNWObkRtZlYeWvJVOtfyWoDWLS2ow==
X-Received: by 2002:a63:724f:: with SMTP id c15mr15941909pgn.339.1622668965386;
        Wed, 02 Jun 2021 14:22:45 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:ea44:6c81:cb03:abf2])
        by smtp.gmail.com with ESMTPSA id z9sm435860pfc.101.2021.06.02.14.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 14:22:44 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 2/3] perf tools: Clone evsel->use_config_name
Date:   Wed,  2 Jun 2021 14:22:40 -0700
Message-Id: <20210602212241.2175005-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
In-Reply-To: <20210602212241.2175005-1-namhyung@kernel.org>
References: <20210602212241.2175005-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The evsel__clone() should copy all fields in the evsel which are set
during the event parsing.  But it missed the use_config_name field.

Fixes: 12279429d862 ("perf stat: Uniquify hybrid event name")
Cc: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 1 +
 tools/perf/util/evsel.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4a3cd1b5bb33..a8d8463f8ee5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -428,6 +428,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->auto_merge_stats = orig->auto_merge_stats;
 	evsel->collect_stat = orig->collect_stat;
 	evsel->weak_group = orig->weak_group;
+	evsel->use_config_name = orig->use_config_name;
 
 	if (evsel__copy_config_terms(evsel, orig) < 0)
 		goto out_err;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 75cf5dbfe208..bdad52a06438 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -83,8 +83,10 @@ struct evsel {
 		bool			collect_stat;
 		bool			weak_group;
 		bool			bpf_counter;
+		bool			use_config_name;
 		int			bpf_fd;
 		struct bpf_object	*bpf_obj;
+		struct list_head	config_terms;
 	};
 
 	/*
@@ -116,10 +118,8 @@ struct evsel {
 	bool			merged_stat;
 	bool			reset_group;
 	bool			errored;
-	bool			use_config_name;
 	struct hashmap		*per_pkg_mask;
 	struct evsel		*leader;
-	struct list_head	config_terms;
 	int			err;
 	int			cpu_iter;
 	struct {
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

