Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8852C44010C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhJ2RS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:18:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:3541 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhJ2RS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:18:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="294170684"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="294170684"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 10:15:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="598276447"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.1])
  by orsmga004.jf.intel.com with ESMTP; 29 Oct 2021 10:15:52 -0700
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
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        linux-kernel@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        Libin Yang <libin.yang@intel.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Gongjun Song <gongjun.song@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v5 0/6] Multiple headphone codec driver support
Date:   Sat, 30 Oct 2021 01:14:03 +0800
Message-Id: <20211029171409.611600-1-brent.lu@intel.com>
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

V5 Changes:
- none, just rebase for patch 3 conflict

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

