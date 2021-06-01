Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EF7396DBA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhFAHGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:06:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2924 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhFAHGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:06:13 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FvNPB0g6Tz68Xb;
        Tue,  1 Jun 2021 15:01:34 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:04:31 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:04:30 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mfd: 88pm805: Use DEFINE_RES_IRQ_NAMED() to simplify code
Date:   Tue, 1 Jun 2021 15:04:25 +0800
Message-ID: <20210601070425.10151-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mfd/88pm805.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/88pm805.c b/drivers/mfd/88pm805.c
index 39f2302e137b864..ada6c513302b7c8 100644
--- a/drivers/mfd/88pm805.c
+++ b/drivers/mfd/88pm805.c
@@ -54,27 +54,14 @@ enum {
 };
 
 static struct resource codec_resources[] = {
-	{
-	 /* Headset microphone insertion or removal */
-	 .name = "micin",
-	 .start = PM805_IRQ_MIC_DET,
-	 .end = PM805_IRQ_MIC_DET,
-	 .flags = IORESOURCE_IRQ,
-	 },
-	{
-	 /* Audio short HP1 */
-	 .name = "audio-short1",
-	 .start = PM805_IRQ_HP1_SHRT,
-	 .end = PM805_IRQ_HP1_SHRT,
-	 .flags = IORESOURCE_IRQ,
-	 },
-	{
-	 /* Audio short HP2 */
-	 .name = "audio-short2",
-	 .start = PM805_IRQ_HP2_SHRT,
-	 .end = PM805_IRQ_HP2_SHRT,
-	 .flags = IORESOURCE_IRQ,
-	 },
+	/* Headset microphone insertion or removal */
+	DEFINE_RES_IRQ_NAMED(PM805_IRQ_MIC_DET, "micin"),
+
+	/* Audio short HP1 */
+	DEFINE_RES_IRQ_NAMED(PM805_IRQ_HP1_SHRT, "audio-short1"),
+
+	/* Audio short HP2 */
+	DEFINE_RES_IRQ_NAMED(PM805_IRQ_HP2_SHRT, "audio-short2"),
 };
 
 static const struct mfd_cell codec_devs[] = {
-- 
2.26.0.106.g9fadedd


