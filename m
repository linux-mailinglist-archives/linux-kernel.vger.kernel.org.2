Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C8C3201D1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 00:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhBSXcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 18:32:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:58069 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhBSXcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 18:32:13 -0500
IronPort-SDR: owLT1ztuIqNcdHI+32B4T2Gtyf8RQ9bKx+6QwWKvnAkrJr/XrD4jg6HEQ1rMA/UtkxhQTBD8aC
 IMIeqdsZXDTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="268854793"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="268854793"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 15:30:28 -0800
IronPort-SDR: TrHNNv7iDNk62UGLpf2z4P8cz0reDsrFq64yr1q4UKtVPP238GZCi00TNPDTX8WCnLtWTHDmTJ
 m0uF6Jh1hwNw==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="496662564"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.153.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 15:30:27 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/9] ASoC: fsl: remove cppcheck warnings
Date:   Fri, 19 Feb 2021 17:29:28 -0600
Message-Id: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing critical and no functional changes.

The only change that needs attention if the 'fsl_ssi: remove
unnecessary tests' patch, where variables are to zero, then tested to
set register fields. Either the tests are indeed redundant or the
entire programming sequence is incorrect.

Pierre-Louis Bossart (9):
  ASoC: fsl: fsl_asrc: remove useless assignment
  ASoC: fsl: fsl_dma: remove unused variable
  ASoC: fsl: fsl_easrc: remove useless assignments
  ASoC: fsl: fsl_esai: clarify expression
  ASoC: fsl: fsl_ssi: remove unnecessary tests
  ASoC: fsl: imx-hdmi: remove unused structure members
  ASoC: fsl: mpc5200: signed parameter in snprintf format
  ASoC: fsl: mpc8610: remove useless assignment
  ASoC: fsl: p1022_ds: remove useless assignment

 sound/soc/fsl/fsl_asrc.c     | 2 +-
 sound/soc/fsl/fsl_dma.c      | 3 ---
 sound/soc/fsl/fsl_easrc.c    | 6 +++---
 sound/soc/fsl/fsl_esai.c     | 2 +-
 sound/soc/fsl/fsl_ssi.c      | 5 ++---
 sound/soc/fsl/imx-hdmi.c     | 4 ----
 sound/soc/fsl/mpc5200_dma.c  | 2 +-
 sound/soc/fsl/mpc8610_hpcd.c | 2 +-
 sound/soc/fsl/p1022_ds.c     | 2 +-
 9 files changed, 10 insertions(+), 18 deletions(-)

-- 
2.25.1

