Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB8533482E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 20:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhCJTk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 14:40:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:63053 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232417AbhCJTkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:40:21 -0500
IronPort-SDR: QAVj1kr2EOQXdU05pOGeY7trvSPBb4M6qTTWmjtTJRqW15PW7OoNroVfzKNhb0BndUDQX26obL
 P1PKkgcpbwzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="175653946"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="175653946"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 11:40:20 -0800
IronPort-SDR: Ngnr155Z4dw1Nf9P58Szzse68G1YMbgnh5b1TDqzsJaZCphjR0QwhrjEpuDkvqMLu8lMYHwvUy
 Izo1CMmL5Xnw==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="372066191"
Received: from alsonico-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.30.88])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 11:40:19 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Jon Hunter <jonathanh@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: soc-core: fix DMI handling
Date:   Wed, 10 Mar 2021 13:39:27 -0600
Message-Id: <20210310193928.108850-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DMI information is not present, trying to assign the card long
name results in the following warning.

WARNING KERN tegra-audio-graph-card sound: ASoC: no DMI vendor name!

The initial solution suggested was to test if the card device is an
ACPI one. This causes a regression visible to userspace on all Intel
platforms, with UCM unable to load card profiles based on DMI
information: the card devices are not necessarily ACPI ones, e.g. when
the parent creates platform devices on Intel devices.

To fix this problem, this patch exports the existing dmi_available
variable and tests it in the ASoC core.

Fixes: c014170408bc ("ASoC: soc-core: Prevent warning if no DMI table is present")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/firmware/dmi_scan.c | 1 +
 sound/soc/soc-core.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index d51ca0428bb8..f191a1f901ac 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -166,6 +166,7 @@ static int __init dmi_checksum(const u8 *buf, u8 len)
 static const char *dmi_ident[DMI_STRING_MAX];
 static LIST_HEAD(dmi_devices);
 int dmi_available;
+EXPORT_SYMBOL_GPL(dmi_available);
 
 /*
  *	Save a DMI string
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 16ba54eb8164..c7e4600b2dd4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1574,7 +1574,7 @@ int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
 	if (card->long_name)
 		return 0; /* long name already set by driver or from DMI */
 
-	if (!is_acpi_device_node(card->dev->fwnode))
+	if (!dmi_available)
 		return 0;
 
 	/* make up dmi long name as: vendor-product-version-board */
-- 
2.25.1

