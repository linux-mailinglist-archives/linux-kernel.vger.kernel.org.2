Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE2F32775F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 07:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhCAGHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 01:07:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:53894 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231530AbhCAGG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 01:06:29 -0500
IronPort-SDR: l6xlHlF/nHJ+upGDHXsnukHh+UrpoLBHT8yIfWL5e7CfAlSW6VbZm+cSCkHWQLnmZhc0rSKn7R
 Kppj9pSLMB8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="165599720"
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="scan'208";a="165599720"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 22:04:52 -0800
IronPort-SDR: pWxczETmz1ZRNneQcYKx+b/I3U8BD6HZyn35mDoYljhocUs+EvDnZI6QSQl/jMgk3BEGrBK3ER
 kn4Pqd3G7Rig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="scan'208";a="397574238"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 28 Feb 2021 22:04:50 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v3 4/4] MAINTAINERS: Add entry for Intel MAX 10 mfd driver
Date:   Mon,  1 Mar 2021 13:59:45 +0800
Message-Id: <1614578385-26955-5-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
References: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds maintainer info for Intel MAX 10 mfd driver.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v3: Add Tom Rix as the reviewer.
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

