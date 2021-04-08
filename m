Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41831357EDE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhDHJOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:14:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15968 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhDHJOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:14:12 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGFrN268jzyNbT
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 17:11:48 +0800 (CST)
Received: from huawei.com (10.67.174.205) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 17:13:48 +0800
From:   Chen Jiahao <chenjiahao16@huawei.com>
To:     <Sergey.Semin@baikalelectronics.ru>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <chenjiahao16@huawei.com>
Subject: [PATCH] bus: bt1-apb: Eliminate a duplicate header file
Date:   Thu, 8 Apr 2021 17:13:54 +0800
Message-ID: <20210408091354.194168-1-chenjiahao16@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.205]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete one of two same header files <linux/clk.h> included in drivers/bus/bt1-apb.c

Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
---
 drivers/bus/bt1-apb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index b25ff941e7c7..74b1b712ef3a 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -22,7 +22,6 @@
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/time64.h>
-#include <linux/clk.h>
 #include <linux/sysfs.h>
 
 #define APB_EHB_ISR			0x00
-- 
2.17.1

