Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495E2334257
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhCJQBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:01:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:32101 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233119AbhCJQBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:01:07 -0500
IronPort-SDR: hmK99BL07zBhwjLNJkk4BWtYQ9vYncVodK9JmgSR0S702clyIfpDNUJBKEGmd+0xjtldQapB+R
 wLHV//SS8Whg==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="167770855"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="167770855"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:01:03 -0800
IronPort-SDR: dkyarsPMcCxFBFOq0lNb4NpH5EkLPnOFyczkp2MctjrdO3fT3kMq/OHrZuuCFBHjHhBzs7ZdA9
 GIJaMOpW8L9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="588877475"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2021 08:01:01 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v4 4/4] MAINTAINERS: Add entry for Intel MAX 10 mfd driver
Date:   Wed, 10 Mar 2021 23:55:48 +0800
Message-Id: <1615391748-1733-5-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615391748-1733-1-git-send-email-yilun.xu@intel.com>
References: <1615391748-1733-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds maintainer info for Intel MAX 10 mfd driver.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v3: Add Tom Rix as the reviewer.
v4: Add Lee's Acked-by, no other change.
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b58a469..ab31c01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9116,6 +9116,16 @@ F:	include/linux/mei_cl_bus.h
 F:	include/uapi/linux/mei.h
 F:	samples/mei/*
 
+INTEL MAX 10 BMC MFD DRIVER
+M:	Xu Yilun <yilun.xu@intel.com>
+R:	Tom Rix <trix@redhat.com>
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
+F:	Documentation/hwmon/intel-m10-bmc-hwmon.rst
+F:	drivers/hwmon/intel-m10-bmc-hwmon.c
+F:	drivers/mfd/intel-m10-bmc.c
+F:	include/linux/mfd/intel-m10-bmc.h
+
 INTEL MENLOW THERMAL DRIVER
 M:	Sujith Thomas <sujith.thomas@intel.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.7.4

