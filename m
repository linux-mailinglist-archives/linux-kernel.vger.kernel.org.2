Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F91E40DA83
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbhIPNBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:01:39 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9886 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239741AbhIPNBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:01:38 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H9HBX3jRxz8yXQ;
        Thu, 16 Sep 2021 20:55:48 +0800 (CST)
Received: from dggema756-chm.china.huawei.com (10.1.198.198) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 21:00:15 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggema756-chm.china.huawei.com (10.1.198.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 16 Sep 2021 21:00:15 +0800
From:   Chen Huang <chenhuang5@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Chen Huang <chenhuang5@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Darius Rad <darius@bluespec.com>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] riscv: improve unaligned memory accesses
Date:   Thu, 16 Sep 2021 13:08:53 +0000
Message-ID: <20210916130855.4054926-1-chenhuang5@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema756-chm.china.huawei.com (10.1.198.198)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset improves RISCV unaligned memory accesses, selects
HAVE_EFFICIENT_UNALIGNED_ACCESS if CPU_HAS_NO_UNALIGNED not
enabled and supports DCACHE_WORD_ACCESS to improve the efficiency
of unaligned memory accesses.

If CPU don't support unaligned memory accesses for now, please
select CONFIG_CPU_HAS_NO_UNALIGNED. For I don't know which CPU
don't support unaligned memory accesses, I don't choose the
CONFIG for them.

Changes since v1:
 - As Darius Rad and Jisheng Zhang mentioned, some CPUs don't support
   unaligned memory accesses, add an option for CPUs to choose it or not.

Chen Huang (2):
  riscv: support HAVE_EFFICIENT_UNALIGNED_ACCESS
  riscv: Support DCACHE_WORD_ACCESS

 arch/riscv/Kconfig                      |  5 ++++
 arch/riscv/include/asm/word-at-a-time.h | 37 +++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

-- 
2.25.1

