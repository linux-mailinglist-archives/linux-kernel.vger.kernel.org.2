Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E69311C36
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 09:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhBFIg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 03:36:57 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49208 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229548AbhBFIgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 03:36:51 -0500
X-UUID: 53bfa8a91c8d442fb25bd5cdc930985c-20210206
X-UUID: 53bfa8a91c8d442fb25bd5cdc930985c-20210206
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1992209691; Sat, 06 Feb 2021 16:36:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 6 Feb 2021 16:36:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 6 Feb 2021 16:36:04 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kasan-dev@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>
CC:     <dan.j.williams@intel.com>, <aryabinin@virtuozzo.com>,
        <glider@google.com>, <dvyukov@google.com>,
        <akpm@linux-foundation.org>, <linux-mediatek@lists.infradead.org>,
        <yj.chiang@mediatek.com>, <catalin.marinas@arm.com>,
        <ardb@kernel.org>, <andreyknvl@google.com>, <broonie@kernel.org>,
        <linux@roeck-us.net>, <rppt@kernel.org>,
        <tyhicks@linux.microsoft.com>, <robin.murphy@arm.com>,
        <vincenzo.frascino@arm.com>, <gustavoars@kernel.org>,
        <lecopzer@gmail.com>, Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH v3 0/5] arm64: kasan: support CONFIG_KASAN_VMALLOC
Date:   Sat, 6 Feb 2021 16:35:47 +0800
Message-ID: <20210206083552.24394-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 48ED01F9EB92388DB50C25F6565B6744F8836A662E8B2C774BE4F94EFBD8AA522000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linux supports KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
("kasan: support backing vmalloc space with real shadow memory")

Acroding to how x86 ported it [1], they early allocated p4d and pgd,
but in arm64 I just simulate how KAsan supports MODULES_VADDR in arm64
by not to populate the vmalloc area except for kimg address.

  -----------  vmalloc_shadow_start
 |           |
 |           | 
 |           | <= non-mapping
 |           |
 |           |
 |-----------|
 |///////////|<- kimage shadow with page table mapping.
 |-----------|
 |           |
 |           | <= non-mapping
 |           |
 ------------- vmalloc_shadow_end
 |00000000000|
 |00000000000| <= Zero shadow
 |00000000000|
 ------------- KASAN_SHADOW_END


Test environment:
    4G and 8G Qemu virt, 
    39-bit VA + 4k PAGE_SIZE with 3-level page table,
    test by lib/test_kasan.ko and lib/test_kasan_module.ko

It works in Kaslr with CONFIG_RANDOMIZE_MODULE_REGION_FULL
and randomize module region inside vmalloc area.

Also work with VMAP_STACK, thanks Ard for testing it.


[1]: commit 0609ae011deb41c ("x86/kasan: support KASAN_VMALLOC")


Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Acked-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Ard Biesheuvel <ardb@kernel.org>

---
Thanks Will Deacon, Ard Biesheuvel and Andrey Konovalov
for reviewing and suggestion.

v3 -> v2
rebase on 5.11-rc6
	1. remove always true condition in kasan_init() and remove unsed
	   vmalloc_shadow_start.
	2. select KASAN_VMALLOC if KANSAN_GENERIC is enabled
	   for VMAP_STACK.
	3. tweak commit message

v2 -> v1
	1. kasan_init.c tweak indent
	2. change Kconfig depends only on HAVE_ARCH_KASAN
	3. support randomized module region.


v2:
https://lkml.org/lkml/2021/1/9/49
v1:
https://lore.kernel.org/lkml/20210103171137.153834-1-lecopzer@gmail.com/
---
Lecopzer Chen (5):
  arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
  arm64: kasan: abstract _text and _end to KERNEL_START/END
  arm64: Kconfig: support CONFIG_KASAN_VMALLOC
  arm64: kaslr: support randomized module area with KASAN_VMALLOC
  arm64: Kconfig: select KASAN_VMALLOC if KANSAN_GENERIC is enabled

 arch/arm64/Kconfig         |  2 ++
 arch/arm64/kernel/kaslr.c  | 18 ++++++++++--------
 arch/arm64/kernel/module.c | 16 +++++++++-------
 arch/arm64/mm/kasan_init.c | 24 ++++++++++++++++--------
 4 files changed, 37 insertions(+), 23 deletions(-)

-- 
2.25.1

