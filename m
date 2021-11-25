Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4016C45D7BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354300AbhKYJ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 04:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348499AbhKYJzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:55:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37763C061757;
        Thu, 25 Nov 2021 01:52:22 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so7861715wme.0;
        Thu, 25 Nov 2021 01:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xy2z4qlxanl4Hw2PX18g8lYJVE5ndrvEF3pAOx4MLrY=;
        b=NN50d0DQt9wmmVdxQYef9+Y7/G2a4VAenOiUMA9QQe5EE3Sq1Kkl4Ix5HnvsOPJ/D5
         bvKVEMaRVzY2W2zromU5gWBk0W8bT+o+tXgHAPo627o2hPpjJarSMUfGYHwbqDpYARtN
         84f3PbeOtHqsOyAXrmZWv0ZWcCTg+JuFiK/OFTAlmRDSQiI2pa9+HWYzNWTu+EFxDpU/
         G+ma9Mcm4MXOskLGHf08pbTa49wFkQxD1NGWyb55R5z7QiaCRK4uJaBr5n3ona9E10aO
         7FxpKTotpNtATCiPwFRT2JYgQMkZPx0O6sAbb9Ebl+WIZnt6xp89P2cofLbrvDihffCZ
         cnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xy2z4qlxanl4Hw2PX18g8lYJVE5ndrvEF3pAOx4MLrY=;
        b=BuqbPZfwjMpve+GYqU6CpNcioW5fVJC4UBmexKkXGWp8zjLINGR5LDY6XO4PeWmXcI
         luV/YqGE/QXStrX/Qb3QqKCC2TK3NAldSq7+AyJkuD95jR2AMJMrVfnn5zPKLaXa5yNt
         r4u8rRsnTlVMbrubq82NWxdZB3UUqb7P8QHTp1u80eDyfA4v4a3il73q1Tbc3Fw3AS4h
         zIctXygUEJp7Ura966LT9qd/+FZNucCwh68oD5SdlR67zUl2usp7jVabbkeaBCx3rjmw
         ZUB4LWbeTosEn69B7NZmTPTT0ZSuznXP0CvRr9Bs5NgQk1Sh8B7UGsaCxgNqZM7tux+S
         pqzA==
X-Gm-Message-State: AOAM531G4ZO0NNOs7X0piRtbjyGLF01fqEmVjrL79vyOMMpcdG8PrE9y
        1eyZ2JCYdOEFKUt8gV2plzs=
X-Google-Smtp-Source: ABdhPJyIFG1pqgyPP+GLxBDWtvShEO+05+7/3fMA5MdoRv7XDsSxvdvFu9CR6pgNbFVnLIg47Bn3lg==
X-Received: by 2002:a1c:f30d:: with SMTP id q13mr5361861wmq.55.1637833940778;
        Thu, 25 Nov 2021 01:52:20 -0800 (PST)
Received: from localhost.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id c1sm2310853wrt.14.2021.11.25.01.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 01:52:20 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/2] ASoC: uniphier: drop selecting non-existing SND_SOC_UNIPHIER_AIO_DMA
Date:   Thu, 25 Nov 2021 10:51:57 +0100
Message-Id: <20211125095158.8394-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211125095158.8394-1-lukas.bulwahn@gmail.com>
References: <20211125095158.8394-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f37fe2f9987b ("ASoC: uniphier: add support for UniPhier AIO common
driver") adds configs SND_SOC_UNIPHIER_{LD11,PXS2}, which select the
non-existing config SND_SOC_UNIPHIER_AIO_DMA.

Hence, ./scripts/checkkconfigsymbols.py warns:

  SND_SOC_UNIPHIER_AIO_DMA
  Referencing files: sound/soc/uniphier/Kconfig

Probably, there is actually no further config intended to be selected
here. So, just drop selecting the non-existing config.

Fixes: f37fe2f9987b ("ASoC: uniphier: add support for UniPhier AIO common driver")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 sound/soc/uniphier/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/uniphier/Kconfig b/sound/soc/uniphier/Kconfig
index aa3592ee1358..ddfa6424c656 100644
--- a/sound/soc/uniphier/Kconfig
+++ b/sound/soc/uniphier/Kconfig
@@ -23,7 +23,6 @@ config SND_SOC_UNIPHIER_LD11
 	tristate "UniPhier LD11/LD20 Device Driver"
 	depends on SND_SOC_UNIPHIER
 	select SND_SOC_UNIPHIER_AIO
-	select SND_SOC_UNIPHIER_AIO_DMA
 	help
 	  This adds ASoC driver for Socionext UniPhier LD11/LD20
 	  input and output that can be used with other codecs.
@@ -34,7 +33,6 @@ config SND_SOC_UNIPHIER_PXS2
 	tristate "UniPhier PXs2 Device Driver"
 	depends on SND_SOC_UNIPHIER
 	select SND_SOC_UNIPHIER_AIO
-	select SND_SOC_UNIPHIER_AIO_DMA
 	help
 	  This adds ASoC driver for Socionext UniPhier PXs2
 	  input and output that can be used with other codecs.
-- 
2.26.2

