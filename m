Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B4E391A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbhEZOeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:34:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5561 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbhEZOeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:34:24 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FqtdK0lHNzmV6V;
        Wed, 26 May 2021 22:29:57 +0800 (CST)
Received: from dggeml759-chm.china.huawei.com (10.1.199.138) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 22:32:48 +0800
Received: from localhost.localdomain (10.175.102.38) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 26 May 2021 22:32:48 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Simon Shields <simon@lineageos.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] ASoC: samsung: midas_wm1811: Fix build error when CONFIG_GPIOLIB is not set
Date:   Wed, 26 May 2021 14:43:39 +0000
Message-ID: <20210526144339.2392592-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeml759-chm.china.huawei.com (10.1.199.138)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error when CONFIG_GPIOLIB is not set:

sound/soc/samsung/midas_wm1811.c: In function 'midas_fm_set':
sound/soc/samsung/midas_wm1811.c:205:3: error:
 implicit declaration of function 'gpiod_set_value_cansleep';
 did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
  205 |   gpiod_set_value_cansleep(priv->gpio_fm_sel, 1);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~
      |   gpio_set_value_cansleep
sound/soc/samsung/midas_wm1811.c: In function 'midas_probe':
sound/soc/samsung/midas_wm1811.c:445:22: error:
 implicit declaration of function 'devm_gpiod_get_optional';
 did you mean 'devm_clk_get_optional'? [-Werror=implicit-function-declaration]
  445 |  priv->gpio_fm_sel = devm_gpiod_get_optional(dev, "fm-sel", GPIOD_OUT_HIGH);
      |                      ^~~~~~~~~~~~~~~~~~~~~~~
      |                      devm_clk_get_optional
sound/soc/samsung/midas_wm1811.c:445:61:
 error: 'GPIOD_OUT_HIGH' undeclared (first use in this function);
 did you mean 'GPIOF_INIT_HIGH'?
  445 |  priv->gpio_fm_sel = devm_gpiod_get_optional(dev, "fm-sel", GPIOD_OUT_HIGH);
      |                                                             ^~~~~~~~~~~~~~
      |                                                             GPIOF_INIT_HIGH

Fixes: fd0ea9cd9698 ("ASoC: samsung: Add sound support for Midas boards")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/samsung/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index a2221ebb1b6a..22be597b1dd9 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -228,6 +228,7 @@ config SND_SOC_SAMSUNG_ARIES_WM8994
 config SND_SOC_SAMSUNG_MIDAS_WM1811
 	tristate "SoC I2S Audio support for Midas boards"
 	depends on SND_SOC_SAMSUNG
+	depends on GPIOLIB
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8994
 	help

