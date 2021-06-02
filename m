Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A1E398401
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhFBIXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:23:37 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3344 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhFBIXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:23:33 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fw21t3d80z19S4V;
        Wed,  2 Jun 2021 16:17:06 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 16:21:49 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 2 Jun 2021
 16:21:48 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-imx@nxp.com>
CC:     <broonie@kernel.org>, <shengjiu.wang@gmail.com>
Subject: [PATCH -next] ASoC: imx-audio-rpmsg: use module_rpmsg_driver to simplify the code
Date:   Wed, 2 Jun 2021 16:26:10 +0800
Message-ID: <20210602082610.3828408-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module_rpmsg_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/fsl/imx-audio-rpmsg.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/fsl/imx-audio-rpmsg.c b/sound/soc/fsl/imx-audio-rpmsg.c
index 50099bcaa9cd..905c3a071300 100644
--- a/sound/soc/fsl/imx-audio-rpmsg.c
+++ b/sound/soc/fsl/imx-audio-rpmsg.c
@@ -122,17 +122,7 @@ static struct rpmsg_driver imx_audio_rpmsg_driver = {
 	.remove		= imx_audio_rpmsg_remove,
 };
 
-static int __init imx_audio_rpmsg_init(void)
-{
-	return register_rpmsg_driver(&imx_audio_rpmsg_driver);
-}
-
-static void __exit imx_audio_rpmsg_exit(void)
-{
-	unregister_rpmsg_driver(&imx_audio_rpmsg_driver);
-}
-module_init(imx_audio_rpmsg_init);
-module_exit(imx_audio_rpmsg_exit);
+module_rpmsg_driver(imx_audio_rpmsg_driver);
 
 MODULE_DESCRIPTION("Freescale SoC Audio RPMSG interface");
 MODULE_AUTHOR("Shengjiu Wang <shengjiu.wang@nxp.com>");
-- 
2.25.1

