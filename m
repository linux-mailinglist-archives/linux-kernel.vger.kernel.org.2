Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC54B3FFAA0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 08:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347275AbhICGu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 02:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347152AbhICGu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 02:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630651797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=paUDlp7iEJb3RmqcU7PhOx7PiOju1z7RQq4LXUKqpHE=;
        b=hd/kv/4uoPDVVHCk7bg1W0K4fn8kcmAEAuAwvmmo8uuLL+BQwIik3W3RLhOPvguYYkCkRM
        oyCJv9AUww4RwwHiceN3Sw3Fb3a44dkfiHFLlCU1ppvCHzUAUyTBMrmlG3ZOBbrWREiMgq
        FRm4/8Pc6kmU7eXm1XL2DBvPMCjWVBQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-YYZ08vu5O-uD4X4UzEUO2Q-1; Fri, 03 Sep 2021 02:49:55 -0400
X-MC-Unique: YYZ08vu5O-uD4X4UzEUO2Q-1
Received: by mail-qt1-f200.google.com with SMTP id b24-20020ac86798000000b0029eaa8c35d6so4564180qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 23:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=paUDlp7iEJb3RmqcU7PhOx7PiOju1z7RQq4LXUKqpHE=;
        b=Tza4+9TZlvtrueGr4AqJkJg+Pi49QdQ1hUkIN5bnvvo9j0iQgRGIyFL/PJ/5ZLxc76
         lU3awBBqvUT4WSiwuNVnOkZL2TDlKu7zTiRBgvDUk1i1HyiU3JkTAa89HvNGWfuEebT2
         nQ78BTZjZDPNleDDgWv3zRlG8sKMb0u6bUqydTf1wXCLOCYXir5h+tKRWt/Y1/WTofTw
         4XgddwvEoOMkPPo9Xv/p0QWu443KuUvzsD0zQUyXx1EgmEVHmrHcZVZRN5O4xn2nWPtl
         jscVr9AuoBbn0imDoSmduLu73iBGTMAlthDjobgKTPCUzNYryfoUwYZx9WoD+L3kMHTt
         dgJA==
X-Gm-Message-State: AOAM5327YA3EmobeZxLsB3P8OM+0SznObo0OUq3m28ePv1tNbahaaOQI
        vYJjgK8utkAOwEFIiwcG44IL5kUDWauYt39q9uXxJ+RtXcpEllzd86P/CIU2kRebWsHNCREX8Q/
        y1jzVr0Yxx1LiGrqkN32d/yb2
X-Received: by 2002:a0c:ab4e:: with SMTP id i14mr2154158qvb.28.1630651795053;
        Thu, 02 Sep 2021 23:49:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykW/paz3da/9QXzOhKwMVDERXVXg3CeWKjwGEs1zXPNM88Zu07JB2eia/5zQd1pdOOdeRrmg==
X-Received: by 2002:a0c:ab4e:: with SMTP id i14mr2154141qvb.28.1630651794814;
        Thu, 02 Sep 2021 23:49:54 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id b1sm2565223qtj.76.2021.09.02.23.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 23:49:54 -0700 (PDT)
Date:   Thu, 2 Sep 2021 23:49:51 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/4] module: Use a list of strings for ro_after_init
 sections
Message-ID: <20210903064951.to4dhiu7zua7s6dn@treble>
References: <20210901233757.2571878-1-keescook@chromium.org>
 <20210901233757.2571878-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210901233757.2571878-4-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 04:37:56PM -0700, Kees Cook wrote:
> Instead of open-coding the section names, use a list for the sections that
> need to be marked read-only after init. Unfortunately, it seems we can't
> do normal section merging with scripts/module.lds.S as ld.bfd doesn't
> correctly update symbol tables. For more details, see commit 6a3193cdd5e5
> ("kbuild: lto: Merge module sections if and only if CONFIG_LTO_CLANG
> is enabled").

I'm missing what this has to do with section merging.  Can you connect
the dots here, i.e. what sections would we want to merge and how would
that help here?

Instead of hard-coding section names in module.c, I'm wondering if we
can do something like the following to set SHF_RO_AFTER_INIT when first
creating the sections.  Completely untested...


diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 0449b125d27f..d4ff34c6199c 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -13,7 +13,7 @@
 #include <linux/types.h>
 
 #define JUMP_TABLE_ENTRY				\
-	".pushsection __jump_table,  \"aw\" \n\t"	\
+	".pushsection __jump_table, \"0x00200003\" \n\t"\
 	_ASM_ALIGN "\n\t"				\
 	".long 1b - . \n\t"				\
 	".long %l[l_yes] - . \n\t"			\
diff --git a/kernel/module.c b/kernel/module.c
index 40ec9a030eec..1dda33c9ae49 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3549,15 +3549,6 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	 * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
 	 */
 	ndx = find_sec(info, ".data..ro_after_init");
-	if (ndx)
-		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
-	/*
-	 * Mark the __jump_table section as ro_after_init as well: these data
-	 * structures are never modified, with the exception of entries that
-	 * refer to code in the __init section, which are annotated as such
-	 * at module load time.
-	 */
-	ndx = find_sec(info, "__jump_table");
 	if (ndx)
 		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e5947fbb9e7a..b25ca38179ea 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -20,6 +20,9 @@
 #include <linux/kernel.h>
 #include <linux/static_call_types.h>
 
+/* cribbed from include/uapi/linux/elf.h */
+#define SHF_RO_AFTER_INIT	0x00200000
+
 struct alternative {
 	struct list_head list;
 	struct instruction *insn;
@@ -466,7 +469,8 @@ static int create_static_call_sections(struct objtool_file *file)
 	list_for_each_entry(insn, &file->static_call_list, call_node)
 		idx++;
 
-	sec = elf_create_section(file->elf, ".static_call_sites", SHF_WRITE,
+	sec = elf_create_section(file->elf, ".static_call_sites",
+				 SHF_WRITE | SHF_RO_AFTER_INIT,
 				 sizeof(struct static_call_site), idx);
 	if (!sec)
 		return -1;

