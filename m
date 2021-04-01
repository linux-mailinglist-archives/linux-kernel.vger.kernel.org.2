Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399CB351E1B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbhDASfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:35:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15523 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238783AbhDASO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:14:58 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FB4xS58h3zNrpn;
        Thu,  1 Apr 2021 22:16:44 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 22:19:17 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lee.jones@linaro.org>, <yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mfd: twl: Remove unused inline function twl4030charger_usb_en()
Date:   Thu, 1 Apr 2021 22:18:40 +0800
Message-ID: <20210401141840.25996-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no caller in tree, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/mfd/twl.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mfd/twl.h b/include/linux/mfd/twl.h
index 089e8942223a..8871cc5188a0 100644
--- a/include/linux/mfd/twl.h
+++ b/include/linux/mfd/twl.h
@@ -781,8 +781,6 @@ int twl4030_sih_setup(struct device *dev, int module, int irq_base);
 #define TWL4030_VAUX3_DEV_GRP		0x1F
 #define TWL4030_VAUX3_DEDICATED		0x22
 
-static inline int twl4030charger_usb_en(int enable) { return 0; }
-
 /*----------------------------------------------------------------------*/
 
 /* Linux-specific regulator identifiers ... for now, we only support
-- 
2.17.1

