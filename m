Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D61F36F6C0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhD3H5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:57:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17826 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhD3H5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:57:21 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FWl4T1RwbzBtMY;
        Fri, 30 Apr 2021 15:54:01 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 30 Apr 2021
 15:56:21 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH -next 0/4] THP supprt for RISCV
Date:   Fri, 30 Apr 2021 16:28:46 +0800
Message-ID: <20210430082850.462609-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings transparent huge pages to RISCV on 64-bit.

I have tested these testcases of vm selftest under qemu-riscv64:
khugepaged
split_huge_page_test
transhuge-stress

Nanyong Sun (4):
  riscv: mm: add _PAGE_LEAF macro
  riscv: mm: make pmd_bad() check leaf condition
  riscv: mm: add param stride for __sbi_tlb_flush_range
  riscv: mm: add THP support on 64-bit

 arch/riscv/Kconfig                    |   1 +
 arch/riscv/include/asm/pgtable-64.h   |   3 +-
 arch/riscv/include/asm/pgtable-bits.h |   5 +
 arch/riscv/include/asm/pgtable.h      | 164 +++++++++++++++++++++++++-
 arch/riscv/mm/tlbflush.c              |  17 ++-
 5 files changed, 178 insertions(+), 12 deletions(-)

-- 
2.25.1

