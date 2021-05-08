Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F282F376E36
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 03:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhEHBwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 21:52:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17476 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhEHBwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 21:52:49 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FcVbp6gYjzkX0T;
        Sat,  8 May 2021 09:49:10 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Sat, 8 May 2021
 09:51:41 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <cuibixuan@huawei.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Ye Bin" <yebin10@huawei.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: codecs: lpass-tx-macro: add missing MODULE_DEVICE_TABLE
Date:   Sat, 8 May 2021 11:15:12 +0800
Message-ID: <20210508031512.53783-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.28.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 sound/soc/codecs/lpass-tx-macro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index acd2fbc0ca7c..27a0d5defd27 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1846,6 +1846,7 @@ static const struct of_device_id tx_macro_dt_match[] = {
 	{ .compatible = "qcom,sm8250-lpass-tx-macro" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, tx_macro_dt_match);
 static struct platform_driver tx_macro_driver = {
 	.driver = {
 		.name = "tx_macro",

