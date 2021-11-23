Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A261E45A3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhKWNdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:33:32 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15856 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbhKWNdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:33:18 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hz4kF3Bvvz91G3;
        Tue, 23 Nov 2021 21:29:41 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 21:30:07 +0800
Received: from huawei.com (10.175.113.32) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 23 Nov
 2021 21:30:06 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <sunnanyong@huawei.com>, <palmerdabbelt@google.com>,
        <wangkefeng.wang@huawei.com>, <anup@brainfault.org>,
        <alex@ghiti.fr>, <jszhang@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 0/2] riscv/mm: Enable THP migration
Date:   Tue, 23 Nov 2021 22:06:36 +0800
Message-ID: <20211123140638.3852400-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables THP migration on riscv via ARCH_ENABLE_THP_MIGRATION.
But first this adjusts PAGE_PROT_NONE to satisfy generic memory semantics
like the behavior of pmd_present() and pmd_trans_huge() when in
THP splitting or migration.

This feature can reduce the time of THP migration by not splits THP
before migration and can guarantee the pages after migration are still
contiguous.[1]

I have tested the below test case on qemu based on riscv after
enabling this feature, the throughput of THP migration gains 13x
performance improvement:
https://github.com/x-y-z/thp-migration-bench

I also have tested and passed the test cases under
tools/testing/selftests/vm.

[1]: https://lwn.net/Articles/723764/

Nanyong Sun (2):
  riscv/mm: Adjust PAGE_PROT_NONE to comply with THP semantics
  riscv/mm: Enable THP migration

 arch/riscv/Kconfig                    |  1 +
 arch/riscv/include/asm/pgtable-bits.h |  2 +-
 arch/riscv/include/asm/pgtable.h      | 16 +++++++++++-----
 3 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.25.1

