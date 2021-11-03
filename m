Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942AC444262
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 14:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhKCN3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 09:29:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15358 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhKCN3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 09:29:13 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hknbh5sNwz90mW;
        Wed,  3 Nov 2021 21:26:24 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 21:26:33 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 21:26:33 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 0/3] ARM: Support KFENCE feature
Date:   Wed, 3 Nov 2021 21:38:42 +0800
Message-ID: <20211103133845.78528-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset supports Kfence feature, tested the kfence_test on ARM QEMU
with or without ARM_LPAE and all passed.

V2:
- drop patch4 in v1, which is used a new way to skip kfence test
  see commit c40c6e593bf9 ("kfence: test: fail fast if disabled at boot")
- fix some issue about NO MMU
  - drop useless set_memory_valid() under no mmu
  - fix implicit declaration of function ‘is_write_fault’ if no mmu
- make KFENCE depends on !XIP_KERNEL, no tested with xip

v1:
https://lore.kernel.org/linux-arm-kernel/20210825092116.149975-1-wangkefeng.wang@huawei.com/

Kefeng Wang (3):
  ARM: mm: Provide set_memory_valid()
  ARM: mm: Provide is_write_fault()
  ARM: Support KFENCE for ARM

 arch/arm/Kconfig                  |  1 +
 arch/arm/include/asm/kfence.h     | 53 +++++++++++++++++++++++++++++++
 arch/arm/include/asm/set_memory.h |  1 +
 arch/arm/mm/fault.c               | 16 ++++++++--
 arch/arm/mm/pageattr.c            | 42 ++++++++++++++++++------
 5 files changed, 100 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/include/asm/kfence.h

-- 
2.26.2

