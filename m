Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56115334253
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhCJQBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:01:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:37100 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232422AbhCJQAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:00:46 -0500
IronPort-SDR: mUJc01wdbTZ7rPafsW2VQx1IIpLFLiPuV7LRTZQ86pB1l773fEKmX/3Xu5QTVK4gjOVvE7cbZn
 +h+ooc2b/IuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186119198"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="186119198"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:00:45 -0800
IronPort-SDR: c3Em6UwgdQORPKfSlHW5FSPoTRq1Xcu+o7kPKqpxWjt0E4Zk00PCtgWioBTjN4qD0FM9t87OHS
 vki+CITjT84g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="588877263"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2021 08:00:41 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v4 0/4] Some improvement for Intel MAX 10 MFD drivers
Date:   Wed, 10 Mar 2021 23:55:44 +0800
Message-Id: <1615391748-1733-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is some improvements for intel-m10-bmc and its subdevs.

Main changes from v1:
- Add a patch (#2) to simplify the definition of the legacy version reg.
- Add a patch (#4), add entry in MAINTAINERS for intel-m10-bmc mfd driver
  and the subdev drivers.

Main changes from v2:
- Add Tom Rix as the reviewer for intel-m10-bmc mfd driver and the subdev
  drivers.
- Rebased to 5.12-rc1

Main changes from v3:
- Improve the comments for valid version check.


Matthew Gerlach (1):
  mfd: intel-m10-bmc: Add access table configuration to the regmap

Xu Yilun (3):
  mfd: intel-m10-bmc: Fix the register access range
  mfd: intel-m10-bmc: Simplify the legacy version reg definition
  MAINTAINERS: Add entry for Intel MAX 10 mfd driver

 MAINTAINERS                       | 10 ++++++++++
 drivers/mfd/intel-m10-bmc.c       | 30 ++++++++++++++++++++----------
 include/linux/mfd/intel-m10-bmc.h |  7 +++++--
 3 files changed, 35 insertions(+), 12 deletions(-)

-- 
2.7.4

