Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FECF37C09C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhELOt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:49:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230474AbhELOty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:49:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A638160D07;
        Wed, 12 May 2021 14:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620830926;
        bh=jnhc6L5aE/L2E2M7Tw9BvkqscRZ44fnqwr1IsxfoBXM=;
        h=From:To:Cc:Subject:Date:From;
        b=ozriwa6JPyCqWIimKbWAnzcrQu/4yT647E3O8yudRHnH6rJDH9P5K26Yf0l++/bbF
         PMgXlCILmRxE5Jsi7wlTpPXZeloT+ISMm8P+KOonVKRmmf7au+vcL0kBBvYpiAEIGR
         IH+8YXfhVuTi5gCVNbc+UaS2rQTZJFIc8PEQLUQekA5Rcu3wCNcTSDd8N1oHy/vpwa
         Znh/06XuWMACFCt2jM0TMEc2wFAHGutaZTl3rHYErRl+pY40Avre69RMlEAMLtVeZR
         DgPKIvLCvEi1TEuCzqRBgSH1SnQVXl5dYNH/6iqjz9zoOWcWWW/TzowQXxKAcAZO3a
         SJNgoWq/Zuqvg==
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] module: check for exit sections in layout_sections() instead of module_init_section()
Date:   Wed, 12 May 2021 16:46:53 +0200
Message-Id: <20210512144653.3726-1-jeyu@kernel.org>
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
 kernel/module.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 173a09175511..a5c9842371b1 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2430,6 +2430,9 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize != ~0UL
+#ifndef CONFIG_MODULE_UNLOAD
+			    || module_exit_section(sname)
+#endif
 			    || module_init_section(sname))
 				continue;
 			s->sh_entsize = get_offset(mod, &mod->core_layout.size, s, i);
@@ -2463,7 +2466,11 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize != ~0UL
+#ifndef CONFIG_MODULE_UNLOAD
+			    || (!module_init_section(sname) && !module_exit_section(sname)))
+#else
 			    || !module_init_section(sname))
+#endif
 				continue;
 			s->sh_entsize = (get_offset(mod, &mod->init_layout.size, s, i)
 					 | INIT_OFFSET_MASK);
@@ -2802,11 +2809,7 @@ void * __weak module_alloc(unsigned long size)
 
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

