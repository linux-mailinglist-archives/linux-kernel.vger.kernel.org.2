Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C413816A1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 09:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhEOHsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 03:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhEOHsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 03:48:05 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B98C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:46:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id p24so607872ejb.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4hR8Zt+w32v44Tv/NVVu8XTyWAnNOqpZLaNOlrFd5qA=;
        b=udQkMbJQCHgOUmVAtYjKlI96bnk9iMQzg3wnCpX+vjzK1UvHc71xid9AbmTBneX3iy
         yL2+nmZsUvTZq1HjbNlphwjMGyOAUW+wdEyctuy5rmD7p7SqIGUfbPEQMmb5Hx6dh1rq
         2XmCBYHUq/dSRDe1k0p2GRFn1t4q3RDf+/1LVZVsBfCv/YD8jekNo3k5yW73Qv5jtqx+
         SsvX6RevyWa1r6FLnE8MzlEoFR7nC0kAqyudMiaBZUIm98nEg52INYIy2hP8CQ0RSjen
         d3ky4R9DEYghc8FiLzwR7U4gk5azzD85QBhWe5o/QDn5j/Q8yPbhT+GwUCj2Qn85+i9c
         Olnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=4hR8Zt+w32v44Tv/NVVu8XTyWAnNOqpZLaNOlrFd5qA=;
        b=as2s94dqIWDfa64TbuRQQn61K0kv3O16qlncl3WBHKpQ3DoNffU0t7e69SvTuOxZyJ
         AzFCNgFyUHd0lmRZ5waTf5Ma+OkXZzn3pIwbEMpmEHBUlhUj6jVG3kYnSucY0T/Ny/BJ
         21UFYmkblL/swTy3I7eVF+i9qN4hbd0ZjuBMwW6sn6IGinzqxseCnnbk8a3ZnOHJCnWY
         zW/HONSdR9Y+8xspOiERvLfeVvT0z4e1PCkEvjet/M67KD+L5+Ukzad+Znl2C4UjBH2y
         YHEpqICh35CgfDOaQoTaUagho7pm16n7Bwb8tJRw1b/Kf8YT5xJ3YjAVZ46V6tF4hf3F
         Bz0Q==
X-Gm-Message-State: AOAM531Ay26auonUYomP5WXh8lu3yVlypi+2QsnJaXlTwR2Kge8yjbhy
        Lg7y/YbGhaU8dw+zvdcpfkY=
X-Google-Smtp-Source: ABdhPJw8Da+qez6zkyH7e+hABX8PfxWYTfNRSbpFN/cUTNFgwAi1aXWDgKtx33rZxl2yz13kLPEyRg==
X-Received: by 2002:a17:906:4143:: with SMTP id l3mr52867418ejk.509.1621064811505;
        Sat, 15 May 2021 00:46:51 -0700 (PDT)
Received: from gmail.com (178-164-188-54.pool.digikabel.hu. [178.164.188.54])
        by smtp.gmail.com with ESMTPSA id o20sm6023832eds.20.2021.05.15.00.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 00:46:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 15 May 2021 09:46:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool fixes
Message-ID: <20210515074645.GA145878@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest objtool/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2021-05-15

   # HEAD: f66c05d6baf36069c01a02f869bebb75586f2318 objtool/x86: Fix elf_add_alternative() endianness

Fix a couple of endianness bugs that crept in.

 Thanks,

	Ingo

------------------>
Vasily Gorbik (2):
      objtool: Fix elf_create_undef_symbol() endianness
      objtool/x86: Fix elf_add_alternative() endianness


 tools/objtool/arch/x86/decode.c | 3 ++-
 tools/objtool/elf.c             | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index cedf3ede7545..24295d39713b 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -19,6 +19,7 @@
 #include <objtool/elf.h>
 #include <objtool/arch.h>
 #include <objtool/warn.h>
+#include <objtool/endianness.h>
 #include <arch/elf.h>
 
 static int is_x86_64(const struct elf *elf)
@@ -725,7 +726,7 @@ static int elf_add_alternative(struct elf *elf,
 		return -1;
 	}
 
-	alt->cpuid = cpuid;
+	alt->cpuid = bswap_if_needed(cpuid);
 	alt->instrlen = orig_len;
 	alt->replacementlen = repl_len;
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d08f5f3670f8..743c2e9d0f56 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -762,6 +762,7 @@ struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
 	data->d_buf = &sym->sym;
 	data->d_size = sizeof(sym->sym);
 	data->d_align = 1;
+	data->d_type = ELF_T_SYM;
 
 	sym->idx = symtab->len / sizeof(sym->sym);
 
