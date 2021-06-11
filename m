Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD23A3AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 06:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFKEXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 00:23:48 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:45428 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229540AbhFKEXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 00:23:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yaohuiwang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Uc0WV3Z_1623385308;
Received: from localhost(mailfrom:yaohuiwang@linux.alibaba.com fp:SMTPD_---0Uc0WV3Z_1623385308)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Jun 2021 12:21:48 +0800
From:   Yaohui Wang <yaohuiwang@linux.alibaba.com>
To:     dave.hansen@linux.intel.com
Cc:     luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm: unexpected behavior of __ioremap_caller
Date:   Fri, 11 Jun 2021 12:21:45 +0800
Message-Id: <20210611042147.80744-1-yaohuiwang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to some boundary calculation & boundary judgment issues,
__ioremap_caller may not work as expected. This may raise the risk of
misusing ioremap_xxx functions, and further, incur terrible performance
issues.

For example, suppose [phys_addr ~ phys_addr + PAGE_SIZE] is normal RAM.
Calling ioremap(phys_addr, PAGE_SIZE-1) will succeed (but it should not).
This will set the cache flag of the phys_addr's directing mapping pte to
be PCD. What's worse, iounmap won't revert this cache flag in the
directing mapping. So the pte in the directing mapping keeps polluted
until we use workarounds (calling ioremap_cache on phys_addr) to fix the
cache bit. If there is important data/code in the polluted page, which is
accessed frequently, then the performance of the machine will drop
terribly.

Here are two patches addressing this issue. The first address the boundary
calculation issue and the second one addresses the boundary judgment
issue.

Yahui Wang (2):
  mm: fix pfn calculation mistake in __ioremap_check_ram
  mm: fix boundary judgement issues

 arch/x86/mm/ioremap.c | 4 ++--
 kernel/resource.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.1

