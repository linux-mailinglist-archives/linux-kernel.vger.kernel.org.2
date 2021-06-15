Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D653A8652
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhFOQZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:25:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60368 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229757AbhFOQZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:25:25 -0400
X-UUID: 4c58e13843204dc49794def372562b3f-20210616
X-UUID: 4c58e13843204dc49794def372562b3f-20210616
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1553996560; Wed, 16 Jun 2021 00:23:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 00:23:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 00:23:15 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <rostedt@goodmis.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <mhelsley@vmware.com>,
        <peterz@infradead.org>, <samitolvanen@google.com>,
        <yj.chiang@mediatek.com>
Subject: [PATCH v3] recordmcount: Correct st_shndx handling
Date:   Wed, 16 Jun 2021 00:23:13 +0800
Message-ID: <20210615162313.26081-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

One should only use st_shndx when >SHN_UNDEF and <SHN_LORESERVE. When
SHN_XINDEX, then use .symtab_shndx. Otherwise use 0.

This handles the case: st_shndx >= SHN_LORESERVE && st_shndx != SHN_XINDEX.

Reported-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
[handle endianness of sym->st_shndx]
Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 scripts/recordmcount.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index f9b19524da11..ef9c3425f86b 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -194,13 +194,18 @@ static unsigned int get_symindex(Elf_Sym const *sym, Elf32_Word const *symtab,
 	unsigned long offset;
 	int index;
 
-	if (sym->st_shndx != SHN_XINDEX)
+	if (w2(sym->st_shndx) > SHN_UNDEF &&
+	    w2(sym->st_shndx) < SHN_LORESERVE)
 		return w2(sym->st_shndx);
 
-	offset = (unsigned long)sym - (unsigned long)symtab;
-	index = offset / sizeof(*sym);
+	if (w2(sym->st_shndx) == SHN_XINDEX) {
+		offset = (unsigned long)sym - (unsigned long)symtab;
+		index = offset / sizeof(*sym);
 
-	return w(symtab_shndx[index]);
+		return w(symtab_shndx[index]);
+	}
+
+	return 0;
 }
 
 static unsigned int get_shnum(Elf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
-- 
2.18.0

