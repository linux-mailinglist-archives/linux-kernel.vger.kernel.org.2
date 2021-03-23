Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B8A345456
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhCWA7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:59:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:63366 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230450AbhCWA7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:59:07 -0400
IronPort-SDR: 69OdcKGZLV6mxHJZ9g4JUBRuTN/5Hm4aTtGE/XQznzHv8HFXasV4XaK20bmcHFfdQktl/LSwcJ
 tsl7jQJlo6MQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="188061141"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="188061141"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 17:59:06 -0700
IronPort-SDR: ZdKNzNMz8SYQ1t8eRal3511rk5tunH7tqDiwiuAf5DnLxi2fCyQ3SWLTmB+/5qt18wpCdvVuau
 f3d0aXGnrN/A==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="414728307"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 17:59:02 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/5] soundwire: add missing \n in dev_err()
Date:   Tue, 23 Mar 2021 08:58:50 +0800
Message-Id: <20210323005855.20890-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We fixed a lot of warnings in 2019 but the magic of copy-paste keeps
adding new ones...

Pierre-Louis Bossart (5):
  soundwire: intel: add missing \n in dev_err()
  soundwire: bandwidth_allocation: add missing \n in dev_err()
  soundwire: cadence: add missing \n in dev_err()
  soundwire: stream: add missing \n in dev_err()
  soundwire: qcom: add missing \n in dev_err()

 drivers/soundwire/cadence_master.c             |  2 +-
 .../soundwire/generic_bandwidth_allocation.c   |  4 ++--
 drivers/soundwire/intel.c                      | 18 +++++++++---------
 drivers/soundwire/qcom.c                       |  2 +-
 drivers/soundwire/stream.c                     | 10 +++++-----
 5 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.17.1

