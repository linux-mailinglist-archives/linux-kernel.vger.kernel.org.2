Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34B2356CA7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352467AbhDGMvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:51:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16063 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352458AbhDGMvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:51:38 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FFkjm6dkVz16J2d;
        Wed,  7 Apr 2021 20:49:16 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 20:51:19 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <mpe@ellerman.id.au>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] powerpc: Make some symbols static
Date:   Wed, 7 Apr 2021 20:59:42 +0800
Message-ID: <20210407125942.4140430-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

arch/powerpc/kernel/btext.c:48:5: warning:
 symbol 'boot_text_mapped' was not declared. Should it be static?
arch/powerpc/kernel/btext.c:49:5: warning:
 symbol 'force_printk_to_btext' was not declared. Should it be static?

These symbols are not used outside of btext.c, so this
commit marks them static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 arch/powerpc/kernel/btext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index 803c2a45b22a..6323304d7f6e 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -45,8 +45,8 @@ unsigned long disp_BAT[2] __initdata = {0, 0};
 
 static unsigned char vga_font[cmapsz];
 
-int boot_text_mapped __force_data = 0;
-int force_printk_to_btext = 0;
+static int boot_text_mapped __force_data;
+static int force_printk_to_btext;
 
 extern void rmci_on(void);
 extern void rmci_off(void);
-- 
2.25.4

