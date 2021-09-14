Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CA140A6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 08:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbhING1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 02:27:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:10352 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240172AbhING1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 02:27:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="218717564"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="218717564"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 23:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="471855735"
Received: from louislifei-optiplex-7050.sh.intel.com ([10.239.154.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Sep 2021 23:26:00 -0700
From:   Fei Li <fei1.li@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com, fei1.li@intel.com
Subject: [PATCH v4 0/2] Introduce some interfaces for ACRN hypervisor HSM driver
Date:   Tue, 14 Sep 2021 14:26:25 +0800
Message-Id: <20210914062627.16431-1-fei1.li@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some new interfaces for ACRN hypervisor HSM driver:
  - MMIO device passthrough
  - virtual device creating/destroying
  - platform information fetching from the hypervisor

ChangeLog:
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


base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
-- 
2.17.1

