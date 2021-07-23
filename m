Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4CD3D39C9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbhGWLOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:14:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:17835 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234255AbhGWLOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:14:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="211921779"
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="211921779"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 04:55:02 -0700
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="455069739"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 04:54:59 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 0/6] soundwire/ASoC: abstract platform-dependent bases
Date:   Fri, 23 Jul 2021 19:54:45 +0800
Message-Id: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shim base and alh base are platform-dependent. This series suggests
to use variables for those bases. It allows us to use different bases
for new platforms.

v2:
 - Update the commit message of "soundwire: move intel sdw register
   definitions to sdw_intel.h"

Bard Liao (6):
  soundwire: move intel sdw register definitions to sdw_intel.h
  ASoC: SOF: intel: add sdw_shim/alh_base to sof_intel_dsp_desc
  ASoC: SOF: intel: hda: remove HDA_DSP_REG_SNDW_WAKE_STS definition
  ASoC: SOF: intel: move sof_intel_dsp_desc() forward
  ASoC: SOF: intel: add snd_sof_dsp_check_sdw_irq ops
  soundwire: intel: introduce shim and alh base

 drivers/soundwire/intel.c           | 74 ------------------------
 drivers/soundwire/intel_init.c      | 14 ++---
 include/linux/soundwire/sdw_intel.h | 87 +++++++++++++++++++++++++++++
 sound/soc/sof/intel/cnl.c           |  6 ++
 sound/soc/sof/intel/hda.c           | 39 ++++++++-----
 sound/soc/sof/intel/hda.h           |  8 ++-
 sound/soc/sof/intel/icl.c           |  3 +
 sound/soc/sof/intel/shim.h          |  3 +
 sound/soc/sof/intel/tgl.c           | 12 ++++
 9 files changed, 149 insertions(+), 97 deletions(-)

-- 
2.17.1

