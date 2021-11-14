Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6F344FB87
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 21:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbhKNUTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 15:19:53 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:45832 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231469AbhKNUTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 15:19:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UwUJyNq_1636921010;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UwUJyNq_1636921010)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Nov 2021 04:16:51 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        james.morse@arm.com, ardb@kernel.org, tabba@google.com,
        akpm@linux-foundation.org, rppt@kernel.org,
        anshuman.khandual@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] fix bug when calling kexec_load()
Date:   Mon, 15 Nov 2021 04:16:48 +0800
Message-Id: <20211114201650.5542-1-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211030183200.51295-1-rongwei.wang@linux.alibaba.com>
References: <20211030183200.51295-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1/2 mainly to fix the bug when calling kexec_load().
And a user case shown in commit log.

Patch 2/2 just make a very simple optimization, reducing
calls to page_address() in kexec_page_alloc().

v1 -> v2
- Patch " arm64: trans_pgd: fix incorrect use of pmd_populate_kernel in
    copy_pte()"
restore the usage of pmd_populate_kernel.

v1 link:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20211030183200.51295-2-rongwei.wang@linux.alibaba.com/

Rongwei Wang (2):
  arm64: trans_pgd: fix incorrect use of pmd_populate_kernel in
    copy_pte()
  arm64: kexec: reduce calls to page_address()

 arch/arm64/kernel/machine_kexec.c | 6 ++++--
 arch/arm64/mm/trans_pgd.c         | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.27.0

