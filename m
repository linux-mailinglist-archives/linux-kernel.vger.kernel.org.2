Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68EB39D305
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 04:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhFGCk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 22:40:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41067 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230145AbhFGCk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 22:40:58 -0400
X-UUID: 8faeb201501c425bb379ce289d69de36-20210607
X-UUID: 8faeb201501c425bb379ce289d69de36-20210607
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1632690706; Mon, 07 Jun 2021 10:38:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Jun 2021 10:38:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Jun 2021 10:38:48 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <rostedt@goodmis.org>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        Matt Helsley <mhelsley@vmware.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <yj.chiang@mediatek.com>
Subject: [PATCH] recordmcount: avoid using ABS symbol as reference
Date:   Mon, 7 Jun 2021 10:38:39 +0800
Message-ID: <20210607023839.26387-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid using ABS symbol, which won't be relocate, as reference.

On arm64 platform, if there's shndx equals SHN_ABS(0xfff1).

Section Headers:
[Nr]    Name                         Type      Address          Off      Size   ES  Flg Lk     Inf    Al
[65521] .text.n_tty_receive_buf      PROGBITS  0000000000000000 3cdab520 000054 00  AX  0      0      4
[65522] .rela.text.n_tty_receive_buf RELA      0000000000000000 3cdab578 000030 18  I   152076 65521  8

find_secsym_ndx, which use r_info in rela section to find the reference
symbol, may take ABS symbol as base.

Symbol table '.symtab' contains 453285 entries:
   Num:    Value          Size Type    Bind   Vis       Ndx Name
     6: 0000000000000002     0 NOTYPE  LOCAL  DEFAULT   ABS section_count

Which cause an invalid address in __mcount_loc.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 scripts/recordmcount.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index f9b19524da11..9b69167fb7ff 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -526,6 +526,10 @@ static int find_secsym_ndx(unsigned const txtndx,
 	for (symp = sym0, t = nsym; t; --t, ++symp) {
 		unsigned int const st_bind = ELF_ST_BIND(symp->st_info);
 
+		/* avoid absolute symbols */
+		if (symp->st_shndx == SHN_ABS)
+			continue;
+
 		if (txtndx == get_symindex(symp, symtab, symtab_shndx)
 			/* avoid STB_WEAK */
 		    && (STB_LOCAL == st_bind || STB_GLOBAL == st_bind)) {
-- 
2.18.0

