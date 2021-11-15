Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDEC4505B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhKONmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:42:51 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14744 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhKONkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:40:20 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ht9Cz2HdRzZd2w;
        Mon, 15 Nov 2021 21:34:55 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 21:37:16 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 21:37:15 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <glider@google.com>, <elver@google.com>, <dvyukov@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH Resend v2 0/3] ARM: Support KFENCE feature
Date:   Mon, 15 Nov 2021 21:48:45 +0800
Message-ID: <20211115134848.171098-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset supports Kfence feature, tested the kfence_test on ARM QEMU
with or without ARM_LPAE and all passed.

V2 Resend:
- adjust is_write_fault() position in patch2 not patch3, sugguested Alexander
- Add ACKed from Marco
- rebased on v5.16-rc1

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

