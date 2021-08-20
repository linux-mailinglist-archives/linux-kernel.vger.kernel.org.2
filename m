Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287833F2C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbhHTMmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:42:24 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14390 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbhHTMmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:42:22 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Grh4J0t60zdc7C;
        Fri, 20 Aug 2021 20:37:52 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 20 Aug 2021 20:41:38 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 20 Aug 2021 20:41:37 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tong Tiangen" <tongtiangen@huawei.com>
Subject: [PATCH -next v2 0/3] riscv: Fix two vdso issue
Date:   Fri, 20 Aug 2021 12:50:39 +0000
Message-ID: <20210820125042.1844629-1-tongtiangen@huawei.com>
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

v2->v1:
 Add patch "Refactor asm/vdso.h" to avoid vdso.lds syntax error if
 CONFIG_GENERIC_TIME_VSYSCALL=n.

1) Refactor the asm/vdso.h to avoid vdso.lds syntax error.

2) Move vdso data page up front and introduce enum vvar_pages, To pave the
way for the subsequent support of TIME_NS, the support of TIME_NS will be
issued in the later patch.

3) In arch_setup_additional_pages(), make Wait for the lock in the
killable mode and return with EINTR if the task got killed while waiting.

Tong Tiangen (3):
  riscv/vdso: Refactor asm/vdso.h
  riscv/vdso: Move vdso data page up front
  riscv/vdso: make arch_setup_additional_pages wait for mmap_sem for
    write killable

 arch/riscv/include/asm/syscall.h  |  1 +
 arch/riscv/include/asm/vdso.h     | 10 ++----
 arch/riscv/kernel/syscall_table.c |  1 -
 arch/riscv/kernel/vdso.c          | 53 +++++++++++++++++++------------
 arch/riscv/kernel/vdso/vdso.lds.S |  3 +-
 5 files changed, 39 insertions(+), 29 deletions(-)

-- 
2.18.0.huawei.25

