Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E389380443
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhENHaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:30:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3757 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhENHaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:30:12 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FhKn53sjFzqTtC;
        Fri, 14 May 2021 15:25:29 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 14 May 2021 15:28:53 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 14 May
 2021 15:28:53 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <abbotti@mev.co.uk>, <hsweeten@visionengravers.com>,
        <gregkh@linuxfoundation.org>, <grandmaster@al2klimov.de>
Subject: [PATCH -next v2] =?UTF-8?q?staging:=20comedi:=20Remove=20unused=20variable?= =?UTF-8?q?=20=E2=80=98min=5Ffull=5Fscale=E2=80=99=20and=20function=20'get?= =?UTF-8?q?=5Fmin=5Ffull=5Fscales'?=
Date:   Fri, 14 May 2021 16:52:14 +0800
Message-ID: <20210514085214.53941-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable ‘min_full_scale’ and function 'get_min_full_scales' are
not used, So delete them.

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
Changes from v2:
* Delete function 'get_min_full_scales'

 drivers/comedi/drivers/jr3_pci.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
index 7a02c4fa3cda..f963080dd61f 100644
--- a/drivers/comedi/drivers/jr3_pci.c
+++ b/drivers/comedi/drivers/jr3_pci.c
@@ -186,19 +186,6 @@ static void set_full_scales(struct jr3_sensor __iomem *sensor,
 	set_s16(&sensor->command_word0, 0x0a00);
 }
 
-static struct six_axis_t get_min_full_scales(struct jr3_sensor __iomem *sensor)
-{
-	struct six_axis_t result;
-
-	result.fx = get_s16(&sensor->min_full_scale.fx);
-	result.fy = get_s16(&sensor->min_full_scale.fy);
-	result.fz = get_s16(&sensor->min_full_scale.fz);
-	result.mx = get_s16(&sensor->min_full_scale.mx);
-	result.my = get_s16(&sensor->min_full_scale.my);
-	result.mz = get_s16(&sensor->min_full_scale.mz);
-	return result;
-}
-
 static struct six_axis_t get_max_full_scales(struct jr3_sensor __iomem *sensor)
 {
 	struct six_axis_t result;
@@ -504,10 +491,8 @@ jr3_pci_poll_subdevice(struct comedi_subdevice *s)
 			result = poll_delay_min_max(20, 100);
 		} else {
 			/* Set full scale */
-			struct six_axis_t min_full_scale;
 			struct six_axis_t max_full_scale;
 
-			min_full_scale = get_min_full_scales(sensor);
 			max_full_scale = get_max_full_scales(sensor);
 			set_full_scales(sensor, max_full_scale);
 
-- 
2.17.1

