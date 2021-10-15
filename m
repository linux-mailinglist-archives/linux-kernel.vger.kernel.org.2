Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785F742FD24
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 22:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbhJOU7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 16:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbhJOU7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 16:59:50 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59A2C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 13:57:43 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id w10so8417761ilc.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 13:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=49zDBd/HOIEQBlwFTNVvuEBRNEd61IZ6dAmkdrZ6Zz8=;
        b=Rcbezt713txvKMHIp92ms4GVUXX/B19bsRh8lZ3riL5Xjrk9JfNOlw1NGiikwlSVKJ
         0XmBZPXsM6qiLtfPhgu64yNBJ490doknrC011F0isgghlE/zoaTbIBuIDd5Bgi3hUTy+
         EeJKGEWso8AL+BROf1DBxLWEVKO6saSQzXLkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=49zDBd/HOIEQBlwFTNVvuEBRNEd61IZ6dAmkdrZ6Zz8=;
        b=oEDwEsSXJWog0AOwBl/RHwOUI+W3eiGV7+vSIzLEZaUphP8AXwjqcnVp+PZYfGJPlr
         393TeX7CQqWe553bmJpfOLJaupKMwomHqR6ofwM5U0PMtwKTzIYsdWpg1pAhiQf2GuwG
         EuIQPZqnxxlRQBLkz9TjTQUuF6It9gkHb1+NkakGtmIuq1S0Nbnrvhc0LCtZwIl/anEE
         YiJYoRsTTWRits6Y4dMFZg1JsInBUC64LvbBu87Rn3HyFOHozPPu+JBFEaifLVURiYty
         3QXQTJE2GimKOW1o4mW+ySEU2HhRhE4BYJLlyHGXviSyj0aG/5tBd/DbK5YgUdwSsKu9
         S/eA==
X-Gm-Message-State: AOAM533Bu9Vd9+jHIubcXIEWqWV6ltI5X3ox7ItEnb3oCsqlgMpzA1Gx
        G9z12/0AskBclRb5pPnRksAfXA==
X-Google-Smtp-Source: ABdhPJx1U2+a89Ah650dUPe3yxxDQ86tw068jNoxqx3nFDyWhBBxX2fHgD/FMlJ6bBxTdfazEPfyJw==
X-Received: by 2002:a05:6e02:1a2e:: with SMTP id g14mr1171444ile.294.1634331463145;
        Fri, 15 Oct 2021 13:57:43 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id ay5sm3455111iob.46.2021.10.15.13.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 13:57:42 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mcgrof@kernel.org, jeyu@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v2] module: change to print useful messages from elf_validity_check()
Date:   Fri, 15 Oct 2021 14:57:40 -0600
Message-Id: <20211015205741.38283-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

elf_validity_check() checks ELF headers for errors and ELF Spec.
compliance and if any of them fail it returns -ENOEXEC from all of
these error paths. Almost all of them don't print any messages.

When elf_validity_check() returns an error, load_module() prints an
error message without error code. It is hard to determine why the
module ELF structure is invalid, even if load_module() prints the
error code which is -ENOEXEC in all of these cases.

Change to print useful error messages from elf_validity_check() to
clearly say what went wrong and why the ELF validity checks failed.

Remove the load_module() error message which is no longer needed.
This patch includes changes to fix build warns on 32-bit platforms:

warning: format '%llu' expects argument of type 'long long unsigned int',
but argument 3 has type 'Elf32_Off' {aka 'unsigned int'}
Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 kernel/module.c | 75 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 21 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 40ec9a030eec..f5d6e388478c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2967,14 +2967,29 @@ static int elf_validity_check(struct load_info *info)
 	Elf_Shdr *shdr, *strhdr;
 	int err;
 
-	if (info->len < sizeof(*(info->hdr)))
-		return -ENOEXEC;
+	if (info->len < sizeof(*(info->hdr))) {
+		pr_err("Invalid ELF header len %lu\n", info->len);
+		goto no_exec;
+	}
 
-	if (memcmp(info->hdr->e_ident, ELFMAG, SELFMAG) != 0
-	    || info->hdr->e_type != ET_REL
-	    || !elf_check_arch(info->hdr)
-	    || info->hdr->e_shentsize != sizeof(Elf_Shdr))
-		return -ENOEXEC;
+	if (memcmp(info->hdr->e_ident, ELFMAG, SELFMAG) != 0) {
+		pr_err("Invalid ELF header magic: != %s\n", ELFMAG);
+		goto no_exec;
+	}
+	if (info->hdr->e_type != ET_REL) {
+		pr_err("Invalid ELF header type: %u != %u\n",
+		       info->hdr->e_type, ET_REL);
+		goto no_exec;
+	}
+	if (!elf_check_arch(info->hdr)) {
+		pr_err("Invalid architecture in ELF header: %u\n",
+		       info->hdr->e_machine);
+		goto no_exec;
+	}
+	if (info->hdr->e_shentsize != sizeof(Elf_Shdr)) {
+		pr_err("Invalid ELF section header size\n");
+		goto no_exec;
+	}
 
 	/*
 	 * e_shnum is 16 bits, and sizeof(Elf_Shdr) is
@@ -2983,8 +2998,10 @@ static int elf_validity_check(struct load_info *info)
 	 */
 	if (info->hdr->e_shoff >= info->len
 	    || (info->hdr->e_shnum * sizeof(Elf_Shdr) >
-		info->len - info->hdr->e_shoff))
-		return -ENOEXEC;
+		info->len - info->hdr->e_shoff)) {
+		pr_err("Invalid ELF section header overflow\n");
+		goto no_exec;
+	}
 
 	info->sechdrs = (void *)info->hdr + info->hdr->e_shoff;
 
@@ -2992,13 +3009,19 @@ static int elf_validity_check(struct load_info *info)
 	 * Verify if the section name table index is valid.
 	 */
 	if (info->hdr->e_shstrndx == SHN_UNDEF
-	    || info->hdr->e_shstrndx >= info->hdr->e_shnum)
-		return -ENOEXEC;
+	    || info->hdr->e_shstrndx >= info->hdr->e_shnum) {
+		pr_err("Invalid ELF section name index: %d || e_shstrndx (%d) >= e_shnum (%d)\n",
+		       info->hdr->e_shstrndx, info->hdr->e_shstrndx,
+		       info->hdr->e_shnum);
+		goto no_exec;
+	}
 
 	strhdr = &info->sechdrs[info->hdr->e_shstrndx];
 	err = validate_section_offset(info, strhdr);
-	if (err < 0)
+	if (err < 0) {
+		pr_err("Invalid ELF section hdr(type %u)\n", strhdr->sh_type);
 		return err;
+	}
 
 	/*
 	 * The section name table must be NUL-terminated, as required
@@ -3006,8 +3029,10 @@ static int elf_validity_check(struct load_info *info)
 	 * strings in the section safe.
 	 */
 	info->secstrings = (void *)info->hdr + strhdr->sh_offset;
-	if (info->secstrings[strhdr->sh_size - 1] != '\0')
-		return -ENOEXEC;
+	if (info->secstrings[strhdr->sh_size - 1] != '\0') {
+		pr_err("ELF Spec violation: section name table isn't null terminated\n");
+		goto no_exec;
+	}
 
 	/*
 	 * The code assumes that section 0 has a length of zero and
@@ -3015,8 +3040,11 @@ static int elf_validity_check(struct load_info *info)
 	 */
 	if (info->sechdrs[0].sh_type != SHT_NULL
 	    || info->sechdrs[0].sh_size != 0
-	    || info->sechdrs[0].sh_addr != 0)
-		return -ENOEXEC;
+	    || info->sechdrs[0].sh_addr != 0) {
+		pr_err("ELF Spec violation: section 0 type(%d)!=SH_NULL or non-zero len or addr\n",
+		       info->sechdrs[0].sh_type);
+		goto no_exec;
+	}
 
 	for (i = 1; i < info->hdr->e_shnum; i++) {
 		shdr = &info->sechdrs[i];
@@ -3026,8 +3054,12 @@ static int elf_validity_check(struct load_info *info)
 			continue;
 		case SHT_SYMTAB:
 			if (shdr->sh_link == SHN_UNDEF
-			    || shdr->sh_link >= info->hdr->e_shnum)
-				return -ENOEXEC;
+			    || shdr->sh_link >= info->hdr->e_shnum) {
+				pr_err("Invalid ELF sh_link!=SHN_UNDEF(%d) or (sh_link(%d) >= hdr->e_shnum(%d)\n",
+				       shdr->sh_link, shdr->sh_link,
+				       info->hdr->e_shnum);
+				goto no_exec;
+			}
 			fallthrough;
 		default:
 			err = validate_section_offset(info, shdr);
@@ -3049,6 +3081,9 @@ static int elf_validity_check(struct load_info *info)
 	}
 
 	return 0;
+
+no_exec:
+	return -ENOEXEC;
 }
 
 #define COPY_CHUNK_SIZE (16*PAGE_SIZE)
@@ -3940,10 +3975,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	 * sections.
 	 */
 	err = elf_validity_check(info);
-	if (err) {
-		pr_err("Module has invalid ELF structures\n");
+	if (err)
 		goto free_copy;
-	}
 
 	/*
 	 * Everything checks out, so set up the section info
-- 
2.30.2

