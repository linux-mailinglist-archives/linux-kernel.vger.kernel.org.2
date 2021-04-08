Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF53B357955
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 03:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhDHBKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 21:10:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16396 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhDHBKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 21:10:40 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FG36x2tTSzkj1b;
        Thu,  8 Apr 2021 09:08:41 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 09:09:44 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <mpe@ellerman.id.au>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 1/2] powerpc: remove set but not used variable 'force_printk_to_btext'
Date:   Thu, 8 Apr 2021 09:18:00 +0800
Message-ID: <20210408011801.557004-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210408011801.557004-1-yukuai3@huawei.com>
References: <20210408011801.557004-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

arch/powerpc/kernel/btext.c:49:12: error: 'force_printk_to_btext'
defined but not used.

It is never used, and so can be removed.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 arch/powerpc/kernel/btext.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index 803c2a45b22a..359d0f4ca532 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -46,7 +46,6 @@ unsigned long disp_BAT[2] __initdata = {0, 0};
 static unsigned char vga_font[cmapsz];
 
 int boot_text_mapped __force_data = 0;
-int force_printk_to_btext = 0;
 
 extern void rmci_on(void);
 extern void rmci_off(void);
-- 
2.25.4

