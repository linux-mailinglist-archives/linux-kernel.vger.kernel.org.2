Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E573D6D14
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbhG0EAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:00:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36734 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234608AbhG0EAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:00:51 -0400
X-UUID: 88bae1ba30cc48128ea925fe74fe3f76-20210727
X-UUID: 88bae1ba30cc48128ea925fe74fe3f76-20210727
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1762002640; Tue, 27 Jul 2021 12:00:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Jul 2021 12:00:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Jul 2021 12:00:43 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Nicholas Tang <nicholas.tang@mediatek.com>,
        Andrew Yang <andrew.yang@mediatek.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Subject: [PATCH 2/2] kasan, mm: reset tag for hex dump address
Date:   Tue, 27 Jul 2021 12:00:21 +0800
Message-ID: <20210727040021.21371-3-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210727040021.21371-1-Kuan-Ying.Lee@mediatek.com>
References: <20210727040021.21371-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Text is a string. We need to move this kasan_reset_tag()
to address but text.

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 mm/slub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6dad2b6fda6f..d20674f839ba 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -576,8 +576,8 @@ static void print_section(char *level, char *text, u8 *addr,
 			  unsigned int length)
 {
 	metadata_access_enable();
-	print_hex_dump(level, kasan_reset_tag(text), DUMP_PREFIX_ADDRESS,
-			16, 1, addr, length, 1);
+	print_hex_dump(level, text, DUMP_PREFIX_ADDRESS,
+			16, 1, kasan_reset_tag((void *)addr), length, 1);
 	metadata_access_disable();
 }
 
-- 
2.18.0

