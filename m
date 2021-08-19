Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72F33F10D8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 04:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbhHSC6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 22:58:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17043 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbhHSC6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 22:58:35 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gqq9J4l2HzbfM1;
        Thu, 19 Aug 2021 10:54:12 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 10:57:44 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 10:57:44 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tong Tiangen" <tongtiangen@huawei.com>
Subject: [PATCH -next 0/2] riscv: Fix two vdso issue
Date:   Thu, 19 Aug 2021 03:06:48 +0000
Message-ID: <20210819030650.716478-1-tongtiangen@huawei.com>
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

1) Move vdso data page up front and introduce enum vvar_pages, To pave the way
for the subsequent support of TIME_NS, the support of TIME_NS will be issued
in the later patch.

2) In arch_setup_additional_pages(), make Wait for the lock in the killable mode
and return with EINTR if the task got killed while waiting.

Tong Tiangen (2):
  riscv/vdso: Move vdso data page up front
  riscv/vdso: make arch_setup_additional_pages wait for mmap_sem for
    write killable

 arch/riscv/include/asm/syscall.h  |  2 ++
 arch/riscv/include/asm/vdso.h     |  4 +--
 arch/riscv/kernel/vdso.c          | 51 ++++++++++++++++++-------------
 arch/riscv/kernel/vdso/vdso.lds.S |  3 +-
 4 files changed, 36 insertions(+), 24 deletions(-)

-- 
2.18.0.huawei.25

