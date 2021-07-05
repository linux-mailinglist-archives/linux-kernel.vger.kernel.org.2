Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724E23BBBF7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhGELKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:10:08 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:9359 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhGELKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:10:06 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GJN8F16nMz75YK;
        Mon,  5 Jul 2021 19:03:09 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 19:07:28 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 19:07:27 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 0/3] arm64: support page mapping percpu first chunk allocator
Date:   Mon, 5 Jul 2021 19:14:50 +0800
Message-ID: <20210705111453.164230-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Percpu embedded first chunk allocator is the firstly option, but it
could fails on ARM64, eg,
  "percpu: max_distance=0x5fcfdc640000 too large for vmalloc space 0x781fefff0000"
  "percpu: max_distance=0x600000540000 too large for vmalloc space 0x7dffb7ff0000"
  "percpu: max_distance=0x5fff9adb0000 too large for vmalloc space 0x5dffb7ff0000"

then we could meet "WARNING: CPU: 15 PID: 461 at vmalloc.c:3087 pcpu_get_vm_areas+0x488/0x838",
the system can't boot successfully.

Let's implement page mapping percpu first chunk allocator as a fallback
to the embedding allocator to increase the robustness of the system.

Also fix a crash when both NEED_PER_CPU_PAGE_FIRST_CHUNK and KASAN_VMALLOC enabled.

Tested on ARM64 qemu with cmdline "percpu_alloc=page" based on next-20210630.

Kefeng Wang (3):
  vmalloc: Choose a better start address in vm_area_register_early()
  arm64: Support page mapping percpu first chunk allocator
  kasan: arm64: Fix pcpu_page_first_chunk crash with KASAN_VMALLOC

 arch/arm64/Kconfig         |  4 ++
 arch/arm64/mm/kasan_init.c | 18 +++++++++
 drivers/base/arch_numa.c   | 82 +++++++++++++++++++++++++++++++++-----
 include/linux/kasan.h      |  2 +
 mm/kasan/init.c            |  5 +++
 mm/vmalloc.c               |  9 +++--
 6 files changed, 107 insertions(+), 13 deletions(-)

-- 
2.26.2

