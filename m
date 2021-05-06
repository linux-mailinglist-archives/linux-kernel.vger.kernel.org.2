Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51536375D39
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 00:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhEFWiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 18:38:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:13614 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230231AbhEFWiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 18:38:07 -0400
IronPort-SDR: yKs74Z4mdVkBp91sHy3fP2QERj0bt29KO7lHxkN3/vCtpWzydWItLrkiDV8BuhLpra+H/4cwtb
 c7xYZeDWaYDA==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="195479002"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="195479002"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 15:37:08 -0700
IronPort-SDR: xQlnBnlWhujIKuhuSxksW7zkRrRAr5xXvj7qKUGZIVIh82uMyBuyGy8L0KXcQs/HCwgF44DzzQ
 PVG4eFSOYvPA==
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="434607076"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 15:37:07 -0700
From:   ira.weiny@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Map register blocks individually
Date:   Thu,  6 May 2021 15:36:50 -0700
Message-Id: <20210506223654.1310516-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

User space will want to map some register blocks.  Currently BARs are mapped in
their entirety and pointers to the register blocks are created into those
mappings.  This will prevent mappings from user space.

This series has 3 clean up patches followed by a patch to mapping the register
blocks individually.

Unfortunately, the information for the register blocks is contained inside the
BARs themselves.  Which means the BAR must be mapped, probed, and unmapped
prior to the registers being mapped individually.

The probe stage creates list of register maps which is then iterated to map
the individual register blocks.

Ira Weiny (4):
  cxl/mem: Fully decode device capability header
  cxl/mem: Reserve all device regions at once
  cxl/mem: Introduce cxl_decode_register_block()
  cxl/mem: Map registers based on capabilities

 drivers/cxl/core.c |  84 ++++++++++++++++++++------
 drivers/cxl/cxl.h  |  34 +++++++++--
 drivers/cxl/pci.c  | 147 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 211 insertions(+), 54 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

