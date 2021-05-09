Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533C93774A2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 02:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhEIACS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 20:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhEIACO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 20:02:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7915C061573
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 17:01:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t4so7396681plc.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 17:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4u+yBWSUwuw+MKgjAZFlc2yNXTul3SQymSkP1FAZTHw=;
        b=HSaD+kTzHd2gIvHjsGrSpZGJDzy1SUmAdWaSbqeV4KIp+Qm+DD/NCrboraigMH1sAW
         5s/WYRVrgBQJSPjpiHpQRFx5LRxp9lWxHeCwCp9oa0gK8LAS35JEipUxPIClKQ5CQMT/
         W5khdFqG5FrlIqdx42HOldsyO7cf/eJKOk9ZI9+s1OUUL5LuJ+f00v5qMO8flaXOW8d6
         j0SHIvYpWoBzgDHEn7xrzQNHC938x715sCygnT66RV9rN74Y0A7T/MiSOUVi2/KMZu0R
         UtafBH6PqIQT7zNT8UaXBReRXQ7c9niW6E7YEnZh3bWbwUqN3N2bofqXjZvWzWZPI0p3
         N9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4u+yBWSUwuw+MKgjAZFlc2yNXTul3SQymSkP1FAZTHw=;
        b=CqqBuqw3PcWrIomFfxIq1ApTBDM8tpvNiRzrNTJYsZymvi6JKUpPb26Qp6M8Uogz0K
         1f1z+gmY5cvRX+Bsj4/vvi3slhOpx0VMYogZuz9mIqWnARWxY3+dFie62T7d0KLYeRek
         hTTPPVKaWQbTLho/Yp6cDwGjyP6cC+/a6PHZvxx5kHMR22ooQ+1GlDhuetzSOW/GGXzE
         RCrWIju4UWlx8028ODZAJX/oACLvxpNHBbBOT/yBXXkjvN3oHgK/4w069XqWUDSyuqRC
         08Bwj/IBt+rYdHJZVbsO8OKAA6Pj63PYetNF0kbrHYLH15frXkqw5ln9yeQ+1R9Iwt9M
         38fQ==
X-Gm-Message-State: AOAM532CHu98ol5z3zSDxmoY7dIOZ+RcIByYdkPJA5sSvM/lLLcK6p0J
        HwAcLgjz4XvruVvVUZQ9A+xuW+cVtrtRTcUFDtM=
X-Google-Smtp-Source: ABdhPJw4aPG88a7BCJzOpnWzpACBS9hwCFgj+2yoz5103f3Erf7IFprjb58lwumF5Olk57gJpR1PNg==
X-Received: by 2002:a17:90a:650c:: with SMTP id i12mr32333806pjj.204.1620518472194;
        Sat, 08 May 2021 17:01:12 -0700 (PDT)
Received: from localhost ([2601:647:5180:4570:16dd:a9ff:fee7:6b79])
        by smtp.gmail.com with ESMTPSA id 12sm7816322pfz.205.2021.05.08.17.01.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 May 2021 17:01:11 -0700 (PDT)
From:   Michael Forney <mforney@mforney.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] objtool: Update section header before relocations
Date:   Sat,  8 May 2021 17:01:03 -0700
Message-Id: <20210509000103.11008-2-mforney@mforney.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509000103.11008-1-mforney@mforney.org>
References: <20210509000103.11008-1-mforney@mforney.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The libelf implemention from elftoolchain has a safety check in
gelf_update_rel[a] to check that the data corresponds to a section
that has type SHT_REL[A] [0]. If the relocation is updated before
the section header is updated with the proper type, this check
fails.

To fix this, update the section header first, before the relocations.
Previously, the section size was calculated in elf_rebuild_reloc_section
by counting the number of entries in the reloc_list. However, we
now need the size during elf_write so instead keep a running total
and add to it for every new relocation.

[0] https://sourceforge.net/p/elftoolchain/mailman/elftoolchain-developers/thread/CAGw6cBtkZro-8wZMD2ULkwJ39J+tHtTtAWXufMjnd3cQ7XG54g@mail.gmail.com/

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 tools/objtool/elf.c | 46 +++++++++++++++++----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index b396ee4ab85d..53d00fefebcf 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -481,6 +481,7 @@ int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 	list_add_tail(&reloc->list, &sec->reloc->reloc_list);
 	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
 
+	sec->reloc->sh.sh_size += sec->reloc->sh.sh_entsize;
 	sec->reloc->changed = true;
 
 	return 0;
@@ -929,26 +930,23 @@ static struct section *elf_create_reloc_section(struct elf *elf,
 	}
 }
 
-static int elf_rebuild_rel_reloc_section(struct section *sec, int nr)
+static int elf_rebuild_rel_reloc_section(struct section *sec)
 {
 	struct reloc *reloc;
-	int idx = 0, size;
+	int idx = 0;
 	void *buf;
 
 	/* Allocate a buffer for relocations */
-	size = nr * sizeof(GElf_Rel);
-	buf = malloc(size);
+	buf = malloc(sec->sh.sh_size);
 	if (!buf) {
 		perror("malloc");
 		return -1;
 	}
 
 	sec->data->d_buf = buf;
-	sec->data->d_size = size;
+	sec->data->d_size = sec->sh.sh_size;
 	sec->data->d_type = ELF_T_REL;
 
-	sec->sh.sh_size = size;
-
 	idx = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list) {
 		reloc->rel.r_offset = reloc->offset;
@@ -963,26 +961,23 @@ static int elf_rebuild_rel_reloc_section(struct section *sec, int nr)
 	return 0;
 }
 
-static int elf_rebuild_rela_reloc_section(struct section *sec, int nr)
+static int elf_rebuild_rela_reloc_section(struct section *sec)
 {
 	struct reloc *reloc;
-	int idx = 0, size;
+	int idx = 0;
 	void *buf;
 
 	/* Allocate a buffer for relocations with addends */
-	size = nr * sizeof(GElf_Rela);
-	buf = malloc(size);
+	buf = malloc(sec->sh.sh_size);
 	if (!buf) {
 		perror("malloc");
 		return -1;
 	}
 
 	sec->data->d_buf = buf;
-	sec->data->d_size = size;
+	sec->data->d_size = sec->sh.sh_size;
 	sec->data->d_type = ELF_T_RELA;
 
-	sec->sh.sh_size = size;
-
 	idx = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list) {
 		reloc->rela.r_offset = reloc->offset;
@@ -1000,16 +995,9 @@ static int elf_rebuild_rela_reloc_section(struct section *sec, int nr)
 
 static int elf_rebuild_reloc_section(struct elf *elf, struct section *sec)
 {
-	struct reloc *reloc;
-	int nr;
-
-	nr = 0;
-	list_for_each_entry(reloc, &sec->reloc_list, list)
-		nr++;
-
 	switch (sec->sh.sh_type) {
-	case SHT_REL:  return elf_rebuild_rel_reloc_section(sec, nr);
-	case SHT_RELA: return elf_rebuild_rela_reloc_section(sec, nr);
+	case SHT_REL:  return elf_rebuild_rel_reloc_section(sec);
+	case SHT_RELA: return elf_rebuild_rela_reloc_section(sec);
 	default:       return -1;
 	}
 }
@@ -1069,12 +1057,6 @@ int elf_write(struct elf *elf)
 	/* Update changed relocation sections and section headers: */
 	list_for_each_entry(sec, &elf->sections, list) {
 		if (sec->changed) {
-			if (sec->base &&
-			    elf_rebuild_reloc_section(elf, sec)) {
-				WARN("elf_rebuild_reloc_section");
-				return -1;
-			}
-
 			s = elf_getscn(elf->elf, sec->idx);
 			if (!s) {
 				WARN_ELF("elf_getscn");
@@ -1085,6 +1067,12 @@ int elf_write(struct elf *elf)
 				return -1;
 			}
 
+			if (sec->base &&
+			    elf_rebuild_reloc_section(elf, sec)) {
+				WARN("elf_rebuild_reloc_section");
+				return -1;
+			}
+
 			sec->changed = false;
 			elf->changed = true;
 		}
-- 
2.31.1

