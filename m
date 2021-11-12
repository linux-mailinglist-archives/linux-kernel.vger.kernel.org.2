Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D60344E0E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 04:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhKLDyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 22:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhKLDyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 22:54:31 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D50C061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 19:51:41 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z19-20020aa79593000000b0049472f5e52dso5001706pfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 19:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dZYNpRCmI52Lfxv1Kj3qct987pZvSTrOpR4mQ6ymhN8=;
        b=i4cNwQvus/YiDhCC0IHfXGa/XH/0Y8aRqnRNARp5wYC6gEoRAsfbCApJl6NZFokkWe
         5FGwevkhG6yYNvjl0duKyRom/0IGy7ViK5bBbGRhU+cjW3aUvDJljeCDxIDDfw8lWjk3
         dbL9rqA/Mfq862JdU9h67Zt6pkJxSIxUQvW6PQr51ffojmbkdUo1oOKMBYR46LLCooez
         SrxbNcw9Z45F/RHZLGI7McH954PM+X+NWFLiG7H5RDbbI5b96/XN9N6E6vPI0DWnZHoI
         a+ZWxtTOc1vAwfY+1JCYB4xqO4YJl5GTftIawP8AGxraZw/mUzYlZK0b4iGEbrG86Rti
         ssAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dZYNpRCmI52Lfxv1Kj3qct987pZvSTrOpR4mQ6ymhN8=;
        b=VWsZ8S3mveXSznoTyfBpkLz6oiPQGtF/HvjnXrb+1LMXXQI4zlBAnT1eMvY1rueUrO
         OsykqXLUoKl0E9pQRLYOZh8jVTxEiu1Eie5DpU2pkTb6+BTz8Rt60B9w5OYJbF/FcWGm
         rNMgTug/e83jhNWkb83fYp903oJmkCnYlB54RKj2GaYY2C7Obvdvk/prbMEXZ0zyEIWm
         9Bx0emXL/lBBcnk9nMT3bOoEcZkMnsD4DSp12ohOjIxARTST1jjfvUCyoh19mlpgXj7Z
         1Bhujn5Rpd7HtpZje7pDOcAI93DaDxMU/0KtVoSMCkLstrqHYNDPWBcP/0uNUYfiS/vr
         /zdg==
X-Gm-Message-State: AOAM533LrAUjEWBSd9kfRTZurD5s8+mzjviTxecYeadXsVHPuKP9oYu6
        kbeMELdKD2PRZdSpmPjvf/Ho8i2gC3O3
X-Google-Smtp-Source: ABdhPJz+k3+zNqvB/iPXMR9Ncht2dhzxLGzJA6paC6lYLz7qyPX3/tUCCwv/Qwz2Cii71Hhwbj4dEICz7VYQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5ce9:74ca:7ed9:75f2])
 (user=irogers job=sendgmr) by 2002:a63:2683:: with SMTP id
 m125mr7988050pgm.277.1636689100511; Thu, 11 Nov 2021 19:51:40 -0800 (PST)
Date:   Thu, 11 Nov 2021 19:51:22 -0800
Message-Id: <20211112035124.94327-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH 1/3] perf symbols: Add documentation to struct symbol.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor some existing comments and then infer the rest.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 166196686f2e..3586fa549f44 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -40,22 +40,33 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 			     GElf_Shdr *shp, const char *name, size_t *idx);
 #endif
 
-/** struct symbol - symtab entry
- *
- * @ignore - resolvable but tools ignore it (e.g. idle routines)
+/**
+ * A symtab entry. When allocated this may be preceded by an annotation (see
+ * symbol__annotation), a browser_index (see symbol__browser_index) and rb_node
+ * to sort by name (see struct symbol_name_rb_node).
  */
 struct symbol {
 	struct rb_node	rb_node;
+	/** Range of symbol [start, end). */
 	u64		start;
 	u64		end;
+	/** Length of the string name. */
 	u16		namelen;
+	/** ELF symbol type as defined for st_info. E.g STT_OBJECT or STT_FUNC. */
 	u8		type:4;
+	/** ELF binding type as defined for st_info. E.g. STB_WEAK or STB_GLOBAL. */
 	u8		binding:4;
+	/** Set true for kernel symbols of idle routines. */
 	u8		idle:1;
+	/** Resolvable but tools ignore it (e.g. idle routines). */
 	u8		ignore:1;
+	/** Symbol for an inlined function. */
 	u8		inlined:1;
+	/** Architecture specific. Unused except on PPC where it holds st_other. */
 	u8		arch_sym;
+	/** Has symbol__annotate2 been performed. */
 	bool		annotate2;
+	/** The name of length namelen associated with the symbol. */
 	char		name[];
 };
 
-- 
2.34.0.rc1.387.gb447b232ab-goog

