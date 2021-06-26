Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3913B4DE8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 12:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFZKMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 06:12:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34827 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229518AbhFZKMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 06:12:01 -0400
X-UUID: 6ddb299865154c4a94ca2d424c352079-20210626
X-UUID: 6ddb299865154c4a94ca2d424c352079-20210626
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 609472269; Sat, 26 Jun 2021 18:09:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 26 Jun 2021 18:09:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 26 Jun 2021 18:09:33 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <kasan-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        <chinwen.chang@mediatek.com>, <nicholas.tang@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Subject: [PATCH v4 0/3] kasan: add memory corruption identification support for hw tag-based kasan
Date:   Sat, 26 Jun 2021 18:09:28 +0800
Message-ID: <20210626100931.22794-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add memory corruption identification for hardware tag-based KASAN mode.

Changes since v4:
 - Change report_tags.h to report_tags.c
 - Refine the commit message
 - Test lib/test_kasan module with SW_TAGS mode
 - Test lib/test_kasan module with HW_TAGS mode
 - Rebase to latest linux-next

Changes since v3:
 - Preserve Copyright from hw_tags.c/sw_tags.c and
   report_sw_tags.c/report_hw_tags.c
 - Make non-trivial change in kasan sw tag-based mode

Changes since v2:
 - Thanks for Marco's Suggestion
 - Rename the CONFIG_KASAN_SW_TAGS_IDENTIFY
 - Integrate tag-based kasan common part
 - Rebase to latest linux-next

Kuan-Ying Lee (3):
  kasan: rename CONFIG_KASAN_SW_TAGS_IDENTIFY to
    CONFIG_KASAN_TAGS_IDENTIFY
  kasan: integrate the common part of two KASAN tag-based modes
  kasan: add memory corruption identification support for hardware
    tag-based mode

 lib/Kconfig.kasan         |  4 +--
 mm/kasan/Makefile         |  4 +--
 mm/kasan/hw_tags.c        | 22 ---------------
 mm/kasan/kasan.h          |  4 +--
 mm/kasan/report_hw_tags.c |  5 ----
 mm/kasan/report_sw_tags.c | 43 ----------------------------
 mm/kasan/report_tags.c    | 51 +++++++++++++++++++++++++++++++++
 mm/kasan/sw_tags.c        | 41 ---------------------------
 mm/kasan/tags.c           | 59 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 116 insertions(+), 117 deletions(-)
 create mode 100644 mm/kasan/report_tags.c
 create mode 100644 mm/kasan/tags.c

-- 
2.18.0

