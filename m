Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A0C39F0C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhFHI1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:27:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3792 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHI1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:27:46 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fzjqf0gZpzWsj1;
        Tue,  8 Jun 2021 16:21:02 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:25:52 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:25:52 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 resend 00/15] init_mm: cleanup ARCH's text/data/brk setup code
Date:   Tue, 8 Jun 2021 16:34:03 +0800
Message-ID: <20210608083418.137226-1-wangkefeng.wang@huawei.com>
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

Add setup_initial_init_mm() helper, then use it
to cleanup the text, data and brk setup code.

v3:
- resend all and fix x86 warning
- make helper declaration in mm.h, implemention in init-mm.c, suggested
  by Mike
- collect ACKs

v2:
- change argument from "char *" to "void *" setup_initial_init_mm()
  suggested by Geert Uytterhoeven
- use NULL instead of (void *)0 on h8300 and m68k

Kefeng Wang (15):
  mm: add setup_initial_init_mm() helper
  arc: convert to setup_initial_init_mm()
  arm: convert to setup_initial_init_mm()
  arm64: convert to setup_initial_init_mm()
  csky: convert to setup_initial_init_mm()
  h8300: convert to setup_initial_init_mm()
  m68k: convert to setup_initial_init_mm()
  nds32: convert to setup_initial_init_mm()
  nios2: convert to setup_initial_init_mm()
  openrisc: convert to setup_initial_init_mm()
  powerpc: convert to setup_initial_init_mm()
  riscv: convert to setup_initial_init_mm()
  s390: convert to setup_initial_init_mm()
  sh: convert to setup_initial_init_mm()
  x86: convert to setup_initial_init_mm()

 arch/arc/mm/init.c                 | 5 +----
 arch/arm/kernel/setup.c            | 5 +----
 arch/arm64/kernel/setup.c          | 5 +----
 arch/csky/kernel/setup.c           | 5 +----
 arch/h8300/kernel/setup.c          | 5 +----
 arch/m68k/kernel/setup_mm.c        | 5 +----
 arch/m68k/kernel/setup_no.c        | 5 +----
 arch/nds32/kernel/setup.c          | 5 +----
 arch/nios2/kernel/setup.c          | 5 +----
 arch/openrisc/kernel/setup.c       | 5 +----
 arch/powerpc/kernel/setup-common.c | 5 +----
 arch/riscv/kernel/setup.c          | 5 +----
 arch/s390/kernel/setup.c           | 5 +----
 arch/sh/kernel/setup.c             | 5 +----
 arch/x86/kernel/setup.c            | 5 +----
 include/linux/mm.h                 | 3 +++
 mm/init-mm.c                       | 9 +++++++++
 17 files changed, 27 insertions(+), 60 deletions(-)

-- 
2.26.2

