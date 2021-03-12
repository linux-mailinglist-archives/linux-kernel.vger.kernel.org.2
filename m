Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975EA33964A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhCLSYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:24:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:4236 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233245AbhCLSXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:43 -0500
IronPort-SDR: 3lBdQhmKzEqLTdD+8eyU6Dg3q3tG5c1bPVf8rKrwzik2q/Y4lA8CRnxT+uGUPsjRSETfXSrC9s
 ZGRE/GrhLyKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="252888934"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="252888934"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:43 -0800
IronPort-SDR: btbVK3oHXYUzV0roY6nLMj4vHmzEGrzBPXFLXQPU/qTRw8vU/YvirN6Nm0eQpMwsnXBVM8Pj6I
 nGyEuzTn+CXA==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377792043"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:42 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 15/23] ASoC: nau8825: remove useless assignment
Date:   Fri, 12 Mar 2021 12:22:38 -0600
Message-Id: <20210312182246.5153-16-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/codecs/nau8825.c:2113:10: style: Variable 'ret' is assigned
a value that is never used. [unreadVariable]
 int ret = 0;
         ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/nau8825.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index e19db30c457b..67de0e49ccf4 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -2111,7 +2111,7 @@ static int nau8825_set_pll(struct snd_soc_component *component, int pll_id, int
 
 static int nau8825_mclk_prepare(struct nau8825 *nau8825, unsigned int freq)
 {
-	int ret = 0;
+	int ret;
 
 	nau8825->mclk = devm_clk_get(nau8825->dev, "mclk");
 	if (IS_ERR(nau8825->mclk)) {
-- 
2.25.1

