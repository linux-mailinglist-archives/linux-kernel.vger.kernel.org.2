Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77217421829
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 22:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhJDUIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 16:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhJDUIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 16:08:17 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C546EC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 13:06:27 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so23100323otq.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 13:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8yryO1q7vUqDj0GD/9buosSXcKos2OvpxJFYmhNgOtE=;
        b=LC1y5JSQvfphIeejoaCaBw4jyLXkqGSZfDhF2XfEwLL1fxJrKqYQx2ZuHnoG/iGrzw
         bGGqoxQuBHRPwoHjkA87Wf+aR5nTsA9zdxPVhzAwVACWpkMl6xreqqG7SJHTEAss+p3J
         is9nr4bltZD87bfH2cHrOPKaHCXz9EFNGBpaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8yryO1q7vUqDj0GD/9buosSXcKos2OvpxJFYmhNgOtE=;
        b=auwKAJM7QAPPb7q4OLMwpUEUddwujlTEMXpeNuJFvps/DV03+yrjIlrq5LROlLL5qq
         HOi/mmgwqA0ip4ugQWTH3bGBjVXilCLKxx5QcsJugLdPuAgsNRVgkICx7mozZq7u+B8l
         a7YEwrq06nqZ33rz3Z0BVh25a1M2PgLNtO0B7TOlsNLR7RPk0XAeXQTugobqNULrcM7V
         iIikYmpEkYm8kiolhNu83NbSU1zyHOEkcG8EtyxkxrFq3Lr1QuE405mowONDMr6TnR4c
         qiG/5J4kuzqEStUYOu4v1VEp8iZrtVkRAJB+tdstreh4Ps7Qa7tXxuvrhrD58TonZvXy
         bVfA==
X-Gm-Message-State: AOAM533WBV4SOZag/NixzZJUqgB2JZ4dqhXnBaYtfcGVIweJgL9IIZzo
        lZDn05kqiYUHkN/E4UFUTdOQ1w==
X-Google-Smtp-Source: ABdhPJwNQI9aToXY//iaLIJ1IgLT2vt58oS+o3xFzTipp9S702s0WDSjiuqNYQw/ee8dJGLNsgClfQ==
X-Received: by 2002:a9d:2086:: with SMTP id x6mr11364389ota.195.1633377987049;
        Mon, 04 Oct 2021 13:06:27 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u2sm3120668otg.51.2021.10.04.13.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 13:06:26 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mcgrof@kernel.org, jeyu@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] module: change to print useful messages from elf_validity_check()
Date:   Mon,  4 Oct 2021 14:06:25 -0600
Message-Id: <20211004200625.378439-1-skhan@linuxfoundation.org>
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

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 kernel/module.c | 83 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 22 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 40ec9a030eec..d972786b10ba 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2942,15 +2942,18 @@ static int module_sig_check(struct load_info *info, int flags)
 
 static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
 {
-	unsigned long secend;
+	unsigned long secend; /* too short when sh_offset is Elf64_Off */
 
 	/*
 	 * Check for both overflow and offset/size being
 	 * too large.
 	 */
 	secend = shdr->sh_offset + shdr->sh_size;
-	if (secend < shdr->sh_offset || secend > info->len)
+	if (secend < shdr->sh_offset || secend > info->len) {
+		pr_err("Invalid ELF section offset/size: secend(%lu) < shdr->sh_offset(%llu) or secend(%lu) > e_shnum(%lu)\n",
+		       secend, shdr->sh_offset, secend, info->len);
 		return -ENOEXEC;
+	}
 
 	return 0;
 }
@@ -2967,14 +2970,31 @@ static int elf_validity_check(struct load_info *info)
 	Elf_Shdr *shdr, *strhdr;
 	int err;
 
-	if (info->len < sizeof(*(info->hdr)))
-		return -ENOEXEC;
+	if (info->len < sizeof(*(info->hdr))) {
+		pr_err("Invalid ELF header len %lu < %lu\n", info->len,
+		       sizeof(*(info->hdr)));
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
+		pr_err("Invalid ELF section header size %d != %lu\n",
+		       info->hdr->e_shentsize, sizeof(Elf_Shdr));
+		goto no_exec;
+	}
 
 	/*
 	 * e_shnum is 16 bits, and sizeof(Elf_Shdr) is
@@ -2983,8 +3003,12 @@ static int elf_validity_check(struct load_info *info)
 	 */
 	if (info->hdr->e_shoff >= info->len
 	    || (info->hdr->e_shnum * sizeof(Elf_Shdr) >
-		info->len - info->hdr->e_shoff))
-		return -ENOEXEC;
+		info->len - info->hdr->e_shoff)) {
+		pr_err("Invalid ELF section header overflow: %ld > %llu\n",
+		       info->hdr->e_shnum * sizeof(Elf_Shdr),
+		       info->len - info->hdr->e_shoff);
+		goto no_exec;
+	}
 
 	info->sechdrs = (void *)info->hdr + info->hdr->e_shoff;
 
@@ -2992,8 +3016,12 @@ static int elf_validity_check(struct load_info *info)
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
@@ -3006,8 +3034,10 @@ static int elf_validity_check(struct load_info *info)
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
@@ -3015,8 +3045,12 @@ static int elf_validity_check(struct load_info *info)
 	 */
 	if (info->sechdrs[0].sh_type != SHT_NULL
 	    || info->sechdrs[0].sh_size != 0
-	    || info->sechdrs[0].sh_addr != 0)
-		return -ENOEXEC;
+	    || info->sechdrs[0].sh_addr != 0) {
+		pr_err("ELF Spec violation: section 0 type!=SH_NULL(%d) or non-zero len(%llu) or addr(%llu)\n",
+		       info->sechdrs[0].sh_type, info->sechdrs[0].sh_size,
+		       info->sechdrs[0].sh_addr);
+		goto no_exec;
+	}
 
 	for (i = 1; i < info->hdr->e_shnum; i++) {
 		shdr = &info->sechdrs[i];
@@ -3026,8 +3060,12 @@ static int elf_validity_check(struct load_info *info)
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
@@ -3049,6 +3087,9 @@ static int elf_validity_check(struct load_info *info)
 	}
 
 	return 0;
+
+no_exec:
+	return -ENOEXEC;
 }
 
 #define COPY_CHUNK_SIZE (16*PAGE_SIZE)
@@ -3940,10 +3981,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
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

