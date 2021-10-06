Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52900424275
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbhJFQV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:21:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:50845 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhJFQV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:21:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="225926605"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="225926605"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="657046588"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.56])
  by orsmga005.jf.intel.com with ESMTP; 06 Oct 2021 09:20:00 -0700
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
Subject: [PATCH 0/3] Multiple headphone codec driver support
Date:   Thu,  7 Oct 2021 00:18:02 +0800
Message-Id: <20211006161805.938950-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support multiple headphone drivers in same machine driver. In this
case, both rt5682 and rt5682s are supported and enumerated by different
ACPI HID "10EC5682" and "RTL5682".

Brent Lu (3):
  ASoC: soc-acpi: add alternative id field for machine driver matching
  ASoC: Intel: sof_rt5682: detect codec variant in probe function
  ASoC: Intel: sof_rt5682: use id_alt to enumerate rt5682s

 include/sound/soc-acpi.h                      |  2 ++
 sound/soc/intel/boards/sof_rt5682.c           | 34 +++----------------
 .../intel/common/soc-acpi-intel-adl-match.c   |  8 +++++
 .../intel/common/soc-acpi-intel-byt-match.c   |  6 ++++
 .../intel/common/soc-acpi-intel-cht-match.c   |  6 ++++
 .../intel/common/soc-acpi-intel-cml-match.c   |  8 +++++
 .../intel/common/soc-acpi-intel-icl-match.c   |  6 ++++
 .../intel/common/soc-acpi-intel-jsl-match.c   | 32 +++++------------
 .../intel/common/soc-acpi-intel-tgl-match.c   |  8 +++++
 sound/soc/soc-acpi.c                          | 21 +++++++++++-
 10 files changed, 76 insertions(+), 55 deletions(-)

-- 
2.25.1

