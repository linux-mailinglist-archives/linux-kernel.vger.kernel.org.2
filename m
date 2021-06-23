Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3423B1430
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFWGyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 02:54:55 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:60154 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWGyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 02:54:54 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 06445D5D50;
        Wed, 23 Jun 2021 14:52:25 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.240.82.166])
        by smtp.263.net (postfix) whith ESMTP id P12363T139709705611008S1624431137991408_;
        Wed, 23 Jun 2021 14:52:25 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e1260b0ac2be0914014618341be74d5b>
X-RL-SENDER: wubian@uniontech.com
X-SENDER: wubian@uniontech.com
X-LOGIN-NAME: wubian@uniontech.com
X-FST-TO: gregkh@linuxfoundation.org
X-RCPT-COUNT: 3
X-SENDER-IP: 58.240.82.166
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   wubian <wubian@uniontech.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, wubian <wubian@uniontech.com>
Subject: [PATCH] uio: Fix bus error that access memory mapped by physical
Date:   Wed, 23 Jun 2021 14:52:14 +0800
Message-Id: <20210623065214.4525-1-wubian@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the arm64, register the uio driver and map a physical space
on the pci device to user space, then use memset write data to
the address space, a bus error will occur. This error is due to
the dc instruction(cache operation) used in the assembly of memset,
uio mapping physical memory will call pgprot_noncached() to set
non-cached and non-buffered, while pgprot_writecombine() has fewer
restrictions. It does not prohibit write buffer, so replacing
pgprot_noncached() with pgprot_writecombine() can solve this problem.

Signed-off-by: wubian <wubian@uniontech.com>
---
 drivers/uio/uio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index ea96e319c8a0..09b04b20fa30 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -739,7 +739,11 @@ static int uio_mmap_physical(struct vm_area_struct *vma)
 
 	vma->vm_ops = &uio_physical_vm_ops;
 	if (idev->info->mem[mi].memtype == UIO_MEM_PHYS)
+#if defined(CONFIG_ARM64)
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+#else
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+#endif
 
 	/*
 	 * We cannot use the vm_iomap_memory() helper here,
-- 
2.20.1



