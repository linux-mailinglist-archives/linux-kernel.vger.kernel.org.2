Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DE7340BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhCRRYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhCRRYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:24:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B240C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/VUMnIMYXPlDSlV6sNI7MRL08VkyK4wr7uHRzf49qGo=; b=WvC6dx1TAECH3K9K1CvZkXI5lj
        +3c2x02zsWob6Bzf9tGLAkhaMNzOStN/1qROhOMKLCXz5t7EEffL1IK11ojrg3t7+liQZP0PnNxsR
        zZUhTbnXTdWZWP5vQH5XdehYNLOI1qVMK/iHeSi2wR8OiEtmM17c381DPDuEexuAtQV8GYgxoZurf
        D+0cCrZEYPOUEcQ8ItFfoPJ6VWPqeSPpC7E5P0Mpa/9pZODtBRUG3bV1nRsyVklymVY/LoIv6uHfm
        4iEj12dkJiAs7nhnQkk9DYBlEh1Y0O1nhh0v2jjmqnEIHv/3vcPExE/2pPC306FZAGcX63oaZ75Us
        H8NEJy0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMwMq-003HIW-Ir; Thu, 18 Mar 2021 17:23:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 45B2F307890;
        Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 388E0213C0F58; Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Message-ID: <20210318171919.948282703@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Mar 2021 18:11:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 09/14] objtool: Extract elf_strtab_concat()
References: <20210318171103.577093939@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a common helper to append strings to a strtab.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c |   73 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 31 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -676,13 +676,51 @@ struct elf *elf_open_read(const char *na
 	return NULL;
 }
 
+static int elf_strtab_concat(struct elf *elf, char *name, const char *strtab_name)
+{
+	struct section *strtab = NULL;
+	Elf_Data *data;
+	Elf_Scn *s;
+	int len;
+
+	if (strtab_name)
+		strtab = find_section_by_name(elf, strtab_name);
+	if (!strtab)
+		strtab = find_section_by_name(elf, ".strtab");
+	if (!strtab) {
+		WARN("can't find %s or .strtab section", strtab_name);
+		return -1;
+	}
+
+	s = elf_getscn(elf->elf, strtab->idx);
+	if (!s) {
+		WARN_ELF("elf_getscn");
+		return -1;
+	}
+
+	data = elf_newdata(s);
+	if (!data) {
+		WARN_ELF("elf_newdata");
+		return -1;
+	}
+
+	data->d_buf = name;
+	data->d_size = strlen(name) + 1;;
+	data->d_align = 1;
+
+	len = strtab->len;
+	strtab->len += data->d_size;
+	strtab->changed = true;
+
+	return len;
+}
+
 struct section *elf_create_section(struct elf *elf, const char *name,
 				   unsigned int sh_flags, size_t entsize, int nr)
 {
-	struct section *sec, *shstrtab;
+	struct section *sec;
 	size_t size = entsize * nr;
 	Elf_Scn *s;
-	Elf_Data *data;
 
 	sec = malloc(sizeof(*sec));
 	if (!sec) {
@@ -739,36 +777,9 @@ struct section *elf_create_section(struc
 	sec->sh.sh_addralign = 1;
 	sec->sh.sh_flags = SHF_ALLOC | sh_flags;
 
-
-	/* Add section name to .shstrtab (or .strtab for Clang) */
-	shstrtab = find_section_by_name(elf, ".shstrtab");
-	if (!shstrtab)
-		shstrtab = find_section_by_name(elf, ".strtab");
-	if (!shstrtab) {
-		WARN("can't find .shstrtab or .strtab section");
-		return NULL;
-	}
-
-	s = elf_getscn(elf->elf, shstrtab->idx);
-	if (!s) {
-		WARN_ELF("elf_getscn");
+	sec->sh.sh_name = elf_strtab_concat(elf, sec->name, ".shstrtab");
+	if (sec->sh.sh_name == -1)
 		return NULL;
-	}
-
-	data = elf_newdata(s);
-	if (!data) {
-		WARN_ELF("elf_newdata");
-		return NULL;
-	}
-
-	data->d_buf = sec->name;
-	data->d_size = strlen(name) + 1;
-	data->d_align = 1;
-
-	sec->sh.sh_name = shstrtab->len;
-
-	shstrtab->len += strlen(name) + 1;
-	shstrtab->changed = true;
 
 	list_add_tail(&sec->list, &elf->sections);
 	elf_hash_add(elf->section_hash, &sec->hash, sec->idx);


