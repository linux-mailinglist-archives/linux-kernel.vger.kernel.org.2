Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A9C32A30E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377961AbhCBIp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:45:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:8982 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377824AbhCBI3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:29:10 -0500
IronPort-SDR: r7LSjGVVqKtZx1bB/c4dzVNOBGfn++MNPB+T5Ai9WmqcX6Inu/mxeyb0wMXBtv3WDb2FZJwU2h
 KsWmrv1JRUTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="183340379"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="183340379"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 00:27:23 -0800
IronPort-SDR: FELPuuSxJMRfmBQIfF71vfY8TV+Wl4uWBHOM9QLs+JL1hUuXr3WcQrBBAF9OHmkODhb/knIpE9
 MDiwUHji5Btg==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="406613386"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 00:27:19 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 0/3] soundwire: clear bus clash/parity interrupt before the mask is enabled
Date:   Tue,  2 Mar 2021 16:27:17 +0800
Message-Id: <20210302082720.12322-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoundWire specification allows a Slave device to report a bus clash
or parity error with the in-band interrupt mechanism.
Unfortunately, on some platforms, these errors are randomly reported and
don't seem to be valid.
This series suggests the addition of a Master level quirk to discard such
interrupts. The quirk should in theory have been added at the Slave level,
but since the problem was detected with different generations of Slave
devices it's hard to point to a specific IP. The problem might also be
board-dependent and hence dealing with a Master quirk is simpler.

v2:
 - Reorder the patches sequence.
 - Add comments about each quirk.
 - Use u64 quirks.


Bard Liao (3):
  soundwire: add master quirks for bus clash and parity
  soundwire: bus: handle master quirks for bus clash and parity
  soundwire: intel: add master quirks for bus clash and parity

 drivers/soundwire/bus.c       | 39 +++++++++++++++++++++++++++++++++++
 drivers/soundwire/intel.c     |  3 +++
 include/linux/soundwire/sdw.h | 22 ++++++++++++++++++++
 3 files changed, 64 insertions(+)

-- 
2.17.1

