Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2BE339650
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbhCLSY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:24:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:4236 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233258AbhCLSXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:48 -0500
IronPort-SDR: GSuNljBHpDzI5U1WjAAdBUGm5HWBb5/13+3D4DewZx7oLblJJCTAbXjRv3NJ6YeeRT6z3BBv+k
 ZenHMk1kGwjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="252888943"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="252888943"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:48 -0800
IronPort-SDR: jVhDZNM4RYTZdGGQjrKfNLLoVRCL8lSQOE2XbcEPGMv6TgIV53VG1rZd6d3Fnj9tqITuLrOVIf
 a+CZvjMRNRyw==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377792054"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:47 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 18/23] ASoC: sti-sas: remove unused struct members
Date:   Fri, 12 Mar 2021 12:22:41 -0600
Message-Id: <20210312182246.5153-19-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warnings:

sound/soc/codecs/sti-sas.c:54:25: style: struct member
'sti_dac_audio::field' is never used. [unusedStructMember]
 struct regmap_field  **field;
                        ^

sound/soc/codecs/sti-sas.c:55:24: style: struct member
'sti_dac_audio::rst' is never used. [unusedStructMember]
 struct reset_control *rst;
                       ^

sound/soc/codecs/sti-sas.c:61:25: style: struct member
'sti_spdif_audio::field' is never used. [unusedStructMember]
 struct regmap_field  **field;
                        ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/sti-sas.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index ec9933b054ad..ffdf7e559515 100644
--- a/sound/soc/codecs/sti-sas.c
+++ b/sound/soc/codecs/sti-sas.c
@@ -51,14 +51,11 @@ static const struct reg_default stih407_sas_reg_defaults[] = {
 struct sti_dac_audio {
 	struct regmap *regmap;
 	struct regmap *virt_regmap;
-	struct regmap_field  **field;
-	struct reset_control *rst;
 	int mclk;
 };
 
 struct sti_spdif_audio {
 	struct regmap *regmap;
-	struct regmap_field  **field;
 	int mclk;
 };
 
-- 
2.25.1

