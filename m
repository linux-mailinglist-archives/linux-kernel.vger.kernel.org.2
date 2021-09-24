Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41163417D07
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347634AbhIXVdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:33:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:37403 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347527AbhIXVdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:33:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10117"; a="285183558"
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="285183558"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 14:32:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="704324501"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2021 14:32:00 -0700
Received: from debox1-server.jf.intel.com (debox1-server.jf.intel.com [10.54.39.121])
        by linux.intel.com (Postfix) with ESMTP id AFA1258096C;
        Fri, 24 Sep 2021 14:31:57 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com,
        andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        srinivas.pandruvada@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/2] Documentation: Update ioctl-number.rst for Intel Software Defined Silicon interface
Date:   Fri, 24 Sep 2021 14:31:56 -0700
Message-Id: <20210924213157.3584061-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserve ioctl number and range for the Intel Software Defined Silicon
driver.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 2e8134059c87..2a6e92639cdb 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -363,6 +363,7 @@ Code  Seq#    Include File                                           Comments
 0xDB  00-0F  drivers/char/mwave/mwavepub.h
 0xDD  00-3F                                                          ZFCP device driver see drivers/s390/scsi/
                                                                      <mailto:aherrman@de.ibm.com>
+0xDF  all    linux/isdsi_if.h
 0xE5  00-3F  linux/fuse.h
 0xEC  00-01  drivers/platform/chrome/cros_ec_dev.h                   ChromeOS EC driver
 0xF3  00-3F  drivers/usb/misc/sisusbvga/sisusb.h                     sisfb (in development)
-- 
2.25.1

