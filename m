Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BF335D17F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 21:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245356AbhDLTxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 15:53:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:63047 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238796AbhDLTxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 15:53:51 -0400
IronPort-SDR: pm81zIzjKcjfRZDViLx08aorgO13eRcZxF3Me+x4Volw8u29Tiq7UhqB+IEZdl0qVO5JvSNMkk
 5Zs8EaEy6NAA==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="279568495"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="279568495"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 12:53:32 -0700
IronPort-SDR: Ce3Uc/BIqQYjNgGATogvofAa13JUDrvlwnr0QbOO1K3EUCHCHqTvNK5XqLDuzMOxA5S5c/kZkG
 d5MjSS8Z0H9g==
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="521317917"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.8.207])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 12:53:31 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v9 0/1] Intel MAX10 BMC Macros for Secure Update
Date:   Mon, 12 Apr 2021 12:53:27 -0700
Message-Id: <20210412195329.241357-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was previously patch 1 of 6 in the patch-series entitled
"Intel MAX10 BMC Secure Update Driver". This is the only patch in
the series that is subject to conflicts with other ongoing changes
and is separated here to simplify maintenance of the patchset.

This patch creates a number of macro definitions that are required
for the Intel MAX10 BMC Secure Update Driver.

Changelog v8 -> v9:
  - Rebased on next-20210412
Changelog v7 -> v8:
  - Rebased on next-20210121
  - Separated out from patchset: "Intel MAX10 BMC Secure Update Driver"
Changelog v6 -> v7:
  - No change
Changelog v5 -> v6:
  - No change
Changelog v4 -> v5:
  - Renamed USER_FLASH_COUNT to STAGING_FLASH_COUNT
Changelog v3 -> v4:
  - No change
Changelog v2 -> v3:
  - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
    Update driver"
  - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
    underlying functions will be called directly.
Changelog v1 -> v2:
  - These functions and macros were previously distributed among
    the patches that needed them. They are now grouped together
    in a single patch containing changes to the Intel MAX10 BMC
    driver.
  - Added DRBL_ prefix to some definitions
  - Some address definitions were moved here from the .c files that
    use them.

Russ Weight (1):
  mfd: intel-m10-bmc: support for MAX10 BMC Secure Updates

 include/linux/mfd/intel-m10-bmc.h | 85 +++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

-- 
2.25.1

