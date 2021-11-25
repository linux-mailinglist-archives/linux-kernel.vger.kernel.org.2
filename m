Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B410745DF5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbhKYRLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:11:32 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:53708 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237777AbhKYRJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:09:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UyHRKKp_1637859960;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UyHRKKp_1637859960)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Nov 2021 01:06:05 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        james.morse@arm.com, ardb@kernel.org, tabba@google.com,
        akpm@linux-foundation.org, rppt@kernel.org,
        anshuman.khandual@arm.com, pasha.tatashin@soleen.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: kexec: reduce calls to page_address()
Date:   Fri, 26 Nov 2021 01:06:00 +0800
Message-Id: <20211125170600.1608-3-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211125170600.1608-1-rongwei.wang@linux.alibaba.com>
References: <20211030183200.51295-1-rongwei.wang@linux.alibaba.com>
 <20211125170600.1608-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kexec_page_alloc(), page_address() is called twice.
This patch add a new variable to help to reduce calls
to page_address().

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 arch/arm64/kernel/machine_kexec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 1038494..7f2530b 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -104,13 +104,15 @@ static void *kexec_page_alloc(void *arg)
 {
 	struct kimage *kimage = (struct kimage *)arg;
 	struct page *page = kimage_alloc_control_pages(kimage, 0);
+	void *vaddr = NULL;
 
 	if (!page)
 		return NULL;
 
-	memset(page_address(page), 0, PAGE_SIZE);
+	vaddr = page_address(page);
+	memset(vaddr, 0, PAGE_SIZE);
 
-	return page_address(page);
+	return vaddr;
 }
 
 int machine_kexec_post_load(struct kimage *kimage)
-- 
1.8.3.1

