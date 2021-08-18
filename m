Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F023EF839
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 04:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbhHRCuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 22:50:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:5298 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231449AbhHRCut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 22:50:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="215969425"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="215969425"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 19:50:15 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="520723283"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 19:50:12 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: [PATCH v2 0/3] soundwire: intel: exit clock-stop mode before system suspend
Date:   Wed, 18 Aug 2021 10:49:51 +0800
Message-Id: <20210818024954.16873-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel validation reported an issue where the HW_RST self-clearing bit
is not cleared in hardware, which as a ripple effect creates issues
with the clock stop mode.

This happens is a specific sequence where the Intel manager is
pm_runtime suspended with the clock-stop mode enabled. During the
system suspend, we currently do nothing, which can lead to potential
issues on system resume and the following pm_runtime suspend,
depending on the hardware state.

This patch suggests a full resume if the clock-stop mode is used. This
may require extra time but will make the suspend/resume flows
completely symmetric. This also removes a race condition where we
could not access SHIM registers if the parent was suspended as
well. Resuming the link also resumes the parent by construction.

BugLink: https://github.com/thesofproject/linux/issues/2606

v2:
 - Better comments and commit messages.
 - Modified the .prepare callback to only deal with the corner case that is
   NOT covered today instead of systematically doing a full resume.

Pierre-Louis Bossart (3):
  soundwire: intel: fix potential race condition during power down
  soundwire: intel: skip suspend/resume/wake when link was not started
  soundwire: intel: conditionally exit clock stop mode on system suspend

 drivers/soundwire/intel.c | 150 ++++++++++++++++++++++++++++++--------
 drivers/soundwire/intel.h |   1 +
 2 files changed, 119 insertions(+), 32 deletions(-)

-- 
2.17.1

