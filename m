Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F3834A3F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhCZJPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:15:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:23494 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhCZJPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:15:36 -0400
IronPort-SDR: JFO/Qh8pSlwamznYkqhx7/nj6WgghTthPE1f9V65b4tVJk2EXHs5ovJNOj7e7K7ZFE6rh3jhsd
 3loBg3wAVvAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="211269553"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="211269553"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:27 -0700
IronPort-SDR: bIPOm3R/3K2MdsaNAp5lh76tGzPU1ypOgvwIw0Wu+MnXshM9vEAY6scQGy2URBZIMLBAVT7U5W
 NR34V3WZVJnA==
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="416463072"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:23 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH 00/11] soundwire: some cleanup patches
Date:   Fri, 26 Mar 2021 17:15:03 +0800
Message-Id: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make soundwire driver more decent and less Cppcheck complaint.

Pierre-Louis Bossart (11):
  soundwire: bus: use correct driver name in error messages
  soundwire: bus: test read status
  soundwire: bus: use consistent tests for return values
  soundwire: bus: demote clock stop prepare log to dev_dbg()
  soundwire: bus: uniquify dev_err() for SCP_INT access
  soundwire: bus: remove useless initialization
  soundwire: generic_bandwidth_allocation: remove useless init
  soundwire: intel: remove useless readl
  soundwire: qcom: check of_property_read status
  soundwire: stream: remove useless initialization
  soundwire: stream: remove useless bus initializations

 drivers/soundwire/bus.c                       | 54 +++++++++++--------
 drivers/soundwire/bus_type.c                  | 15 ++++--
 .../soundwire/generic_bandwidth_allocation.c  |  4 +-
 drivers/soundwire/intel.c                     |  2 -
 drivers/soundwire/qcom.c                      |  3 ++
 drivers/soundwire/stream.c                    |  8 +--
 6 files changed, 52 insertions(+), 34 deletions(-)

-- 
2.17.1

