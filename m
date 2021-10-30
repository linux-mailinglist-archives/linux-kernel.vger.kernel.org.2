Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8732C440B45
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 20:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhJ3Sek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 14:34:40 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:53483 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229788AbhJ3Seg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 14:34:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UuHo6Jk_1635618721;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UuHo6Jk_1635618721)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 31 Oct 2021 02:32:03 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        james.morse@arm.com, ardb@kernel.org, tabba@google.com,
        akpm@linux-foundation.org, rppt@kernel.org,
        anshuman.khandual@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fix bug when calling kexec_load()
Date:   Sun, 31 Oct 2021 02:31:58 +0800
Message-Id: <20211030183200.51295-1-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1/2 mainly to fix the bug when calling kexec_load().
And a user case shown in commit log.

Patch 2/2 just make a very simple optimization, reducing
calls to page_address() in kexec_page_alloc().

Thanks!

Rongwei Wang (2):
  arm64: trans_pgd: fix incorrect use of pmd_populate_kernel in
    copy_pte()
  arm64: kexec: reduce calls to page_address()

 arch/arm64/kernel/machine_kexec.c | 6 ++++--
 arch/arm64/mm/trans_pgd.c         | 7 ++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.27.0

