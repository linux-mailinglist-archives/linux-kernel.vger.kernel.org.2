Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C65C389BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhETDSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:18:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:58818 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhETDSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:18:06 -0400
IronPort-SDR: gVuubufW9z4jvx3Umqw7n0rXiR0viC8MBmd38SAOKYmW9Z5cyeBqavfCF4YpOEoye1nAxzzgYU
 r4jvtuUmzMhQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286659600"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286659600"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 20:16:45 -0700
IronPort-SDR: 9k6sy+XDAQQIIPMCc053Z4fRy85gaC85Ws3ZQ027xLft/tNZj7auaK2Zfi/N5POPshW4WbBzp0
 cJ24R31Gf5rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395527153"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by orsmga006.jf.intel.com with ESMTP; 19 May 2021 20:16:41 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 00/11] Convert Intel IOMMU to use sva-lib helpers
Date:   Thu, 20 May 2021 11:15:20 +0800
Message-Id: <20210520031531.712333-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series converts the Intel IOMMU to use the generic sva
helpers defined in iommu-sva-lib.c and io-pgfault.c. It includes the
SVA pasid management and IO page fault handling.

This series could be divided into below parts:
PATCH[1~3]: Use iommu_sva_alloc/free_pasid() to manage the SVA pasid.
PATCH[4-6]: Use the generic sva io page fault handler iommu_queue_iopf.
PATCH[7-11]: Add ftrace and debugfs support for io page fault handling.

Please help to review.

Best regards,
baolu

Lu Baolu (11):
  iommu/vt-d: Add pasid private data helpers
  iommu/vt-d: Use iommu_sva_alloc(free)_pasid() helpers
  iommu/vt-d: Use common helper to lookup svm devices
  iommu/vt-d: Refactor prq_event_thread()
  iommu/vt-d: Allocate/register iopf queue for sva devices
  iommu/vt-d: Report prq to io-pgfault framework
  iommu/vt-d: Add prq_report trace event
  iommu/vt-d: Add common code for dmar latency performance monitors
  iommu/vt-d: Expose latency monitor data through debugfs
  iommu/vt-d: Add cache invalidation latency sampling
  iommu/vt-d: Add PRQ handling latency sampling

 include/linux/intel-iommu.h        |  33 +-
 drivers/iommu/intel/perf.h         |  73 ++++
 include/trace/events/intel_iommu.h |  37 ++
 drivers/iommu/intel/debugfs.c      | 111 +++++
 drivers/iommu/intel/dmar.c         |  31 ++
 drivers/iommu/intel/iommu.c        |  73 +++-
 drivers/iommu/intel/perf.c         | 166 ++++++++
 drivers/iommu/intel/svm.c          | 627 ++++++++++++++---------------
 drivers/iommu/intel/Kconfig        |   5 +
 drivers/iommu/intel/Makefile       |   1 +
 10 files changed, 819 insertions(+), 338 deletions(-)
 create mode 100644 drivers/iommu/intel/perf.h
 create mode 100644 drivers/iommu/intel/perf.c

-- 
2.25.1

