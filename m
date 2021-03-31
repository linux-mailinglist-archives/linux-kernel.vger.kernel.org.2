Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5CE34F5FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhCaBOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:14:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:50710 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233144AbhCaBOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:14:11 -0400
IronPort-SDR: O31BfbeK3RRdeiATzXjfz4Oh8Gqd7m1eVYwgrhaOOw6Slw+zbA+JRSwEc74m3Z9IY6GX2YhsP0
 3YMLhbxBG0mQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179020185"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="179020185"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 18:14:11 -0700
IronPort-SDR: MzsrEQo7I1AypxZhMjlEiHsNJMiukxVdmvKyyukMSeudJQQ8ZmMMQj0Y2+s7PmTbeljyg1v0FA
 m3O5Xi6sAZDA==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="418414692"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 18:14:08 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/2] soundwire: bus: handle errors in clock stop/start sequences
Date:   Wed, 31 Mar 2021 09:13:53 +0800
Message-Id: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a device lost sync and can no longer ACK a command, it may not be
able to enter a lower-power state but it will still be able to resync
when the clock restarts. In those cases, we want to continue with the
clock stop sequence.

This patch modifies the behavior when -ENODATA is received, with the
error level demoted to a dev_dbg() since it's a recoverable issue.

For consistency the log messages are also modified to be unique and
self-explanatory, and missing logs are also added on clock stop exit.

Pierre-Louis Bossart (2):
  soundwire: add macro to selectively change error levels
  soundwire: bus: handle errors in clock stop/start sequences

 drivers/soundwire/bus.c | 70 +++++++++++++++++++----------------------
 drivers/soundwire/bus.h |  8 +++++
 2 files changed, 40 insertions(+), 38 deletions(-)

-- 
2.17.1

