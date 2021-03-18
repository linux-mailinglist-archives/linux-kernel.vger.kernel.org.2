Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81526340263
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCRJq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:46:59 -0400
Received: from m12-17.163.com ([220.181.12.17]:53651 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhCRJqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KgawQ
        vR0t/NPcYMe1qByne8sWSU1/NBPgw8Jk81KcJw=; b=pEm895Y1olyJxv+NCHBAl
        ocDATiuTYfkST9hwmgzq5evra03XA3oCBT1N18VVdG9e4z6VMdJik0jEIbM6+HK+
        aabiUUcw46rnQmY0jLNAynLB5bW64plXIhIuLg/Bq0R8K9/6FRx8OaZei6MHJrNL
        TGohwi4lco9bp8hMNWeh8U=
Received: from COOL-20200916KH.ccdomain.com (unknown [218.94.48.178])
        by smtp13 (Coremail) with SMTP id EcCowAD3BjtkIVNg_DWQqg--.30356S2;
        Thu, 18 Mar 2021 17:46:15 +0800 (CST)
From:   qiumibaozi_1@163.com
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, ganjisheng <ganjisheng@yulong.com>
Subject: [PATCH 5/5] Fix spelling of interrupts
Date:   Thu, 18 Mar 2021 17:46:10 +0800
Message-Id: <20210318094610.32-1-qiumibaozi_1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAD3BjtkIVNg_DWQqg--.30356S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr48AF13GFWDuw1fXryUAwb_yoW3Jrg_uF
        ykXrsIgw4rtF1SgF18ZF4fX3y0krW8ZFs7urnakFnrGFy2vF17Xa4DXr13Zr4xXrW5Zr90
        yrW8tw4SvFy2kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5epB3UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5tlxzxxedr6xjbr6il2tof0z/xtbCBgBZ2F3I1EV3xQAAsx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ganjisheng <ganjisheng@yulong.com>

Signed-off-by: ganjisheng <ganjisheng@yulong.com>
---
 drivers/mfd/ab8500-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index a903791..f5b0874 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -133,7 +133,7 @@
 
 /*
  * Map interrupt numbers to the LATCH and MASK register offsets, Interrupt
- * numbers are indexed into this array with (num / 8). The interupts are
+ * numbers are indexed into this array with (num / 8). The interrupts are
  * defined in linux/mfd/ab8500.h
  *
  * This is one off from the register names, i.e. AB8500_IT_MASK1_REG is at
-- 
1.9.1


