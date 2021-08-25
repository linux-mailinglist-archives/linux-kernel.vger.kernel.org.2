Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514EC3F718E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbhHYJSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:18:09 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8771 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbhHYJSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:18:09 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GvgMz2S67zYrNx;
        Wed, 25 Aug 2021 17:16:47 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 17:17:20 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 17:17:20 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/4] ARM: Support KFENCE feature
Date:   Wed, 25 Aug 2021 17:21:12 +0800
Message-ID: <20210825092116.149975-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch 1~3 is to support KFENCE feature on ARM. 

NOTE: 
The context of patch2/3 changes in arch/arm/mm/fault.c is based on link[1],
which make some refactor and cleanup about page fault.

kfence_test is not useful when kfence is not enabled, skip kfence test
when kfence not enabled in patch4.

I tested the kfence_test on ARM QEMU with or without ARM_LPAE and all passed.

[1] https://lore.kernel.org/linux-arm-kernel/20210610123556.171328-1-wangkefeng.wang@huawei.com/

Kefeng Wang (4):
  ARM: mm: Provide set_memory_valid()
  ARM: mm: Provide is_write_fault()
  ARM: Support KFENCE for ARM
  mm: kfence: Only load kfence_test when kfence is enabled

 arch/arm/Kconfig                  |  1 +
 arch/arm/include/asm/kfence.h     | 52 +++++++++++++++++++++++++++++++
 arch/arm/include/asm/set_memory.h |  5 +++
 arch/arm/mm/fault.c               | 16 ++++++++--
 arch/arm/mm/pageattr.c            | 41 ++++++++++++++++++------
 include/linux/kfence.h            |  2 ++
 mm/kfence/core.c                  |  8 +++++
 mm/kfence/kfence_test.c           |  2 ++
 8 files changed, 114 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/include/asm/kfence.h

-- 
2.26.2

