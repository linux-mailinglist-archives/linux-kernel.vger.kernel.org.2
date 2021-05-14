Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AADE3812DC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhENVdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232542AbhENVdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:33:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 905B66143F;
        Fri, 14 May 2021 21:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621027929;
        bh=4L4mcKVn3lkbqXEEkhEsQV92HBC1CPOXzYICTb92p2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=JpuFugNGtCnfLnbuSbD6CYvS9tqG7bcN2jo/Rzbn/NVrHpOOWL7eV0QAY28Wxe03K
         12BtzI6hEX+yVdfs7SDSFprIQ4WsWbty/nHjnLJP5jrSWHWeIux++zfG4EC1yV+XO1
         q+xp/qqE1d/sp622ccn1qu/941nWsAIaPjp8itRWGUOkr9WAuah0cIRllwQTbQCnZp
         ozBSoCKp+ZVx6e+ASRN7jsYuZL1I5N18jsrQ4RdzRvfnpJ27qo0639AKPl76HuOT3q
         ZiA1LF4H3iOkY3dPOCd7TmEXgnMfiyvnXk9a7pBFkUEJxRU34qT05AfFNeDm556Bph
         kD+ZQlgrBsncQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl: fix SND_SOC_IMX_RPMSG dependency
Date:   Fri, 14 May 2021 23:31:14 +0200
Message-Id: <20210514213118.630427-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Kconfig produces a warning with SND_SOC_FSL_RPMSG=y and SND_IMX_SOC=m:

WARNING: unmet direct dependencies detected for SND_SOC_IMX_RPMSG
  Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_IMX_SOC [=m] && RPMSG [=y]
  Selected by [y]:
  - SND_SOC_FSL_RPMSG [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && COMMON_CLK [=y] && RPMSG [=y] && SND_IMX_SOC [=m]!=n

Add a dependency to prevent this configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/fsl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 0917d65d6921..556c284f49dd 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -119,6 +119,7 @@ config SND_SOC_FSL_RPMSG
 	tristate "NXP Audio Base On RPMSG support"
 	depends on COMMON_CLK
 	depends on RPMSG
+	depends on SND_IMX_SOC || SND_IMX_SOC = n
 	select SND_SOC_IMX_RPMSG if SND_IMX_SOC != n
 	help
 	  Say Y if you want to add rpmsg audio support for the Freescale CPUs.
-- 
2.29.2

