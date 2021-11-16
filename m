Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08DF4529FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 06:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhKPFsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 00:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbhKPFsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:48:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA14C0F26E5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 19:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=a8+nzB38YXVlnd3HYFObvlW7g/vak6rnP+u7DlG8bUE=; b=PQmeD7aWOHcH5fQzYeRRCt1vE5
        dMw0dSv+m5Jw37sjyKtz1JmP2p/UeSSmwp+uI+CPjRnGRCaonQOvhB6ozA7lliQIhmporNAUQshN5
        3VKqyGP/ZzgCfr740p8vNZrttppoyGBfHMvrQeWxeMAbSZCLE0tTjq+QAUeRqImMGTLI+WVhugRt+
        Y+O6ePHOkBTRYhFZYTiv72NyA5sfyf7C8YRaRme0nFNQcg1lCgXufJP58XTsbhCpCm47P7Emzz0G7
        DW32DJUn6pXMXP0Qtyo72Eg4ddFEm4j9fPfKL+StRatSiSBuzlQoGjoIphzL/X/vsMpx32UgEXDsJ
        xKic7Fzg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmpHC-000Dh2-Qq; Tue, 16 Nov 2021 03:36:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2 v2] sh: mcount.S: fix build error when PRINTK is not enabled
Date:   Mon, 15 Nov 2021 19:36:54 -0800
Message-Id: <20211116033654.9781-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a build error in mcount.S when CONFIG_PRINTK is not enabled.
Fixes this build error:

sh2-linux-ld: arch/sh/lib/mcount.o: in function `stack_panic':
(.text+0xec): undefined reference to `dump_stack'

Fixes: e460ab27b6c3e ("sh: Fix up stack overflow check with ftrace disabled.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2: add PRINTK to STACK_DEBUG dependency (thanks, Geert)

 arch/sh/Kconfig.debug |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211115.orig/arch/sh/Kconfig.debug
+++ linux-next-20211115/arch/sh/Kconfig.debug
@@ -15,7 +15,7 @@ config SH_STANDARD_BIOS
 
 config STACK_DEBUG
 	bool "Check for stack overflows"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && PRINTK
 	help
 	  This option will cause messages to be printed if free stack space
 	  drops below a certain limit. Saying Y here will add overhead to
