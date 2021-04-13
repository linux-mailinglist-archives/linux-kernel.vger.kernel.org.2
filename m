Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F9335E7B5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348262AbhDMUpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhDMUpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:45:39 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0333FC061574;
        Tue, 13 Apr 2021 13:45:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w4so13994036wrt.5;
        Tue, 13 Apr 2021 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ofPn2mdRtTE7ElcZXwF2kZ46phxxe+jY7bsznPkzuoU=;
        b=PWVGfHrR1yygXP+Q89qMNfKtVP6CQBelVvBwcBljVcvcDdEnZnSUNdxb4n4WiQmu4V
         aI7BOfA4PVpC170M+wD4NSvFzsKmgYUzylcePTJJX9YdpoNFtm0hZ4azShlLquSakpnt
         MJRC9lPlOqQIhuXDaIDd0nj8hzY05EC8nIh2mELhdDHU37E2c5QOF3uZaKRUqfmciRtj
         e75PbhBbgNmEDz1zCDHrYzP/Qy3sAJITMYjZRmWvIocJITW6oKqkYBMDFomN3uu1WCqF
         24rfbwctICenr1AEqjm8sdtvafsqc64dfqrh/9Nd/81bPeO9ofEtw7w+9FA+6RWC8/X6
         IquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ofPn2mdRtTE7ElcZXwF2kZ46phxxe+jY7bsznPkzuoU=;
        b=AxfebU7sr2fTytZ44agBl+UFqEqBJgM8Ipxdp20emA9cPamHKmfoKiWCOeab/lseeM
         hKrCnUG2fX2MopSWLL3ZqIVV5oppXyPL+IXmE6l0RKssflr9tN/R5rqiImer45CDokwm
         0+ayR5L4G7n67lbdKrzzej+m5L9/i0bjxjzPAsXSXAI6z1sxmyChkyssmyF9eMk1Raka
         SpjlVBWuJ38+2Tab494q15afB6T9E3zVsoXG1jnioiNqYjnarlIuZ8aUNwqWC+RQcxc9
         VvboNurOohM9B/JbSuvm2S9yoM2EBGj9OIkcDSSeSESVE+SwXSpKEnAsMv6zrXX/w8Q/
         m/Eg==
X-Gm-Message-State: AOAM531qBiu+gyoCJmHl4NwK7UIRSVAwR9LayxRyxJf/pdh++vUbGqve
        9589dN4UdLWP6R/fTDwjORc=
X-Google-Smtp-Source: ABdhPJxTFoylCyBlkk0JGmB+/r8VFD/dKMAYewZuK4NuQajcEv8RDyvOKg/yqssVlRqkpntXUZN4sQ==
X-Received: by 2002:a5d:468b:: with SMTP id u11mr30802239wrq.293.1618346717781;
        Tue, 13 Apr 2021 13:45:17 -0700 (PDT)
Received: from LEGION ([39.46.65.172])
        by smtp.gmail.com with ESMTPSA id x14sm20784716wrw.13.2021.04.13.13.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 13:45:17 -0700 (PDT)
Date:   Wed, 14 Apr 2021 01:45:11 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@suse.de>,
        open list <linux-kernel@vger.kernel.org>
Cc:     musamaanjum@gmail.com, kernel-janitors@vger.kernel.org,
        dan.carpenter@oracle.com, colin.king@canonical.com
Subject: [PATCH] objtool: prevent memory leak in error paths
Message-ID: <20210413204511.GA664936@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory allocated by sym and sym->name isn't being freed if some error
occurs in elf_create_undef_symbol(). Free the sym and sym->name if error
is detected before returning NULL.

Addresses-Coverity: ("Prevent memory leak")
Fixes: 2f2f7e47f052 ("objtool: Add elf_create_undef_symbol()")
Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
Only build has been tested.

tools/objtool/elf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d08f5f3670f8..17ee265a6c6b 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -733,7 +733,7 @@ struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
 
 	sym->sym.st_name = elf_add_string(elf, NULL, sym->name);
 	if (sym->sym.st_name == -1)
-		return NULL;
+		goto err;
 
 	sym->sym.st_info = GELF_ST_INFO(STB_GLOBAL, STT_NOTYPE);
 	// st_other 0
@@ -744,19 +744,19 @@ struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
 	symtab = find_section_by_name(elf, ".symtab");
 	if (!symtab) {
 		WARN("can't find .symtab");
-		return NULL;
+		goto err;
 	}
 
 	s = elf_getscn(elf->elf, symtab->idx);
 	if (!s) {
 		WARN_ELF("elf_getscn");
-		return NULL;
+		goto err;
 	}
 
 	data = elf_newdata(s);
 	if (!data) {
 		WARN_ELF("elf_newdata");
-		return NULL;
+		goto err;
 	}
 
 	data->d_buf = &sym->sym;
@@ -773,6 +773,10 @@ struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
 	elf_add_symbol(elf, sym);
 
 	return sym;
+err:
+	free(sym->name);
+	free(sym);
+	return NULL;
 }
 
 struct section *elf_create_section(struct elf *elf, const char *name,
-- 
2.25.1

