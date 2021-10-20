Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8A3434FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhJTQGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:06:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:12447 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231163AbhJTQGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:06:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="229088031"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="229088031"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 08:59:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="494685355"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.56])
  by orsmga008.jf.intel.com with ESMTP; 20 Oct 2021 08:59:07 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rander Wang <rander.wang@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Huajun Li <huajun.li@intel.com>, Brent Lu <brent.lu@intel.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        linux-kernel@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 0/6] Multiple headphone codec driver support
Date:   Wed, 20 Oct 2021 23:57:09 +0800
Message-Id: <20211020155715.2045947-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support multiple headphone drivers in same machine driver. In this
case, both rt5682 and rt5682s are supported and enumerated by different
ACPI HID "10EC5682" and "RTL5682".

V2 Changes:
- remove useless 'NULL', 'false' in if-condition
- can use 'comp_ids' field alone to enumerate driver
- add comma to the end of entry in structure initialization
- keep the table of byt/cht/cml/icl untouched

V3 Changes:
- upstreamd from SOF github, PR#3200
- use new compatiable IDs to shrink the enumerate table of BYT and CHT
- add 'const' to snd_soc_acpi_codecs structures

V4 Changes:
- add signoff to patch 4~6

Brent Lu (3):
  ASoC: soc-acpi: add comp_ids field for machine driver matching
  ASoC: Intel: sof_rt5682: detect codec variant in probe function
  ASoC: Intel: sof_rt5682: use comp_ids to enumerate rt5682s

Pierre-Louis Bossart (3):
  ASoC: Intel: soc-acpi-byt: shrink tables using compatible IDs
  ASoC: Intel: soc-acpi-cht: shrink tables using compatible IDs
  ASoC: Intel: soc-acpi: use const for all uses of snd_soc_acpi_codecs

 include/sound/soc-acpi.h                      |  3 +
 sound/soc/intel/boards/sof_rt5682.c           | 34 ++-------
 .../intel/common/soc-acpi-intel-adl-match.c   | 11 ++-
 .../intel/common/soc-acpi-intel-bxt-match.c   |  2 +-
 .../intel/common/soc-acpi-intel-byt-match.c   | 68 +++++++-----------
 .../intel/common/soc-acpi-intel-cht-match.c   | 69 +++++++------------
 .../intel/common/soc-acpi-intel-cml-match.c   |  8 +--
 .../intel/common/soc-acpi-intel-glk-match.c   |  2 +-
 .../intel/common/soc-acpi-intel-jsl-match.c   | 43 ++++--------
 .../intel/common/soc-acpi-intel-kbl-match.c   | 12 ++--
 .../intel/common/soc-acpi-intel-skl-match.c   |  2 +-
 .../intel/common/soc-acpi-intel-tgl-match.c   | 11 ++-
 sound/soc/soc-acpi.c                          | 24 ++++++-
 13 files changed, 119 insertions(+), 170 deletions(-)

-- 
2.25.1

