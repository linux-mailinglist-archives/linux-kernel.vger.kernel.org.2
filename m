Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79C440830B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 05:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbhIMDHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 23:07:52 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:32940 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237561AbhIMDHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 23:07:46 -0400
X-UUID: 411b20b6823d4893b7019c28facb89d7-20210913
X-UUID: 411b20b6823d4893b7019c28facb89d7-20210913
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 775770715; Mon, 13 Sep 2021 11:06:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 13 Sep 2021 11:06:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Sep 2021 11:06:26 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] scripts/sorttable: riscv: fix undelcred identifier 'EM_RISCV' error
Date:   Mon, 13 Sep 2021 11:06:25 +0800
Message-ID: <20210913030625.4525-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following build break by adding a conditional definition
of EM_RISCV in order to allow cross-compilation on machines
which do not have EM_RISCV definition in their host.

build break log from [1]:
scripts/sorttable.c:352:7: error: use of undeclared identifier 'EM_RISCV'

[1] https://lore.kernel.org/lkml/e8965b25-f15b-c7b4-748c-d207dda9c8e8@i2se.com/

Cc: Jisheng Zhang <jszhang@kernel.org>
Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 54fed35fd393 ("riscv: Enable BUILDTIME_TABLE_SORT")
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 scripts/sorttable.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index f355869c65cd..6ee4fa882919 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -54,6 +54,10 @@
 #define EM_ARCV2	195
 #endif
 
+#ifndef EM_RISCV
+#define EM_RISCV	243
+#endif
+
 static uint32_t (*r)(const uint32_t *);
 static uint16_t (*r2)(const uint16_t *);
 static uint64_t (*r8)(const uint64_t *);
-- 
2.18.0

