Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2A362973
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbhDPUjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343657AbhDPUjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4457FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:38:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v2so7516490ybc.17
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jDS7Yxe+QOQd/ON8hFRWD8N0+6UfcyzD361zMutG46I=;
        b=AkvSGo1f82tRhgaVzheYzcz1/uHLFpEltaiLCHNc1FQJ0VIZvloEZRvttwz2Es0C9P
         JX2LNWBfwyju6TagtI3dBRt9bVrrtt+1P7QY4rJfTZoLt0evZuVLmewsroHlcVFWFes6
         ADh3S57I42WpbAnMIk4L/prCP9SaBUiZQ8ocb7Q6NMptSk8qG71Dn5z7B70L32yWQ6y8
         c5Kh1Lm6DJDe2uRNOjCN19N4L17xaiGLmFMzMU+u6iQ5rVgNtkCQWP1wdojuq1s05WYz
         tq3A2pH4uDwNo6aLLVcLGXMMn8lISDJn5fsSHhNteuW38VA7StOaYUBqlYnFxE/q/Oz4
         LH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jDS7Yxe+QOQd/ON8hFRWD8N0+6UfcyzD361zMutG46I=;
        b=ah7VGZ8LouA31ooPSzEH2bZ8Rdg1PMJK0nD0PE5M/bJBV3+bNSMWMv7xoTXuZR/p/X
         B3ltn8+L5n9C5MBmM6yDZXOAnoNelkE/3W0r2vCDtjGl8snIWPkBLeXFt8KUREScItOU
         dDNqwnyBDYL463WXa01A10VFxXUcdM2xdhz5VP/ja8A6CE3GfSpOzZJdQciEbeHUbi5/
         CBPDzbsxMwm+uFL1/bnVRF+6je8OI/nuxJxWoLvIEBaAVKhEXXqisMQ3xBckRgE+UtDF
         qqf7crRC0W6E7QIpxFO3m2Rt3bjxqt8pFEnHMuyGVpmItgXPjpztuA+V7zRp1KmOA5m6
         7dAw==
X-Gm-Message-State: AOAM53220jRa+JLd9Sz3wScFGtb/OLYN0aSzyKVtm1Q6YPn50IRvIec3
        eHSHq+LNaU9JTJF+MApY0OufZidI57psHf3rKMY=
X-Google-Smtp-Source: ABdhPJz6EYopab2NjNAirRR4XPpYKA7IO2tjJMvpgmFWOwpBc3UjDlp1MCM4q79PxwLfEdyF8wD1k54/T4m+GKFzQc0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a25:b993:: with SMTP id
 r19mr1340658ybg.445.1618605530534; Fri, 16 Apr 2021 13:38:50 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:31 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 02/15] objtool: Add CONFIG_CFI_CLANG support
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces function references with
references to the CFI jump table, which confuses objtool. This change,
based on Josh's initial patch [1], goes through the list of relocations
and replaces jump table symbols with the actual function symbols.

[1] https://lore.kernel.org/r/d743f4b36e120c06506567a9f87a062ae03da47f.1611263462.git.jpoimboe@redhat.com/

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/objtool/elf.c                 | 48 +++++++++++++++++++++++++++++
 tools/objtool/include/objtool/elf.h |  2 +-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d08f5f3670f8..5cf2c61ce7b8 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -273,6 +273,10 @@ static int read_sections(struct elf *elf)
 		}
 		sec->len = sec->sh.sh_size;
 
+		/* Detect -fsanitize=cfi jump table sections */
+		if (!strncmp(sec->name, ".text..L.cfi.jumptable", 22))
+			sec->cfi_jt = true;
+
 		list_add_tail(&sec->list, &elf->sections);
 		elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
 		elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
@@ -548,6 +552,48 @@ static int read_rela_reloc(struct section *sec, int i, struct reloc *reloc, unsi
 	return 0;
 }
 
+static int fix_cfi_relocs(const struct elf *elf)
+{
+	struct section *sec, *tmpsec;
+	struct reloc *reloc, *tmpreloc;
+
+	list_for_each_entry_safe(sec, tmpsec, &elf->sections, list) {
+		list_for_each_entry_safe(reloc, tmpreloc, &sec->reloc_list, list) {
+			struct symbol *sym;
+			struct reloc *func_reloc;
+
+			/*
+			 * CONFIG_CFI_CLANG replaces function relocations to refer
+			 * to an intermediate jump table. Undo the conversion so
+			 * objtool can make sense of things.
+			 */
+			if (!reloc->sym->sec->cfi_jt)
+				continue;
+
+			if (reloc->sym->type == STT_SECTION)
+				sym = find_func_by_offset(reloc->sym->sec,
+							  reloc->addend);
+			else
+				sym = reloc->sym;
+
+			if (!sym || !sym->sec)
+				continue;
+
+			/*
+			 * The jump table immediately jumps to the actual function,
+			 * so look up the relocation there.
+			 */
+			func_reloc = find_reloc_by_dest_range(elf, sym->sec, sym->offset, 5);
+			if (!func_reloc || !func_reloc->sym)
+				continue;
+
+			reloc->sym = func_reloc->sym;
+		}
+	}
+
+	return 0;
+}
+
 static int read_relocs(struct elf *elf)
 {
 	struct section *sec;
@@ -608,6 +654,8 @@ static int read_relocs(struct elf *elf)
 		tot_reloc += nr_reloc;
 	}
 
+	fix_cfi_relocs(elf);
+
 	if (stats) {
 		printf("max_reloc: %lu\n", max_reloc);
 		printf("tot_reloc: %lu\n", tot_reloc);
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 45e5ede363b0..ef19578fc5e4 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -39,7 +39,7 @@ struct section {
 	char *name;
 	int idx;
 	unsigned int len;
-	bool changed, text, rodata, noinstr;
+	bool changed, text, rodata, noinstr, cfi_jt;
 };
 
 struct symbol {
-- 
2.31.1.368.gbe11c130af-goog

