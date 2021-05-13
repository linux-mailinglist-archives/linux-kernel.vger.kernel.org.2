Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3D637F79B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhEMMOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:14:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2586 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbhEMMMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:12:54 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fgr6k5BygzsRJ8;
        Thu, 13 May 2021 20:09:02 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Thu, 13 May 2021
 20:11:36 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <abbotti@mev.co.uk>, <hsweeten@visionengravers.com>,
        <gregkh@linuxfoundation.org>, <grandmaster@al2klimov.de>,
        <john.wanghui@huawei.com>
Subject: [PATCH -next] =?UTF-8?q?staging:=20comedi:=20Remove=20unused=20variable?= =?UTF-8?q?=20=E2=80=98min=5Ffull=5Fscale=E2=80=99?=
Date:   Thu, 13 May 2021 21:34:58 +0800
Message-ID: <20210513133458.27766-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.28.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following build warnings:
drivers/comedi/drivers/jr3_pci.c:507:22:
	warning: variable ‘min_full_scale’ set but not used

And fix build warnings after removing ‘min_full_scale’:
drivers/comedi/drivers/jr3_pci.c:189:26:
	warning: ‘get_min_full_scales’ defined but not used
 static struct six_axis_t get_min_full_scales(struct jr3_sensor __iomem *sensor)
                          ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 drivers/comedi/drivers/jr3_pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
index 7a02c4fa3cda..122b95dc2bf9 100644
--- a/drivers/comedi/drivers/jr3_pci.c
+++ b/drivers/comedi/drivers/jr3_pci.c
@@ -186,7 +186,7 @@ static void set_full_scales(struct jr3_sensor __iomem *sensor,
 	set_s16(&sensor->command_word0, 0x0a00);
 }
 
-static struct six_axis_t get_min_full_scales(struct jr3_sensor __iomem *sensor)
+static __maybe_unused struct six_axis_t get_min_full_scales(struct jr3_sensor __iomem *sensor)
 {
 	struct six_axis_t result;
 
@@ -504,10 +504,8 @@ jr3_pci_poll_subdevice(struct comedi_subdevice *s)
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

