Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A27A32A28C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381587AbhCBIFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:05:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:13743 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381488AbhCBHw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:52:57 -0500
IronPort-SDR: 3X9utV5MQ6HhMoYOKwzMRBPUCRAiNybbPwbAY8eUk1+9kk+IxNtEAM26LlSXH1infjkFitKZzU
 mjU4KgjqqHJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186782220"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="186782220"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 23:51:09 -0800
IronPort-SDR: 6RbV4hktqVLxK4m9qsZBCzwonRlqfOBgJvEbq5XzAR0Y+pHALuGYzTPTRMrTi928iYv92cZjkg
 jsn+hZGOVYfQ==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="406597558"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 23:51:05 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 0/3] soundwire: add DMI quirks for overridind addr
Date:   Tue,  2 Mar 2021 15:51:02 +0800
Message-Id: <20210302075105.11515-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform firmware may have incorrect _ADR values causing the driver
probes to fail. Adding the override_ops allows people to override the
addr values.

v2:
 - Add the override_adr ops
 - Move DMI quirks to a new file

Pierre-Louis Bossart (2):
  soundwire: Intel: introduce DMI quirks for HP Spectre x360 Convertible
  soundwire: Intel: add DMI quirk for Dell SKU 0A3E

Vinod Koul (1):
  soundwire: add override addr ops

 drivers/soundwire/Makefile     |  2 +-
 drivers/soundwire/bus.h        |  2 +
 drivers/soundwire/dmi-quirks.c | 96 ++++++++++++++++++++++++++++++++++
 drivers/soundwire/intel.c      |  1 +
 drivers/soundwire/slave.c      |  8 ++-
 include/linux/soundwire/sdw.h  |  4 +-
 6 files changed, 110 insertions(+), 3 deletions(-)
 create mode 100644 drivers/soundwire/dmi-quirks.c

-- 
2.17.1

