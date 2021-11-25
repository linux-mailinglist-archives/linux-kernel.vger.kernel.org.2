Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229B445DF5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhKYRLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:11:17 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:51501 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232587AbhKYRJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:09:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UyHRKKp_1637859960;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UyHRKKp_1637859960)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Nov 2021 01:06:02 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        james.morse@arm.com, ardb@kernel.org, tabba@google.com,
        akpm@linux-foundation.org, rppt@kernel.org,
        anshuman.khandual@arm.com, pasha.tatashin@soleen.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] simple optimizations for page_address and
Date:   Fri, 26 Nov 2021 01:05:58 +0800
Message-Id: <20211125170600.1608-1-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211030183200.51295-1-rongwei.wang@linux.alibaba.com>
References: <20211030183200.51295-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Patch 1/2 mainly to fix the bug when calling kexec_load() originally, but
because of ignored and link[1] also fixed this bug and had been applied
to arm64 (for-next/fixes) before us. Anyway, It's nice to unify the use of
'pmd_populate_kernel' under arm64.

Patch 2/2 just make a very simple optimization, reducing
calls to page_address() in kexec_page_alloc().

v2 -> v3:
- Patch "arm64: trans_pgd: unify the use of pmd_populate_kernel"
rename this patch.

v1 -> v2:
- Patch " arm64: trans_pgd: fix incorrect use of pmd_populate_kernel in
  copy_pte()"
restore the usage of pmd_populate_kernel.

link1:
https://lore.kernel.org/linux-arm-kernel/20211111060316.12438-1-kernelfans@gmail.com/

v1:
https://lore.kernel.org/linux-arm-kernel/20211030183200.51295-1-rongwei.wang@linux.alibaba.com/
v2:
https://lore.kernel.org/linux-arm-kernel/20211114201650.5542-1-rongwei.wang@linux.alibaba.com/

Rongwei Wang (2):
  arm64: trans_pgd: unify the use of pmd_populate_kernel
  arm64: kexec: reduce calls to page_address()

 arch/arm64/kernel/machine_kexec.c | 6 ++++--
 arch/arm64/mm/trans_pgd.c         | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
1.8.3.1

