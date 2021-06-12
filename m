Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164403A4EE5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 14:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhFLMkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 08:40:52 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:37618 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhFLMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 08:40:51 -0400
Received: by mail-wm1-f54.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso10156845wmg.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pvddg2cis787snEyuu2x3z4ZCkJvY1LbSfP6f1WO9PM=;
        b=EQHWM8OnyHfFsF6Ypep7l7bZ52bQ5hXhpLSxULaX0p3bojL7koTJAiJpQZ9OLRzdvy
         AFMREsUL8VAN6j2FSLw8W6L4hdNv7d1zE/R6UVBlgPL2zxaQNoacRZDEpsmuJFn3+Q/m
         /1nXbNcq5PYk3dU+Oz0lqG9+WvLSr7xnk2Vu2R01oz3lGfTzejmfx8P3kb4itIdusnhg
         EBf/bU3uxuEmUaqlx8b+VAs5xzygwczpgMwZDFt7PC1dTUzzyVqnHOtH7Xg9WNQ3IxFD
         lMkgsgFTJP+4pF8PUG99VwbT1FFSM9NPtmU8v8irIwe9zNTI8rAFfq5zsDB0TGWqZ6X1
         62Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=pvddg2cis787snEyuu2x3z4ZCkJvY1LbSfP6f1WO9PM=;
        b=iFiMZD1Hctxb+JDLKoCG/qmlxicp+zOXPQZezJvBskNdjBmWgw44CB3XWvZOaQUZrq
         52hvUTGNtuljQ8NWLa5LYFZ624Axu94+DNS51i5ayBADuk1hJ92pUOowBa8M/Ui3ltN+
         dAuEIl51KS+kJotmGRjjfJfNRTHWHI2Gk6udcIEs9uzupJpYaf+ZP10niMghdnOMw1Wc
         cJCvAuJ1SOJX7zp4zJAZXff7p8MhwXxa9uH7Xdl2JY1L8J0aP6z9kJv1Da+ImdxGSjNK
         8qlb11pSJcuPtWhBQ0zv6Ckjjymg+Sk7KDrSmchv1qdzSBZeMGpyh4ag+rHxDUc+nqB+
         Z4XA==
X-Gm-Message-State: AOAM530a3BeW1bjxze8z72BDU6orIQFjAgTkyXwft1k6OcTNxgKQ7qFH
        doHryIuKG2cgw/DUO5LU6dCY4aex9LI=
X-Google-Smtp-Source: ABdhPJw8kyzMVQOh5a/NmAKEiPwwdZXbfD278my8H4FWz39LQf9AQEiF+h7w4ZrwCsk2mb6FHGE3tQ==
X-Received: by 2002:a05:600c:1d1b:: with SMTP id l27mr8180064wms.62.1623501470912;
        Sat, 12 Jun 2021 05:37:50 -0700 (PDT)
Received: from gmail.com (77-234-80-172.pool.digikabel.hu. [77.234.80.172])
        by smtp.gmail.com with ESMTPSA id r3sm8404110wmq.8.2021.06.12.05.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 05:37:50 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 12 Jun 2021 14:37:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [GIT PULL] objtool fixes
Message-ID: <YMSqmtLIojtlZQIQ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest objtool/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2021-06-12

   # HEAD: 2d49b721dc18c113d5221f4cf5a6104eb66cb7f2 objtool: Only rewrite unconditional retpoline thunk calls

Two objtool fixes:

 - fix a bug that corrupts the code by mistakenly rewriting
   conditional jumps,
 - and fix another bug generating an incorrect ELF symbol table
   during retpoline rewriting.

 Thanks,

	Ingo

------------------>
Peter Zijlstra (2):
      objtool: Fix .symtab_shndx handling for elf_create_undef_symbol()
      objtool: Only rewrite unconditional retpoline thunk calls


 tools/objtool/arch/x86/decode.c |  4 ++++
 tools/objtool/elf.c             | 25 ++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 24295d39713b..523aa4157f80 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -747,6 +747,10 @@ int arch_rewrite_retpolines(struct objtool_file *file)
 
 	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
 
+		if (insn->type != INSN_JUMP_DYNAMIC &&
+		    insn->type != INSN_CALL_DYNAMIC)
+			continue;
+
 		if (!strcmp(insn->sec->name, ".text.__x86.indirect_thunk"))
 			continue;
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 743c2e9d0f56..41bca1d13d8e 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -717,7 +717,7 @@ static int elf_add_string(struct elf *elf, struct section *strtab, char *str)
 
 struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
 {
-	struct section *symtab;
+	struct section *symtab, *symtab_shndx;
 	struct symbol *sym;
 	Elf_Data *data;
 	Elf_Scn *s;
@@ -769,6 +769,29 @@ struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
 	symtab->len += data->d_size;
 	symtab->changed = true;
 
+	symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
+	if (symtab_shndx) {
+		s = elf_getscn(elf->elf, symtab_shndx->idx);
+		if (!s) {
+			WARN_ELF("elf_getscn");
+			return NULL;
+		}
+
+		data = elf_newdata(s);
+		if (!data) {
+			WARN_ELF("elf_newdata");
+			return NULL;
+		}
+
+		data->d_buf = &sym->sym.st_size; /* conveniently 0 */
+		data->d_size = sizeof(Elf32_Word);
+		data->d_align = 4;
+		data->d_type = ELF_T_WORD;
+
+		symtab_shndx->len += 4;
+		symtab_shndx->changed = true;
+	}
+
 	sym->sec = find_section_by_index(elf, 0);
 
 	elf_add_symbol(elf, sym);
