Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E24306582
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhA0U5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbhA0U4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:56:49 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB88AC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 12:56:04 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id d26so2282199qve.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 12:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=afydIjTboHZYNt7UhxBI9r/K8JAPb3TsRLb2cVHkJug=;
        b=OEss27zfJ7iNp3b9IE3aHmQWzKmbK7MxprrUD6n6W3wsjaIXDpNdUha+30ZoETTBwP
         84bE1InbOkYlY9PQ9QHdl2YXYFxHzdPpYzyVJ5ocIw2ZRnu77mmFttvuLaYi8BQcRSHD
         zf4hRWKGUwtM+pgKaF+7/KQqA5QlkWvAi+azXjPy6RIkbqrWm4xUstPJIf1wgEE/fyzQ
         MnsrhA1Ypuqu+XExTbjWuCgrK+SK3AumC0ds690JhPVfxG3GVVGxRskGn/t60npT5TDx
         MJsLP63hBNEHn17qSig/tYbCvu/hKHgWGKD/7TQgV7HrBIG5sJe41yrKnig9P09i0mQa
         O9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=afydIjTboHZYNt7UhxBI9r/K8JAPb3TsRLb2cVHkJug=;
        b=MFqUx/fiTn8shCWoIH9go7n7osN0y6L8iPO4VuEqQvZusa+uJZKCnJlQdSWABp1rMo
         HkJXVlHeIW5e/5UVeBv1NGn1a0jeX0oWLoOsjGD6iUBGdfIGi2HlrDhZ8KGN6D3KRIuC
         0SQsIVN6YLnOo6PFyljTsQM7dY1s2vZHLYkViIiUlIN+jiHv5gHXBfMEokRMW4yMofJx
         56dlhtDHwqafdN2aqgAFAZlh1Q0t36iKenJ5MzRVty1feTmWI0NpBbTu/cPCSZ2oAlba
         XQiH+hmG/+ruyRg/Q95/ppKP8x0l8Q4JGNRQqS+NLCeB30bClf3tONXpjD9yiF/c4HXq
         w1Qg==
X-Gm-Message-State: AOAM533LMOFdxjDbl7J7YuforbbbVVJmabvdYtTqRDQnrZ64yl1LqiDz
        Q5DwJ7PONpz6Szg8dwGyopZhv2aQZTVt
X-Google-Smtp-Source: ABdhPJyo+erd0t2C9lhJVscGgivAL6+qxWCusKgWAQe95FLVOrO+xKnIT46IU+7Udx+HnT9zbSiEY+fCjQv8
Sender: "maskray via sendgmr" <maskray@maskray1.svl.corp.google.com>
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
 (user=maskray job=sendgmr) by 2002:a05:6214:12ab:: with SMTP id
 w11mr12230114qvu.8.1611780963780; Wed, 27 Jan 2021 12:56:03 -0800 (PST)
Date:   Wed, 27 Jan 2021 12:56:00 -0800
In-Reply-To: <20210125172956.j2prlchhqwfcgzuc@google.com>
Message-Id: <20210127205600.1227437-1-maskray@google.com>
Mime-Version: 1.0
References: <20210125172956.j2prlchhqwfcgzuc@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v4] x86: Treat R_386_PLT32 as R_386_PC32
From:   Fangrui Song <maskray@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is similar to commit b21ebf2fb4cd ("x86: Treat R_X86_64_PLT32 as
R_X86_64_PC32"), but for i386.  As far as Linux kernel is concerned,
R_386_PLT32 can be treated the same as R_386_PC32.

R_386_PLT32/R_X86_64_PLT32 are PC-relative relocation types which can
only be used by branches. If the referenced symbol is defined
externally, a PLT will be used.
R_386_PC32/R_X86_64_PC32 are PC-relative relocation types which can be
used by address taking operations and branches. If the referenced symbol
is defined externally, a copy relocation/canonical PLT entry will be
created in the executable.

On x86-64, there is no PIC vs non-PIC PLT distinction and an
R_X86_64_PLT32 relocation is produced for both `call/jmp foo` and
`call/jmp foo@PLT` with newer (2018) GNU as/LLVM integrated assembler.
This avoids canonical PLT entries (st_shndx=0, st_value!=0).

On i386, there are 2 types of PLTs, PIC and non-PIC. Currently the
GCC/GNU as convention is to use R_386_PC32 for non-PIC PLT and
R_386_PLT32 for PIC PLT. Copy relocations/canonical PLT entries are
possible ABI issues but GCC/GNU as will likely keep the status quo
because (1) the ABI is legacy (2) the change will drop a GNU ld
diagnostic for non-default visibility ifunc in shared objects.
https://sourceware.org/bugzilla/show_bug.cgi?id=27169

clang-12 -fno-pic (since
https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6)
can emit R_386_PLT32 for compiler generated function declarations,
because preventing canonical PLT entries is weighed over the rare ifunc
diagnostic.

Link: https://github.com/ClangBuiltLinux/linux/issues/1210
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Fangrui Song <maskray@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

---
Change in v2:
* Improve commit message
---
Change in v3:
* Change the GCC link to the more relevant GNU as link.
* Fix the relevant llvm-project commit.
---
Change in v4:
* Improve comments and commit message
---
 arch/x86/kernel/module.c |  1 +
 arch/x86/tools/relocs.c  | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 34b153cbd4ac..5e9a34b5bd74 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -114,6 +114,7 @@ int apply_relocate(Elf32_Shdr *sechdrs,
 			*location += sym->st_value;
 			break;
 		case R_386_PC32:
+		case R_386_PLT32:
 			/* Add the value, subtract its position */
 			*location += sym->st_value - (uint32_t)location;
 			break;
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index ce7188cbdae5..1c3a1962cade 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -867,9 +867,11 @@ static int do_reloc32(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
 	case R_386_PC32:
 	case R_386_PC16:
 	case R_386_PC8:
+	case R_386_PLT32:
 		/*
-		 * NONE can be ignored and PC relative relocations don't
-		 * need to be adjusted.
+		 * NONE can be ignored and PC relative relocations don't need
+		 * to be adjusted. Because sym must be defined, R_386_PLT32 can
+		 * be treated the same way as R_386_PC32.
 		 */
 		break;
 
@@ -910,9 +912,11 @@ static int do_reloc_real(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
 	case R_386_PC32:
 	case R_386_PC16:
 	case R_386_PC8:
+	case R_386_PLT32:
 		/*
-		 * NONE can be ignored and PC relative relocations don't
-		 * need to be adjusted.
+		 * NONE can be ignored and PC relative relocations don't need
+		 * to be adjusted. Because sym must be defined, R_386_PLT32 can
+		 * be treated the same way as R_386_PC32.
 		 */
 		break;
 
-- 
2.30.0.280.ga3ce27912f-goog

