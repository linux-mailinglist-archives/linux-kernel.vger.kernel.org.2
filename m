Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B023D4066BE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 07:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhIJFb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 01:31:27 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16248 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhIJFbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 01:31:24 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H5PZV6MDcz8stp;
        Fri, 10 Sep 2021 13:29:38 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 10 Sep 2021 13:30:10 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 10 Sep 2021 13:30:09 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <ryabinin.a.a@gmail.com>, <andreyknvl@gmail.com>,
        <dvyukov@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <elver@google.com>, <akpm@linux-foundation.org>,
        <gregkh@linuxfoundation.org>
CC:     <kasan-dev@googlegroups.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4 0/3] arm64: support page mapping percpu first chunk allocator
Date:   Fri, 10 Sep 2021 13:33:51 +0800
Message-ID: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
even the system could not boot successfully.

Let's implement page mapping percpu first chunk allocator as a fallback
to the embedding allocator to increase the robustness of the system.

Also fix a crash when both NEED_PER_CPU_PAGE_FIRST_CHUNK and KASAN_VMALLOC enabled.

Tested on ARM64 qemu with cmdline "percpu_alloc=page" based on v5.14.

V4:
- add ACK/RB
- address comments about patch1 from Catalin
- add Greg and Andrew into list suggested by Catalin

v3:
- search for a range that fits instead of always picking the end from
  vmalloc area suggested by Catalin.
- use NUMA_NO_NODE to avoid "virt_to_phys used for non-linear address:"
  issue in arm64 kasan_populate_early_vm_area_shadow().
- add Acked-by: Marco Elver <elver@google.com> to patch v3

V2:
- fix build error when CONFIG_KASAN disabled, found by lkp@intel.com
- drop wrong __weak comment from kasan_populate_early_vm_area_shadow(),
  found by Marco Elver <elver@google.com>

Kefeng Wang (3):
  vmalloc: Choose a better start address in vm_area_register_early()
  arm64: Support page mapping percpu first chunk allocator
  kasan: arm64: Fix pcpu_page_first_chunk crash with KASAN_VMALLOC

 arch/arm64/Kconfig         |  4 ++
 arch/arm64/mm/kasan_init.c | 16 ++++++++
 drivers/base/arch_numa.c   | 82 +++++++++++++++++++++++++++++++++-----
 include/linux/kasan.h      |  6 +++
 mm/kasan/init.c            |  5 +++
 mm/vmalloc.c               | 19 ++++++---
 6 files changed, 116 insertions(+), 16 deletions(-)

-- 
2.26.2

