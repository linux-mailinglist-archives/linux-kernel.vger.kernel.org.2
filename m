Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8719363B08
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 07:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhDSF1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 01:27:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:44552 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhDSF1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 01:27:47 -0400
IronPort-SDR: Ee51u6DO0cPLpck0FoH/f/R1uAVVECYpedKPXm7MuB5JZsytfTlGpzFDlnBTNC9EutW7nniJjo
 vKHzuUUv7m4A==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="193147296"
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="193147296"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 22:27:17 -0700
IronPort-SDR: GUo2Fc2DtIux661H0B5bDXL7JJgDuHUt8iwz5tvO0A71MBCMcCvQauoesBxinNHK08ULXlj2n0
 JzBC6NPMn1yQ==
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="426370589"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 22:27:14 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/4] soundwire: only use CLOCK_STOP_MODE0 and handle -ENODATA
Date:   Mon, 19 Apr 2021 13:26:59 +0800
Message-Id: <20210419052703.2782-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing devices and implementations only support the required
CLOCK_STOP_MODE0. All the code related to CLOCK_STOP_MODE1 has not
been tested and is highly questionable, with a clear confusion between
CLOCK_STOP_MODE1 and the simple clock stop state machine.

This patch removes all usages of CLOCK_STOP_MODE1 - which has no
impact on any solution - and fixes the use of the simple clock stop
state machine. The resulting code should be a lot more symmetrical and
easier to maintain.

Note that CLOCK_STOP_MODE1 is not supported in the SoundWire Device
Class specification so it's rather unlikely that we need to re-add
this mode later.

If a device lost sync and can no longer ACK a command, it may not be
able to enter a lower-power state but it will still be able to resync
when the clock restarts. In those cases, we want to continue with the
clock stop sequence.

This patch modifies the behavior during clock stop sequences to only
log errors unrelated to -ENODATA/Command_Ignored. The flow is also
modified so that loops continue to prepare/deprepare other devices
even when one seems to have lost sync.

When resuming the clocks, all issues are logged with a dev_warn(),
previously only some of them were checked. This is the only part that
now differs between the clock stop entry and clock stop exit
sequences: while we don't want to stop the suspend flow, we do want
information on potential issues while resuming, as they may have
ripple effects.

For consistency the log messages are also modified to be unique and
self-explanatory. Errors in sdw_slave_clk_stop_callback() were
removed, they are now handled in the caller.

Pierre-Louis Bossart (4):
  soundwire: bus: only use CLOCK_STOP_MODE0 and fix confusions
  soundwire: add missing kernel-doc description
  soundwire: bus: handle -ENODATA errors in clock stop/start sequences
  soundwire: bus: add missing \n in dynamic debug

 drivers/soundwire/bus.c       | 155 +++++++++++++++-------------------
 include/linux/soundwire/sdw.h |   3 +-
 2 files changed, 70 insertions(+), 88 deletions(-)

-- 
2.17.1

