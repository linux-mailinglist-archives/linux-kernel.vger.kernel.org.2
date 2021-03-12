Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85682339638
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhCLSXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:23:17 -0500
Received: from mga02.intel.com ([134.134.136.20]:36913 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233115AbhCLSXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:08 -0500
IronPort-SDR: EQc8/IVwq+9vsIHqnv/8hqXthzalyUgZUdhKKL9lRNCNBpmbk/W6dCx0gJWXQ8OszB2XhHi89x
 bnNDrWPYm4QA==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="175999081"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="175999081"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:08 -0800
IronPort-SDR: 3n6+mEsWk5rHd66thCMs3LXA9CGR8WYgCJUwGmEYQNLlEpgNY5fpFyNe4BZLJk61DuvqOubFrR
 RIxbULFANBuw==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377791897"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:07 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 01/23] ASoC: ab8500-codec: remove useless structure
Date:   Fri, 12 Mar 2021 12:22:24 -0600
Message-Id: <20210312182246.5153-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cppcheck warnings:

sound/soc/codecs/ab8500-codec.c:117:20: style: struct member 'ab8500_codec_drvdata_dbg::vaud' is never used. [unusedStructMember]
 struct regulator *vaud;
                   ^
sound/soc/codecs/ab8500-codec.c:118:20: style: struct member 'ab8500_codec_drvdata_dbg::vamic1' is never used. [unusedStructMember]
 struct regulator *vamic1;
                   ^
sound/soc/codecs/ab8500-codec.c:119:20: style: struct member 'ab8500_codec_drvdata_dbg::vamic2' is never used. [unusedStructMember]
 struct regulator *vamic2;
                   ^
sound/soc/codecs/ab8500-codec.c:120:20: style: struct member 'ab8500_codec_drvdata_dbg::vdmic' is never used. [unusedStructMember]
 struct regulator *vdmic;
                   ^

The structure is never used, remove.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/ab8500-codec.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index c95f007cede1..5525e1ccab76 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -113,13 +113,6 @@ enum amic_idx {
 	AMIC_IDX_2
 };
 
-struct ab8500_codec_drvdata_dbg {
-	struct regulator *vaud;
-	struct regulator *vamic1;
-	struct regulator *vamic2;
-	struct regulator *vdmic;
-};
-
 /* Private data for AB8500 device-driver */
 struct ab8500_codec_drvdata {
 	struct regmap *regmap;
-- 
2.25.1

