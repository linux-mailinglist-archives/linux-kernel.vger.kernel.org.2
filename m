Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E180A38D240
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 02:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhEVANU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 20:13:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:23457 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230120AbhEVANT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 20:13:19 -0400
IronPort-SDR: U/DvaTTMC/aIpWbNRRdGXjspbGSVfnrgeQauWN5rjIcL+Q80tjcre3Zqxcn78rUIZweif/LKRV
 TyImZFBGyEKg==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="287140637"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="287140637"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 17:11:55 -0700
IronPort-SDR: t0Az3X5fX0ugNGFpjrBkPyh2zyWIiLtN7ZFR73H57ANLffZm03TuJ5IOh7zYia+nJRn1PVQmAb
 VFS3dHCp2Q2Q==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="474751184"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 17:11:55 -0700
From:   ira.weiny@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Map register blocks individually
Date:   Fri, 21 May 2021 17:11:49 -0700
Message-Id: <20210522001154.2680157-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Changes for v2:
	Incorporate feedback from Dan
	Ensure memory blocks are individually reserved as well as mapped
	Remove pci device management in favor of lower level device management
	Drop version checking
	Reorder patches
	Update commit messages

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
The probe stage creates list of register blocks which is then iterated to map
the individual register blocks.

Once mapping is performed in 2 steps the pci device management is removed and
the resource reservation can be done per register block as well.

Finally, the mapping the HDM decoder register block is added.


Ben Widawsky (1):
  cxl: Add HDM decoder capbilities

Ira Weiny (4):
  cxl/mem: Introduce cxl_decode_register_block()
  cxl/mem: Reserve all device regions at once
  cxl/mem: Map registers based on capabilities
  cxl/mem: Reserve individual register block regions

 drivers/cxl/core.c | 182 +++++++++++++++++++++++++++++++++++++++++----
 drivers/cxl/cxl.h  |  98 +++++++++++++++++++++---
 drivers/cxl/pci.c  | 168 ++++++++++++++++++++++++++++++++---------
 drivers/cxl/pci.h  |   1 +
 4 files changed, 388 insertions(+), 61 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

