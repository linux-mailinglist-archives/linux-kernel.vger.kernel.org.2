Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C240943FB7C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 13:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhJ2Ljt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 07:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231901AbhJ2Ljr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 07:39:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D4CD60E90;
        Fri, 29 Oct 2021 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635507439;
        bh=yTSogPIfy5AE72vKBkjJknnLiy8pwiVnVsgW2jY63+8=;
        h=From:To:Cc:Subject:Date:From;
        b=e3kO/N6rU9VLg2hykHHrFW7T2Y6E/yqkcAlb7afeOa/WcnblltUBaiCrhRAPV8HfM
         OVWSgm0iyjUoJQTUiHWDJ3JWA3FtMhP1S+9UTRQZ3/6zAWc25/oovNkyyP58ma/n1l
         TK6Tk1EVr6rJ+Bkk8LOkUZCwJ4C/YN+GPcPxoJCzgIYrIj3xgZC+OAMFYBW7uZZcGj
         lWZFG1pwXmr5NYNlsKL9RUs1xzt/5IaczXP8W+99FyTRUE5W3kZdt4b5tzMg3fmeN2
         03Oy9kLVorbgCreuBphyBe2FHT2c8KqQft1Q3UwqOpa/7OTD087mmg4Odrr0fj/YGP
         HPoGTHMGm6wLw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: acp: select CONFIG_SND_SOC_ACPI
Date:   Fri, 29 Oct 2021 13:36:57 +0200
Message-Id: <20211029113714.966823-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The acp-platform driver now needs the ACPI helpers:

ld.lld: error: undefined symbol: snd_soc_acpi_find_machine
>>> referenced by acp-platform.c
>>>               soc/amd/acp/acp-platform.o:(acp_machine_select) in archive sound/built-in.a

ld.lld: error: undefined symbol: snd_soc_acpi_codec_list
>>> referenced by acp-renoir.c
>>>               soc/amd/acp/acp-renoir.o:(snd_soc_acpi_amd_acp_machines) in archive sound/built-in.a

Other drivers using this interface, select SND_SOC_ACPI, so do the
same thing here.

Fixes: e646b51f5dd5 ("ASoC: amd: acp: Add callback for machine driver on ACP")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/amd/acp/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index e3d5cf993f5f..52a1371f9e61 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -20,6 +20,7 @@ config SND_SOC_AMD_ACP_I2S
 
 config SND_SOC_AMD_ACP_PCM
 	tristate
+	select SND_SOC_ACPI if ACPI
 
 config SND_AMD_ASOC_RENOIR
 	tristate "AMD ACP ASOC Renoir Support"
-- 
2.29.2

