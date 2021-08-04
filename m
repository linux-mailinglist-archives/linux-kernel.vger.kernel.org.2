Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10143DFDB8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 11:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbhHDJKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 05:10:35 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:39770 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236991AbhHDJKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 05:10:33 -0400
X-UUID: 37b1258cb2234a309df1b9ba8a8e64aa-20210804
X-UUID: 37b1258cb2234a309df1b9ba8a8e64aa-20210804
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 21374007; Wed, 04 Aug 2021 17:10:17 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 4 Aug 2021 17:10:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 4 Aug 2021 17:10:15 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Nicholas Tang <nicholas.tang@mediatek.com>,
        Andrew Yang <andrew.yang@mediatek.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Subject: [PATCH v3 0/2] kasan: reset tag when accessing invalid metadata
Date:   Wed, 4 Aug 2021 17:09:55 +0800
Message-ID: <20210804090957.12393-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With hardware tag-based kasan enabled, we reset the tag
when we access metadata to avoid from false alarm.

Changes since v3:
 - Remove inappropriate suggested-by

Changes since v2:
 - Refine the commit message in detail.
 - Thanks Andrey's explanation about false alarm
   of kmemleak.

Kuan-Ying Lee (2):
  kasan, kmemleak: reset tags when scanning block
  kasan, slub: reset tag when printing address

 mm/kmemleak.c | 6 +++---
 mm/slub.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.18.0

