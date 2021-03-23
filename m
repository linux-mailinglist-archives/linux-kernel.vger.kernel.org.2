Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674BB34617E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhCWObZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232186AbhCWObM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:31:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D98026191F;
        Tue, 23 Mar 2021 14:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616509871;
        bh=D6pTLSJCRpfh2oXokGcyBU20V0xCNExvFA1A+tFPPuE=;
        h=From:To:Cc:Subject:Date:From;
        b=eIO7RJw8c8tfFbHT9KHjShbcnOxPcjAURhHBpr9GhD/BN6Jdyg+4HY7krtO/GxRxD
         CiVDQIoc7GESO2nU9tBEvgz6c6feSYlgv6wBl+qDWHL5upVUDCHvSzLmDBGYzG/3wK
         ke1xOyaCDFRIMXTIsJLd/JNQnKS8xiQqnRxgewYjrKV85+19J0JEPvuLnt2m2DmCts
         lOjmNvlVB9Gq4f7vZqoywVkHVoKf7mTfxngsXu0+OSrsc2JvEk1xZnMf8ILXrZWixK
         OVH7DTpcJuGYfpMZXBx98+89DKjTGuRmav23JfkgQnQ978DVatxbG2U45kWQ11XhD6
         8RVqrBkCMSqWA==
From:   Jessica Yu <jeyu@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, rostedt@goodmis.org, jpoimboe@redhat.com,
        jbaron@akamai.com, ardb@kernel.org, sumit.garg@linaro.org,
        oliver.sang@intel.com, jarkko@kernel.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] module: treat exit sections the same as init sections when !CONFIG_MODULE_UNLOAD
Date:   Tue, 23 Mar 2021 15:27:56 +0100
Message-Id: <20210323142756.11443-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic code patching (alternatives, jump_label and static_call) can
have sites in __exit code, even if __exit is never executed. Therefore
__exit must be present at runtime, at least for as long as __init code
is.

Additionally, for jump_label and static_call, the __exit sites must also
identify as within_module_init(), such that the infrastructure is aware
to never touch them after module init -- alternatives are only ran once
at init and hence don't have this particular constraint.

By making __exit identify as __init for !MODULE_UNLOAD, the above is
satisfied.

So the section ordering should look like the following when
!CONFIG_MODULE_UNLOAD, with the .exit sections moved to the init region of
the module.

Core section allocation order:
 	.text
 	.rodata
 	__ksymtab_gpl
 	__ksymtab_strings
 	.note.* sections
 	.bss
 	.data
 	.gnu.linkonce.this_module
 Init section allocation order:
 	.init.text
 	.exit.text
 	.symtab
 	.strtab

[jeyu: thanks to Peter Zijlstra for most of the changelog]

Link: https://lore.kernel.org/lkml/YFiuphGw0RKehWsQ@gunter/
Signed-off-by: Jessica Yu <jeyu@kernel.org>
---

Do you want to take this patch with the other static_call patches? Or
should I take this through modules-next?

 kernel/module.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 30479355ab85..173a09175511 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2802,7 +2802,11 @@ void * __weak module_alloc(unsigned long size)
 
 bool __weak module_init_section(const char *name)
 {
+#ifndef CONFIG_MODULE_UNLOAD
+	return strstarts(name, ".init") || module_exit_section(name);
+#else
 	return strstarts(name, ".init");
+#endif
 }
 
 bool __weak module_exit_section(const char *name)
@@ -3116,11 +3120,6 @@ static int rewrite_section_headers(struct load_info *info, int flags)
 		 */
 		shdr->sh_addr = (size_t)info->hdr + shdr->sh_offset;
 
-#ifndef CONFIG_MODULE_UNLOAD
-		/* Don't load .exit sections */
-		if (module_exit_section(info->secstrings+shdr->sh_name))
-			shdr->sh_flags &= ~(unsigned long)SHF_ALLOC;
-#endif
 	}
 
 	/* Track but don't keep modinfo and version sections. */
-- 
2.30.1

