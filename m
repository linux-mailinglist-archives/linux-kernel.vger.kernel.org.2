Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A242D41FF52
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 05:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhJCDFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 23:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJCDFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 23:05:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC833C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 20:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=V2oLactPpE5eJWgOLN3Dhq4j/4VC1w7xQGXAdA2EUAA=; b=dsSyZPPISXb3VZpr7E4zsjPCYm
        Rdwbph+1+lOthfEY7StkeMW/KId/D8kKDxpXjV/ogYGSBxj2js+NEUBfsaU2HU1UUAphnlTbwNpVu
        g/SASSf37tG2LRI4uZqq1X48WVkWJZZR2dwbnnsyw7l7XojZtj7JGaEt4r2evyyw43wmi9iWSmLLj
        qYdmcR5KQq+L0PnDsUA4SMF1JdtEMGDvNbpXu1gQRRAY8R4bQkiMftDj/hhQYLvITws+08P04+0p0
        zTTZCWaw9YAWKD63qCLgipjHS2vEJiCwjWQjQpJ6KKyN8WN4d8Khd8azf7HKa6uFWEzlfO7MIBawr
        OPZhwgXw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWrnJ-0037Sc-Qe; Sun, 03 Oct 2021 03:04:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: add COMPILE_TEST for SND_SOC_FSL_ASRC
Date:   Sat,  2 Oct 2021 20:04:04 -0700
Message-Id: <20211003030404.32707-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert pointed out that since sound/soc has the soc_dummy_driver for
NO_DMA platforms, it is possible (desirable) to have drivers that
depend on HAS_DMA to alternately depend on COMPILE_TEST.

This means that SND_ATMEL_FSL_ASRC can depend on HAS_DMA || COMPIE_TEST.

Fixes: 121a01521b1e ("ASoC: fsl: fix build failure")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
---
 sound/soc/fsl/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211001.orig/sound/soc/fsl/Kconfig
+++ linux-next-20211001/sound/soc/fsl/Kconfig
@@ -5,7 +5,7 @@ comment "Common SoC Audio options for Fr
 
 config SND_SOC_FSL_ASRC
 	tristate "Asynchronous Sample Rate Converter (ASRC) module support"
-	depends on HAS_DMA
+	depends on HAS_DMA || COMPILE_TEST
 	select REGMAP_MMIO
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
