Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5053FD167
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 04:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241632AbhIACik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 22:38:40 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14443 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhIACij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 22:38:39 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gzp5k3m7bzbfdy;
        Wed,  1 Sep 2021 10:33:46 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 1 Sep 2021 10:37:41 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 1 Sep 2021 10:37:41 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <abdulras@google.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v3 0/3] riscv: Fix two vdso issue
Date:   Wed, 1 Sep 2021 02:46:18 +0000
Message-ID: <20210901024621.2528797-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3->v2:
  Adapt to the latest code.

v2->v1:
  Add patch "Refactor asm/vdso.h" to avoid vdso.lds syntax error if
  CONFIG_GENERIC_TIME_VSYSCALL=n.

1) Move vdso data page up front and introduce enum vvar_pages, This makes it
easier to introduce new feature TIME_NS.

2) In arch_setup_additional_pages(), make Wait for the lock in the killable mode
and return with EINTR if the task got killed while waiting.

Tong Tiangen (3):
  riscv/vdso: Refactor asm/vdso.h
  riscv/vdso: Move vdso data page up front
  riscv/vdso: make arch_setup_additional_pages wait for mmap_sem for
    write killable

 arch/riscv/include/asm/syscall.h  |  1 +
 arch/riscv/include/asm/vdso.h     | 15 ++++-----
 arch/riscv/kernel/syscall_table.c |  1 -
 arch/riscv/kernel/vdso.c          | 53 +++++++++++++++++++------------
 arch/riscv/kernel/vdso/vdso.lds.S |  3 +-
 5 files changed, 42 insertions(+), 31 deletions(-)

-- 
2.18.0.huawei.25

