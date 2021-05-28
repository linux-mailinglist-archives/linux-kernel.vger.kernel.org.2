Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5732393A73
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 02:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhE1AvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 20:51:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:54485 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhE1AvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 20:51:01 -0400
IronPort-SDR: PQFiKI63xyPAZHovu8cVx75jS7AzMyKviNk5O9g1glJLsWhxJyUR+27wHRcXaGiwLKrnRct1Q6
 cKLIXDp1Gslg==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="200977676"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="200977676"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:49:26 -0700
IronPort-SDR: zVQQH3v2xd+LxDnXvdv09uRsLErVWOQZoyeCN2eLQD+vtbxK1hPaSPXsKySNkm7C1NDqDNpe05
 wvSjPIZTQnjg==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="445261698"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:49:26 -0700
From:   ira.weiny@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/5] Map register blocks individually
Date:   Thu, 27 May 2021 17:49:17 -0700
Message-Id: <20210528004922.3980613-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Changes for v3:
	From Jonathan:
		Add Reviews.  Thanks!
		Add back the kernel doc comment and enhance it a bit
		Update commit messages with more details.
		Remove CXL_REGLOC_RBI_MAX
	Dan
		Add pcim_enable_device() back in because it is needed
		and is not incompatible with pci_release_mem_regions()
		like I originally though.
		Change cxl_ioremap_block() to devm_cxl_iomap_block()

	Add kernel doc comment for cxl_probe_component_regs()
	Update HDM patch to devm_cxl_iomap_block() call.

Some hardware implementations mix component and device registers into the same
BAR and the driver stack is going to have independent mapping implementations
for those 2 cases.  Furthermore, it will be nice to have finer grained mappings
should user space want to map some register blocks.

Unfortunately, the information for the register blocks is contained inside the
BARs themselves.  Which means the BAR must be mapped, probed, and unmapped
prior to the registers being mapped individually.

The series starts by introducing the helper function
cxl_decode_register_block().  Then breaks out region reservation and register
mapping.  Separates mapping the registers into a probe stage and mapping stage.
The probe stage creates a list of register blocks which is then iterated to map
the individual register blocks.

Once mapping is performed in 2 steps the pci device management is removed and
the resource reservation can be done per register block as well.

Finally, mapping the HDM decoder register block is added.


Ben Widawsky (1):
  cxl/pci: Add HDM decoder capabilities

Ira Weiny (4):
  cxl/mem: Introduce cxl_decode_register_block()
  cxl/mem: Reserve all device regions at once
  cxl/mem: Map registers based on capabilities
  cxl/mem: Reserve individual register block regions

 drivers/cxl/core.c | 193 ++++++++++++++++++++++++++++++++++++++++++---
 drivers/cxl/cxl.h  |  98 ++++++++++++++++++++---
 drivers/cxl/pci.c  | 164 ++++++++++++++++++++++++++++++--------
 3 files changed, 402 insertions(+), 53 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

