Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A133AE923
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhFUMgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:36:39 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:48786 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229710AbhFUMgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:36:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yaohuiwang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UdBFKyJ_1624278859;
Received: from localhost(mailfrom:yaohuiwang@linux.alibaba.com fp:SMTPD_---0UdBFKyJ_1624278859)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Jun 2021 20:34:20 +0800
From:   Yaohui Wang <yaohuiwang@linux.alibaba.com>
To:     dave.hansen@linux.intel.com, tglx@linutronix.de
Cc:     luto@kernel.org, peterz@infradead.org, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        luoben@linux.alibaba.com, yaohuiwang@linux.alibaba.com
Subject: [PATCH v3 0/2] x86/ioremap: fix boundary calculation and boundary judgment issues for ioremap()
Date:   Mon, 21 Jun 2021 20:34:17 +0800
Message-Id: <20210621123419.2976-1-yaohuiwang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap_xxx() functions should fail if the memory address range contains
normal RAM. But due to some boundary calculation and boundary judgment
issues, the RAM check may be omitted for the very start or the very end
page in the memory range. As a consequence, ioremap_xxx() can be applied
to normal RAM pages by mistake. This raises the risk of misusing
ioremap_xxx() functions on normal RAM ranges, and may incur terrible
performance issues.

For example, suppose [phys_addr ~ phys_addr + PAGE_SIZE - 1] is a normal
RAM page. Calling ioremap(phys_addr, PAGE_SIZE-1) will succeed (but it
should not). This will set the cache flag of the phys_addr's directing
mapping pte to be PCD. What's worse, iounmap() won't revert this cache
flag in the directing mapping. So the pte in the directing mapping keeps
polluted until workarounds are applied (by invoking ioremap_cache() on
phys_addr) to fix the cache bit. If there is important data/code in the
polluted page, which is accessed frequently, then the performance of the
machine will drop terribly.

These two patches aim to address this issue. 

Yahui Wang (2):
  x86/ioremap: fix the pfn calculation mistake in __ioremap_check_ram()
  kernel/resource: fix boundary judgment issues in find_next_iomem_res()
    and __walk_iomem_res_desc()

 arch/x86/mm/ioremap.c | 16 ++++++++--------
 kernel/resource.c     |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)


base-commit: 13311e74253fe64329390df80bed3f07314ddd61
-- 
2.25.1

