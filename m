Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5985234705F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 05:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhCXEF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 00:05:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33181 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229882AbhCXEFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 00:05:35 -0400
X-UUID: eb711cfae5c642b1902f3ad106b7ca61-20210324
X-UUID: eb711cfae5c642b1902f3ad106b7ca61-20210324
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1831448406; Wed, 24 Mar 2021 12:05:28 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Mar 2021 12:05:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Mar 2021 12:05:27 +0800
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
Subject: [PATCH v4 0/5] arm64: kasan: support CONFIG_KASAN_VMALLOC
Date:   Wed, 24 Mar 2021 12:05:17 +0800
Message-ID: <20210324040522.15548-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
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

It works with Kaslr and CONFIG_RANDOMIZE_MODULE_REGION_FULL
and randomize module region inside vmalloc area.

Also work on VMAP_STACK, thanks Ard for testing it.


[1]: commit 0609ae011deb41c ("x86/kasan: support KASAN_VMALLOC")


---
Thanks Will Deacon, Ard Biesheuvel and Andrey Konovalov
for reviewing and suggestion.

v4:
	1. rebase on 5.12-rc4
	2. tweak commit message

v3:
rebase on 5.11-rc6
	1. remove always true condition in kasan_init() and remove unsed
	   vmalloc_shadow_start.
	2. select KASAN_VMALLOC if KANSAN_GENERIC is enabled
	   for VMAP_STACK.
	3. tweak commit message

v2:
	1. kasan_init.c tweak indent
	2. change Kconfig depends only on HAVE_ARCH_KASAN
	3. support randomized module region.



v3:
https://lore.kernel.org/lkml/20210206083552.24394-1-lecopzer.chen@mediatek.com/
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

