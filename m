Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA51B4193F0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhI0MRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234284AbhI0MRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:17:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC99F61002;
        Mon, 27 Sep 2021 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632744946;
        bh=I2kLfjcYEq3Pn4ErFSyTzDxe3WqNuLFDliR3QOYIh48=;
        h=From:To:Cc:Subject:Date:From;
        b=fIIKqxL9qw6wTOMU611lb1v/toPd+VhxDI/BgUfGmR1T2ir6HsQfn41QNIPpCD7qr
         vZYaDMslpVZ/tvuoXJ+YMphKNyDe01JNssCwQ/RHBTlu2oVTi40Est+zgBNnfGu5eC
         k0GOvaTQqVNDaHdyGgnVQ+alHPJwmj2mnMXuF2E4pTPd4vShvVeWqQ+xaGzeuzo3nJ
         LO31rVjjKFpXBSCooPD1zIXue1RwsLyIfAVXBTnChTnMCSNkRY+Y1yb6KXZO2nGqjN
         WmWkEUf6CzGOzV1V/US9MxWBzCXZPdUmHiLkH07OALSGDO2nkY1J/3B5AJVUb9rDgu
         1S6jlxVMb/J1Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] module: fix clang CFI with MODULE_UNLOAD=n
Date:   Mon, 27 Sep 2021 14:15:10 +0200
Message-Id: <20210927121541.939745-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_MODULE_UNLOAD is disabled, the module->exit member
is not defined, causing a build failure:

kernel/module.c:4493:8: error: no member named 'exit' in 'struct module'
                mod->exit = *exit;

add an #ifdef block around this.

Fixes: cf68fffb66d6 ("add support for Clang CFI")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/module.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 40ec9a030eec..5c26a76e800b 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4489,8 +4489,10 @@ static void cfi_init(struct module *mod)
 	/* Fix init/exit functions to point to the CFI jump table */
 	if (init)
 		mod->init = *init;
+#ifdef CONFIG_MODULE_UNLOAD
 	if (exit)
 		mod->exit = *exit;
+#endif
 
 	cfi_module_add(mod, module_addr_min);
 #endif
-- 
2.29.2

