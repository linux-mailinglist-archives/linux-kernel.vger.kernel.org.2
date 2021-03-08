Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B082F3309C9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhCHIzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:55:37 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:35441 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229494AbhCHIzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:55:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UQtN008_1615193706;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UQtN008_1615193706)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Mar 2021 16:55:06 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] perf symbols: turn dso__fprintf_symbols_by_name into void function
Date:   Mon,  8 Mar 2021 16:55:04 +0800
Message-Id: <1615193704-19876-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function always return '0' and no callers use the return value.
So make it a void function.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 tools/perf/util/dso.h            | 2 +-
 tools/perf/util/symbol_fprintf.c | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index cd2fe64..d7ebf21 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -364,7 +364,7 @@ struct dso *machine__findnew_kernel(struct machine *machine, const char *name,
 
 void dso__reset_find_symbol_cache(struct dso *dso);
 
-size_t dso__fprintf_symbols_by_name(struct dso *dso, FILE *fp);
+void dso__fprintf_symbols_by_name(struct dso *dso, FILE *fp);
 size_t dso__fprintf(struct dso *dso, FILE *fp);
 
 static inline bool dso__is_vmlinux(struct dso *dso)
diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index 35c936c..031584e 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -59,10 +59,9 @@ size_t symbol__fprintf_symname(const struct symbol *sym, FILE *fp)
 	return __symbol__fprintf_symname_offs(sym, NULL, false, false, fp);
 }
 
-size_t dso__fprintf_symbols_by_name(struct dso *dso,
+void dso__fprintf_symbols_by_name(struct dso *dso,
 				    FILE *fp)
 {
-	size_t ret = 0;
 	struct rb_node *nd;
 	struct symbol_name_rb_node *pos;
 
@@ -70,6 +69,4 @@ size_t dso__fprintf_symbols_by_name(struct dso *dso,
 		pos = rb_entry(nd, struct symbol_name_rb_node, rb_node);
 		fprintf(fp, "%s\n", pos->sym.name);
 	}
-
-	return ret;
 }
-- 
1.8.3.1

