Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C7342427A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbhJFQWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:22:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:44629 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239148AbhJFQWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:22:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="213157230"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="213157230"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="657046681"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.56])
  by orsmga005.jf.intel.com with ESMTP; 06 Oct 2021 09:20:12 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        linux-kernel@vger.kernel.org, Rander Wang <rander.wang@intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        Libin Yang <libin.yang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>
Subject: [PATCH 2/3] ASoC: Intel: sof_rt5682: detect codec variant in probe function
Date:   Thu,  7 Oct 2021 00:18:04 +0800
Message-Id: <20211006161805.938950-3-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006161805.938950-1-brent.lu@intel.com>
References: <20211006161805.938950-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect whether the headphone codec is ALC5682I-VS or not in probe
function so we don't need to duplicate all board configs for this new
variant.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 613662eedd0d..9f1e5ef11b13 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -864,6 +864,10 @@ static int sof_audio_probe(struct platform_device *pdev)
 	if ((sof_rt5682_quirk & SOF_SPEAKER_AMP_PRESENT) && !mach->quirk_data)
 		sof_rt5682_quirk &= ~SOF_SPEAKER_AMP_PRESENT;
 
+	/* Detect the headset codec variant ALC5682I-VS */
+	if (acpi_dev_present("RTL5682", NULL, -1))
+		sof_rt5682_quirk |= SOF_RT5682S_HEADPHONE_CODEC_PRESENT;
+
 	if (soc_intel_is_byt() || soc_intel_is_cht()) {
 		is_legacy_cpu = 1;
 		dmic_be_num = 0;
-- 
2.25.1

