Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25FD34AB33
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhCZPOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhCZPNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:13:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B1C0613B2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=lenVpfVTRdmlr4QerYGvPmX9xUOMv73u9GEKuv3kF7M=; b=Oq9qqYPImN3uveIwcFx3p4IQtm
        i2lDXZoFhRL7hJk8FpJsypDHMGtbDPmWHYr7bTnIU7LevP38NDmFmSiCpTr4iYJ+MT372SqApiSTW
        eWNGxNmS0EjAtOfJpPbn4n0DcMJx5ianRniva86RDgSWnf0Kl4Eu6psY6qnP7FsRkfhwIfvb8ZRni
        znJCvfnM2T4Po1quMIDDH9405WpWzDTcs+9t5L+g+kNE6jB3PlYITqEpTDCqQrwbtMCMOOa8xmNd0
        kvaoJcn86Isc6IMMR6+YFgPflO48nk+eJJQoIFNWBNH86ut9H1RbyhFNnU6NAJDkxiz/fReUC0BrV
        Kv2cTmOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPo9X-003s0D-T9; Fri, 26 Mar 2021 15:13:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6603307985;
        Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5C3642BD7339A; Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Message-ID: <20210326151259.941474004@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 16:12:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v3 10/16] objtool: Extract elf_strtab_concat()
References: <20210326151159.128534163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a common helper to append strings to a strtab.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c |   60 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 22 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -666,13 +666,48 @@ struct elf *elf_open_read(const char *na
 	return NULL;
 }
 
+static int elf_add_string(struct elf *elf, struct section *strtab, char *str)
+{
+	Elf_Data *data;
+	Elf_Scn *s;
+	int len;
+
+	if (!strtab)
+		strtab = find_section_by_name(elf, ".strtab");
+	if (!strtab) {
+		WARN("can't find .strtab section");
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
+	data->d_buf = str;
+	data->d_size = strlen(str) + 1;;
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
 	struct section *sec, *shstrtab;
 	size_t size = entsize * nr;
 	Elf_Scn *s;
-	Elf_Data *data;
 
 	sec = malloc(sizeof(*sec));
 	if (!sec) {
@@ -729,7 +764,6 @@ struct section *elf_create_section(struc
 	sec->sh.sh_addralign = 1;
 	sec->sh.sh_flags = SHF_ALLOC | sh_flags;
 
-
 	/* Add section name to .shstrtab (or .strtab for Clang) */
 	shstrtab = find_section_by_name(elf, ".shstrtab");
 	if (!shstrtab)
@@ -738,27 +772,9 @@ struct section *elf_create_section(struc
 		WARN("can't find .shstrtab or .strtab section");
 		return NULL;
 	}
-
-	s = elf_getscn(elf->elf, shstrtab->idx);
-	if (!s) {
-		WARN_ELF("elf_getscn");
-		return NULL;
-	}
-
-	data = elf_newdata(s);
-	if (!data) {
-		WARN_ELF("elf_newdata");
+	sec->sh.sh_name = elf_add_string(elf, shstrtab, sec->name);
+	if (sec->sh.sh_name == -1)
 		return NULL;
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


