Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6675E34B5CC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 10:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhC0JxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 05:53:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15357 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhC0Jww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 05:52:52 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6vGk5Jd3z8y9b;
        Sat, 27 Mar 2021 17:50:38 +0800 (CST)
Received: from huawei.com (10.67.174.78) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Sat, 27 Mar 2021
 17:52:30 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <chenlifu@huawei.com>, Sekhar Nori <nsekhar@ti.com>,
        Russell King <linux@armlinux.org.uk>
CC:     <heying24@huawei.com>, <yuehaibing@huawei.com>,
        <weiyongjun1@huawei.com>, <johnny.chenyi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ARM: davinci: dm646x-evm: use DEFINE_SPINLOCK() for spinlock
Date:   Sat, 27 Mar 2021 17:52:26 +0800
Message-ID: <20210327095226.105039-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.174.78]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lifu Chen <chenlifu@huawei.com>

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Lifu Chen <chenlifu@huawei.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 952ddabc743e..a07b5f83a373 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -470,7 +470,7 @@ static struct davinci_i2c_platform_data i2c_pdata = {
 #define TVP5147_CH1		"tvp514x-1"
 
 /* spin lock for updating above registers */
-static spinlock_t vpif_reg_lock;
+static DEFINE_SPINLOCK(vpif_reg_lock);
 
 static int set_vpif_clock(int mux_mode, int hd)
 {
@@ -746,8 +746,6 @@ static struct vpif_capture_config dm646x_vpif_capture_cfg = {
 
 static void __init evm_init_video(void)
 {
-	spin_lock_init(&vpif_reg_lock);
-
 	dm646x_setup_vpif(&dm646x_vpif_display_config,
 			  &dm646x_vpif_capture_cfg);
 }

