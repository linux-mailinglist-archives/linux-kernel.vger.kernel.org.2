Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E01D347A39
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbhCXOIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:08:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14575 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbhCXOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:07:36 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F594C2mlrz19HW9;
        Wed, 24 Mar 2021 22:05:31 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 24 Mar 2021
 22:07:21 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ruscur@russell.cc>, <oohall@gmail.com>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] powerpc/eeh: Remove unused inline function eeh_dev_phb_init_dynamic()
Date:   Wed, 24 Mar 2021 22:07:14 +0800
Message-ID: <20210324140714.19612-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 475028efc708 ("powerpc/eeh: Remove eeh_dev_phb_init_dynamic()")
left behind this, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/include/asm/eeh.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index b1a5bba2e0b9..ee0e7b8eac60 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -333,8 +333,6 @@ static inline bool eeh_enabled(void)
 
 static inline void eeh_show_enabled(void) { }
 
-static inline void eeh_dev_phb_init_dynamic(struct pci_controller *phb) { }
-
 static inline int eeh_check_failure(const volatile void __iomem *token)
 {
 	return 0;
-- 
2.17.1

