Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF6934705E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 05:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhCXEFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 00:05:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56205 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229629AbhCXEFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 00:05:35 -0400
X-UUID: e8b19a2958fb4ac385dd2697d19b3266-20210324
X-UUID: e8b19a2958fb4ac385dd2697d19b3266-20210324
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 834884717; Wed, 24 Mar 2021 12:05:32 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Mar 2021 12:05:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Mar 2021 12:05:31 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <ryabinin.a.a@gmail.com>, <glider@google.com>,
        <andreyknvl@gmail.com>, <dvyukov@google.com>,
        <akpm@linux-foundation.org>, <tyhicks@linux.microsoft.com>,
        <maz@kernel.org>, <rppt@kernel.org>, <linux@roeck-us.net>,
        <gustavoars@kernel.org>, <yj.chiang@mediatek.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH v4 3/5] arm64: Kconfig: support CONFIG_KASAN_VMALLOC
Date:   Wed, 24 Mar 2021 12:05:20 +0800
Message-ID: <20210324040522.15548-4-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210324040522.15548-1-lecopzer.chen@mediatek.com>
References: <20210324040522.15548-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can backed shadow memory in vmalloc area after vmalloc area
isn't populated at kasan_init(), thus make KASAN_VMALLOC selectable.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Acked-by: Andrey Konovalov <andreyknvl@gmail.com>
Tested-by: Andrey Konovalov <andreyknvl@gmail.com>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5656e7aacd69..3e54fa938234 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -138,6 +138,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
+	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
 	select HAVE_ARCH_KFENCE
-- 
2.25.1

