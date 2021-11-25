Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D2B45D530
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350470AbhKYHO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:14:27 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14980 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349831AbhKYHM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:12:26 -0500
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J087N5d5LzZd6Q;
        Thu, 25 Nov 2021 15:06:40 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 15:09:14 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 25 Nov
 2021 15:09:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <alsa-devel@alsa-project.org>,
        <sound-open-firmware@alsa-project.org>
CC:     <broonie@kernel.org>, <yc.hung@mediatek.com>,
        <daniel.baluta@nxp.com>
Subject: [PATCH -next] ASoC: SOF: mediatek: Add missing of_node_put() in platform_parse_resource()
Date:   Thu, 25 Nov 2021 15:16:08 +0800
Message-ID: <20211125071608.3056715-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node pointer is returned by of_parse_phandle() with
refcount incremented in platform_parse_resource(). Calling
of_node_put() to aovid the refcount leak.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 40e5a25875a6..55d9812870a4 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -43,6 +43,7 @@ static int platform_parse_resource(struct platform_device *pdev, void *data)
 	}
 
 	ret = of_address_to_resource(mem_region, 0, &res);
+	of_node_put(mem_region);
 	if (ret) {
 		dev_err(dev, "of_address_to_resource dma failed\n");
 		return ret;
@@ -64,6 +65,7 @@ static int platform_parse_resource(struct platform_device *pdev, void *data)
 	}
 
 	ret = of_address_to_resource(mem_region, 0, &res);
+	of_node_put(mem_region);
 	if (ret) {
 		dev_err(dev, "of_address_to_resource sysmem failed\n");
 		return ret;
-- 
2.25.1

