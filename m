Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EF437F48D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhEMI7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:59:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:47029 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232285AbhEMI7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:59:11 -0400
IronPort-SDR: Ge4mtf0cn6lSYAhWnhiJXhJVX9ivVdxTCxK2HBZKYvyo3vgMW9HrbPwTxK1bUlmXqpD/OONynx
 +BFbM8E60cqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187032230"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187032230"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 01:58:00 -0700
IronPort-SDR: BAcoaDI44qVcI+FFyL+H50gdAaRjrqFFVgW2+h0lTSQZKgMnBVrpcERcuc4QH7AX1LkrqN3uSX
 hT3mP2jOkkCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625928216"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2021 01:57:58 -0700
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com,
        guy.zadicario@intel.com
Subject: [PATCH v2 00/15] misc: nnpi: New PCIe driver for Intel's NNP-I pcie device
Date:   Thu, 13 May 2021 11:57:10 +0300
Message-Id: <20210513085725.45528-1-guy.zadicario@intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series is a driver for a new PCIe device from Intel named NNP-I
(Nirvana Neural Processor for Inference). NNP-I is a PCIe connected compute
device used for acceleration of AI deep learning inference applications in the
data-center.

The reason that this driver should be in the kernel is that it aims to serve
multiple users and user-space applications which might share the same NNP-I
card. Workloads from multiple applications can be processed simultanously by
the NNP-I card if enough compute resources exist.

Overview of the NNP-I device, driver structure and ABIs used in the driver is in
patch#1, which adds the info as a document as it might be a useful info for
anyone trying to understand the driver even past review.

In order to ease the review process, there will be multiple series for the
entire driver code. This is the first series, and it implements everything
necessary to initialize the NNP-I device and allow a user-space inference
application to use it. Other features, which are mostly related to maintenance,
device status visibility and error-handling, will be submitted on the next stage.

A basic user-space library and test application which illustrates the flow of
an NNP-I inference application can be found here: https://github.com/IntelAI/nnpi-host
(This series is enough for the test application to run)

This patchset has gone through internal review inside Intel, the summary of the
change log from the internal review follows.

I would appreciate any feedback, questions or comments to this series.

Changes in v2:
    - Removed email disclaimer added to the end of each patch.
    - Small fix to Kconfig requested by Randy
    - Removed from this cover letter the long Intel internal pre-review change
      log of this patchset.

Link to v1 cover letter: https://lwn.net/Articles/856037/

Guy Zadicario (15):
  misc: nnpi: Document NNP-I's driver overview
  misc: nnpi: Initialize NNP-I framework and PCIe modules
  misc: nnpi: Manage and schedule messages to device
  misc: nnpi: Define host/card ipc protocol
  misc: nnpi: Manage host memory resources
  misc: nnpi: Allow usermode to manage host resources
  misc: nnpi: Disallow host memory resource access if no NNP-I devices
    exist
  misc: nnpi: Boot NNP-I device
  misc: nnpi: Process device response messages
  misc: nnpi: Query and verify device protocol
  misc: nnpi: Create comm channel from app to device
  misc: nnpi: Route device response messages
  misc: nnpi: Expose command channel file interface
  misc: nnpi: Create command channel from userspace
  misc: nnpi: Map host resources to device channel

 Documentation/ABI/testing/sysfs-driver-intel_nnpi  |    5 +
 Documentation/misc-devices/index.rst               |    1 +
 Documentation/misc-devices/intel-nnpi.rst          |  237 +++++
 MAINTAINERS                                        |    6 +
 drivers/misc/Kconfig                               |    1 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/intel-nnpi/Kconfig                    |   18 +
 drivers/misc/intel-nnpi/Makefile                   |   13 +
 drivers/misc/intel-nnpi/bootimage.c                |  246 +++++
 drivers/misc/intel-nnpi/bootimage.h                |   43 +
 drivers/misc/intel-nnpi/cmd_chan.c                 |  790 ++++++++++++++
 drivers/misc/intel-nnpi/cmd_chan.h                 |  134 +++
 drivers/misc/intel-nnpi/device.c                   | 1081 ++++++++++++++++++++
 drivers/misc/intel-nnpi/device.h                   |  182 ++++
 drivers/misc/intel-nnpi/device_chardev.c           |  789 ++++++++++++++
 drivers/misc/intel-nnpi/device_chardev.h           |   14 +
 drivers/misc/intel-nnpi/host_chardev.c             |  353 +++++++
 drivers/misc/intel-nnpi/host_chardev.h             |   12 +
 drivers/misc/intel-nnpi/hostres.c                  |  627 ++++++++++++
 drivers/misc/intel-nnpi/hostres.h                  |  167 +++
 .../misc/intel-nnpi/ipc_include/ipc_c2h_events.h   |  198 ++++
 drivers/misc/intel-nnpi/ipc_include/ipc_protocol.h |  340 ++++++
 .../misc/intel-nnpi/ipc_include/nnp_boot_defs.h    |   71 ++
 drivers/misc/intel-nnpi/ipc_include/nnp_elbi.h     |   91 ++
 drivers/misc/intel-nnpi/msg_scheduler.c            |  319 ++++++
 drivers/misc/intel-nnpi/msg_scheduler.h            |  153 +++
 drivers/misc/intel-nnpi/nnp_pcie.c                 |  530 ++++++++++
 drivers/misc/intel-nnpi/nnp_user.c                 |  131 +++
 drivers/misc/intel-nnpi/nnp_user.h                 |   79 ++
 include/uapi/misc/intel_nnpi.h                     |  304 ++++++
 30 files changed, 6936 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_nnpi
 create mode 100644 Documentation/misc-devices/intel-nnpi.rst
 create mode 100644 drivers/misc/intel-nnpi/Kconfig
 create mode 100644 drivers/misc/intel-nnpi/Makefile
 create mode 100644 drivers/misc/intel-nnpi/bootimage.c
 create mode 100644 drivers/misc/intel-nnpi/bootimage.h
 create mode 100644 drivers/misc/intel-nnpi/cmd_chan.c
 create mode 100644 drivers/misc/intel-nnpi/cmd_chan.h
 create mode 100644 drivers/misc/intel-nnpi/device.c
 create mode 100644 drivers/misc/intel-nnpi/device.h
 create mode 100644 drivers/misc/intel-nnpi/device_chardev.c
 create mode 100644 drivers/misc/intel-nnpi/device_chardev.h
 create mode 100644 drivers/misc/intel-nnpi/host_chardev.c
 create mode 100644 drivers/misc/intel-nnpi/host_chardev.h
 create mode 100644 drivers/misc/intel-nnpi/hostres.c
 create mode 100644 drivers/misc/intel-nnpi/hostres.h
 create mode 100644 drivers/misc/intel-nnpi/ipc_include/ipc_c2h_events.h
 create mode 100644 drivers/misc/intel-nnpi/ipc_include/ipc_protocol.h
 create mode 100644 drivers/misc/intel-nnpi/ipc_include/nnp_boot_defs.h
 create mode 100644 drivers/misc/intel-nnpi/ipc_include/nnp_elbi.h
 create mode 100644 drivers/misc/intel-nnpi/msg_scheduler.c
 create mode 100644 drivers/misc/intel-nnpi/msg_scheduler.h
 create mode 100644 drivers/misc/intel-nnpi/nnp_pcie.c
 create mode 100644 drivers/misc/intel-nnpi/nnp_user.c
 create mode 100644 drivers/misc/intel-nnpi/nnp_user.h
 create mode 100644 include/uapi/misc/intel_nnpi.h

-- 
1.8.3.1

