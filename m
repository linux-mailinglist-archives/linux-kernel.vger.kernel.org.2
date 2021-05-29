Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECA8394BB5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 12:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhE2Krm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 06:47:42 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2406 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhE2Kri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 06:47:38 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FsdRJ3vvJz66cm;
        Sat, 29 May 2021 18:42:20 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 18:46:00 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 18:46:00 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 00/15] init_mm: setup init_mm text/data/brk by new setup_initial_init_mm() helper
Date:   Sat, 29 May 2021 18:54:49 +0800
Message-ID: <20210529105504.180544-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add setup_initial_init_mm() helper and use it to cleanup the text,
data and brk setup code.

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

 arch/arc/mm/init.c                 |  5 +----
 arch/arm/kernel/setup.c            |  5 +----
 arch/arm64/kernel/setup.c          |  5 +----
 arch/csky/kernel/setup.c           |  5 +----
 arch/h8300/kernel/setup.c          |  5 +----
 arch/m68k/kernel/setup_mm.c        |  5 +----
 arch/m68k/kernel/setup_no.c        |  5 +----
 arch/nds32/kernel/setup.c          |  5 +----
 arch/nios2/kernel/setup.c          |  5 +----
 arch/openrisc/kernel/setup.c       |  5 +----
 arch/powerpc/kernel/setup-common.c |  5 +----
 arch/riscv/kernel/setup.c          |  5 +----
 arch/s390/kernel/setup.c           |  5 +----
 arch/sh/kernel/setup.c             |  5 +----
 arch/x86/kernel/setup.c            |  5 +----
 include/linux/mm_types.h           | 10 ++++++++++
 16 files changed, 25 insertions(+), 60 deletions(-)

-- 
2.26.2

