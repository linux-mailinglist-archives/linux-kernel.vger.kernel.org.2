Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9948C44CEAE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 02:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhKKBQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 20:16:41 -0500
Received: from mga06.intel.com ([134.134.136.31]:54337 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232179AbhKKBQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:16:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="293652766"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="293652766"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 17:13:51 -0800
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="602427994"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.236.115])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 17:13:50 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com, ardb@kernel.org,
        bjorn.andersson@linaro.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [RFC PATCH 0/5] Firmware Upload Framework
Date:   Wed, 10 Nov 2021 17:13:40 -0800
Message-Id: <20211111011345.25049-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Firmware Upload framework provides a common API for uploading firmware
files to target devices. An example use case involves FPGA devices that
load FPGA, Card BMC, and firmware images from FLASH when the card boots.
Users need the ability to update these firmware images while the card is
in use.

Device drivers that instantiate the Firmware Upload class driver will
interact with the target device to transfer and authenticate the firmware
data. Uploads are performed in the context of a kernel worker thread in
order to facilitate progress indicators during lengthy uploads.

This driver was previously submitted in the context of the FPGA sub-
system as the "FPGA Image Load Framework", but the framework is generic
enough to support other devices as well. The previous submission of this
patch-set can be viewed here:

https://marc.info/?l=linux-kernel&m=163295640216820&w=2

The n3000bmc-sec-update driver is the first driver to use the Firmware
Upload API. A recent version of these patches can be viewed here:

https://marc.info/?l=linux-kernel&m=163295697217095&w=2

I don't think I am duplicating any functionality that is currently covered
in the firmware subsystem. I appreciate your feedback on these patches.

- Russ

Russ Weight (5):
  firmware: Create firmware upload framework
  firmware: upload: Enable firmware uploads
  firmware: upload: Signal eventfd when complete
  firmware: upload: Add status ioctl
  firmware: upload: Enable cancel of firmware upload

 .../driver-api/firmware/firmware-upload.rst   |  54 +++
 Documentation/driver-api/firmware/index.rst   |   1 +
 MAINTAINERS                                   |   9 +
 drivers/firmware/Kconfig                      |   8 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/firmware-upload.c            | 413 ++++++++++++++++++
 include/linux/firmware/firmware-upload.h      |  69 +++
 include/uapi/linux/firmware-upload.h          |  73 ++++
 8 files changed, 628 insertions(+)
 create mode 100644 Documentation/driver-api/firmware/firmware-upload.rst
 create mode 100644 drivers/firmware/firmware-upload.c
 create mode 100644 include/linux/firmware/firmware-upload.h
 create mode 100644 include/uapi/linux/firmware-upload.h

-- 
2.25.1

