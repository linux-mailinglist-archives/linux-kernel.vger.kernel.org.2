Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7452A3A8F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFPDqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:46:12 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7319 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFPDqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:46:11 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G4WCj586Vz6y6w;
        Wed, 16 Jun 2021 11:40:01 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.62) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 16 Jun 2021 11:44:00 +0800
From:   Yu Jiahua <yujiahua1@huawei.com>
To:     <a.hajda@samsung.com>, <narmstrong@baylibre.co>,
        <robert.foss@linaro.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>
CC:     <xji@analogixsemi.com>, <yujiahua1@huawei.com>,
        <hsinyi@chromium.org>, <sam@ravnborg.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drivers: gpu: add missing MODULE_DEVICE_TABLE in anx7625.c
Date:   Tue, 15 Jun 2021 19:44:48 -0800
Message-ID: <20210616034448.34919-1-yujiahua1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.62]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Signed-off-by: Yu Jiahua <yujiahua1@huawei.com>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 65cc05982f82..beb01364af4d 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1830,6 +1830,7 @@ static const struct of_device_id anx_match_table[] = {
 	{.compatible = "analogix,anx7625",},
 	{},
 };
+MODULE_DEVICE_TABLE(of, anx_match_table);
 
 static struct i2c_driver anx7625_driver = {
 	.driver = {
-- 
2.17.1

