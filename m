Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7220543C93F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbhJ0MMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:12:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:22295 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235323AbhJ0MMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:12:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="227600306"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="227600306"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 05:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="486649975"
Received: from dev01.bj.intel.com ([10.238.158.57])
  by orsmga007.jf.intel.com with ESMTP; 27 Oct 2021 05:09:38 -0700
From:   Huaisheng Ye <huaisheng.ye@intel.com>
To:     dan.j.williams@intel.com, hch@lst.de, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huaisheng Ye <huaisheng.ye@intel.com>
Subject: [PATCH 0/4] add ro state control function for nvdimm drivers
Date:   Wed, 27 Oct 2021 20:09:33 +0800
Message-Id: <20211027120937.1163744-1-huaisheng.ye@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

libndctl failed to pass for the reason of writing pmem disk when running
ndctl testing.

Here is the error message below,

    namespace6.0: failed to write /dev/pmem6
    check_namespaces: namespace6.0 validate_bdev failed
    ndctl-test1 failed: -6

Commit 98f49b63e84d4ee1a5c327d0b5f4e8699f6c70fe removes set_device_ro and
e00adcadf3af7a8335026d71ab9f0e0a922191ac adds a new set_read_only method
to allow for driver-specific processing when changing the block device's
read-only state.

Current drivers nd_pmem, nd_blk and nd_btt don't have the capability to
enable or disable write protect (read-only) state. Without that,
blkdev_roset just modifies the value of bd_read_only of struct block_device
and returns success to ioctl of block device. Error would happen when writing
read-only disk next.

Add ro state control function in libnvdimm for this purpose, and implement
set_read_only for BLKROSET.

Huaisheng Ye (4):
  libnvdimm: add a ro state control function for nvdimm
  libnvdimm/pmem: implement ->set_read_only to hook into BLKROSET
    processing
  libnvdimm/blk: implement ->set_read_only to hook into BLKROSET
    processing
  libnvdimm/btt: implement ->set_read_only to hook into BLKROSET
    processing

 drivers/nvdimm/blk.c  |  1 +
 drivers/nvdimm/btt.c  |  1 +
 drivers/nvdimm/bus.c  | 17 +++++++++++++++++
 drivers/nvdimm/nd.h   |  1 +
 drivers/nvdimm/pmem.c |  1 +
 5 files changed, 21 insertions(+)

-- 
2.27.0

