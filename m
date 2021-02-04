Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4234D30A19E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 06:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhBAFsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 00:48:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:18860 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhBAFpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 00:45:22 -0500
IronPort-SDR: L8tueSMKodp4mWVDM79ITvmVwqwJgOdXTR3ab7B3e2O7tmI+6GEugh9Lc6gRLLpcJI5Q4Il/C2
 u6RHigW27/Sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="177129268"
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="scan'208";a="177129268"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2021 21:42:48 -0800
IronPort-SDR: PLphEVLiZVB9bAjv1uXDE6J3QX7nlD9kyHW+EUhi0kqwN0sytb+TZSxJTiQwTflZIgck05kJgU
 yproivahxrbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="scan'208";a="368973525"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jan 2021 21:42:46 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com
Subject: [PATCH v10 2/2] Documentation: fpga: dfl: Add description for DFL UIO support
Date:   Mon,  1 Feb 2021 13:38:03 +0800
Message-Id: <1612157883-18616-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612157883-18616-1-git-send-email-yilun.xu@intel.com>
References: <1612157883-18616-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds description for UIO support for dfl devices on DFL
bus.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v2: no doc in v1, add it for v2.
v3: some documentation fixes.
v4: documentation change since the driver matching is changed.
v5: no change.
v6: improve the title of the userspace driver support section.
    some word improvement.
v7: rebased to next-20210119
v8: some doc fixes.
v9: some doc change since we switch to the driver in drivers/uio.
v10: no change.
---
 Documentation/fpga/dfl.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index c41ac76..e35cf87 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -7,6 +7,7 @@ Authors:
 - Enno Luebbers <enno.luebbers@intel.com>
 - Xiao Guangrong <guangrong.xiao@linux.intel.com>
 - Wu Hao <hao.wu@intel.com>
+- Xu Yilun <yilun.xu@intel.com>
 
 The Device Feature List (DFL) FPGA framework (and drivers according to
 this framework) hides the very details of low layer hardwares and provides
@@ -530,6 +531,28 @@ Being able to specify more than one DFL per BAR has been considered, but it
 was determined the use case did not provide value.  Specifying a single DFL
 per BAR simplifies the implementation and allows for extra error checking.
 
+
+Userspace driver support for DFL devices
+========================================
+The purpose of an FPGA is to be reprogrammed with newly developed hardware
+components. New hardware can instantiate a new private feature in the DFL, and
+then present a DFL device in the system. In some cases users may need a
+userspace driver for the DFL device:
+
+* Users may need to run some diagnostic test for their hardware.
+* Users may prototype the kernel driver in user space.
+* Some hardware is designed for specific purposes and does not fit into one of
+  the standard kernel subsystems.
+
+This requires direct access to MMIO space and interrupt handling from
+userspace. The uio_dfl module exposes the UIO device interfaces for this
+purpose.
+
+UIO_DFL should be selected to enable the uio_dfl module driver. To support a
+new DFL feature via UIO direct access, its feature id should be added to the
+driver's id_table.
+
+
 Open discussion
 ===============
 FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
-- 
2.7.4

