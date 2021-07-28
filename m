Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C133D9703
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 22:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhG1UrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 16:47:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:60188 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231585AbhG1UrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 16:47:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="234634458"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="234634458"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 13:47:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="506679869"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 13:47:01 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 0/7] Basic recovery for machine checks inside SGX
Date:   Wed, 28 Jul 2021 13:46:46 -0700
Message-Id: <20210728204653.1509010-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210719182009.1409895-1-tony.luck@intel.com>
References: <20210719182009.1409895-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:

Jarkko:
	1) Don't provide a dummy non-NULL value for "owner" of new SGX EPC
	   pages at the call site. Instead change sgx_alloc_epc_page() to
	   provide a non-NULL value.
	2) Add description of the new debugfs files to sgx.rst
	   [Added a whole section on uncorrected memory errors]

Tony Luck (7):
  x86/sgx: Provide indication of life-cycle of EPC pages
  x86/sgx: Add infrastructure to identify SGX EPC pages
  x86/sgx: Initial poison handling for dirty and free pages
  x86/sgx: Add SGX infrastructure to recover from poison
  x86/sgx: Hook sgx_memory_failure() into mainline code
  x86/sgx: Add hook to error injection address validation
  x86/sgx: Add documentation for SGX memory errors

 .../firmware-guide/acpi/apei/einj.rst         |  19 +++
 Documentation/x86/sgx.rst                     |  26 ++++
 arch/x86/include/asm/set_memory.h             |   4 +
 arch/x86/kernel/cpu/sgx/main.c                | 134 +++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h                 |   6 +-
 drivers/acpi/apei/einj.c                      |   3 +-
 include/linux/mm.h                            |  15 ++
 mm/memory-failure.c                           |  19 ++-
 8 files changed, 216 insertions(+), 10 deletions(-)


base-commit: ff1176468d368232b684f75e82563369208bc371
-- 
2.29.2

