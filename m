Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F2934B1B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhCZWAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:00:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:61331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230378AbhCZWAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:00:14 -0400
IronPort-SDR: Ald12DQII2uKRBl74/ytIMGeVMJQHuhFGnwIQSG+8xH24zr0drpQt7TY2qbDeGGdH5aC7ZC1i3
 wm5k4WGMGtIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="188957134"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="188957134"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:00:13 -0700
IronPort-SDR: VJAH5WVjhPt4JQZSA/x4BysEr0LbukiDsMA6a0UaInhYJs94LgfJtIFHyAx7J0a0m8XKAWS0Af
 XGBN3/OuZ5CQ==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416706881"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.231.203])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:00:12 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 12/17] ASoC: tegra: tegra20_das: clarify expression
Date:   Fri, 26 Mar 2021 16:59:22 -0500
Message-Id: <20210326215927.936377-13-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/tegra/tegra20_das.c:64:60: style: Boolean result is used in
bitwise operation. Clarify expression with
parentheses. [clarifyCondition]
 reg = otherdap << TEGRA20_DAS_DAP_CTRL_SEL_DAP_CTRL_SEL_P |
                                                           ^
sound/soc/tegra/tegra20_das.c:65:61: style: Boolean result is used in
bitwise operation. Clarify expression with
parentheses. [clarifyCondition]

  !!sdata2rx << TEGRA20_DAS_DAP_CTRL_SEL_DAP_SDATA2_TX_RX_P |
                                                            ^
sound/soc/tegra/tegra20_das.c:66:61: style: Boolean result is used in
bitwise operation. Clarify expression with
parentheses. [clarifyCondition]
  !!sdata1rx << TEGRA20_DAS_DAP_CTRL_SEL_DAP_SDATA1_TX_RX_P |
                                                            ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/tegra/tegra20_das.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/tegra/tegra20_das.c b/sound/soc/tegra/tegra20_das.c
index 79dba878d854..69c651274c12 100644
--- a/sound/soc/tegra/tegra20_das.c
+++ b/sound/soc/tegra/tegra20_das.c
@@ -61,10 +61,10 @@ int tegra20_das_connect_dap_to_dap(int dap, int otherdap, int master,
 
 	addr = TEGRA20_DAS_DAP_CTRL_SEL +
 		(dap * TEGRA20_DAS_DAP_CTRL_SEL_STRIDE);
-	reg = otherdap << TEGRA20_DAS_DAP_CTRL_SEL_DAP_CTRL_SEL_P |
-		!!sdata2rx << TEGRA20_DAS_DAP_CTRL_SEL_DAP_SDATA2_TX_RX_P |
-		!!sdata1rx << TEGRA20_DAS_DAP_CTRL_SEL_DAP_SDATA1_TX_RX_P |
-		!!master << TEGRA20_DAS_DAP_CTRL_SEL_DAP_MS_SEL_P;
+	reg = (otherdap << TEGRA20_DAS_DAP_CTRL_SEL_DAP_CTRL_SEL_P) |
+		(!!sdata2rx << TEGRA20_DAS_DAP_CTRL_SEL_DAP_SDATA2_TX_RX_P) |
+		(!!sdata1rx << TEGRA20_DAS_DAP_CTRL_SEL_DAP_SDATA1_TX_RX_P) |
+		(!!master << TEGRA20_DAS_DAP_CTRL_SEL_DAP_MS_SEL_P);
 
 	tegra20_das_write(addr, reg);
 
-- 
2.25.1

