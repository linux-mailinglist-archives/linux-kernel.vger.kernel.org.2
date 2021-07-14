Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390453C7CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 05:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbhGNDZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 23:25:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:9187 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237641AbhGNDZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 23:25:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="210095732"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="210095732"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 20:22:22 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="459818090"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 20:22:19 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 00/10] soundwire/ASoC: add mockup codec support
Date:   Wed, 14 Jul 2021 11:21:59 +0800
Message-Id: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding mockup SoundWire codec is useful to debug driver/topology changes
without having any actual device connected.

Bard Liao (2):
  soundwire: stream: don't abort bank switch on Command_Ignored/-ENODATA
  soundwire: stream: don't program mockup device ports

Pierre-Louis Bossart (8):
  ASoC: codecs: add SoundWire mockup device support
  ASoC: soc-acpi: cnl: add table for SoundWire mockup devices
  ASoC: soc-acpi: tgl: add table for SoundWire mockup devices
  ASoC: Intel: boards: sof_sdw: add SoundWire mockup codecs for tests
  soundwire: add flag to ignore all command/control for mockup devices
  soundwire: bus: squelch error returned by mockup devices
  soundwire: cadence: add debugfs interface for PDI loopbacks
  soundwire: cadence: override PDI configurations to create loopback

 drivers/soundwire/bus.c                       |  10 +-
 drivers/soundwire/cadence_master.c            | 174 ++++++++--
 drivers/soundwire/cadence_master.h            |   3 +
 drivers/soundwire/stream.c                    |   5 +-
 include/linux/soundwire/sdw.h                 |   3 +
 sound/soc/codecs/Kconfig                      |  18 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/sdw-mockup.c                 | 312 ++++++++++++++++++
 sound/soc/intel/boards/Kconfig                |   1 +
 sound/soc/intel/boards/sof_sdw.c              |  41 +++
 sound/soc/intel/common/Makefile               |   3 +-
 .../intel/common/soc-acpi-intel-cnl-match.c   |  15 +
 .../common/soc-acpi-intel-sdw-mockup-match.c  | 166 ++++++++++
 .../common/soc-acpi-intel-sdw-mockup-match.h  |  17 +
 .../intel/common/soc-acpi-intel-tgl-match.c   |  23 ++
 15 files changed, 754 insertions(+), 39 deletions(-)
 create mode 100644 sound/soc/codecs/sdw-mockup.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-sdw-mockup-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-sdw-mockup-match.h

-- 
2.17.1

