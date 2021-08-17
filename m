Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C318E3EF264
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhHQTC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:02:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:18728 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233385AbhHQTCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:02:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="203324527"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="203324527"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 12:01:34 -0700
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="488147352"
Received: from aaadelek-mobl3.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.12.89])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 12:01:32 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        sound-open-firmware@alsa-project.org (moderated list:SOUND - SOUND OPEN
        FIRMWARE (SOF) DRIVERS)
Subject: [RFC PATCH 2/2] ASoC: SOF: trigger re-probing of deferred devices from workqueue
Date:   Tue, 17 Aug 2021 14:00:57 -0500
Message-Id: <20210817190057.255264-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audio drivers such as HDaudio legacy and SOF rely on a workqueue to
split the probe into two, with a first pass returning success
immediately, and the second pass taking a lot more time due to the use
of request_module() and the DSP initializations.

This workqueue-based solution helps deal with conflicting requirements
a) other drivers should not be blocked by a long probe
b) a PROBE_PREFER_ASYNCHRONOUS probe_type is explicitly not allowed
to avoid a deadlock when request_module() is used.

This patch makes sure the deferred probe framework is triggered when
the provider of resources successfully completes its initialization.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 3e4dd4a86363..cecc0e914807 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -251,6 +251,9 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 
 	sdev->probe_completed = true;
 
+	/* kick-off re-probing of deferred devices */
+	driver_deferred_probe_trigger();
+
 	return 0;
 
 fw_trace_err:
-- 
2.25.1

