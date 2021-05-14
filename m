Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6343803F2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhENHE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:04:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2658 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhENHE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:04:27 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FhKCV5NX9zQnJk;
        Fri, 14 May 2021 14:59:50 +0800 (CST)
Received: from DESKTOP-EFRLNPK.china.huawei.com (10.174.176.189) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 14 May 2021 15:03:07 +0800
From:   Qiheng Lin <linqiheng@huawei.com>
To:     <linqiheng@huawei.com>, Phong LE <ple@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] drm: bridge: fix wrong pointer passed to PTR_ERR()
Date:   Fri, 14 May 2021 15:03:06 +0800
Message-ID: <20210514070306.606-1-linqiheng@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.189]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR_ERR should access the value just tested by IS_ERR, otherwise
the wrong error code will be returned.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index d8a60691fd32..6980c9801d0d 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -943,7 +943,7 @@ static int it66121_probe(struct i2c_client *client,
 	ctx->regmap = devm_regmap_init_i2c(client, &it66121_regmap_config);
 	if (IS_ERR(ctx->regmap)) {
 		ite66121_power_off(ctx);
-		return PTR_ERR(ctx);
+		return PTR_ERR(ctx->regmap);
 	}
 
 	regmap_read(ctx->regmap, IT66121_VENDOR_ID0_REG, &vendor_ids[0]);

