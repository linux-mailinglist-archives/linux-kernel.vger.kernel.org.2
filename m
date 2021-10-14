Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA8442DE93
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhJNPsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhJNPsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:48:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00D8C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jo+n8sD+BOX68cR7g18qRONEu6OTlCBp2imi7qfHsYY=; b=BYRM06ARsKAIt7edH8cYxRqGKU
        BPxNxhczxgZBF/WTmr+B6lRIQ6joje2pKEMq3jbBwRumP55nBGBAof2//jciMsysYm/TaF3AIoj0P
        tOHB8mWCIGxTDYCPsGRPrHBRXe81HRoQJOey+y4W4/Wk2k6cuO3JyHqTexwVoMcFrLfvdFdjIaZji
        dvkp/KG2Rs1zT0qCIHp2TzI0eKynyBegFu4PcjT/x3GeO/cj1tMcpGCssIwXf3BxK9iceVS2ibjiQ
        KdISppAoBD6HmyBrenjuo4vLd84pZ6iElx1jVvofcv1hPhDwiBZeSqUYPHenidEidD1ETRYL0apo6
        uGsomw/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mb2tC-008RNZ-3O; Thu, 14 Oct 2021 15:43:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13617300252;
        Thu, 14 Oct 2021 17:43:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E04422CA7F58C; Thu, 14 Oct 2021 17:43:25 +0200 (CEST)
Date:   Thu, 14 Oct 2021 17:43:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 1/9] objtool,x86: Replace alternatives with
 .retpoline_sites
Message-ID: <YWhQHbtOysHh2WWu@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123644.614129149@infradead.org>
 <20211013201135.ftaztysa4bdjedqd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013201135.ftaztysa4bdjedqd@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 01:11:35PM -0700, Josh Poimboeuf wrote:

> Guess it shouldn't be called arch_rewrite_retpolines() anymore.  And it
> can be moved to check.c next to create_static_call_sections().
> 
> Also is it possible to remove the arch_is_retpoline() check in
> get_alt_entry()?  I'm having trouble remembering why that was needed in
> the first place.

Makes sense...

---
+++ b/tools/objtool/arch/x86/decode.c
@@ -711,52 +711,6 @@ const char *arch_ret_insn(int len)
 	return ret[len-1];
 }
 
-int arch_rewrite_retpolines(struct objtool_file *file)
-{
-	struct instruction *insn;
-	struct section *sec;
-	int idx;
-
-	sec = find_section_by_name(file->elf, ".retpoline_sites");
-	if (sec) {
-		WARN("file already has .retpoline_sites, skipping");
-		return 0;
-	}
-
-	idx = 0;
-	list_for_each_entry(insn, &file->retpoline_call_list, call_node)
-		idx++;
-
-	if (!idx)
-		return 0;
-
-	sec = elf_create_section(file->elf, ".retpoline_sites", 0,
-				 sizeof(int), idx);
-	if (!sec) {
-		WARN("elf_create_section: .retpoline_sites");
-		return -1;
-	}
-
-	idx = 0;
-	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
-
-		int *site = (int *)sec->data->d_buf + idx;
-		*site = 0;
-
-		if (elf_add_reloc_to_insn(file->elf, sec,
-					  idx * sizeof(int),
-					  R_X86_64_PC32,
-					  insn->sec, insn->offset)) {
-			WARN("elf_add_reloc_to_insn: .retpoline_sites");
-			return -1;
-		}
-
-		idx++;
-	}
-
-	return 0;
-}
-
 int arch_decode_hint_reg(u8 sp_reg, int *base)
 {
 	switch (sp_reg) {
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -683,6 +683,52 @@ static int create_static_call_sections(s
 	return 0;
 }
 
+static int create_retpoline_sites_sections(struct objtool_file *file)
+{
+	struct instruction *insn;
+	struct section *sec;
+	int idx;
+
+	sec = find_section_by_name(file->elf, ".retpoline_sites");
+	if (sec) {
+		WARN("file already has .retpoline_sites, skipping");
+		return 0;
+	}
+
+	idx = 0;
+	list_for_each_entry(insn, &file->retpoline_call_list, call_node)
+		idx++;
+
+	if (!idx)
+		return 0;
+
+	sec = elf_create_section(file->elf, ".retpoline_sites", 0,
+				 sizeof(int), idx);
+	if (!sec) {
+		WARN("elf_create_section: .retpoline_sites");
+		return -1;
+	}
+
+	idx = 0;
+	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
+
+		int *site = (int *)sec->data->d_buf + idx;
+		*site = 0;
+
+		if (elf_add_reloc_to_insn(file->elf, sec,
+					  idx * sizeof(int),
+					  R_X86_64_PC32,
+					  insn->sec, insn->offset)) {
+			WARN("elf_add_reloc_to_insn: .retpoline_sites");
+			return -1;
+		}
+
+		idx++;
+	}
+
+	return 0;
+}
+
 static int create_mcount_loc_sections(struct objtool_file *file)
 {
 	struct section *sec;
@@ -1950,11 +1996,6 @@ static void mark_rodata(struct objtool_f
 	file->rodata = found;
 }
 
-__weak int arch_rewrite_retpolines(struct objtool_file *file)
-{
-	return 0;
-}
-
 static int decode_sections(struct objtool_file *file)
 {
 	int ret;
@@ -2027,15 +2068,6 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	/*
-	 * Must be after add_special_section_alts(), since this will emit
-	 * alternatives. Must be after add_{jump,call}_destination(), since
-	 * those create the call insn lists.
-	 */
-	ret = arch_rewrite_retpolines(file);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
@@ -3438,6 +3470,13 @@ int check(struct objtool_file *file)
 		goto out;
 	warnings += ret;
 
+	if (retpoline) {
+		ret = create_retpoline_sites_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
+	}
+
 	if (mcount) {
 		ret = create_mcount_loc_sections(file);
 		if (ret < 0)
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -109,14 +109,6 @@ static int get_alt_entry(struct elf *elf
 			return -1;
 		}
 
-		/*
-		 * Skip retpoline .altinstr_replacement... we already rewrite the
-		 * instructions for retpolines anyway, see arch_is_retpoline()
-		 * usage in add_{call,jump}_destinations().
-		 */
-		if (arch_is_retpoline(new_reloc->sym))
-			return 1;
-
 		reloc_to_sec_off(new_reloc, &alt->new_sec, &alt->new_off);
 
 		/* _ASM_EXTABLE_EX hack */
