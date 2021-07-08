Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943663C190E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 20:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhGHSRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 14:17:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:2094 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhGHSRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 14:17:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="231327150"
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="231327150"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 11:14:35 -0700
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="482637386"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 11:14:34 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     tony.luck@intel.com
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Basic recovery for machine checks inside SGX
Date:   Thu,  8 Jul 2021 11:14:19 -0700
Message-Id: <20210708181423.1312359-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cover the easy cases:
1) memory errors reported by patrol scrubber in unused SGX pages
2) machine checks due to poison consumption from SGX_PAGE_TYPE_REG
   pages
3) When poison is consumed in an enclave inside a guest, just kill
   the guest.

Tony Luck (4):
  x86/sgx: Track phase and type of SGX EPC pages
  x86/sgx: Add basic infrastructure to recover from errors in SGX memory
  x86/sgx: Hook sgx_memory_failure() into mainline code
  x86/sgx: Add hook to error injection address validation

 .../firmware-guide/acpi/apei/einj.rst         |  19 +++
 arch/x86/include/asm/sgx.h                    |   6 +
 arch/x86/kernel/cpu/sgx/encl.c                |   4 +-
 arch/x86/kernel/cpu/sgx/ioctl.c               |   4 +-
 arch/x86/kernel/cpu/sgx/main.c                | 147 +++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h                 |  17 +-
 arch/x86/kernel/cpu/sgx/virt.c                |  11 +-
 drivers/acpi/apei/einj.c                      |   3 +-
 include/linux/mm.h                            |  15 ++
 mm/memory-failure.c                           |   4 +
 10 files changed, 219 insertions(+), 11 deletions(-)


base-commit: 62fb9874f5da54fdb243003b386128037319b219
-- 
2.29.2

