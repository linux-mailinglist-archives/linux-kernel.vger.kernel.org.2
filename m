Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D6F3500C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 14:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhCaM57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 08:57:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15836 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbhCaM53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 08:57:29 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F9R9s10JLz9thw;
        Wed, 31 Mar 2021 20:55:13 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Wed, 31 Mar 2021
 20:57:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ruscur@russell.cc>, <oohall@gmail.com>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <sbobroff@linux.ibm.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] powerpc/eeh: Add correct inline functions
Date:   Wed, 31 Mar 2021 20:53:13 +0800
Message-ID: <20210331125313.24036-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pseries_eeh_add_device_early()/pseries_eeh_add_device_tree_early() is
never used since adding, however pseries_eeh_init_edev() and
pseries_eeh_init_edev_recursive() need their inline versions.

Fixes: b6eebb093cad ("powerpc/eeh: Make early EEH init pseries specific")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/include/asm/eeh.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index b1a5bba2e0b9..0b6c2a6711d3 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -357,8 +357,8 @@ static inline int eeh_phb_pe_create(struct pci_controller *phb) { return 0; }
 void pseries_eeh_init_edev(struct pci_dn *pdn);
 void pseries_eeh_init_edev_recursive(struct pci_dn *pdn);
 #else
-static inline void pseries_eeh_add_device_early(struct pci_dn *pdn) { }
-static inline void pseries_eeh_add_device_tree_early(struct pci_dn *pdn) { }
+static inline void pseries_eeh_init_edev(struct pci_dn *pdn) { }
+static inline void pseries_eeh_init_edev_recursive(struct pci_dn *pdn) { }
 #endif
 
 #ifdef CONFIG_PPC64
-- 
2.17.1

