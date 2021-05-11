Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023EA379D42
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhEKDCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:02:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:8772 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKDCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:02:06 -0400
IronPort-SDR: muRLHeaTOTXqRLrNXPnjpqAcFzUlkts4zzlETKVn+3cl61v8Tb5Q2no9gEgOy1Ky8x89/aeEMH
 DB/SnBARCtsA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199393416"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="199393416"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 20:01:00 -0700
IronPort-SDR: U441RXw6BwKX8wnS0lMwj7Bifgeu7KPZHz3b6+YHjN9iYDpx7bZsLWyeBhf9IJPyAan013Fn2T
 nUJNdA72KIyg==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="436431103"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 20:00:57 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH 0/4] soundwire: only use CLOCK_STOP_MODE0 and handle -ENODATA errors in clock stop/start sequences
Date:   Tue, 11 May 2021 11:00:44 +0800
Message-Id: <20210511030048.25622-1-yung-chuan.liao@linux.intel.com>
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

