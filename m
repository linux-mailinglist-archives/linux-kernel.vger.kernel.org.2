Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4673BBB4A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 12:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhGEKgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 06:36:05 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:56953 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230521AbhGEKgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:36:04 -0400
X-UUID: 4b55a2b2358d48b3bde728d1ed5ef1f3-20210705
X-UUID: 4b55a2b2358d48b3bde728d1ed5ef1f3-20210705
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1204610253; Mon, 05 Jul 2021 18:33:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 5 Jul 2021 18:33:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 5 Jul 2021 18:33:24 +0800
From:   <yee.lee@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <nicholas.Tang@mediatek.com>, <Kuan-Ying.lee@mediatek.com>,
        <chinwen.chang@mediatek.com>, Yee Lee <yee.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v6 0/2]  kasan: solve redzone overwritten issue at debug
Date:   Mon, 5 Jul 2021 18:32:25 +0800
Message-ID: <20210705103229.8505-1-yee.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yee Lee <yee.lee@mediatek.com>

Issue: In SLUB debug, hwtag kasan_unpoison() would overwrite the redzone
in those objects with unaligned size.

The first patch Introduces slub_debug_enable_unlikely() to check
the state of debug mode.

The second patch Adds memzero_explict() to separate the initialization for
such condition. The new code path is executed about 1.1% during nromal
booting process. The penalty is acceptable since it only works in debug
mode.

=============
Exp: QEMUv5.2(+mte)/SLUB_debug mode
code path exec : 941/80854 (1.1%)

Changed since v6:
 - Move helper instead of introducing a new one.

Changed since v5:
 - Fix format

Changed since v4:
 - Introduce slub_debug_enable_unlikly() to check the debug state.
 - Include "slab.h" and Add slub_debug_enable_unlikly() to lead
   the condition statement.
 - Add comment block about this new code path in source code.

Changed since v3:
 - Apply IS_ENABLED to wrap codes under SLUB debug mode.
 - Replace memset() by memzero_explict().

---

Marco Elver (1):
  mm: move helper to check slub_debug_enabled

Yee Lee (1):
  kasan: Add memzero int for unaligned size at DEBUG

 mm/kasan/kasan.h | 12 ++++++++++++
 mm/slab.h        | 15 +++++++++++----
 mm/slub.c        | 14 --------------
 3 files changed, 23 insertions(+), 18 deletions(-)

-- 
2.18.0

