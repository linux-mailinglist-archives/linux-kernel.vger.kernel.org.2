Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E613F715A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhHYJBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:01:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:33931 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231963AbhHYJBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:01:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="215640225"
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="scan'208";a="215640225"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 02:01:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="scan'208";a="455971115"
Received: from louislifei-optiplex-7050.sh.intel.com ([10.239.154.151])
  by fmsmga007.fm.intel.com with ESMTP; 25 Aug 2021 02:01:02 -0700
From:   Fei Li <fei1.li@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, fei1.li@intel.com,
        yu1.wang@intel.com, shuox.liu@gmail.com
Subject: [PATCH v2 0/3] Introduce some interfaces for ACRN hypervisor
Date:   Wed, 25 Aug 2021 17:01:39 +0800
Message-Id: <20210825090142.4418-1-fei1.li@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some new interfaces for ACRN hypervisor HSM driver:
  - MMIO device passthrough
  - virtual device creating/destroying
  - platform information fetching from the hypervisor

ChangeLog:
v2:
 - remove "stable@vger.kernel.org" in the cc list since this patch set
   doesn't fix any anything, it's not for Linux -stable releases. 

Shuo Liu (3):
  virt: acrn: Introduce interfaces for MMIO device passthrough
  virt: acrn: Introduce interfaces for virtual device
    creating/destroying
  virt: acrn: Introduce interface to fetch platform info from the
    hypervisor

 drivers/virt/acrn/hsm.c       | 102 ++++++++++++++++++++++++++++++
 drivers/virt/acrn/hypercall.h |  64 +++++++++++++++++++
 include/uapi/linux/acrn.h     | 114 ++++++++++++++++++++++++++++++++++
 3 files changed, 280 insertions(+)


base-commit: 7c60610d476766e128cc4284bb6349732cbd6606
-- 
2.25.1

