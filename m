Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9D3415A28
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 10:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbhIWImS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 04:42:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:24992 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239825AbhIWImR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 04:42:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="284806414"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="284806414"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 01:40:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="558226820"
Received: from louislifei-optiplex-7050.sh.intel.com ([10.239.154.151])
  by fmsmga002.fm.intel.com with ESMTP; 23 Sep 2021 01:40:44 -0700
From:   Fei Li <fei1.li@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com, fei1.li@intel.com
Subject: [PATCH v5 0/2] Introduce some interfaces for ACRN hypervisor HSM driver
Date:   Thu, 23 Sep 2021 16:41:26 +0800
Message-Id: <20210923084128.18902-1-fei1.li@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some new interfaces for ACRN hypervisor HSM driver:
  - MMIO device passthrough
  - virtual device creating/destroying
  - platform information fetching from the hypervisor

---
ChangeLog:
v5:
 - add comments where is the userspace code that uses the new api in commit log.
 - specify the endian for some fields in struct acrn_vdev.

v4:
 - remove "RFC" from Subject field.

v3:
 - remove "platform information fetching from the hypervisor". What platform
   information needs to be fetched has not been finally decided. Will send tis
   patch out once that has been decided.
 - add comments where is the userspace code that uses this new api:
   - MMIO device passthrough
     (a) assign a MMIO device to a User VM
     https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L562
     (b) de-assign a MMIO device from a User VM
     https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L568
   - virtual device creating/destroying
     (a) create a virtual device for a User VM
     https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L606
     (b) destroy a virtual device of a User VM
     https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L612

v2:
 - remove "stable@vger.kernel.org" in the cc list since this patch set
   doesn't fix any anything, it's not for Linux -stable releases. 


Shuo Liu (2):
  virt: acrn: Introduce interfaces for MMIO device passthrough
  virt: acrn: Introduce interfaces for virtual device
    creating/destroying

 drivers/virt/acrn/hsm.c       | 49 ++++++++++++++++++++++++
 drivers/virt/acrn/hypercall.h | 52 ++++++++++++++++++++++++++
 include/uapi/linux/acrn.h     | 70 +++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)


base-commit: 58e2cf5d794616b84f591d4d1276c8953278ce24
-- 
2.17.1

