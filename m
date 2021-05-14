Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B3A380DC7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 18:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhENQKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 12:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhENQKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 12:10:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAB6E61444;
        Fri, 14 May 2021 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621008565;
        bh=2bfduflE/KgkS+6/0pU/9rUqC6IBuf2o/UzpyigyMdw=;
        h=From:To:Cc:Subject:Date:From;
        b=EiurnMNUirvVCv4vV1pBbfMfU9YeMxguV1beHrtRrsPa2AdI2ccywWQZ/x+ABoJEU
         YDyjW4DyVzxRDkeG69kGsfmKLfAmhXukOITAn9esFLot+O50/qQIheFR3gRvmXpN/v
         GNehv0yB8vE1ElhMQ4i4PcR9+zQSlFgBwifl+Rek9CsBBmCI5fdknXTIu797bFGC5C
         8c1VdzQhzA+zs2igZ28BRpa31y0j2RRSdMbP6YqkLiLA3BKJvJp5yoZGzZ8UYPvLzn
         zWkZXMS7A1vZIGvPkxEag4/71eACBkA9hKbI/Nk0+0pFjBB1Q32Q0Hop5y39IX7MB4
         Ojo18U7ORysqw==
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v2] module: check for exit sections in layout_sections() instead of module_init_section()
Date:   Fri, 14 May 2021 18:09:04 +0200
Message-Id: <20210514160904.21989-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, when CONFIG_MODULE_UNLOAD=n, the module loader just does not
attempt to load exit sections since it never expects that any code in those
sections will ever execute. However, dynamic code patching (alternatives,
jump_label and static_call) can have sites in __exit code, even if __exit is
never executed. Therefore __exit must be present at runtime, at least for as
long as __init code is.

Commit 33121347fb1c ("module: treat exit sections the same as init
sections when !CONFIG_MODULE_UNLOAD") solves the requirements of
jump_labels and static_calls by putting the exit sections in the init
region of the module so that they are at least present at init, and
discarded afterwards. It does this by including a check for exit
sections in module_init_section(), so that it also returns true for exit
sections, and the module loader will automatically sort them in the init
region of the module.

However, the solution there was not completely arch-independent. ARM is
a special case where it supplies its own module_{init, exit}_section()
functions. Instead of pushing the exit section checks into
module_init_section(), just implement the exit section check in
layout_sections(), so that we don't have to touch arch-dependent code.

Fixes: 33121347fb1c ("module: treat exit sections the same as init sections when !CONFIG_MODULE_UNLOAD")
Signed-off-by: Jessica Yu <jeyu@kernel.org>
---

v2:
    - Use a helper function to make reading the conditionals in
      layout_sections easier (Russell King)

I named the helper 'module_init_layout_section' since we're trying to sort
sections into either the module core region or init region, which I think
is slightly more descriptive.

 kernel/module.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index faf9114a9981..1d0e59f95a9a 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2400,6 +2400,15 @@ static long get_offset(struct module *mod, unsigned int *size,
 	return ret;
 }
 
+static bool module_init_layout_section(const char *sname)
+{
+#ifndef CONFIG_MODULE_UNLOAD
+	if (module_exit_section(sname))
+		return true;
+#endif
+	return module_init_section(sname);
+}
+
 /*
  * Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
  * might -- code, read-only data, read-write data, small data.  Tally
@@ -2434,7 +2443,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize != ~0UL
-			    || module_init_section(sname))
+			    || module_init_layout_section(sname))
 				continue;
 			s->sh_entsize = get_offset(mod, &mod->core_layout.size, s, i);
 			pr_debug("\t%s\n", sname);
@@ -2467,7 +2476,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize != ~0UL
-			    || !module_init_section(sname))
+			    || !module_init_layout_section(sname))
 				continue;
 			s->sh_entsize = (get_offset(mod, &mod->init_layout.size, s, i)
 					 | INIT_OFFSET_MASK);
@@ -2806,11 +2815,7 @@ void * __weak module_alloc(unsigned long size)
 
 bool __weak module_init_section(const char *name)
 {
-#ifndef CONFIG_MODULE_UNLOAD
-	return strstarts(name, ".init") || module_exit_section(name);
-#else
 	return strstarts(name, ".init");
-#endif
 }
 
 bool __weak module_exit_section(const char *name)
-- 
2.31.1

