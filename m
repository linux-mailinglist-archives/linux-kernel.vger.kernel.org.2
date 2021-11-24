Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D87345C7E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348948AbhKXOr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:47:27 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:40143 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350320AbhKXOrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:47:04 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HzkKJ6YKvz9sSs;
        Wed, 24 Nov 2021 15:43:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VGJ0UZeZW-Lk; Wed, 24 Nov 2021 15:43:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HzkKJ5rtJz9sSd;
        Wed, 24 Nov 2021 15:43:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B5C728B774;
        Wed, 24 Nov 2021 15:43:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EDSwOKENqCfz; Wed, 24 Nov 2021 15:43:48 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A09318B763;
        Wed, 24 Nov 2021 15:43:48 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1AOEhdgQ343791
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 15:43:39 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1AOEhc8I343790;
        Wed, 24 Nov 2021 15:43:38 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] recordmcount: Support empty section from recent binutils
Date:   Wed, 24 Nov 2021 15:43:30 +0100
Message-Id: <cd0f6bdfdf1ee096fb2c07e7b38940921b8e9118.1637764848.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1637765008; l=1214; s=20211009; h=from:subject:message-id; bh=LFKGdto9BxD3XwnA+xbvk1tj0uMg8K2nc3ka3MH1LxA=; b=kKPr2EvB+f933bX3j4SlmszKBVeJZcMu11wNEYVvHil18VpHl9EmoVmGM1qz6Lxcr1A0CN2smfUS ZePFQtQ0BOBdcQFnrmc6jtJKqnsLlrwvl/J+sZGw1WEolzcBETXU
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like recent binutils (2.36 and over ?) may empty some section,
leading to failure like:

	Cannot find symbol for section 11: .text.unlikely.
	kernel/kexec_file.o: failed
	make[1]: *** [scripts/Makefile.build:287: kernel/kexec_file.o] Error 1

In order to avoid that, ensure that the section has a content before
returning it's name in has_rel_mcount().

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Link: https://github.com/linuxppc/issues/issues/388
Link: https://lore.kernel.org/all/20210215162209.5e2a475b@gandalf.local.home/
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 scripts/recordmcount.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 1e9baa5c4fc6..cc6600b729ae 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -575,6 +575,8 @@ static char const *has_rel_mcount(Elf_Shdr const *const relhdr,
 				  char const *const shstrtab,
 				  char const *const fname)
 {
+	if (!shdr0->sh_size)
+		return NULL;
 	if (w(relhdr->sh_type) != SHT_REL && w(relhdr->sh_type) != SHT_RELA)
 		return NULL;
 	return __has_rel_mcount(relhdr, shdr0, shstrtab, fname);
-- 
2.33.1

