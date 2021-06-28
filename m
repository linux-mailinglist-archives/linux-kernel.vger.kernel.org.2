Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF383B6A06
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 23:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbhF1VOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 17:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbhF1VO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 17:14:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE5FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 14:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=mTjSPzZG9+K/4jkT2IaNNnrtPpIfy0RNExLT/c4RwLY=; b=BGDYXRqiLf6JHU3uKfkeLeuhde
        E8il+lkcZ5dOf9R8Bnd9EpKjLgaUXp9shQbX01J1RySanAx6mAIsyBFz8X7MEsf6OuycLBxm5UTfd
        vk5nXPCgy2WRGo+j4MHRNE/z/uXYdHM/OFiuLJ6pzctxqcGoIIydEviXB3v9V83Jlu0rSJwnFGFdI
        nxgkMZNQu+a67F4IYUmKchMOGzA2v4zkt98msNBGJoeEEGhm5BgCluXy6yRAY5QYSluJxttuH4GMc
        XNxU2Fm9NTQPgXubne6fdfOsj5sqnNsknZvppKa/e8R4gwhLYjbipps2c5tSy4FL++VFnCcECE0HH
        jnFEenRw==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxyXu-009CEy-OV; Mon, 28 Jun 2021 21:11:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2] ASoC: atmel: ATMEL drivers depend on HAS_DMA
Date:   Mon, 28 Jun 2021 14:11:58 -0700
Message-Id: <20210628211158.30273-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a config (such as arch/sh/) which does not set HAS_DMA when MMU
is not set, several ATMEL ASoC drivers select symbols that cause
kconfig warnings. There is one "depends on HAS_DMA" here but several
more are needed to prevent kconfig warnings since 'select' does not
recognize any dependencies.

Fix the following kconfig warnings:

WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
  Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && HAS_DMA [=n]
  Selected by [m]:
  - SND_ATMEL_SOC_SSC [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m]
  - SND_ATMEL_SOC_SSC_PDC [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m]

WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC_PDC
  Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m] && HAS_DMA [=n]
  Selected by [m]:
  - SND_AT91_SOC_SAM9G20_WM8731 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && SND_SOC_I2C_AND_SPI [=m]

WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC
  Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && HAS_DMA [=n]
  Selected by [m]:
  - SND_ATMEL_SOC_SSC_DMA [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m]

WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC_DMA
  Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m] && HAS_DMA [=n]
  Selected by [m]:
  - SND_ATMEL_SOC_WM8904 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && I2C [=m]
  - SND_AT91_SOC_SAM9X5_WM8731 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && SND_SOC_I2C_AND_SPI [=m]

Fixes: 3951e4aae2ce ("ASoC: atmel-pcm: dma support based on pcm dmaengine")
Fixes: 18291410557f ("ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in Kconfig")
Fixes: 061981ff8cc8 ("ASoC: atmel: properly select dma driver state")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
v2: rebase & resend;
    drop Cc: to Bo Shen <voice.shen@atmel.com> # bounced

 sound/soc/atmel/Kconfig |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-next-20210628.orig/sound/soc/atmel/Kconfig
+++ linux-next-20210628/sound/soc/atmel/Kconfig
@@ -19,12 +19,14 @@ config SND_ATMEL_SOC_DMA
 
 config SND_ATMEL_SOC_SSC
 	tristate
+	depends on HAS_DMA
 	select SND_ATMEL_SOC_DMA
 	select SND_ATMEL_SOC_PDC
 
 config SND_ATMEL_SOC_SSC_PDC
 	tristate "SoC PCM DAI support for AT91 SSC controller using PDC"
 	depends on ATMEL_SSC
+	depends on HAS_DMA
 	select SND_ATMEL_SOC_PDC
 	select SND_ATMEL_SOC_SSC
 	help
@@ -34,6 +36,7 @@ config SND_ATMEL_SOC_SSC_PDC
 config SND_ATMEL_SOC_SSC_DMA
 	tristate "SoC PCM DAI support for AT91 SSC controller using DMA"
 	depends on ATMEL_SSC
+	depends on HAS_DMA
 	select SND_ATMEL_SOC_DMA
 	select SND_ATMEL_SOC_SSC
 	help
@@ -44,6 +47,7 @@ config SND_AT91_SOC_SAM9G20_WM8731
 	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
 	depends on ARCH_AT91 || COMPILE_TEST
 	depends on ATMEL_SSC && SND_SOC_I2C_AND_SPI
+	depends on HAS_DMA
 	select SND_ATMEL_SOC_SSC_PDC
 	select SND_SOC_WM8731
 	help
@@ -54,6 +58,7 @@ config SND_ATMEL_SOC_WM8904
 	tristate "Atmel ASoC driver for boards using WM8904 codec"
 	depends on ARCH_AT91 || COMPILE_TEST
 	depends on ATMEL_SSC && I2C
+	depends on HAS_DMA
 	select SND_ATMEL_SOC_SSC_DMA
 	select SND_SOC_WM8904
 	help
@@ -64,6 +69,7 @@ config SND_AT91_SOC_SAM9X5_WM8731
 	tristate "SoC Audio support for WM8731-based at91sam9x5 board"
 	depends on ARCH_AT91 || COMPILE_TEST
 	depends on ATMEL_SSC && SND_SOC_I2C_AND_SPI
+	depends on HAS_DMA
 	select SND_ATMEL_SOC_SSC_DMA
 	select SND_SOC_WM8731
 	help
